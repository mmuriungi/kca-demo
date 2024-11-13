table 50721 "Aca-Charge Addition"
{
    LookupPageId = "Aca-Charge Additions";
    DrillDownPageId = "Aca-Charge Additions";
    fields
    {
        field(1; "No."; Code[30])
        {

        }
        field(2; "Document date"; date)
        {

        }
        field(3; "Posting Date"; Date)
        {
            trigger OnValidate()
            begin
                Description := 'Additional Charge posting as at ' + Format("Posting Date");
            end;

        }

        field(5; Description; Text[100])
        {

        }
        field(6; "Academic Year"; code[30])
        {
            TableRelation = "ACA-Academic Year"."Code";
        }
        field(7; "Semester"; code[30])
        {
            TableRelation = "ACA-Semesters"."Code";
        }
        field(8; "Posted"; Boolean)
        {

        }

        field(10; "User Name"; code[20])
        {

        }

    }

    var
        Gensetup: Record "ACA-General Set-Up";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            Gensetup.Get();
            "No." := NoSeriesManagement.GetNextNo(Gensetup."Charge Addition", 0D, True);
            "Document date" := Today;
            "User Name" := UserId;

        end;
    end;

    var
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
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        SettlementType: Record "ACA-Settlement Type";
        Prog: Record "ACA-Programme";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bill_StudentsCaptionLbl: Label 'Bill Students';
        //Prepayments calculation
        acacharges: Record "ACA-Std Charges";
        acacharges2: Record "ACA-Std Charges";
        // RcptPay: Record "ACA-Std Receipts";
        PaidAmount: Decimal;
        PaidRemaining: Decimal;
        PaidUtilized: Decimal;
        AmountToPay: Decimal;
        //Prepayment: Record "ACA-Std Receipts Prepayments";
        //Prepayment1: Record "ACA-Std Receipts Prepayments";
        studPPAmount: Decimal;
        studChargeAMT: Decimal;
        cust2: Record Customer;
        sno: Integer;

    procedure PostCharge(var addCharge: Record "Aca-Charge Addition")
    var
        chargeHeader: Record "Aca-Charge Addition";
        ChargeLine: Record "Aca-Charge Addition Lines";
    begin
        //Billing
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;


        GenSetUp.GET();
        GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
        PaidRemaining := 0;
        sno := 0;
        chargeHeader.Reset();
        chargeHeader.SetRange("No.", addCharge."No.");
        chargeHeader.SetRange(Posted, false);
        if chargeHeader.Find('-') then begin

            ChargeLine.Reset();
            ChargeLine.SetRange("Document No.", chargeHeader."No.");
            ChargeLine.SetRange(Posted, false);
            if ChargeLine.Find('-') then begin
                repeat
                    Clear(studChargeAMT);
                    ChargeLine.TestField(Amount);
                    studChargeAMT := ChargeLine.Amount;
                    //ChargeLine.CalcFields("Student Prepaid");
                    // clear(PaidRemaining);
                    PaidRemaining := ChargeLine."Student Prepaid";
                    sno := sno + 1;
                    clear(DueDate);
                    DueDate := chargeHeader."Posting Date";



                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    if DueDate <> 0D then
                        GenJnl."Posting Date" := DueDate
                    else
                        GenJnl."Posting Date" := TODAY;
                    GenJnl."Document No." := ChargeLine."Transaction ID";
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                    GenJnl."Account No." := ChargeLine."Student No.";
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.Amount := ChargeLine.Amount;
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl.Description := ChargeLine."Charge Description" + ' ' + ChargeLine.Semester;
                    GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                    GenJnl."Bal. Account No." := ChargeLine."Income Account";
                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                    Cust.get(ChargeLine."Student No.");
                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");

                    GenJnl."Shortcut Dimension 2 Code" := Cust."Global Dimension 2 Code";
                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                    GenJnl."Recovery Priority" := ChargeLine.Priority;

                    IF GenJnl.Amount <> 0 THEN;
                    GenJnl.INSERT;


                    StudentCharges.Init();
                    StudentCharges.Amount := ChargeLine.Amount;
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                    StudentCharges."Code" := ChargeLine."Charge Code";
                    StudentCharges."Date" := chargeHeader."Posting Date";
                    StudentCharges.Description := ChargeLine."Charge Description";
                    StudentCharges."Distribution Account" := ChargeLine."Income Account";
                    StudentCharges.Programme := ChargeLine.Programme;
                    StudentCharges.Recognized := true;
                    StudentCharges."Reg. Transacton ID" := ChargeLine."Reg. Transacton ID";
                    StudentCharges."Student No." := ChargeLine."Student No.";
                    StudentCharges."Student Name" := ChargeLine."Student Name";
                    StudentCharges.Semester := ChargeLine.Semester;
                    StudentCharges.Stage := ChargeLine.Stage;
                    StudentCharges."Transacton ID" := ChargeLine."Transaction ID";
                    StudentCharges."Recovery Priority" := ChargeLine.Priority;
                    StudentCharges.Validate("Transacton ID");
                    StudentCharges.Recognized := TRUE;
                    StudentCharges.Insert();
                until ChargeLine.Next() = 0;



            end;

            //Post 
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name", 'SALES');
            GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
            IF GenJnl.FindSet() THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnl);
            END;
            ChargeLine.Posted := true;
            ChargeLine.Modify();


        end;
        chargeHeader.Posted := true;
        chargeHeader.Modify();
    end;



}