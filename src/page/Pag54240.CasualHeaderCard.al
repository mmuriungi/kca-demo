page 54240 "Casual Header Card."
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Casual Payment Header.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Salaries&Wages A/c"; Rec."Salaries&Wages A/c")
                {
                    ApplicationArea = All;
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    Caption = 'Net Payable Acc';
                    ApplicationArea = All;
                }
                field("P.A.Y.E Acc"; Rec."P.A.Y.E Acc")
                {
                    ApplicationArea = All;
                }
                field("NSSF Account"; Rec."NSSF Account")
                {
                    ApplicationArea = All;
                }
                field(NHIFAccount; Rec.NHIFAccount)
                {
                    ApplicationArea = All;
                }
                field("Total Basic Amount"; Rec."Total Basic Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total PAYE"; Rec."Total PAYE")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total NHIF"; Rec."Total NHIF")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total NSSF"; Rec."Total NSSF")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Payable"; Rec."Net Payable")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Casual Payment Line.")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Payroll Period" = FIELD("Payroll Period");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Casual Salary")
            {
                Image = PostBatch;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    Rec.TESTFIELD(Posted, FALSE);
                    Rec.CALCFIELDS("Total Basic Amount", "Total NHIF", "Total NSSF", "Total PAYE");
                    Rec."Net Payable" := Rec."Total Basic Amount" - (Rec."Total NHIF" + Rec."Total NSSF" + Rec."Total PAYE");
                    "Post CasualSalaries`"();
                end;
            }
            action("Approve Casuals")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // IF UserSetup.GET(USERID)THEN
                    //   BEGIN
                    //     //IF UserSetup.Leave=TRUE THEN BEGIN
                    //       Status:=Status::Released;
                    //       MESSAGE('Document Sucessfully Realesed');
                    //       MODIFY;
                    //       END ELSE
                    //       ERROR('You do not have permission kindly contact Administrator');
                    //     END;
                    Rec.TESTFIELD("Payroll Period");
                    Rec.TESTFIELD("Payment Method");
                    Rec.CALCFIELDS("Net Payable");
                    IF Rec."Net Payable" <= 0 THEN
                        ERROR('Net payable amount must be greater than zero');
                end;
            }
            action("Print Payment Schedule")
            {
                Image = PrintVoucher;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    PaymentHeader.RESET;
                    PaymentHeader.SETRANGE(PaymentHeader."No.", Rec."No.");
                    IF PaymentHeader.FIND('-') THEN
                        REPORT.RUN(70135365, TRUE, FALSE, PaymentHeader);
                    //70135365
                end;
            }
            action("Print Bank Schedule")
            {
                Image = PrintVoucher;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Released);
                    PaymentHeader.RESET;
                    PaymentHeader.SETRANGE(PaymentHeader."No.", Rec."No.");
                    IF PaymentHeader.FIND('-') THEN
                        REPORT.RUN(70135366, TRUE, FALSE, PaymentHeader);
                    //70135365
                end;
            }
        }
    }

    var
        CashMgtSetup: Record "FIN-Cash Office Setup";
        GenJnlLine: Record 81;
        JournalTemplate: Code[50];
        JournalBatch: Code[50];
        Casualline: Record "Casual Payment Lines.";
        TotalWage: Decimal;
        UserSetup: Record 91;
        PaymentHeader: Record "Casual Payment Header.";

    local procedure "Post CasualSalaries`"()
    begin
        CashMgtSetup.GET();
        CashMgtSetup.TESTFIELD(CashMgtSetup."Payroll Template");
        CashMgtSetup.TESTFIELD(CashMgtSetup."Payroll  Batch");
        //CashMgtSetup.TESTFIELD('CASUAL SALARY');
        //CashMgtSetup.TESTFIELD('CASUAL SALARY');

        JournalTemplate := CashMgtSetup."Payroll Template";
        JournalBatch := CashMgtSetup."Payroll  Batch";

        //....... DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        GenJnlLine.DELETEALL;

        //.................INSERT THE NET AMOUNT TRANSACTION................

        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := CashMgtSetup."Payroll Template";
        GenJnlLine."Journal Batch Name" := CashMgtSetup."Payroll  Batch";
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := Rec."Salary Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Net Payable");

        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF Rec.Remarks <> '' THEN
            GenJnlLine.Description := Rec.Remarks
        ELSE
            GenJnlLine.Description := Rec.Payee + ': Casual Net Payee -' + Rec."No.";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine."Reason Code" := 'CASUAL SALARY';
        GenJnlLine."Source Code" := 'CASUAL SALARY';
        Casualline.RESET;
        Casualline.SETRANGE(Casualline."Document No.", Rec."No.");
        IF Casualline.FIND('-') THEN BEGIN
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        END;
        //Validate dimensionsSH
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.INSERT;
        //*************** INSERT PAYE Transactions**************************
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := CashMgtSetup."Payroll Template";
        GenJnlLine."Journal Batch Name" := CashMgtSetup."Payroll  Batch";
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := Rec."P.A.Y.E Acc";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Total PAYE");

        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF Rec.Remarks <> '' THEN
            GenJnlLine.Description := Rec.Remarks
        ELSE
            GenJnlLine.Description := Rec.Payee + ': Casual PAYE -' + Rec."No.";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine."Reason Code" := 'CASUAL SALARY';
        GenJnlLine."Source Code" := 'CASUAL SALARY';
        Casualline.RESET;
        Casualline.SETRANGE(Casualline."Document No.", Rec."No.");
        IF Casualline.FIND('-') THEN BEGIN
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        END;
        //Validate dimensionsSH
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.INSERT;
        //************INSERT NHIF TRANSACTIONS ***********
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := CashMgtSetup."Payroll Template";
        GenJnlLine."Journal Batch Name" := CashMgtSetup."Payroll  Batch";
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := Rec.NHIFAccount;
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Total NHIF");

        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF Rec.Remarks <> '' THEN
            GenJnlLine.Description := Rec.Remarks
        ELSE
            GenJnlLine.Description := Rec.Payee + ': Casual NHIF -' + Rec."No.";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine."Reason Code" := 'CASUAL SALARY';
        GenJnlLine."Source Code" := 'CASUAL SALARY';
        Casualline.RESET;
        Casualline.SETRANGE(Casualline."Document No.", Rec."No.");
        IF Casualline.FIND('-') THEN BEGIN
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        END;
        //Validate dimensionsSH
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.INSERT;
        //*******************Insert NSSF Transactions***********
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := CashMgtSetup."Payroll Template";
        GenJnlLine."Journal Batch Name" := CashMgtSetup."Payroll  Batch";
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := Rec."NSSF Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Total NSSF");

        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF Rec.Remarks <> '' THEN
            GenJnlLine.Description := Rec.Remarks
        ELSE
            GenJnlLine.Description := Rec.Payee + ': Casual NSSF -' + Rec."No.";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine."Reason Code" := 'CASUAL SALARY';
        GenJnlLine."Source Code" := 'CASUAL SALARY';
        Casualline.RESET;
        Casualline.SETRANGE(Casualline."Document No.", Rec."No.");
        IF Casualline.FIND('-') THEN BEGIN
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        END;
        //Validate dimensionsSH
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.INSERT;
        ///************************Insert Balancing Transactions******************

        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := CashMgtSetup."Payroll Template";
        GenJnlLine."Journal Batch Name" := CashMgtSetup."Payroll  Batch";
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := Rec."Salaries&Wages A/c";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        TotalWage := 0;
        Rec.CALCFIELDS("Total NHIF", "Total Basic Amount", "Total NSSF", "Total PAYE");
        TotalWage := Rec."Total NHIF" + Rec."Total NSSF" + Rec."Total PAYE" + Rec."Net Payable";
        GenJnlLine.Amount := (TotalWage);

        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF Rec.Remarks <> '' THEN
            GenJnlLine.Description := Rec.Remarks
        ELSE
            GenJnlLine.Description := Rec.Payee + ': Total casual Payment -' + Rec."No.";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine."Reason Code" := 'CASUAL SALARY';
        GenJnlLine."Source Code" := 'CASUAL SALARY';
        Casualline.RESET;
        Casualline.SETRANGE(Casualline."Document No.", Rec."No.");
        IF Casualline.FIND('-') THEN BEGIN
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        END;
        //Validate dimensionsSH
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.INSERT;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JournalBatch);
        IF GenJnlLine.FIND('-') THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
        Casualline.RESET;
        Casualline.SETRANGE(Casualline."Document No.", Rec."No.");
        IF Casualline.FIND('-') THEN
            Casualline.Status := Casualline.Status::Fulfilled
    end;
}

