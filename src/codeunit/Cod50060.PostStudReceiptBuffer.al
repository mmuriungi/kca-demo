codeunit 50060 "Post Stud Receipt Buffer"
{

    Access = Public;

    trigger OnRun()
    begin

    end;

    var



        acacharges: Record "ACA-Std Charges";
        acacharges2: Record "ACA-Std Charges";

        PaidAmount: Decimal;
        PaidRemaining: Decimal;
        PaidUtilized: Decimal;
        AmountToPay: Decimal;

        acaReceipts: Record "ACA-Receipt";
        StudPay: Record "ACA-Std Payments";
        Cust: Record 18;
        GenJnl: Record 81;
        GenSetup: Record "ACA-General Set-Up";
        GLPosting: Codeunit 12;
        Stud: Record 18;
        StudentNo: Code[20];
        CReg: Record "ACA-Course Registration";
        LineNo: Integer;
        TransType: Option " ","Direct Bank Deposit",HELB,Bursary,CDF,Scholarship;
        Imported_Receipts_BufferCaptionLbl: Label 'Imported Receipts Buffer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        TransBank: Code[20];
        receiptsBuffer: Record "ACA-Imp. Receipts Buffer";
        cust1: Record Customer;


    procedure PostReceiptBuffer(var scholarshipHeader: Record "ACA-Scholarship Batches")
    begin

        scholarshipHeader.Find();
        scholarshipHeader.TestField("Batch No.");

        GenSetup.GET();

        //delete exisiting gen journal lines before re inserting
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        if not GenJnl.IsEmpty then GenJnl.DeleteAll();

        //find receipts buffer lines
        receiptsBuffer.Reset();
        receiptsBuffer.SetRange("Transaction Code", scholarshipHeader."No.");
        // receiptsBuffer.SetRange("Batch No.", scholarshipHeader."Batch No.");
        receiptsBuffer.SetRange(Posted, false);
        receiptsBuffer.SetFilter(Amount, '>%1', 0);
        receiptsBuffer.SetRange(Invalid, false);
        if receiptsBuffer.Find('-') then
            repeat
                receiptsBuffer.CalcFields("Stud Exist");
                if receiptsBuffer."Stud Exist" > 0 then begin
                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl."Line No." + 110000;
                    GenJnl."Posting Date" := receiptsBuffer.Date;
                    GenJnl."Document No." := receiptsBuffer."Receipt No";
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Document Type" := GenJnl."Document Type"::Payment;
                    GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                    GenJnl."External Document No." := receiptsBuffer."Receipt No";
                    GenJnl."Account No." := receiptsBuffer."Student No.";

                    GenJnl.Amount := receiptsBuffer.Amount * -1;
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.VALIDATE(GenJnl.Amount);
                    scholarshipHeader.TestField("G/L Account");
                    GenJnl."Bal. Account No." := scholarshipHeader."G/L Account";
                    GenJnl.Description := receiptsBuffer.Description + '-' + scholarshipHeader."Batch No.";

                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                    GenJnl.INSERT;
                    receiptsBuffer.Unallocated := TRUE;
                    receiptsBuffer.Posted := TRUE;
                    receiptsBuffer.MODIFY;
                end;



                PaidAmount := receiptsBuffer.Amount;
                PaidRemaining := receiptsBuffer.Amount;
                PaidUtilized := 0;

                Cust.Reset();
                Cust.SetRange("No.", receiptsBuffer."Student No.");
                if Cust.Find('-') then begin
                    //Check Balance First
                    Cust.CalcFields(Balance);
                    if Cust.Balance > 0 then begin
                        //Loop Through Charges and Insert Charges
                        acacharges.Reset();
                        acacharges.SetRange("Student No.", Cust."No.");
                        acacharges.SetRange(Recognized, true);
                        acacharges.SetRange("Fully Paid", false);
                        acacharges.SetCurrentKey("Recovery Priority");
                        if acacharges.FindFirst then begin
                            repeat





                                //Post Receipts To receipt Buffer
                                //Message('Im Here');
                                acaReceipts.INIT;
                                acaReceipts."Receipt No." := receiptsBuffer."Receipt No";
                                acaReceipts.VALIDATE(acaReceipts."Receipt No.");
                                acaReceipts."Student No." := receiptsBuffer."Student No.";
                                acaReceipts."Date" := receiptsBuffer."Date";
                                acaReceipts."Bank Slip/Cheque No" := receiptsBuffer."Cheque No";
                                acaReceipts."Payment Mode" := acaReceipts."Payment Mode"::Cheque;
                                acaReceipts.Amount := receiptsBuffer.Amount;
                                acaReceipts."Payment By" := UserId;
                                acaReceipts."Transaction Date" := TODAY;
                                acaReceipts."Transaction Time" := TIME;
                                acaReceipts."User ID" := USERID;
                                acaReceipts."Auto  Receipt Date" := TODAY;
                                acaReceipts."Auto  Receipted" := TRUE;
                                // acaReceipts."Bal. Account Type" := acaReceipts."Bal. Account Type"::"G/L Account";
                                // acaReceipts."Bal. Account No." := scholarshipHeader."G/L Account";
                                acaReceipts.INSERT;
                            until acacharges.Next() = 0;
                        END;
                    END;
                END;
            UNTIL receiptsBuffer.Next() = 0;



        GenJnl.Reset();
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        IF GenJnl.FindSet() THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnl);

        end;


    end;



    procedure PostGrant(var grantsManagement: Record "ACA-Grants")
    begin

        grantsManagement.Find();
        GenSetup.GET();

        //delete exisiting gen journal lines before re inserting
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'BNKDEPOSIT');
        GenJnl.SETRANGE("Journal Batch Name", 'BNKDEPOSIT');
        if not GenJnl.IsEmpty then GenJnl.DeleteAll();

        GenJnl.INIT;
        GenJnl."Line No." := GenJnl."Line No." + 110000;
        GenJnl."Posting Date" := grantsManagement."Document Date";
        GenJnl."Document No." := grantsManagement.No;
        GenJnl.VALIDATE(GenJnl."Document No.");
        GenJnl."Journal Template Name" := 'BNKDEPOSIT';
        GenJnl."Journal Batch Name" := 'BNKDEPOSIT';
        //GenJnl."Document Type" := GenJnl."Document Type"::Payment;
        GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
        //GenJnl."External Document No." := receiptsBuffer."Receipt No";
        GenJnl."Account No." := GenSetup."Grants Account";

        GenJnl.Amount := grantsManagement."Total Amount Awarded" * -1;
        GenJnl.VALIDATE(GenJnl."Account No.");
        GenJnl.VALIDATE(GenJnl.Amount);
        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
        GenJnl."Bal. Account No." := GenSetup."Grants Account";
        GenJnl.Description := grantsManagement."Grants Description";

        GenJnl.VALIDATE(GenJnl."Bal. Account No.");

        GenJnl.INSERT;


        GenJnl.Reset();
        GenJnl.SETRANGE("Journal Template Name", 'BNKDEPOSIT');
        GenJnl.SETRANGE("Journal Batch Name", 'BNKDEPOSIT');
        IF GenJnl.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);

        end;


    end;

}