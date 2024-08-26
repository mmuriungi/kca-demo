report 50533 "Post Student Charges"
{
    ApplicationArea = All;
    Caption = 'Post Student Charges';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ACACourseRegistration; "ACA-Course Registration")
        {
            DataItemTableView = where("Settlement Type" = filter(<> ''), Posted = filter(false), "Student No." = filter(<> ''), Semester = filter('SEM 3 2021/2022'));
            column(AcademicYear; "Academic Year")
            {
            }
            column(AdmissionNo; "Admission No.")
            {
            }
            column(StudentName; "Student Name")
            {
            }
            column(StudentStatus; "Student Status")
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                GenJnl.RESET;
                GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
                GenJnl.SETRANGE(GenJnl."Journal Batch Name", 'STUD PAY');
                GenJnl.DELETEALL;

                GenSetUp.GET();
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

                //Post New
                GenJnl.RESET;
                GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
                GenJnl.SETRANGE(GenJnl."Journal Batch Name", 'STUD PAY');

                IF GenJnl.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
                END;
            end;

            trigger OnAfterGetRecord()

            begin
                if ACACourseRegistration."Settlement Type" = '' then exit;
                //BILLING
                Recz.Reset();
                Recz.SetRange("No.", ACACourseRegistration."Student No.");
                if Recz.find('-') then;
                AccPayment := FALSE;
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", ACACourseRegistration."Student No.");
                StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
                StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                StudentCharges.SETFILTER(StudentCharges.Code, '<>%1', '');
                IF StudentCharges.FIND('-') THEN BEGIN
                    // IF NOT CONFIRM('Un-billed charges will be posted. Do you wish to continue?', FALSE) = TRUE THEN
                    //    ERROR('You have selected to Abort Student Billing');


                    // SettlementType := '';
                    // CReg.RESET;
                    // CReg.SETFILTER(CReg."Settlement Type", '<>%1', '');
                    // CReg.SETRANGE(CReg."Student No.", ACACourseRegistration."Student No.");
                    // IF CReg.FIND('-') THEN
                    //     SettlementType := CReg."Settlement Type"
                    // ELSE
                    //     ERROR('The Settlement Type Does not Exists in the Course Registration');
                    if SettlementType = '' then
                        SettlementType := 'KUCCPS';

                    SettlementTypes.GET(SettlementType);
                    SettlementTypes.TESTFIELD(SettlementTypes."Tuition G/L Account");




                    // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS BY BKK...//
                    IF StudentCharges.COUNT = 1 THEN BEGIN
                        Recz.CALCFIELDS(Balance);
                        IF Recz.Balance < 0 THEN BEGIN
                            IF ABS(Recz.Balance) > StudentCharges.Amount THEN BEGIN
                                Recz."Application Method" := Recz."Application Method"::Manual;
                                AccPayment := TRUE;
                                Recz.MODIFY;
                            END;
                        END;
                    END;

                END;


                //ERROR('TESTING '+FORMAT("Application Method"));

                IF Cust.GET(Recz."No.") THEN;

                //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

                //Charge Student if not charged
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", Recz."No.");
                StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
                IF StudentCharges.FIND('-') THEN BEGIN

                    REPEAT

                        DueDate := StudentCharges.Date;
                        IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                            IF Sems.From <> 0D THEN BEGIN
                                IF Sems.From > DueDate THEN
                                    DueDate := Sems.From;
                            END;
                        END;

                        GenJnl2.RESET;
                        GenJnl2.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl2.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl2.FIND('+') THEN;

                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl2."Line No." + 10000;
                        GenJnl."Posting Date" := TODAY;
                        GenJnl."Document No." := StudentCharges."Transacton ID";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        //
                        IF Cust.GET(Recz."No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := Recz."No.";
                        END;

                        GenJnl.Amount := StudentCharges.Amount;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := StudentCharges.Description;
                        GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                        IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                           (StudentCharges.Charge = FALSE) THEN BEGIN
                            GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                            CReg.RESET;
                            CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                            CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                            CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                            IF CReg.FIND('-') THEN BEGIN
                                IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                                    Stages.RESET;
                                    Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                                    Stages.SETRANGE(Stages.Code, CReg.Stage);
                                    IF Stages.FIND('-') THEN BEGIN
                                        IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                                            CReg.CALCFIELDS(CReg."Units Taken");
                                            IF CReg.Modules <> CReg."Units Taken" THEN
                                                ERROR('Units Taken must be equal to the no of modules registered for.');

                                        END;
                                    END;
                                END;

                                CReg.Posted := TRUE;
                                CReg.MODIFY;
                            END;


                        END ELSE
                            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                               (StudentCharges.Charge = FALSE) THEN BEGIN
                                //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
                                StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";


                                CReg.RESET;
                                CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                IF CReg.FIND('-') THEN BEGIN
                                    CReg.Posted := TRUE;
                                    CReg.MODIFY;
                                END;



                            END ELSE
                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                                    IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                        GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                                END ELSE
                                    IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                        IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                        StudentCharges.Code) THEN
                                            GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                                    END ELSE
                                        IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                           (StudentCharges.Charge = TRUE) THEN BEGIN
                                            IF Charges.GET(StudentCharges.Code) THEN
                                                GenJnl."Bal. Account No." := Charges."G/L Account";
                                        END;


                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                        GenJnl."Shortcut Dimension 1 Code" := Recz."Global Dimension 1 Code";
                        IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                            Prog.TESTFIELD(Prog."Department Code");
                            GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                        END;



                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                        GenJnl."Due Date" := DueDate;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        IF StudentCharges."Recovery Priority" <> 0 THEN;
                        //     GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                        // ELSE
                        //     GenJnl."Recovery Priority" := 25;
                        GenJnl.INSERT;

                        //Distribute Money
                        IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                                    Stages.TESTFIELD(Stages."Distribution Account");
                                    StudentCharges.TESTFIELD(StudentCharges.Distribution);
                                    IF Cust.GET(Recz."No.") THEN BEGIN
                                        CustPostGroup.GET(Cust."Customer Posting Group");

                                        GenJnl2.RESET;
                                        GenJnl2.SETRANGE("Journal Template Name", 'SALES');
                                        GenJnl2.SETRANGE("Journal Batch Name", 'STUD PAY');
                                        IF GenJnl2.FIND('+') THEN;
                                        GenJnl.INIT;
                                        GenJnl."Line No." := GenJnl2."Line No." + 10000;
                                        GenJnl."Posting Date" := TODAY;
                                        GenJnl."Document No." := StudentCharges."Transacton ID";
                                        //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                        GenJnl.VALIDATE(GenJnl."Document No.");
                                        GenJnl."Journal Template Name" := 'SALES';
                                        GenJnl."Journal Batch Name" := 'STUD PAY';
                                        GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                        //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                        GenJnl."Account No." := SettlementTypes."Tuition G/L Account";
                                        GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                        GenJnl.VALIDATE(GenJnl."Account No.");
                                        GenJnl.VALIDATE(GenJnl.Amount);
                                        GenJnl.Description := 'Fee Distribution';
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                        //GenJnl."Bal. Account No.":=Stages."Distribution Account";

                                        StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                        SettlementTypes.GET(StudentCharges."Settlement Type");
                                        GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                        GenJnl."Shortcut Dimension 1 Code" := Recz."Global Dimension 1 Code";
                                        IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                            Prog.TESTFIELD(Prog."Department Code");
                                            GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                        END;

                                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                                        GenJnl.INSERT;

                                    END;
                                END;
                            END;
                        END ELSE BEGIN
                            //Distribute Charges
                            IF StudentCharges.Distribution > 0 THEN BEGIN
                                StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
                                IF Charges.GET(StudentCharges.Code) THEN BEGIN
                                    Charges.TESTFIELD(Charges."G/L Account");

                                    GenJnl2.RESET;
                                    GenJnl2.SETRANGE("Journal Template Name", 'SALES');
                                    GenJnl2.SETRANGE("Journal Batch Name", 'STUD PAY');
                                    IF GenJnl2.FIND('+') THEN;
                                    GenJnl.INIT;
                                    GenJnl."Line No." := GenJnl2."Line No." + 10000;
                                    GenJnl."Posting Date" := TODAY;
                                    GenJnl."Document No." := StudentCharges."Transacton ID";
                                    GenJnl.VALIDATE(GenJnl."Document No.");
                                    GenJnl."Journal Template Name" := 'SALES';
                                    GenJnl."Journal Batch Name" := 'STUD PAY';
                                    GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                    GenJnl."Account No." := StudentCharges."Distribution Account";
                                    GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                    GenJnl.VALIDATE(GenJnl."Account No.");
                                    GenJnl.VALIDATE(GenJnl.Amount);
                                    GenJnl.Description := 'Fee Distribution';
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                    GenJnl."Bal. Account No." := Charges."G/L Account";
                                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                    GenJnl."Shortcut Dimension 1 Code" := Recz."Global Dimension 1 Code";

                                    IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                        Prog.TESTFIELD(Prog."Department Code");
                                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                    END;
                                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                    GenJnl.INSERT;

                                END;
                            END;
                        END;
                        //End Distribution


                        StudentCharges.Recognized := TRUE;
                        StudentCharges.MODIFY;
                        //.......BY BKK
                        StudentCharges.Posted := TRUE;
                        StudentCharges.MODIFY;

                        CReg.Posted := TRUE;
                        CReg.MODIFY;


                    //.....END BKK

                    UNTIL StudentCharges.NEXT = 0;


                    /*
                    GenJnl.SETRANGE("Journal Template Name",'SALES');
                    GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                    REPEAT
                    GLPosting.RUN(GenJnl);
                    UNTIL GenJnl.NEXT = 0;
                    END;


                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name",'SALES');
                    GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                    GenJnl.DELETEALL;
                    */


                    //Post New


                    Recz."Application Method" := Recz."Application Method"::"Apply to Oldest";
                    Cust.Status := Cust.Status::Current;
                    Cust.MODIFY;

                END;


                //BILLING

                // StudentPayments.RESET;
                // StudentPayments.SETRANGE(StudentPayments."Student No.", Recz."No.");
                // IF StudentPayments.FIND('-') THEN
                //     StudentPayments.DELETEALL;


                // StudentPayments.RESET;
                // StudentPayments.SETRANGE(StudentPayments."Student No.", Recz."No.");
                // IF AccPayment = TRUE THEN BEGIN
                //     IF Cust.GET(Recz."No.") THEN
                //         Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                //     Cust.MODIFY;
                // END;
                //  PAGE.RUN(Page::"ACA-Student Payments Form", StudentPayments);

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        Prog: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";
        Recz: Record Customer;
        AccPayment: Boolean;
        SettlementType: Code[20];
        myInt: Integer;
        SettlementTypes: Record "ACA-Settlement Type";
        GenJnl2: Record "Gen. Journal Line";
}
