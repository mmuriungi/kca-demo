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
            getPayType(PayTypes);
            getEmployee(Employee, PartTime."Account No.");
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
            PvLines.Validate("Amount");
            if PvLines.Insert(true) then begin
                Message('Payment Voucher Created Successfully');
            end;
        end;
    end;

    procedure getPayType(var PayTypes: Record "FIN-Receipts and Payment Types")
    begin
        PayTypes.Reset();
        PayTypes.SetRange("Lecturer Claim?", true);
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
    begin
        PurchHeader := claimHandler.CreatePurchaseHeader(PartTime."Account No.", PartTime."Global Dimension 1 Code", PartTime."Global Dimension 2 Code", PartTime."Shortcut Dimension 3 Code", Today, PartTime.Purpose, PartTime."No.", Enum::"Claim Type"::Parttime);
        HrSetup.Get();
        claimHandler.CreatePurchaseLine(PurchHeader, HrSetup."Claim G/L Account", PurchLine.Type::"G/L Account", 1, PartTime."Payment Amount");
    end;

}
