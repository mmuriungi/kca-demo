codeunit 50113 PostCaferiaBatches
{
     procedure PostReceiptToJournal(CafeteriaSalesBatches: Record "Cafeteria Sales Batches")
    var
        LineNos: Integer;
        POSSalesHeader: Record "POS Sales Header";
        TotalRecords: Integer;
        RemainingRecords: Integer;
        ProcessedRecord: Integer;
        PesaFlowIntergration2: Record "PesaFlow Intergration";
          CountedRecs: Integer;
        TotLoops: Integer;
        Dialogs: Dialog;
        //UserSetup
         officeTemp2: Record "FIN-Cash Office User Template";
          GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        UserSetup: Record "User Setup";
        LineNo: Integer;

    begin
        //Rec.VALIDATE("M-Pesa Transaction Number");
        Clear(CountedRecs);
        Clear(TotalRecords);
        Clear(ProcessedRecord);
        Clear(RemainingRecords);
        Clear(ProcessedRecord);
        Dialogs.Open('#1#################################################\' +
        '#2#################################################\' +
        '#3#################################################\' +
        '#4#################################################\');
        if not officeTemp2.Get(UserId) then Error('Access denied!');
        if officeTemp2.Find('-') then begin
            officeTemp2.TestField("Receipt Journal Template");
            officeTemp2.TestField("Receipt Journal Batch");
            // Delete Lines Present on the General Journal Line    LineNos
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", officeTemp2."Receipt Journal Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", officeTemp2."Receipt Journal Batch");
            GenJnLine.DeleteAll;

            Batch.Init;
            Batch."Journal Template Name" := officeTemp2."Receipt Journal Template";
            Batch.Name := officeTemp2."Receipt Journal Batch";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert;
        end;
        Clear(UserSetup);
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.Find('-') then begin end else Error('Access denied!');
        Clear(POSSalesHeader);
        POSSalesHeader.Reset;
        POSSalesHeader.SetRange(Batch_Id, CafeteriaSalesBatches.Batch_Id);
        POSSalesHeader.SetRange(Cashier, CafeteriaSalesBatches.User_Id);
        POSSalesHeader.SetRange("Posting date", CafeteriaSalesBatches.Batch_Date);
        //POSSalesHeader.SETRANGE(,FALSE);
        POSSalesHeader.SetRange(Posted, true);
        if POSSalesHeader.Find('-') then begin
            CountedRecs := POSSalesHeader.Count;
            TotalRecords := CountedRecs;
            RemainingRecords := CountedRecs;
            Dialogs.Update(1, 'Posting batch....');
            Dialogs.Update(2, 'Total Record: ' + Format(TotalRecords));
            repeat
            begin
                ProcessedRecord += 1;
                RemainingRecords -= 1;
                Dialogs.Update(3, 'Processed: ' + Format(ProcessedRecord));
                Dialogs.Update(4, 'Remaining: ' + Format(RemainingRecords));
                POSSalesHeader.CalcFields("Receipt Posted to Ledger");
                if POSSalesHeader."Receipt Posted to Ledger" = false then begin

                    LineNo := LineNo + 1000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name" := officeTemp2."Receipt Journal Template";
                    GenJnLine."Journal Batch Name" := officeTemp2."Receipt Journal Batch";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Document Type" := GenJnLine."document type"::Payment;
                    GenJnLine."Shortcut Dimension 1 Code" := '020';

                    GenJnLine."Account Type" := GenJnLine."account type"::"Bank Account";
                    if POSSalesHeader."Payment Method" = POSSalesHeader."payment method"::Cash then begin
                        GenJnLine."Account No." := POSSalesHeader."Cash Account";
                    end else if (POSSalesHeader."Payment Method" = POSSalesHeader."payment method"::Mpesa) then begin
                        GenJnLine."Account No." := POSSalesHeader."Bank Account";
                    end else if (POSSalesHeader."Payment Method" = POSSalesHeader."payment method"::ECITIZEN) then begin
                        GenJnLine."Account No." := POSSalesHeader."Bank Account";
                    end else
                        Error('Option Not Activated');
                    GenJnLine."Posting Date" := POSSalesHeader."Posting date";
                    if POSSalesHeader."M-Pesa Transaction Number" <> '' then
                        GenJnLine."Document No." := POSSalesHeader."M-Pesa Transaction Number"
                    else
                        GenJnLine."Document No." := POSSalesHeader."No.";
                    GenJnLine."External Document No." := POSSalesHeader."No.";
                    GenJnLine.Description := 'Food sales for ' + Format(POSSalesHeader."Customer Type");
                    POSSalesHeader.CalcFields("Total Amount");
                    if ProcessedRecord = 60 then
                        ProcessedRecord := ProcessedRecord;
                    GenJnLine.Amount := POSSalesHeader."Total Amount";
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Bal. Account Type" := GenJnLine."bal. account type"::"G/L Account";
                    GenJnLine."Bal. Account No." := POSSalesHeader."Income Account";
                    GenJnLine."User ID" := POSSalesHeader.Cashier;
                    if GenJnLine.Amount <> 0 then begin
                        GenJnLine.Insert;
                        POSSalesHeader."Batch Posted" := true;
                        POSSalesHeader."Batch PostedDate" := Today;
                        POSSalesHeader."Batch Posted By" := UserId;
                        POSSalesHeader."Batch Posted Time" := Time;
                        POSSalesHeader.Modify;

                        Clear(PesaFlowIntergration2);
                        PesaFlowIntergration2.Reset;
                        PesaFlowIntergration2.SetRange(PesaFlowIntergration2.PaymentRefID, POSSalesHeader."M-Pesa Transaction Number");
                        if PesaFlowIntergration2.Find('-') then begin
                            PesaFlowIntergration2.Posted := true;
                            PesaFlowIntergration2.Modify;
                        end;
                    end;
                end;
            end;
            until POSSalesHeader.Next = 0;
        end;
        Dialogs.Close;
        Clear(GenJnLine);
        GenJnLine.Reset;
        GenJnLine.SetRange(GenJnLine."Journal Template Name", officeTemp2."Receipt Journal Template");
        GenJnLine.SetRange(GenJnLine."Journal Batch Name", officeTemp2."Receipt Journal Batch");
        if GenJnLine.FindSet() then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnLine);
            // Mark Batch as posted
            CafeteriaSalesBatches."Posted By" := UserId;
            CafeteriaSalesBatches."Batch Status" := CafeteriaSalesBatches."batch status"::Posted;
            CafeteriaSalesBatches."Date Posted" := Today;
            CafeteriaSalesBatches."Time Posted" := Time;
            CafeteriaSalesBatches.Modify;
        end else
            Error('Nothing to Post!');
        Message('Receipts batch posted successfully!');
    end;
}
