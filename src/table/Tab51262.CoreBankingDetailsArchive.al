#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51262 "Core_Banking_Details Archive"
{

    fields
    {
        field(2; "Statement No"; Code[20])
        {
        }
        field(3; Bank_Code; Code[20])
        {
        }
        field(4; "Transaction Number"; Code[20])
        {
        }
        field(5; "Transaction Date"; Date)
        {
        }
        field(6; "Posting Status"; Option)
        {
            OptionCaption = 'New,Posted,Repeat (Not Posted),Student Missing';
            OptionMembers = New,Posted,"Repeat (Not Posted)","Student Missing";
        }
        field(7; "Transaction Description"; Text[50])
        {
        }
        field(8; "Student No."; Code[20])
        {
        }
        field(9; "Transaction Occurences"; Integer)
        {
            CalcFormula = count(Core_Banking_Details where("Transaction Number" = field("Transaction Number")));
            FieldClass = FlowField;
        }
        field(10; "Trans. Amount"; Decimal)
        {
        }
        field(11; "Core_Banking Status"; Option)
        {
            CalcFormula = lookup(Core_Banking_Stud_Exists_Statu."Core_Banking Status" where("Exists in Customer" = field("Exists in Customer"),
                                                                                             "Exists in KUCCPS Import" = field("Exists in KUCCPS Import")));
            FieldClass = FlowField;
            OptionCaption = ' ,Student,KUCCPS Import';
            OptionMembers = " ",Student,"KUCCPS Import";
        }
        field(12; "Exists in Customer"; Boolean)
        {
            CalcFormula = exist(Customer where("No." = field("Student No."),
                                                "Customer Posting Group" = filter('STUDENT')));
            FieldClass = FlowField;
        }
        field(13; "Exists in KUCCPS Import"; Boolean)
        {
            CalcFormula = exist("KUCCPS Imports" where(Admin = field("Student No.")));
            FieldClass = FlowField;
        }
        field(14; Posted; Boolean)
        {

            trigger OnValidate()
            var
                Customer: Record customer;
            begin
            end;
        }
        field(15; "Receipt Exists"; Boolean)
        {
            CalcFormula = exist("ACA-Std Payments" where("Student No." = field("Student No."),
                                                          "Cheque No" = field("Transaction Number")));
            FieldClass = FlowField;
        }
        field(16; "Student Name"; Text[250])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Student No."),
                                                      "Customer Posting Group" = filter('STUDENT')));
            Enabled = true;
            FieldClass = FlowField;
        }
        field(17; Selected; Boolean)
        {
        }
        field(18; "Exists In Pesaflow"; Boolean)
        {
            CalcFormula = exist("PesaFlow Intergration" where(PaymentRefID = field("Transaction Number")));
            FieldClass = FlowField;
        }
        field(19; "Pesa Flow Stud. Ref."; Code[20])
        {
            CalcFormula = lookup("PesaFlow Intergration".CustomerRefNo where(PaymentRefID = field("Transaction Number")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Statement No", Bank_Code, "Transaction Number", "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        CoreBankingDetailsArchive.Init;
        CoreBankingDetailsArchive."Statement No" := Rec."Statement No";
        CoreBankingDetailsArchive.Bank_Code := Rec.Bank_Code;
        CoreBankingDetailsArchive."Transaction Number" := Rec."Transaction Number";
        CoreBankingDetailsArchive."Transaction Date" := Rec."Transaction Date";
        CoreBankingDetailsArchive."Posting Status" := Rec."Posting Status";
        CoreBankingDetailsArchive."Transaction Description" := Rec."Transaction Description";
        CoreBankingDetailsArchive."Student No." := Rec."Student No.";
        CoreBankingDetailsArchive."Transaction Occurences" := Rec."Transaction Occurences";
        CoreBankingDetailsArchive."Trans. Amount" := Rec."Trans. Amount";
        CoreBankingDetailsArchive."Core_Banking Status" := Rec."Core_Banking Status";
        CoreBankingDetailsArchive."Exists in Customer" := Rec."Exists in Customer";
        CoreBankingDetailsArchive."Exists in KUCCPS Import" := Rec."Exists in KUCCPS Import";
        CoreBankingDetailsArchive.Posted := Rec.Posted;
        CoreBankingDetailsArchive."Receipt Exists" := Rec."Receipt Exists";
        CoreBankingDetailsArchive."Student Name" := Rec."Student Name";
        CoreBankingDetailsArchive.Selected := Rec.Selected;
        CoreBankingDetailsArchive."Exists In Pesaflow" := Rec."Exists In Pesaflow";
        CoreBankingDetailsArchive."Pesa Flow Stud. Ref." := Rec."Pesa Flow Stud. Ref.";
        CoreBankingDetailsArchive.Insert;
    end;

    var
        Core_Banking_ActiveStatements: Record "Core_Banking_Active Statements";
        UserSetup: Record "User Setup";
        CoreBankingDetailsArchive: Record "Core_Banking_Details Archive";


    /*  procedure PostReceiptsFromBuffer(var CoreBankingDetails: Record "Core_Banking_Details Archive")
     var
         CoreBankingDetails: Record Core_Banking_Details;
         ACAStudentReceipts: Record "ACA-Std Payments";
         ACACourseRegistration: Record "ACA-Course Registration";
         ACAStudentReceipts2: Record "ACA-Std Payments";
     begin
         //****************************************
         Clear(Customer);
         Customer.Reset;
         Customer.SetRange("No.", CoreBankingDetails."Student No.");
         if not (Customer.Find('-')) then exit;
         Clear(ACACourseRegistration);
         ACACourseRegistration.Reset;
         ACACourseRegistration.SetRange("Student No.", CoreBankingDetails."Student No.");
         ACACourseRegistration.SetRange(Reversed, false);
         if ACACourseRegistration.Find('-') then;
         //*************************************************
         ACAStudentReceipts.Init;
         ACAStudentReceipts."Student No." := CoreBankingDetails."Student No.";
         ACAStudentReceipts."User ID" := UserId;
         ACAStudentReceipts."Cheque No" := CoreBankingDetails."Transaction Number";
         ACAStudentReceipts."Drawer Name" := 'AUTO';
         // ACAStudentReceipts."Drawer Bank" := ACAStudentReceipts."Drawer Bank"::;
         ACAStudentReceipts."Amount to pay" := CoreBankingDetails."Trans. Amount";
         ACAStudentReceipts."Payment Mode" := ACAStudentReceipts."payment mode"::"Bank Slip";
         ACAStudentReceipts.Programme := ACACourseRegistration.Programme;
         ACAStudentReceipts."Bank No." := CoreBankingDetails.Bank_Code;
         ACAStudentReceipts."Payment By" := CoreBankingDetails."Student No.";
         ACAStudentReceipts."Bank Slip Date" := CoreBankingDetails."Transaction Date";
         ACAStudentReceipts."Transaction Date" := CoreBankingDetails."Transaction Date";
         ACAStudentReceipts."Auto Post" := true;
         ACAStudentReceipts.Semester := ACACourseRegistration.Semester;
         if ACAStudentReceipts.Insert then begin
             Clear(ACAStudentReceipts2);
             ACAStudentReceipts2.Reset;
             ACAStudentReceipts2.SetRange("Student No.", CoreBankingDetails."Student No.");
             ACAStudentReceipts2.SetRange("Cheque No", CoreBankingDetails."Transaction Number");
             ACAStudentReceipts2.SetRange(Semester, ACACourseRegistration.Semester);
             if ACAStudentReceipts2.Find('-') then
                 Post(ACAStudentReceipts2);
         end;
         CoreBankingDetails.Posted := true;
         CoreBankingDetails."Posting Status" := CoreBankingDetails."posting status"::Posted;
         CoreBankingDetails.Modify;
     end;
  */
    local procedure Post(ACAStdPayments: Record "ACA-Std Payments")
    var
        cust2: Record Customer;
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
        TotalApplied: Decimal;
        Sems: Record "ACA-Semesters";
        DueDate: Date;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CReg: Record "ACA-Course Registration";
        CustLedg: Record "Cust. Ledger Entry";
        StudentPay: Record "ACA-Std Payments";
        ProgrammeSetUp: Record "ACA-Programme";
        CourseReg: Code[20];
        LastReceiptNo: Code[20];
        "No. Series Line": Record "No. Series Line";
        "Last No": Code[20];
        Prog: Record "ACA-Programme";
        BankRec: Record "Bank Account";
        [InDataSet]
        "Amount to payEnable": Boolean;
        [InDataSet]
        "Cheque NoEnable": Boolean;
        [InDataSet]
        "Drawer NameEnable": Boolean;
        [InDataSet]
        "Bank No.Enable": Boolean;
        [InDataSet]
        "Bank Slip DateEnable": Boolean;
        [InDataSet]
        "Applies to Doc NoEnable": Boolean;
        [InDataSet]
        "Apply to OverpaymentEnable": Boolean;
        [InDataSet]
        "CDF AccountEnable": Boolean;
        [InDataSet]
        "CDF DescriptionEnable": Boolean;
        [InDataSet]
        ApplicationEnable: Boolean;
        [InDataSet]
        "Unref. Entry No.Enable": Boolean;
        [InDataSet]
        "Staff Invoice No.Enable": Boolean;
        [InDataSet]
        "Staff DescriptionEnable": Boolean;
        [InDataSet]
        "Payment ByEnable": Boolean;
        StudHostel: Record "ACA-Students Hostel Rooms";
        HostLedg: Record "ACA-Hostel Ledger";
        BankName: Text[100];
    begin
        with ACAStdPayments do begin

            Validate("Cheque No");
            if Posted then exit;
            TestField("Transaction Date");
            //IF CONFIRM('Do you want to post the transaction?',TRUE) = FALSE THEN BEGIN
            //EXIT;
            //END;
            if (("Payment Mode" = "payment mode"::"Bank Slip") or ("Payment Mode" = "payment mode"::Cheque)) then begin
                TestField("Bank Slip Date");
                TestField("Bank No.");
            end;
            CustLedg.Reset;
            CustLedg.SetRange(CustLedg."Customer No.", "Student No.");
            CustLedg.SetRange(CustLedg.Open, true);
            CustLedg.SetRange(CustLedg.Reversed, false);
            if CustLedg.Find('-') then begin
                repeat
                    TotalApplied := TotalApplied + CustLedg."Amount Applied";
                until CustLedg.Next = 0;
            end;

            if "Amount to pay" > TotalApplied then begin
                // // IF CONFIRM('There is an overpayment. Do you want to continue?',FALSE) = FALSE THEN
                // //  BEGIN
                // // EXIT;
                // // END;

            end;

            if Cust.Get("Student No.") then begin
                Cust."Application Method" := Cust."application method"::"Apply to Oldest";
                Cust.CalcFields(Balance);
                if Cust.Status = Cust.Status::"New Admission" then begin
                    if ((Cust.Balance = 0) or (Cust.Balance < 0)) then begin
                        Cust.Status := Cust.Status::Current;
                    end else begin
                        Cust.Status := Cust.Status::"New Admission";
                    end;
                end else begin
                    Cust.Status := Cust.Status::Current;
                end;
                Cust.Modify;
            end;

            if Cust.Get("Student No.") then
                GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            GenJnl.DeleteAll;

            GenSetUp.Get();
            GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            GenJnl.DeleteAll;

            GenSetUp.TestField(GenSetUp."Pre-Payment Account");
            /*
            //Charge Student if not charged
            StudentCharges.RESET;
            StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
            StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
            IF StudentCharges.FIND('-') THEN BEGIN

            REPEAT

            DueDate:=StudentCharges.Date;
            IF Sems.GET(StudentCharges.Semester) THEN BEGIN
            IF Sems.From<>0D THEN BEGIN
            IF Sems.From > DueDate THEN
            DueDate:=Sems.From;
            END;
            END;

            GenJnl.INIT;
            GenJnl."Line No." := GenJnl."Line No." + 10000;
            GenJnl."Posting Date":=TODAY;
            GenJnl."Document No.":=StudentCharges."Transacton ID";
            GenJnl.VALIDATE(GenJnl."Document No.");
            GenJnl."Journal Template Name":='SALES';
            GenJnl."Journal Batch Name":='STUD PAY';
            GenJnl."Account Type":=GenJnl."Account Type"::Customer;
            //
            IF Cust.GET("Student No.") THEN BEGIN
            IF Cust."Bill-to Customer No." <> '' THEN
            GenJnl."Account No.":=Cust."Bill-to Customer No."
            ELSE
            GenJnl."Account No.":="Student No.";
            END;

            GenJnl.Amount:=StudentCharges.Amount;
            GenJnl.VALIDATE(GenJnl."Account No.");
            GenJnl.VALIDATE(GenJnl.Amount);
            GenJnl.Description:=StudentCharges.Description;
            GenJnl."Bal. Account Type":=GenJnl."Account Type"::"G/L Account";

            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
               (StudentCharges.Charge = FALSE) THEN BEGIN
            GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";

            CReg.RESET;
            CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
            CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
            CReg.SETRANGE(CReg."Student No.",StudentCharges."Student No.");
            IF CReg.FIND('-') THEN BEGIN
            IF CReg."Register for"=CReg."Register for"::Stage THEN BEGIN
            Stages.RESET;
            Stages.SETRANGE(Stages."Programme Code",CReg.Programmes);
            Stages.SETRANGE(Stages.Code,CReg.Stage);
            IF Stages.FIND('-') THEN BEGIN
            IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units"= FALSE) THEN BEGIN
            CReg.CALCFIELDS(CReg."Units Taken");
            IF CReg. Modules <> CReg."Units Taken" THEN
            ERROR('Units Taken must be equal to the no of modules registered for.');

            END;
            END;
            END;

            CReg.Posted:=TRUE;
            CReg.MODIFY;
            END;


            END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                        (StudentCharges.Charge = FALSE) THEN BEGIN
            GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";

            CReg.RESET;
            CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
            CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
            IF CReg.FIND('-') THEN BEGIN
            CReg.Posted:=TRUE;
            CReg.MODIFY;
            END;

            END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
            IF ExamsByStage.GET(StudentCharges.Programme,StudentCharges.Stage,StudentCharges.Semester,StudentCharges.Code) THEN
            GenJnl."Bal. Account No.":=ExamsByStage."G/L Account";

            END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
            IF ExamsByUnit.GET(StudentCharges.Programme,StudentCharges.Stage,ExamsByUnit."Unit Code",StudentCharges.Semester,
            StudentCharges.Code) THEN
            GenJnl."Bal. Account No.":=ExamsByUnit."G/L Account";

            END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                        (StudentCharges.Charge = TRUE) THEN BEGIN
            IF Charges.GET(StudentCharges.Code) THEN
            GenJnl."Bal. Account No.":=Charges."G/L Account";
            END;
            GenJnl.VALIDATE(GenJnl."Bal. Account No.");

            CReg.RESET;
            CReg.SETRANGE(CReg."Student No.","Student No.");
            CReg.SETRANGE(CReg.Reversed,FALSE) ;
            IF CReg.FIND('+') THEN BEGIN
            IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
            ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
            //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
            GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
            IF cust2.GET("Student No.") THEN;
            IF cust2."Global Dimension 2 Code"  = '' THEN
              cust2."Global Dimension 2 Code":=ProgrammeSetUp."Department Code";
            IF cust2."Global Dimension 2 Code"<>'' THEN BEGIN

            GenJnl."Shortcut Dimension 2 Code":=cust2."Global Dimension 2 Code"
            END
            ELSE
              GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
              IF cust2."Global Dimension 2 Code" = ''   THEN
               ERROR('Department code is missing!')

            END;
            END;
            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

            GenJnl."Due Date":=DueDate;
            GenJnl.VALIDATE(GenJnl."Due Date");
            IF StudentCharges."Recovery Priority" <> 0 THEN
            GenJnl."Recovery Priority":=StudentCharges."Recovery Priority"
            ELSE
            GenJnl."Recovery Priority":=25;
            IF GenJnl.Amount<>0 THEN
            GenJnl.INSERT;

            //Distribute Money
            IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
            IF Stages.GET(StudentCharges.Programme,StudentCharges.Stage) THEN BEGIN
            IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
            Stages.TESTFIELD(Stages."Distribution Account");
            StudentCharges.TESTFIELD(StudentCharges.Distribution);
            IF Cust.GET("Student No.") THEN BEGIN
            CustPostGroup.GET(Cust."Customer Posting Group");

            GenJnl.INIT;
            GenJnl."Line No." := GenJnl."Line No." + 10000;
            GenJnl."Posting Date":=TODAY;
            GenJnl."Document No.":=ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
            GenJnl.VALIDATE(GenJnl."Document No.");
            GenJnl."Journal Template Name":='SALES';
            GenJnl."Journal Batch Name":='STUD PAY';
            GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
            GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
            GenJnl."Account No.":=GenSetUp."Pre-Payment Account";
            GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
            GenJnl.VALIDATE(GenJnl."Account No.");
            GenJnl.VALIDATE(GenJnl.Amount);
            GenJnl.Description:='Fee Distribution';
            GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
            GenJnl."Bal. Account No.":=Stages."Distribution Account";
            GenJnl.VALIDATE(GenJnl."Bal. Account No.");

            CReg.RESET;
            CReg.SETRANGE(CReg."Student No.","Student No.");
            CReg.SETRANGE(CReg.Reversed,FALSE) ;
            IF CReg.FIND('+') THEN BEGIN
            IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
            ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
            GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
            GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
            END;
            END;
            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
            IF GenJnl.Amount<>0 THEN
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
            GenJnl.INIT;
            GenJnl."Line No." := GenJnl."Line No." + 10000;
            GenJnl."Posting Date":=TODAY;
            GenJnl."Document No.":=ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
            GenJnl.VALIDATE(GenJnl."Document No.");
            GenJnl."Journal Template Name":='SALES';
            GenJnl."Journal Batch Name":='STUD PAY';
            GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
            GenJnl."Account No.":=StudentCharges."Distribution Account";
            GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
            GenJnl.VALIDATE(GenJnl."Account No.");
            GenJnl.VALIDATE(GenJnl.Amount);
            GenJnl.Description:='Fee Distribution';
            GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
            GenJnl."Bal. Account No.":=Charges."G/L Account";
            GenJnl.VALIDATE(GenJnl."Bal. Account No.");

            CReg.RESET;
            CReg.SETRANGE(CReg."Student No.","Student No.");
            CReg.SETRANGE(CReg.Reversed,FALSE) ;
            IF CReg.FIND('+') THEN BEGIN
            IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
            ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
            GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
            GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
            END;
            END;
            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
            IF GenJnl.Amount<>0 THEN
            GenJnl.INSERT;

            END;
            END;
            END;
            //End Distribution
            StudentCharges.Recognized:=TRUE;
            StudentCharges.MODIFY;
            UNTIL StudentCharges.NEXT = 0;
            //Post New
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name",'SALES');
            GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
            IF GenJnl.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B2",GenJnl);
            END;
            //Post New
            END;
            //BILLING
            */
            "Last No" := '';
            "No. Series Line".Reset;
            BankRec.Get("Bank No.");
            BankRec.TestField(BankRec."Receipt No. Series");
            "No. Series Line".SetRange("No. Series Line"."Series Code", BankRec."Receipt No. Series");
            if "No. Series Line".Find('-') then begin

                "Last No" := IncStr("No. Series Line"."Last No. Used");
                "No. Series Line"."Last No. Used" := IncStr("No. Series Line"."Last No. Used");
                "No. Series Line".Modify;
            end;
            GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            GenJnl.DeleteAll;

            Cust.CalcFields(Balance);
            if Cust.Status = Cust.Status::"New Admission" then begin
                if ((Cust.Balance = 0) or (Cust.Balance < 0)) then begin
                    Cust.Status := Cust.Status::Current;
                end else begin
                    Cust.Status := Cust.Status::"New Admission";
                end;
            end else begin
                Cust.Status := Cust.Status::Current;
            end;

            // IF "Payment Mode"="Payment Mode"::"Applies to Overpayment" THEN
            // ERROR('Overpayment must be applied manualy.');

            /////////////////////////////////////////////////////////////////////////////////
            //Receive payments
            if "Payment Mode" <> "payment mode"::"Applies to Overpayment" then begin

                //Over Payment
                TotalApplied := 0;
                CustLedg.Reset;
                CustLedg.SetRange(CustLedg."Customer No.", "Student No.");
                //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                CustLedg.SetRange(CustLedg.Open, true);
                CustLedg.SetRange(CustLedg.Reversed, false);
                if CustLedg.Find('-') then begin
                    repeat
                        TotalApplied := TotalApplied + CustLedg."Amount Applied";
                    until CustLedg.Next = 0;
                end;
                CReg.Reset;
                CReg.SetCurrentkey(CReg."Reg. Transacton ID");
                //CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
                CReg.SetRange(CReg."Student No.", "Student No.");
                if CReg.Find('+') then
                    CourseReg := CReg."Reg. Transacton ID";

                Receipt.Init;
                Receipt."Receipt No." := "Last No";
                //Receipt.VALIDATE(Receipt."Receipt No.");
                Receipt."Student No." := "Student No.";
                Receipt.Date := "Transaction Date";
                Receipt."KCA Rcpt No" := "KCA Receipt No";
                Receipt."Bank Slip Date" := "Bank Slip Date";
                Receipt."Bank Slip/Cheque No" := "Cheque No";
                Receipt.Validate("Bank Slip/Cheque No");
                Receipt."Bank Account" := "Bank No.";
                if "Payment Mode" = "payment mode"::"Bank Slip" then
                    Receipt."Payment Mode" := Receipt."payment mode"::"Bank Slip" else
                    if "Payment Mode" = "payment mode"::Cheque then
                        Receipt."Payment Mode" := Receipt."payment mode"::Cheque else
                        if "Payment Mode" = "payment mode"::Cash then
                            Receipt."Payment Mode" := Receipt."payment mode"::Cash else
                            Receipt."Payment Mode" := "Payment Mode";
                Receipt.Amount := "Amount to pay";
                Receipt."Payment By" := "Payment By";
                Receipt."Transaction Date" := Today;
                Receipt."Transaction Time" := Time;
                Receipt."User ID" := UserId;
                Receipt."Reg ID" := CourseReg;
                Receipt.Insert;

                Receipt.Reset;
                if Receipt.Find('+') then begin

                    CustLedg.Reset;
                    CustLedg.SetRange(CustLedg."Customer No.", "Student No.");
                    //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                    CustLedg.SetRange(CustLedg.Open, true);
                    CustLedg.SetRange(CustLedg.Reversed, false);
                    if CustLedg.Find('-') then begin

                        GenSetUp.Get();


                    end;

                end;

                //Bank Entry
                if BankRec.Get("Bank No.") then
                    BankName := BankRec.Name;

                if ("Payment Mode" <> "payment mode"::Unreferenced) and ("Payment Mode" <> "payment mode"::"Staff Invoice")
                and ("Payment Mode" <> "payment mode"::Weiver) and ("Payment Mode" <> "payment mode"::CDF)
                and ("Payment Mode" <> "payment mode"::HELB) then begin

                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Bank Slip Date";
                    GenJnl."Document No." := "Last No";
                    GenJnl."External Document No." := "Cheque No";
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."account type"::"Bank Account";
                    GenJnl."Account No." := "Bank No.";
                    GenJnl.Amount := "Amount to pay";
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := Format("Payment Mode") + '-' + Format("Bank Slip Date") + '-' + BankName;
                    GenJnl."Bal. Account Type" := GenJnl."bal. account type"::Customer;
                    if Cust."Bill-to Customer No." <> '' then
                        GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                    else
                        GenJnl."Bal. Account No." := "Student No.";


                    GenJnl.Validate(GenJnl."Bal. Account No.");

                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", "Student No.");
                    CReg.SetRange(CReg.Reversed, false);
                    if CReg.Find('+') then begin
                        if ProgrammeSetUp.Get(CReg.Programmes) then begin
                            ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                            //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        end;
                    end;
                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.Insert;
                end;
                if "Payment Mode" = "payment mode"::Unreferenced then begin
                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Bank Slip Date";
                    GenJnl."Document No." := "Last No";
                    GenJnl."External Document No." := "Drawer Name";
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."account type"::Customer;
                    GenJnl."Account No." := 'UNREF';
                    GenJnl.Amount := "Amount to pay";
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := Cust.Name;
                    GenJnl."Bal. Account Type" := GenJnl."bal. account type"::Customer;
                    if Cust."Bill-to Customer No." <> '' then
                        GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                    else
                        GenJnl."Bal. Account No." := "Student No.";

                    GenJnl."Applies-to Doc. No." := "Unref Document No.";
                    GenJnl.Validate(GenJnl."Applies-to Doc. No.");
                    if GenJnl.Amount <> 0 then
                        GenJnl.Insert;

                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", "Student No.");
                    CReg.SetRange(CReg.Reversed, false);
                    if CReg.Find('+') then begin
                        if ProgrammeSetUp.Get(CReg.Programmes) then begin
                            ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                            //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        end;
                    end;
                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");


                end;
                // Tripple - T...Staff Invoice
                if "Payment Mode" = "payment mode"::"Staff Invoice" then begin
                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Bank Slip Date";
                    GenJnl."Document No." := "Last No";
                    GenJnl."External Document No." := '';
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."account type"::Customer;
                    GenJnl."Account No." := "Student No.";
                    GenJnl.Amount := -"Amount to pay";
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := 'Staff Invoice No. ' + "Staff Invoice No.";
                    GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                    GenJnl."Bal. Account No." := '200012';

                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", "Student No.");
                    CReg.SetRange(CReg.Reversed, false);
                    if CReg.Find('+') then begin
                        if ProgrammeSetUp.Get(CReg.Programmes) then begin
                            ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                            //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        end;
                    end;
                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.Insert;


                end;
                // Tripple - T...CDF
                if "Payment Mode" = "payment mode"::CDF then begin
                    GenSetUp.TestField(GenSetUp."CDF Account");
                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Bank Slip Date";
                    GenJnl."Document No." := "Last No";
                    GenJnl."External Document No." := 'CDF';
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."account type"::Customer;
                    GenJnl."Account No." := "Student No.";
                    GenJnl.Amount := -"Amount to pay";
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := "CDF Description";
                    //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                    //GenJnl."Bal. Account No.":=;
                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", "Student No.");
                    CReg.SetRange(CReg.Reversed, false);
                    if CReg.Find('+') then begin
                        if ProgrammeSetUp.Get(CReg.Programmes) then begin
                            ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                            //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        end;
                    end;
                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.Insert;

                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Bank Slip Date";
                    GenJnl."Document No." := "Last No";
                    GenJnl."External Document No." := 'CDF';
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."account type"::"G/L Account";
                    GenJnl."Account No." := GenSetUp."CDF Account";
                    GenJnl.Amount := "Amount to pay";
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := "Student No.";

                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", "Student No.");
                    CReg.SetRange(CReg.Reversed, false);
                    if CReg.Find('+') then begin
                        if ProgrammeSetUp.Get(CReg.Programmes) then begin
                            ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                            //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                            GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        end;
                    end;
                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.Insert;


                end;


                if "Payment Mode" = "payment mode"::HELB then begin
                    GenSetUp.TestField(GenSetUp."Helb Account");
                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Bank Slip Date";
                    GenJnl."Document No." := "Last No";
                    GenJnl."External Document No." := '';
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."account type"::Customer;
                    GenJnl."Account No." := "Student No.";
                    GenJnl.Amount := -"Amount to pay";
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := 'HELB';
                    GenJnl."Bal. Account Type" := GenJnl."bal. account type"::"G/L Account";
                    GenJnl."Bal. Account No." := GenSetUp."Helb Account";
                    CReg.Reset;
                    CReg.SetRange(CReg."Student No.", "Student No.");
                    CReg.SetRange(CReg.Reversed, false);
                    if CReg.Find('+') then begin
                        if ProgrammeSetUp.Get(CReg.Programmes) then begin
                            GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                        end;
                    end;

                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                    if GenJnl.Amount <> 0 then
                        GenJnl.Insert;


                end;

                //Post

                GenJnl.Reset;
                GenJnl.SetRange("Journal Template Name", 'SALES');
                GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
                if GenJnl.Find('-') then begin

                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post B2", GenJnl);
                    ACAStdPayments.Posted := true;
                    ACAStdPayments.Modify;
                    Modify;
                end;
            end;
        end;

    end;
}

