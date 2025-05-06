codeunit 50095 "PartTimer Management"
{
    procedure checkClaimEligibility(Var parttimeLine: Record "Parttime Claim Lines")
    var
        PartTime: Record "Parttime Claim Header";
        LecturerUnits: Record "ACA-Lecturers Units";
        ExamMarks: Record "ACA-Exam Results";
    begin
        LecturerUnits.Reset();
        LecturerUnits.SetRange(Lecturer, parttimeLine."Lecture No.");
        LecturerUnits.SetRange("Unit", parttimeLine."Unit");
        LecturerUnits.SetRange(Semester, parttimeLine.Semester);
        LecturerUnits.SetRange(Stage, parttimeLine.Stage);
        //LecturerUnits.SetRange(Programme, parttimeLine.Programme);
        if LecturerUnits.FindFirst() then begin
            ExamMarks.Reset();
            ExamMarks.SetRange(Unit, LecturerUnits."Unit");
            ExamMarks.SetRange(Semester, LecturerUnits.Semester);
            ExamMarks.SetRange(Stage, LecturerUnits.Stage);
            ExamMarks.SetRange(Programmes, LecturerUnits.Programme);
            ExamMarks.SetFilter(ExamType, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
            parttimeLine."Cat Exists" := ExamMarks.FindSet();
            ExamMarks.Reset();
            ExamMarks.SetRange(Unit, LecturerUnits."Unit");
            ExamMarks.SetRange(Semester, LecturerUnits.Semester);
            ExamMarks.SetRange(Stage, LecturerUnits.Stage);
            ExamMarks.SetRange(Programmes, LecturerUnits.Programme);
            ExamMarks.SETFILTER(ExamType, '%1|%2|%3', 'EXAM', 'MAIN EXAM', 'FINAl EXAM');
            parttimeLine."Exam Exists" := ExamMarks.FindSet();

            if parttimeLine."Cat Exists" and parttimeLine."Exam Exists" then
                parttimeLine.Excluded := false
            else
                parttimeLine.Excluded := true;
        end else
            parttimeLine.Excluded := true;
    end;

    procedure calculateClaimAmount(Var parttimeLine: Record "Parttime Claim Lines")
    var
        PartTimeRates: Record "Part-Timer Rates";
        AcaUnits: Record "ACA-Units/Subjects";
        Attendance: Record "Class Attendance Header";
        LecturerUnits: Record "ACA-Lecturers Units";
    begin
        if parttimeLine.Excluded then
            //parttimeLine.Amount := 0
            Error('You cannot claim for this unit because either CAT or EXAM is missing')
        else begin
            AcaUnits.Reset();
            AcaUnits.SetRange(Code, parttimeLine."Unit");
            if AcaUnits.FindFirst() then begin
                LecturerUnits.Reset();
                LecturerUnits.SetRange(Lecturer, parttimeLine."Lecture No.");
                LecturerUnits.SetRange("Unit", parttimeLine."Unit");
                LecturerUnits.SetRange(Semester, parttimeLine.Semester);
                LecturerUnits.SetRange(Stage, parttimeLine.Stage);
                if LecturerUnits.FindFirst() then begin
                    parttimeLine."Hours Done" := LecturerUnits."No. Of Hours";
                end;
                PartTimeRates.Reset();
                PartTimeRates.SetRange("Programme Category", parttimeLine."Programme Category");
                if PartTimeRates.FindFirst() then begin
                    // parttimeLine."Hourly Rate" := PartTimeRates."Rate per Hour";
                    parttimeLine."Hourly Rate" := LecturerUnits.Rate;
                    parttimeLine.Validate("Hourly Rate");
                end;
            end;
        end;
    end;

    procedure createPaymentVoucher(Var PartTime: Record "Parttime Claim Header")
    var
        PVHeader: Record "FIN-Payments Header";
        PvLines: Record "FIN-Payment Line";
        Employee: Record "HRM-Employee C";
        PayTypes: Record "FIN-Receipts and Payment Types";
        Vendor: Record Vendor;
        HrSetup: Record "HRM-Setup";
    begin
        PVHeader.Init();
        PVHeader."Document Type" := PVHeader."Document Type"::"Payment Voucher";
        PVHeader."No." := '';
        PVHeader."Global Dimension 1 Code" := PartTime."Global Dimension 1 Code";
        PVHeader."Shortcut Dimension 2 Code" := PartTime."Global Dimension 2 Code";
        PVHeader."Shortcut Dimension 3 Code" := PartTime."Shortcut Dimension 3 Code";
        PVHeader."Payment Type" := PVHeader."Payment Type"::Normal;
        PVHeader."Paying Bank Account" := PartTime."Paying Bank Account";
        PVHeader."Pay Mode" := PVHeader."Pay Mode";
        PVHeader."Responsibility Center" := PartTime."Responsibility Center";
        PVHeader."Payment Narration" := PartTime.Purpose;
        PVHeader.Payee := PartTime.Payee;
        PVHeader."Source Document No" := PartTime."No.";
        PVHeader."Source Table" := PartTime.RecordId.TableNo;
        PVHeader.Date := Today;
        if PVHeader.Insert(true) then begin
            PartTime.CalcFields("Payment Amount");
            getEmployee(Employee, PartTime."Account No.");
            getPayType(PayTypes, Employee);
            Vendor.Reset();
            Vendor.SetRange("No.", Employee."Vendor No.");
            if Vendor.FindFirst() then begin
                HrSetup.Get();
                Vendor."Vendor Posting Group" := HrSetup."Parttimer Posting Group";
                Vendor.Modify();
            end;
            PvLines.Init();
            PvLines.No := PVHeader."No.";
            PvLines.Type := PayTypes.Code;
            PvLines.Validate("Type");
            PvLines."Account No." := Employee."Vendor No.";
            PvLines.Validate("Account No.");
            PvLines."Global Dimension 1 Code" := PartTime."Global Dimension 1 Code";
            PvLines."Shortcut Dimension 2 Code" := PartTime."Global Dimension 2 Code";
            PvLines."Shortcut Dimension 3 Code" := PartTime."Shortcut Dimension 3 Code";
            PvLines.Amount := PartTime."Payment Amount";
            PvLines."Vendor Transaction Type" := PvLines."Vendor Transaction Type"::"Part timer";
            PvLines.Validate("Amount");
            if PvLines.Insert(true) then begin
                Message('Payment Voucher Created Successfully');
            end;
        end;
    end;

    procedure getPayType(var PayTypes: Record "FIN-Receipts and Payment Types"; var Employee: Record "HRM-Employee C")
    begin
        PayTypes.Reset();
        PayTypes.SetRange("Lecturer Claim?", true);
        if Employee."Part Timer Type" = Employee."Part Timer Type"::"Internal" then
            PayTypes.SetRange("Claim PAYE Percentage", PayTypes."Claim PAYE Percentage"::"30 %")
        else
            PayTypes.SetRange("Claim PAYE Percentage", PayTypes."Claim PAYE Percentage"::"35 %");
        PayTypes.FindFirst();
    end;

    procedure getEmployee(var Employee: Record "HRM-Employee C"; No: Code[20])
    begin
        Employee.Reset();
        Employee.SetRange("No.", No);
        Employee.FindFirst();
    end;

    procedure createPurchaseInvoice(Var PartTime: Record "Parttime Claim Header")
    var
        claimHandler: Codeunit "Claims Handler";
        PurchHeader: Record "Purchase Header";
        HrSetup: Record "HRM-Setup";
        PurchLine: Record "Purchase Line";
        Employee: Record "HRM-Employee C";
    begin
        getEmployee(Employee, PartTime."Account No.");
        PurchHeader := claimHandler.CreatePurchaseHeader(Employee."Vendor No.", PartTime."Global Dimension 1 Code", PartTime."Global Dimension 2 Code", PartTime."Shortcut Dimension 3 Code", Today, PartTime.Purpose, PartTime."No.", Enum::"Claim Type"::Parttime);
        HrSetup.Get();
        claimHandler.CreatePurchaseLine(PurchHeader, HrSetup."Parttimer G/L Account", PurchLine.Type::"G/L Account", 1, PartTime."Payment Amount");
    end;


    procedure CreateBatchPaymentVoucher(BatchNo: Code[20])
    var
        PartTime: Record "Parttime Claim Header";
        BatchRec: Record "Parttime Claims Batch";
        PVHeader: Record "FIN-Payments Header";
        PVLine: Record "FIN-Payment Line";
        LineNo: Integer;
        Employee: Record "HRM-Employee C";
        PayTypes: Record "FIN-Receipts and Payment Types";
        Vendor: Record Vendor;
        HrSetup: Record "HRM-Setup";
        TotalAmount: Decimal;
        LineAmount: Decimal;
    begin
        // Get Batch Details
        if not BatchRec.Get(BatchNo) then
            Error('Batch %1 does not exist.', BatchNo);

        BatchRec.CalcFields("Total Amount", "Claims Count");
        if BatchRec."Claims Count" = 0 then
            Error('No claims found in batch %1.', BatchNo);

        // Create PV header for the batch
        PVHeader.Init();
        PVHeader."Document Type" := PVHeader."Document Type"::"Payment Voucher";
        PVHeader."No." := '';
        PVHeader."Global Dimension 1 Code" := '';
        PVHeader."Shortcut Dimension 2 Code" := '';
        PVHeader."Payment Type" := PVHeader."Payment Type"::Normal;
        PVHeader."Pay Mode" := PVHeader."Pay Mode"::EFT;
        PVHeader."Payment Narration" := 'Part Time Claims Batch ' + BatchNo;
        PVHeader.Payee := 'Part-Time Claims Batch ' + BatchNo;
        PVHeader."Source Document No" := BatchNo;
        PVHeader."Source Table" := BatchRec.RecordId.TableNo;
        PVHeader.Date := Today;
        PVHeader.Insert(true);

        // Process each claim in the batch
        LineNo := 10000;
        PartTime.Reset();
        PartTime.SetRange("Batch No.", BatchNo);
        if PartTime.FindSet() then begin
            repeat
                PartTime.CalcFields("Payment Amount");
                LineAmount := PartTime."Payment Amount";
                TotalAmount += LineAmount;

                // Get employee and setup information
                getEmployee(Employee, PartTime."Account No.");
                getPayType(PayTypes, Employee);

                // Update vendor posting group if needed
                Vendor.Reset();
                Vendor.SetRange("No.", Employee."Vendor No.");
                if Vendor.FindFirst() then begin
                    HrSetup.Get();
                    Vendor."Vendor Posting Group" := HrSetup."Parttimer Posting Group";
                    Vendor.Modify();
                end;

                // Create payment line for each claim
                PVLine.Init();
                PVLine."Line No." := LineNo;
                PVLine.No := PVHeader."No.";
                PVLine.Type := PayTypes.Code;
                PVLine.Validate(Type);
                PVLine."Account Type" := PVLine."Account Type"::Vendor;

                if Employee."Vendor No." <> '' then
                    PVLine."Account No." := Employee."Vendor No."
                else
                    Error('Employee %1 does not have a vendor number.', PartTime."Account No.");

                PVLine.Validate("Account No.");
                PVLine."Global Dimension 1 Code" := PartTime."Global Dimension 1 Code";
                PVLine."Shortcut Dimension 2 Code" := PartTime."Global Dimension 2 Code";
                if PartTime."Shortcut Dimension 3 Code" <> '' then
                    PVLine."Shortcut Dimension 3 Code" := PartTime."Shortcut Dimension 3 Code";
                PVLine.Amount := LineAmount;
                PVLine."Vendor Transaction Type" := PVLine."Vendor Transaction Type"::"Part timer";
                PVLine.Validate(Amount);
                PVLine.Insert(true);

                // Mark claim as processed
                PartTime.Posted := true;
                PartTime."Date Posted" := Today;
                PartTime."Time Posted" := Time;
                PartTime."Posted By" := UserId;
                PartTime.Modify();

                LineNo += 10000;
            until PartTime.Next() = 0;
        end;

        // Update batch record
        BatchRec."Pv Generated" := true;
        BatchRec.Modify();

        Message('Payment voucher %1 has been generated for batch %2 with %3 claims totaling %4.',
            PVHeader."No.", BatchNo, BatchRec."Claims Count", TotalAmount);
    end;

    procedure CreateBatchPurchaseInvoices(BatchNo: Code[20])
    var
        PartTime: Record "Parttime Claim Header";
        BatchRec: Record "Parttime Claims Batch";
        HrSetup: Record "HRM-Setup";
        Employee: Record "HRM-Employee C";
        VendorClaims: Dictionary of [Code[20], List of [Code[20]]];
        VendorAmounts: Dictionary of [Code[20], Decimal];
        VendorList: List of [Code[20]];
        VendorNo: Code[20];
        ClaimList: List of [Code[20]];
        TempClaimList: List of [Code[20]];
        ClaimNo: Code[20];
        TotalAmount: Decimal;
        InvoiceCount: Integer;
        VendorName: Text[100];
        InvoiceNo: Code[20];
        Vendor: Record Vendor;
    begin
        // Get Batch Details
        if not BatchRec.Get(BatchNo) then
            Error('Batch %1 does not exist.', BatchNo);
        
        BatchRec.CalcFields("Total Amount", "Claims Count");
        if BatchRec."Claims Count" = 0 then
            Error('No claims found in batch %1.', BatchNo);

        // Get HR Setup
        HrSetup.Get();
        HrSetup.TestField("Parttimer G/L Account");
        
        // First, group all claims by vendor
        PartTime.Reset();
        PartTime.SetRange("Batch No.", BatchNo);
        
        if PartTime.FindSet() then begin
            repeat
                // Get employee and check vendor number
                getEmployee(Employee, PartTime."Account No.");
                
                if Employee."Vendor No." = '' then
                    Error('Employee %1 does not have a vendor number.', PartTime."Account No.");
                
                // Group by vendor
                if not VendorClaims.ContainsKey(Employee."Vendor No.") then begin
                    Clear(TempClaimList);
                    VendorClaims.Add(Employee."Vendor No.", TempClaimList);
                    VendorAmounts.Add(Employee."Vendor No.", 0);
                    VendorList.Add(Employee."Vendor No.");
                end;
                
                PartTime.CalcFields("Payment Amount");
                VendorClaims.Get(Employee."Vendor No.").Add(PartTime."No.");
                VendorAmounts.Set(Employee."Vendor No.", VendorAmounts.Get(Employee."Vendor No.") + PartTime."Payment Amount");
                
            until PartTime.Next() = 0;
        end else begin
            Error('No claims found in batch %1.', BatchNo);
        end;
        
        // Now create an invoice for each vendor
        foreach VendorNo in VendorList do begin
            InvoiceNo := CreateVendorInvoice(BatchNo, VendorNo, VendorClaims.Get(VendorNo), VendorAmounts.Get(VendorNo));
            
            // Get vendor name for message
            if Vendor.Get(VendorNo) then
                VendorName := Vendor.Name
            else
                VendorName := VendorNo;
                
            TotalAmount += VendorAmounts.Get(VendorNo);
            InvoiceCount += 1;
        end;
        
        // Update batch record
        BatchRec."Pv Generated" := true;
        BatchRec.Modify();
        
        Message('Successfully created %1 purchase invoices for batch %2, totaling %3.', 
            InvoiceCount, BatchNo, TotalAmount);
    end;

    local procedure CreateVendorInvoice(BatchNo: Code[20]; VendorNo: Code[20]; ClaimsList: List of [Code[20]]; Amount: Decimal): Code[20]
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PartTime: Record "Parttime Claim Header";
        PartTimeInvoiceBatch: Record "PartTime Invoice Batch";
        HrSetup: Record "HRM-Setup";
        LineNo: Integer;
        ClaimNo: Code[20];
        Vendor: Record Vendor;
    begin
        HrSetup.Get();
        
        // Create purchase header
        PurchHeader.Init();
        PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;
        PurchHeader."No." := '';
        PurchHeader."Buy-from Vendor No." := VendorNo;
        PurchHeader.Validate("Buy-from Vendor No.");
        PurchHeader."Posting Date" := Today;
        PurchHeader."Document Date" := Today;
        PurchHeader."Due Date" := Today;
        PurchHeader."Vendor Invoice No." := 'PTB-' + BatchNo + '-' + VendorNo;
        PurchHeader."Your Reference" := 'Part-Time Claims Batch ' + BatchNo;
        PurchHeader.Insert(true);
        
        // Create lines for each claim
        LineNo := 10000;
        foreach ClaimNo in ClaimsList do begin
            if PartTime.Get(ClaimNo) then begin
                PartTime.CalcFields("Payment Amount");
                
                PurchLine.Init();
                PurchLine."Document Type" := PurchHeader."Document Type";
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := LineNo;
                PurchLine.Type := PurchLine.Type::"G/L Account";
                PurchLine."No." := HrSetup."Parttimer G/L Account";
                PurchLine.Validate("No.");
                PurchLine.Description := 'Payment for Parttime Claim ' + PartTime."No." + ' - ' + PartTime.Payee;
                PurchLine."Unit of Measure" := 'EACH';
                PurchLine.Quantity := 1;
                PurchLine."Direct Unit Cost" := PartTime."Payment Amount";
                PurchLine.Validate("Direct Unit Cost");
                PurchLine."Shortcut Dimension 1 Code" := PartTime."Global Dimension 1 Code";
                PurchLine."Shortcut Dimension 2 Code" := PartTime."Global Dimension 2 Code";
                PurchLine.Insert(true);
                
                // Mark claim as processed
                PartTime.Posted := true;
                PartTime."Date Posted" := Today;
                PartTime."Time Posted" := Time;
                PartTime."Posted By" := UserId;
                PartTime.Modify();
                
                LineNo += 10000;
            end;
        end;
        
        // Record the invoice in the batch tracking table
        PartTimeInvoiceBatch.Init();
        PartTimeInvoiceBatch."Batch No." := BatchNo;
        PartTimeInvoiceBatch."Invoice No." := PurchHeader."No.";
        PartTimeInvoiceBatch."Vendor No." := VendorNo;
        if Vendor.Get(VendorNo) then
            PartTimeInvoiceBatch."Vendor Name" := Vendor.Name;
        PartTimeInvoiceBatch."Date Created" := Today;
        PartTimeInvoiceBatch."Created By" := UserId;
        PartTimeInvoiceBatch.Amount := Amount;
        PartTimeInvoiceBatch.Status := PartTimeInvoiceBatch.Status::Open;
        PartTimeInvoiceBatch.Insert();
        
        exit(PurchHeader."No.");
    end;
}
