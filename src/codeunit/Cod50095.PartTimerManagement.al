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
                parttimeLine.Included := true
            else
                parttimeLine.Included := false;
        end else
            parttimeLine.Included := false;
    end;

    procedure calculateClaimAmount(Var parttimeLine: Record "Parttime Claim Lines")
    var
        PartTimeRates: Record "Part-Timer Rates";
        AcaUnits: Record "ACA-Units/Subjects";
        Attendance: Record "Class Attendance Header";
        LecturerUnits: Record "ACA-Lecturers Units";
    begin
        //if parttimeLine.Included = false then
        //parttimeLine.Amount := 0
        // Error('You cannot claim for this unit because either CAT or EXAM is missing')
        /* else */
        begin
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
        PVHeader."PV Category" := PVHeader."PV Category"::"Part-time Pay";
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
        PurchHeader := claimHandler.CreatePurchaseHeader(Employee."Vendor No.", PartTime."Global Dimension 1 Code", PartTime."Global Dimension 2 Code", PartTime."Shortcut Dimension 3 Code", Today, PartTime.Purpose, PartTime."No.", Enum::"Claim Type"::Parttime, '');
        HrSetup.Get();
        claimHandler.CreatePurchaseLine(PurchHeader, HrSetup."Parttimer G/L Account", PurchLine.Type::"G/L Account", 1, PartTime."Payment Amount");
    end;

    procedure PostClaim(Var PartTime: Record "Parttime Claim Header") Posted: Boolean
    var
        claimHandler: Codeunit "Claims Handler";
        HrSetup: Record "HRM-Setup";
        Employee: Record "HRM-Employee C";
        gnLine: Record "Gen. Journal Line";
        ClaimLines: Record "Parttime Claim Lines";
    begin
        getEmployee(Employee, PartTime."Account No.");

        ClaimLines.Reset();
        ClaimLines.SetRange("Document No.", PartTime."No.");
        if ClaimLines.FindSet() then begin
            repeat
                gnLine.INIT;
                gnLine."Journal Template Name" := 'GENERAL';
                gnLine."Journal Batch Name" := 'LECTURER';
                gnLine."Line No." := gnLine."Line No." + 100;
                gnLine."Account Type" := gnLine."Account Type"::Vendor;
                gnLine."Account No." := Employee."Vendor No.";
                gnLine."Shortcut Dimension 1 Code" := PartTime."Global Dimension 1 Code";
                gnLine."Shortcut Dimension 2 Code" := PartTime."Global Dimension 2 Code";
                gnLine."Shortcut Dimension 3 Code" := PartTime."Shortcut Dimension 3 Code";
                gnLine."Document Type" := gnLine."Document Type"::Invoice;
                gnLine."Posting Date" := TODAY;
                gnLine."Document No." := PartTime."No.";
                gnLine.Description := COPYSTR(PartTime.Semester + '/' + ClaimLines.Unit + '/' + ClaimLines."Unit Description", 1, 50);
                gnLine."Bal. Account Type" := gnLine."Bal. Account Type"::"G/L Account";
                gnLine."Bal. Account No." := '70310';//GeneralSetup."Lecturers Expense Account";
                gnLine.Amount := ClaimLines.Amount * -1;
                gnLine.INSERT;
            until ClaimLines.Next() = 0;
            gnLine.RESET;
            gnLine.SETRANGE(gnLine."Journal Template Name", 'GENERAL');
            gnLine.SETRANGE(gnLine."Journal Batch Name", 'LECTURER');
            IF gnLine.FindSet() THEN BEGIN
                if CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", gnLine) then Posted := true;
            END;
        end;
    end;

    procedure createPurchaseInvoiceBatch(Var PartTime: Record "Parttime Claim Header"; BatchNo: Code[20])
    var
        claimHandler: Codeunit "Claims Handler";
        PurchHeader: Record "Purchase Header";
        HrSetup: Record "HRM-Setup";
        PurchLine: Record "Purchase Line";
        Employee: Record "HRM-Employee C";
        BatchInvoice: Record "PartTime Invoice Batch";
        ClaimsBatch: Record "Parttime Claims Batch";
    begin
        getEmployee(Employee, PartTime."Account No.");
        PurchHeader := claimHandler.CreatePurchaseHeaderApproved(Employee."Vendor No.", PartTime."Global Dimension 1 Code", PartTime."Global Dimension 2 Code", PartTime."Shortcut Dimension 3 Code", Today, PartTime.Purpose, PartTime."No.", Enum::"Claim Type"::Parttime, BatchNo);
        HrSetup.Get();
        claimHandler.CreatePurchaseLineApproved(PurchHeader, HrSetup."Parttimer G/L Account", PurchLine.Type::"G/L Account", 1, PartTime."Payment Amount");
        ClaimsBatch.Get(BatchNo);
        ClaimsBatch.CalcFields("Total Amount");
        BatchInvoice.init();
        BatchInvoice."Batch No." := BatchNo;
        BatchInvoice."Amount" := ClaimsBatch."Total Amount";
        BatchInvoice."Date Created" := Today;
        BatchInvoice."Created By" := UserId;
        BatchInvoice."Status" := BatchInvoice."Status"::Open;
        if not BatchInvoice.Insert(true) then
            BatchInvoice.Modify();
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
        PVHeader."Global Dimension 1 Code" := BatchRec."Global Dimension 1 Code";
        PVHeader."Shortcut Dimension 2 Code" := BatchRec."Global Dimension 2 Code";
        PVHeader."Shortcut Dimension 3 Code" := BatchRec."Shortcut Dimension 3 Code";
        PVHeader."Responsibility Center" := BatchRec."Responsibility Center";
        PVHeader."Payment Type" := PVHeader."Payment Type"::Normal;
        PVHeader."PV Category" := PVHeader."PV Category"::"Part-time Pay";
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
        ClaimArray: array[1000] of Record "Parttime Claim Header";
        Claim: Record "Parttime Claim Header";
        i: Integer;
        ClaimCount: Integer;
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
            i := 1;
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
                ClaimArray[i] := PartTime;
                i += 1;
                TotalAmount += PartTime."Payment Amount";
            until PartTime.Next() = 0;
            ClaimCount := i - 1;
        end else begin
            Error('No claims found in batch %1.', BatchNo);
        end;

        // Now create an invoice for each vendor
        for i := 1 to ClaimCount do begin
            createPurchaseInvoiceBatch(ClaimArray[i], BatchNo);
        end;

        // Update batch record
        BatchRec."Invoice Batch Generated" := true;
        BatchRec.Modify();

        Message('Successfully created %1 purchase invoices for batch %2, totaling %3.',
            ClaimCount, BatchNo, TotalAmount);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnBeforeConfirmPost, '', false, false)]
    local procedure PostBatchClaimInvoicesSilent(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    begin
        if PurchaseHeader."Batch No." <> '' then begin
            HideDialog := true;
        end;
    end;

    procedure openPaymentVoucher(var PartTime: Record "Parttime Claim Header")
    var
        PvHeader: Record "FIN-Payments Header";
    begin
        PvHeader.Reset();
        PvHeader.SetRange("Source Document No", PartTime."No.");
        if PvHeader.FindFirst() then begin
            PAGE.Run(PAGE::"FIN-Payment Vouchers", PvHeader);
        end;
    end;
}
