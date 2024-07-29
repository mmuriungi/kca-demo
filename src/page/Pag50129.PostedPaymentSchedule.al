page 50129 "Posted Payment Schedule"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Payment Schedule";
    SourceTableView = WHERE(Posted = CONST(true));

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
            action("Post Payments")
            {
                Image = PreviewChecks;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you really want to post the selected the payments?', FALSE) THEN
                        PostPaymentVoucher;
                end;
            }
            separator(Controls)
            {
            }
            action("Print Schedule")
            {
                Image = PaymentHistory;
                Promoted = true;

                trigger OnAction()
                begin
                    PS.RESET;
                    PS.SETFILTER(No, Rec.No);
                    IF PS.FIND('-') THEN
                        REPORT.RUN(70135530, TRUE, TRUE, PS);
                end;
            }
            separator(Check)
            {
            }
            action("Void Cheque")
            {
                Image = VoidCheck;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you really want to void the cheque?', FALSE) THEN BEGIN
                        CheckEntry.RESET;
                        CheckEntry.SETRANGE("Check No.", Rec."Cheque No");
                        IF CheckEntry.FIND('-') THEN BEGIN
                            CheckEntry."Entry Status" := CheckEntry."Entry Status"::Voided;
                            CheckEntry.MODIFY;
                        END;
                        Rec.Posted := FALSE;
                        Rec."Posted By" := USERID;
                        Rec.MODIFY;
                    END;
                end;
            }
            separator(Control)
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
        PS: Record "Payment Schedule";
        CheckEntry: Record 272;

    //[Scope('Internal')]
    procedure PostPaymentVoucher()
    begin
        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
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


        //Post:=FALSE;
        //Post:=JournlPosted.PostedSuccessfully();
        //IF Post THEN  BEGIN
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
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

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

        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;

        //Before posting if paymode is cheque print the cheque
        //IF ("Pay Mode"="Pay Mode"::Cheque) AND ("Cheque Type"="Cheque Type"::"Computer Check") THEN BEGIN
        DocPrint.PrintCheck(GenJnlLine);
        //CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance",GenJnlLine);
        //Confirm Cheque printed //Not necessary.
        //END;
        //Post Other Payment Journal Entries
    end;
}

