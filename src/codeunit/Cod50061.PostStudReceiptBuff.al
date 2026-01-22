codeunit 50061 "Post Stud Receipt Buff"
{

    Access = Public;

    trigger OnRun()
    begin

    end;

    var
        LastReceiptNo: Code[20];
        "No. Series Line": Record "No. Series Line";
        BankRec: Record "Bank Account";

        "Last No": Code[20];
        StudPay: Record "ACA-Std Payments";
        Cust: Record 18;
        GenJnl: Record 81;
        GenSetup: Record "ACA-General Set-Up";
        GLPosting: Codeunit 12;
        Stud: Record 18;
        StudentNo: Code[20];
        CReg: Record "ACA-Course Registration";
        LineNo: Integer;
        //TransType: Option " ","M-pesa",Cheque,"Direct Bank Deposit",HELB,Bursary,CDF,Scholarship;
        Imported_Receipts_BufferCaptionLbl: Label 'Imported Receipts Buffer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        TransBank: Code[20];
        receiptsBuffer: Record "ACA-Imp. Receipts Buffer";
        cafeStudLedger: Record "CAFE Studentledger";

    procedure GetLastEntryNo(): Integer;
    begin
        cafeStudLedger.Reset();
        if cafeStudLedger.FindLast() then
            exit(cafeStudLedger."Entry No.")
        else
            exit(0);
    end;

    procedure PostReceiptBuffer(var receiptBuffer: Record "Receipts Buffer")
    begin

        receiptBuffer.Find();
        receiptBuffer.TestField("No.");
        if receiptBuffer.Cafeteria = true then begin
            GenSetup.GET();

            //delete exisiting gen journal lines before re inserting
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name", 'SALES');
            GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
            if not GenJnl.IsEmpty then GenJnl.DeleteAll();

            //find receipts buffer lines
            receiptsBuffer.Reset();
            receiptsBuffer.SetRange("Transaction Code", receiptBuffer."No.");
            //receiptsBuffer.SetRange("Batch No.", receiptBuffer."Batch No.");
            receiptsBuffer.SetRange(Posted, false);
            receiptsBuffer.SetFilter(Amount, '>%1', 0);
            if receiptsBuffer.Find('-') then
                repeat
                    IF Stud.GET(receiptsBuffer."Student No.") THEN BEGIN
                        StudentNo := Stud."No.";
                    END ELSE
                        EXIT;
                    StudPay.RESET;
                    StudPay.SETRANGE(StudPay."Student No.", StudentNo);
                    //StudPay.SetRange("User ID", UserId);
                    IF not StudPay.IsEmpty THEN
                        StudPay.DELETEALL;


                    StudPay.INIT;
                    StudPay."Student No." := receiptsbuffer."Student No.";
                    StudPay."User ID" := USERID;
                    //StudPay."Payment Mode":=StudPay."Payment Mode"::"Direct Bank Deposit";
                    IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::Cheque THEN BEGIN
                        StudPay."Payment Mode" := StudPay."Payment Mode"::Cheque;
                    end else
                        IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"M-pesa" THEN BEGIN
                            StudPay."Payment Mode" := StudPay."Payment Mode"::"M-Pesa";
                        end else
                            IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"Direct Bank Deposit" THEN BEGIN
                                StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                            END ELSE
                                StudPay."Cheque No" := receiptsBuffer."Cheque No";
                    StudPay."Drawer Name" := receiptsBuffer.Description;
                    StudPay."Payment By" := receiptsBuffer.Description;
                    StudPay."Bank No." := receiptBuffer."Bank Code";
                    StudPay."Amount to pay" := receiptsBuffer.Amount;
                    //StudPay."Cheque No" := "ACA-Imp. Receipts Buffer"."Cheque No";
                    StudPay.VALIDATE(StudPay."Amount to pay");
                    StudPay."Transaction Date" := receiptsBuffer.Date;
                    //StudPay.VALIDATE(StudPay."Auto Bill");
                    StudPay.VALIDATE(StudPay."Auto Post Final");

                    StudPay.INSERT;

                    receiptsBuffer.Unallocated := TRUE;
                    receiptsBuffer.Posted := TRUE;
                    receiptBuffer.Posted := True;
                    receiptsBuffer.MODIFY;
                    //INSERT TO JOURNAL FOR TRANSFER
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN GenJnl.DELETEALL;
                    //cafe control account posting
                    GenJnl.INIT;
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'CAFE';
                    GenJnl."Line No." := GenJnl."Line No." + 120000;
                    GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                    GenJnl."Account No." := '60183';
                    GenJnl."Posting Date" := receiptBuffer."Batch Date";
                    GenJnl."Document No." := receiptBuffer."No.";
                    GenJnl.Description := receiptsBuffer.Description;
                    GenJnl.Amount := (receiptsBuffer.Amount) * -1;
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::Customer;
                    GenJnl."Bal. Account No." := receiptsBuffer."Student No.";
                    IF GenJnl.Amount <> 0 THEN
                        GenJnl.INSERT;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'CAFE');
                    IF GenJnl.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnl);
                    end;

                    //credit cafe account
                    cafestudLedger.Init();
                    cafestudLedger."Entry No." := GetLastEntryNo + 1;
                    cafestudLedger.StudentId := receiptsBuffer."Student No.";
                    cafestudLedger."Document No." := receiptBuffer."No.";
                    cafestudLedger."Entry Type" := cafestudLedger."Entry Type"::"Positive Adjmt.";
                    cafestudLedger."Posting Date" := receiptBuffer."Batch Date";
                    cafestudLedger.Amount := receiptsBuffer.Amount;
                    cafestudLedger.Description := receiptsBuffer.Description;
                    cafestudLedger.Insert(true);

                until receiptsBuffer.Next() = 0;
            Message('Successfully Posted!!');


        end else begin
            GenSetup.GET();

            //delete exisiting gen journal lines before re inserting
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name", 'SALES');
            GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
            if not GenJnl.IsEmpty then GenJnl.DeleteAll();

            //find receipts buffer lines
            receiptsBuffer.Reset();
            receiptsBuffer.SetRange("Transaction Code", receiptBuffer."No.");
            //receiptsBuffer.SetRange("Batch No.", receiptBuffer."Batch No.");
            receiptsBuffer.SetRange(Posted, false);
            receiptsBuffer.SetFilter(Amount, '>%1', 0);
            if receiptsBuffer.Find('-') then
                repeat
                    IF Stud.GET(receiptsBuffer."Student No.") THEN BEGIN
                        StudentNo := Stud."No.";
                    END ELSE
                        EXIT;
                    StudPay.RESET;
                    StudPay.SETRANGE(StudPay."Student No.", StudentNo);
                    //StudPay.SetRange("User ID", UserId);
                    IF not StudPay.IsEmpty THEN
                        StudPay.DELETEALL;


                    StudPay.INIT;
                    StudPay."Student No." := receiptsbuffer."Student No.";
                    StudPay."User ID" := USERID;
                    //StudPay."Payment Mode":=StudPay."Payment Mode"::"Direct Bank Deposit";
                    IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::Cheque THEN BEGIN
                        StudPay."Payment Mode" := StudPay."Payment Mode"::Cheque;
                    end else
                        IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"M-pesa" THEN BEGIN
                            StudPay."Payment Mode" := StudPay."Payment Mode"::"M-Pesa";
                        end else
                            IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"Direct Bank Deposit" THEN BEGIN
                                StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                            END ELSE
                                StudPay."Cheque No" := receiptsBuffer."Cheque No";
                    StudPay."Drawer Name" := receiptsBuffer.Description;
                    StudPay."Payment By" := receiptsBuffer.Description;
                    StudPay."Bank No." := receiptBuffer."Bank Code";
                    StudPay."Amount to pay" := receiptsBuffer.Amount;
                    //StudPay."Cheque No" := "ACA-Imp. Receipts Buffer"."Cheque No";
                    StudPay.VALIDATE(StudPay."Amount to pay");
                    StudPay."Transaction Date" := receiptsBuffer.Date;
                    //StudPay.VALIDATE(StudPay."Auto Bill");
                    StudPay.VALIDATE(StudPay."Auto Post Final");

                    StudPay.INSERT;
                until receiptsBuffer.Next() = 0;
            Message('Successfully Posted!!');
        end;

    end;

}