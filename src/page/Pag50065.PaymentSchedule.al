page 50065 "Payment Schedule"
{
    PageType = Card;
    SourceTable = "Payment Schedule";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Paying Bank No"; Rec."Paying Bank No")
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                }
                field(Payee; Rec.Payee)
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                }
                field("Cheque Format"; Rec."Cheque Format")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(PaymentLine; "Payment Schedule Line")
            {
                SubPageLink = No = FIELD(No);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Cheque")
            {
                Image = PreviewChecks;
                Promoted = true;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you really want to post the selected the payments?', FALSE) THEN
                        //  IF "Cheque Format"="Cheque Format"::"Kalamazoo Format" THEN PrintKalamzoo;
                        //  IF "Cheque Format"="Cheque Format"::"Plain Format" THEN PrintNormal;
                        PostPaymentVoucher;
                end;
            }
            separator(Controls)
            {
            }
        }
    }

    var
        Payments: Record "Payment Schedule";
        PSline: Record "Payment Schedule Line";
        PVHead: Record "FIN-Payments Header";
        GenJnlLine: Record 81;
        Temp: Record "FIN-Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineNo: Integer;
        DocPrint: Codeunit 229;
        AdjustGenJnl: Codeunit 407;
        ImpH: Record "FIN-Imprest Header";
        PS: Record "Payment Schedule";
        BankRec: Record 270;
        PostChequeNo: Codeunit "General. Jnl.-Post Line";
        CheckLedger: Record 272;

    //[Scope('Internal')]
    procedure PostPaymentVoucher()
    begin
        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        Rec.TESTFIELD(Payee);
        Rec.TESTFIELD("Paying Bank No");
        Temp.GET(USERID);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the PV Template is set up in Cash Office Setup');
        END;
        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the PV Batch is set up in the Cash Office Setup')
        END;

        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;
        GenJnlLine.DELETEALL;
        GenJnlLine.RESET;

        IF Payments.GET(Rec.No) THEN PostHeader(Payments);
        IF BankRec.GET(Rec."Paying Bank No") THEN BEGIN
            BankRec."Last Check No." := Rec."Cheque No";
            BankRec.MODIFY;
        END;

        Rec.Posted := TRUE;
        // Status:=Payments.Status::Posted;
        Rec."Posted By" := USERID;
        Rec."Posting Dated" := TODAY;
        Rec.MODIFY;


        PSline.RESET;
        PSline.SETRANGE(No, Rec.No);
        IF PSline.FIND('-') THEN BEGIN
            REPEAT
                IF PVHead.GET(PSline."Payment No") THEN BEGIN
                    PVHead."Cheque No." := Rec."Cheque No";
                    PVHead."Payment Release Date" := Rec."Cheque Date";
                    PVHead."Cheque Printed" := TRUE;
                    PVHead."Payment Schedule No" := Rec.No;
                    PVHead.MODIFY;
                    PostChequeNo.UpdateBankCheque(Rec."Paying Bank No", PSline."Payment No", Rec."Cheque No");
                END;
                IF ImpH.GET(PSline."Payment No") THEN BEGIN
                    ImpH."Cheque No." := Rec."Cheque No";
                    ImpH."Payment Release Date" := Rec."Cheque Date";
                    //Imph.ch:=TRUE;
                    ImpH."Payment Schedule No" := Rec.No;
                    PostChequeNo.UpdateBankCheque(Rec."Paying Bank No", PSline."Payment No", Rec."Cheque No");
                    CheckLedger.RESET;
                    IF CheckLedger.FINDLAST() THEN LineNo := CheckLedger."Entry No.";
                    //        CheckLedger.INIT;
                    //        CheckLedger."Document No.":=No;
                    //        CheckLedger."Posting Date":=TODAY;
                    //        CheckLedger."Bank Account No.":="Paying Bank No";
                    //        CheckLedger."Check Date":="Cheque Date";
                    //        CheckLedger."Check No.":="Cheque No";
                    //        CheckLedger."Entry No.":=LineNo;
                    //        CheckLedger.INSERT;
                    ImpH.MODIFY;
                END;
            UNTIL PSline.NEXT = 0;
        END;

        //END;
    end;

    //[Scope('Internal')]
    procedure PostHeader(var Payment: Record "Payment Schedule")
    begin



        IF (Rec."Cheque No" = '') THEN BEGIN
            ERROR('Please ensure that the cheque number is inserted');
        END;

        //
        // IF Payments."Pay Mode"=Payments."Pay Mode"::EFT THEN
        //  BEGIN
        //    IF Payments."Cheque No."='' THEN
        //      BEGIN
        //        ERROR ('Please ensure that the EFT number is inserted');
        //      END;
        //  END;
        //
        // IF Payments."Pay Mode"=Payments."Pay Mode"::"Letter of Credit" THEN
        //  BEGIN
        //    IF Payments."Cheque No."='' THEN
        //      BEGIN
        //        ERROR('Please ensure that the Letter of Credit ref no. is entered.');
        //      END;
        //  END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);

        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;


        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Cheque Date";

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := Rec.No;
        GenJnlLine."External Document No." := Rec."Cheque No";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Paying Bank No";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        // GenJnlLine."Currency Code":=Payments."Currency Code";
        // GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        //CurrFactor
        //  GenJnlLine."Currency Factor":=Payments."Currency Factor";
        //  GenJnlLine.VALIDATE("Currency Factor");

        Rec.CALCFIELDS("Total Amount");
        GenJnlLine.Amount := -(Rec."Total Amount");
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := '';
        // GenJnlLine."Recipient Bank Account":="Paying Bank No";

        // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        // GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        // GenJnlLine."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        // GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
        // GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");

        GenJnlLine.Description := COPYSTR(Rec.Payee, 1, 50);//COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
        GenJnlLine.Payee := Rec.Payee;
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;


        //
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        IF GenJnlLine.FIND('-') THEN BEGIN
            AdjustGenJnl.RUN(GenJnlLine);
            IF Rec."Cheque Format" = Rec."Cheque Format"::"Kalamazoo Format" THEN BEGIN
                REPORT.RUN(70134841, FALSE, FALSE, GenJnlLine)
            END ELSE BEGIN
                // REPORT.RUN(70134836,FALSE,FALSE,GenJnlLine);
                PS.RESET;
                PS.SETFILTER(No, Rec.No);
                IF PSline.FIND('-') THEN
                    REPORT.RUN(50090, FALSE, FALSE, PS);

            END;
            //70134836
        END;
        //DocPrint.PrintCheck(GenJnlLine);
        //CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance",GenJnlLine);
    end;

    local procedure PrintNormal()
    begin

        PS.SETFILTER(No, Rec.No);
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);

        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;


        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Cheque Date";

        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := Rec.No;
        GenJnlLine."External Document No." := Rec."Cheque No";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Paying Bank No";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        // GenJnlLine."Currency Code":=Payments."Currency Code";
        // GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        //CurrFactor
        //  GenJnlLine."Currency Factor":=Payments."Currency Factor";
        //  GenJnlLine.VALIDATE("Currency Factor");

        Rec.CALCFIELDS("Total Amount");
        GenJnlLine.Amount := -(Rec."Total Amount");
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := '';
        // GenJnlLine."Recipient Bank Account":="Paying Bank No";

        // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        // GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        // GenJnlLine."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
        // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        // GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
        // GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");

        GenJnlLine.Description := COPYSTR(Rec.Payee, 1, 50);//COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
        GenJnlLine.Payee := Rec.Payee;
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;

    end;

    local procedure PrintKalamzoo()
    begin
    end;
}

