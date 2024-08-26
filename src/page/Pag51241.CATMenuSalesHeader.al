page 51241 "CAT-Menu Sales Header"
{
    PageType = Document;
    SourceTable = "CAT-Menu Sale Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            group(weter)
            {
                field("Receipt No"; Rec."Receipt No")
                {
                    Editable = true;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        IF (Rec."Customer Type" = Rec."Customer Type"::Staff) OR (Rec."Customer Type" = Rec."Customer Type"::Department) THEN BEGIN
                            "Paid AmountEditable" := FALSE;
                            BalanceEditable := FALSE;
                        END
                        ELSE BEGIN
                            "Paid AmountEditable" := TRUE;
                            // CurrForm.Balance.editable:=true;
                        END;
                    end;
                }
                field("Sales Type"; Rec."Sales Type")
                {

                    trigger OnValidate()
                    begin
                        IF (Rec."Sales Type" = Rec."Sales Type"::Prepayment) THEN BEGIN
                            "Paid AmountEditable" := FALSE;
                            "Customer NoEditable" := TRUE;
                        END
                        ELSE BEGIN
                            "Paid AmountEditable" := TRUE;
                            "Customer NoEditable" := FALSE;
                            // CurrForm.Balance.editable:=true;
                        END;
                    end;
                }
                field("Customer No"; Rec."Customer No")
                {
                    Editable = "Customer NoEditable";

                    trigger OnValidate()
                    begin
                        Student.RESET;
                        Student.SETRANGE(Student."No.", Rec."Customer No");
                        IF Student.FIND('-') THEN BEGIN
                            Rec."Customer Name" := Student.Name
                        END;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Prepayment Balance"; Rec."Prepayment Balance")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Cashier Name"; Rec."Cashier Name")
                {
                    Editable = false;
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                    Editable = "Paid AmountEditable";

                    trigger OnValidate()
                    begin
                        SalesLine.RESET;
                        Amt := 0;
                        SalesLine.SETRANGE(SalesLine."Receipt No", Rec."Receipt No");
                        IF SalesLine.FIND('-') THEN BEGIN
                            REPEAT
                                Amt := Amt + SalesLine.Amount;
                            UNTIL SalesLine.NEXT = 0;
                        END;
                        Rec.Balance := Rec."Paid Amount" - Amt;
                    end;
                }
                field(Balance; Rec.Balance)
                {
                    Editable = BalanceEditable;
                }
            }
            part("CAT-Menu Sales Line"; "CAT-Menu Sales Line")
            {
                SubPageLink = "Receipt No" = FIELD("Receipt No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Preview Receipt")
            {
                Caption = 'Preview Receipt';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MenuSale.RESET;
                    MenuSale.SETRANGE(MenuSale."Receipt No", Rec."Receipt No");
                    IF MenuSale.FIND('-') THEN
                        REPORT.RUN(39005646, TRUE, TRUE, MenuSale);
                end;
            }
            action("Post / Receipt")
            {
                Caption = 'Post / Receipt';
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F12';

                trigger OnAction()
                begin

                    IF PostJrn() = TRUE THEN BEGIN
                        MenuSale.SETFILTER(MenuSale."Receipt No", Rec."Receipt No");
                        IF MenuSale.FIND('-') THEN
                            REPORT.RUN(51240, TRUE, FALSE, MenuSale);
                        Rec.CALCFIELDS(Amount);
                        Rec."Line Amount" := Rec.Amount;
                        Rec.Posted := TRUE;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Cashier Name", USERID);
    end;

    trigger OnInit()
    begin
        "Paid AmountEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Cashier Name" := USERID;
        //"Sales Point":='MESS';
        SaleSetUp.GET();
        Rec."Receiving Bank" := SaleSetUp."Receiving Bank Account";
    end;

    var
        Student: Record "Customer";
        BankLedger: Record "Bank Account Ledger Entry";
        SalesLine: Record "CAT-Menu Sales Line";
        Amt: Decimal;
        "Line No": Integer;
        MenuRec: Record "CAT-Daily Menu";
        "Cashier Rec": Record "Customer";
        MenuSale: Record "CAT-Menu Sale Header";
        GrnLine: Record "Gen. Journal Line";
        SaleSetUp: Record "CAT-Catering SetUp";
        Temp: Text[30];
        Batch: Text[30];
        [InDataSet]
        "Paid AmountEditable": Boolean;
        [InDataSet]
        BalanceEditable: Boolean;
        CateringL: Record "CAT-Catering Prepayment Ledger";
        GLEntry: Record "G/L Entry";
        LastEntry: Integer;
        "Customer NoEditable": Boolean;

    procedure UpdateCashBox()
    begin
        //------------------BKK--------------

        BankLedger.RESET;
        SalesLine.RESET;
        MenuRec.RESET;
        IF (Rec."Customer Type" <> Rec."Customer Type"::Staff) AND (Rec."Customer Type" <> Rec."Customer Type"::Department) THEN BEGIN

            Amt := 0;
            Rec.TESTFIELD(Date);
            //TESTFIELD("Cashier No");
            Rec.TESTFIELD("Receiving Bank");
            //TESTFIELD("Paid Amount");
            IF Rec.Balance < 0 THEN BEGIN
                ERROR('The Paid Amount Is Less By ' + FORMAT(Rec.Balance))
            END;
            IF BankLedger.FINDLAST() THEN BEGIN
                "Line No" := BankLedger."Entry No." + 1
            END
            ELSE BEGIN
                "Line No" := 1
            END;
            SalesLine.SETRANGE(SalesLine."Receipt No", Rec."Receipt No");
            IF SalesLine.FIND('-') THEN BEGIN
                REPEAT
                    Amt := Amt + SalesLine.Amount;
                UNTIL SalesLine.NEXT = 0;
            END;

            IF Amt = 0 THEN BEGIN
                ERROR('There is Nothing In The Sales Line')
            END;

            BankLedger.INIT;
            BankLedger."Entry No." := "Line No";
            BankLedger."Bank Account No." := Rec."Receiving Bank";
            BankLedger."Posting Date" := Rec.Date;
            BankLedger."Document No." := Rec."Receipt No";
            BankLedger.Description := Rec."Receipt No" + ' ' + Rec."Customer Name";
            BankLedger.Amount := Amt;
            BankLedger."Remaining Amount" := Amt;
            BankLedger."Amount (LCY)" := Amt;
            BankLedger."User ID" := Rec."Cashier No";
            BankLedger.Open := TRUE;
            BankLedger."Document Date" := Rec.Date;
            BankLedger.INSERT(TRUE);
        END;
        SalesLine.RESET;
        SalesLine.SETRANGE(SalesLine."Receipt No", Rec."Receipt No");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                MenuRec.RESET;
                MenuRec.SETRANGE(MenuRec."Menu Date", Rec.Date);
                MenuRec.SETRANGE(MenuRec.Menu, SalesLine.Menu);
                // MenuRec.SETRANGE(MenuRec.Type,MenuRec.Type::Student);
                IF MenuRec.FIND('-') THEN BEGIN
                    MenuRec."Remaining Qty" := MenuRec."Remaining Qty" - SalesLine.Quantity;
                    MenuRec.MODIFY;
                END;
            UNTIL SalesLine.NEXT = 0;
        END;

        //MESSAGE('Money Taken') ;
    end;

    procedure PostJrn() Posted: Boolean
    begin
        Posted := FALSE;
        Rec.TESTFIELD(Date);
        //TESTFIELD("Paid Amount");
        //TESTFIELD("Cashier);
        //TESTFIELD("Receiving Bank");
        IF Rec.Balance < 0 THEN BEGIN
            ERROR('The Paid Amount Is Less By ' + FORMAT(Rec.Balance))
        END;

        Amt := 0;
        SalesLine.SETRANGE(SalesLine."Receipt No", Rec."Receipt No");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                Amt := Amt + SalesLine.Amount;
            UNTIL SalesLine.NEXT = 0;
        END;
        IF Amt = 0 THEN BEGIN
            ERROR('There is Nothing In The Sales Line')
        END;
        IF SaleSetUp.GET() THEN BEGIN
            Temp := SaleSetUp."Sales Template";
            Batch := SaleSetUp."Sales Batch";
            SaleSetUp.TESTFIELD(SaleSetUp."Catering Income Account");
            SaleSetUp.TESTFIELD(SaleSetUp."Catering Control Account");
            SaleSetUp.TESTFIELD(SaleSetUp."Receiving Bank Account");
        END ELSE BEGIN
            ERROR('Enter The Sales Template And Batch In Catering SetUp')
        END;
        Rec."Receiving Bank" := SaleSetUp."Receiving Bank Account";
        IF Rec."Sales Type" = Rec."Sales Type"::Cash THEN BEGIN
            Rec.TESTFIELD("Paid Amount");
            GrnLine.RESET;
            GrnLine.SETRANGE(GrnLine."Journal Template Name", Temp);
            GrnLine.SETRANGE(GrnLine."Journal Batch Name", Batch);
            IF GrnLine.FIND('-') THEN BEGIN
                GrnLine.DELETEALL;
            END;

            GrnLine.INIT;
            GrnLine."Journal Template Name" := Temp;
            GrnLine."Journal Batch Name" := Batch;
            GrnLine."Line No." := "Line No";
            GrnLine."Account Type" := GrnLine."Account Type"::"Bank Account";
            GrnLine."Account No." := Rec."Receiving Bank";
            GrnLine."Posting Date" := Rec.Date;
            GrnLine."Document Type" := 0;
            GrnLine."Document No." := Rec."Receipt No";
            GrnLine.Description := 'Food Sale - ' + Rec."Customer No";
            GrnLine."Bal. Account No." := SaleSetUp."Catering Income Account";
            GrnLine."Bal. Account Type" := GrnLine."Bal. Account Type"::"G/L Account";
            GrnLine.Amount := Amt;
            //GrnLine."Shortcut Dimension 1 Code":='MAIN';
            // GrnLine.VALIDATE(GrnLine."Shortcut Dimension 1 Code");
            // GrnLine."Shortcut Dimension 3 Code":='170';
            // GrnLine.VALIDATE(GrnLine."Shortcut Dimension 2 Code");
            GrnLine.INSERT(TRUE);

        END;

        IF Rec."Sales Type" = Rec."Sales Type"::Prepayment THEN BEGIN
            // MenuSale.TESTFIELD(MenuSale."Customer No");
            Rec.CALCFIELDS("Prepayment Balance");
            Rec.CALCFIELDS(Amount);
            IF (Rec."Prepayment Balance" - Rec.Amount) < 0 THEN ERROR('The Prepayment balance is not sufficient for the selected transaction');

            GrnLine.RESET;
            GrnLine.SETRANGE(GrnLine."Journal Template Name", Temp);
            GrnLine.SETRANGE(GrnLine."Journal Batch Name", Batch);
            IF GrnLine.FIND('-') THEN BEGIN
                GrnLine.DELETEALL;
            END;

            GrnLine.INIT;
            GrnLine."Journal Template Name" := Temp;
            GrnLine."Journal Batch Name" := Batch;
            GrnLine."Line No." := "Line No";
            GrnLine."Account Type" := GrnLine."Account Type"::"G/L Account";
            GrnLine."Account No." := SaleSetUp."Catering Control Account";
            GrnLine."Posting Date" := Rec.Date;
            GrnLine."Document Type" := 0;
            GrnLine."Document No." := Rec."Receipt No";
            GrnLine.Description := 'Food Sale - ' + Rec."Customer No";
            GrnLine."Bal. Account No." := SaleSetUp."Catering Income Account";
            GrnLine."Bal. Account Type" := GrnLine."Bal. Account Type"::"G/L Account";
            GrnLine.Amount := Amt;
            Posted := TRUE;
            Rec.MODIFY;
            //GrnLine."Shortcut Dimension 1 Code":='MAIN';
            // GrnLine.VALIDATE(GrnLine."Shortcut Dimension 1 Code");
            // GrnLine."Shortcut Dimension 3 Code":='170';
            // GrnLine.VALIDATE(GrnLine."Shortcut Dimension 2 Code");
            GrnLine.INSERT(TRUE);

        END;
        IF GLEntry.FINDLAST() THEN LastEntry := GLEntry."Entry No.";
        GrnLine.RESET;
        GrnLine.SETRANGE(GrnLine."Journal Template Name", Temp);
        GrnLine.SETRANGE(GrnLine."Journal Batch Name", Batch);
        IF GrnLine.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B2", GrnLine);
        END;
        // Confirm if posted
        IF GLEntry.FINDLAST() THEN
            IF LastEntry <> GLEntry."Entry No." THEN Posted := TRUE;

        IF Posted = TRUE THEN BEGIN
            IF Rec."Sales Type" = Rec."Sales Type"::Prepayment THEN BEGIN
                IF CateringL.FINDLAST() THEN
                    "Line No" := "Line No" + 1;
                "Line No" := CateringL."Entry No";
                CateringL.INIT;
                CateringL."Entry No" := "Line No" + 1;
                CateringL."Customer No" := Rec."Customer No";
                CateringL."Entry Type" := CateringL."Entry Type"::Consumption;
                CateringL.Date := TODAY;
                CateringL.Description := 'Food Sales';
                CateringL.Amount := Rec.Amount * -1;
                CateringL."User ID" := USERID;
                CateringL.INSERT;

                SalesLine.RESET;
                SalesLine.SETRANGE(SalesLine."Receipt No", Rec."Receipt No");
                IF SalesLine.FIND('-') THEN BEGIN
                    REPEAT
                        MenuRec.RESET;
                        MenuRec.SETRANGE(MenuRec."Menu Date", Rec.Date);
                        MenuRec.SETRANGE(MenuRec.Menu, SalesLine.Menu);
                        // MenuRec.SETRANGE(MenuRec.Type,MenuRec.Type::Student);
                        IF MenuRec.FIND('-') THEN BEGIN
                            MenuRec."Remaining Qty" := MenuRec."Remaining Qty" - SalesLine.Quantity;
                            MenuRec.MODIFY;
                        END;
                    UNTIL SalesLine.NEXT = 0;
                END;
            END;
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        //  "Customer Type":="Customer Type"::Student;
        Rec."Cashier Name" := USERID;
    end;
}

