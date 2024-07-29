codeunit 54219 "Common Management"
{
    var
        PosSetup: Record "POS Setup";
        posLines: record "POS Sales Lines";
        GenJnLine: Record "Gen. Journal Line";
        GenJournBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        itemledger: Record "POS Item Ledger";
        Err: Label 'You cannot post a cash sale with amount less that 0';
        POSSaleHeader: Record "POS Sales Header";
        DocAttachment: Record "Document Attachment";
        cafestudLedger: Record "Reconcile CV Acc Buffer";
        totSalesAmount: Decimal;

    procedure PostSale(ReceiptNo: Code[50])
    begin
        PosSetup.Get();
        POSSaleHeader.Reset();
        if POSSaleHeader.Get(ReceiptNo) then begin
            POSSaleHeader.TestField("Amount Paid");
            posLines.Reset();
            posLines.SetRange("Document No.", ReceiptNo);
            if posLines.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := posLines."No.";
                    itemledger."Document No." := posLines."No." + posLines."Document No.";
                    itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
                    itemledger."Posting Date" := POSSaleHeader."Posting Date";
                    itemledger.Quantity := -posLines.Quantity;
                    itemledger.Description := posLines.Description;
                    itemledger.Insert(true);
                    posLines.Posted := true;
                    posLines.Modify();
                until posLines.Next() = 0;
                if POSSaleHeader."Customer Type" <> POSSaleHeader."Customer Type"::NonRevenue then begin
                    POSSaleHeader.Validate("Customer Type");
                    // Delete Lines Present on the General Journal Line
                    GenJnLine.RESET;
                    GenJnLine.SETRANGE(GenJnLine."Journal Template Name", PosSetup."Journal Template Name");
                    GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", ReceiptNo);
                    GenJnLine.DELETEALL;

                    GenJournBatch.Reset();
                    GenJournBatch."Journal Template Name" := PosSetup."Journal Template Name";
                    GenJournBatch.Name := ReceiptNo;
                    IF NOT GenJournBatch.GET(GenJournBatch."Journal Template Name", GenJournBatch.Name) THEN
                        GenJournBatch.INSERT;

                    //Debit Post acquisition
                    LineNo := GetLastLineNo() + 1000;
                    GenJnLine.INIT;
                    GenJnLine."Journal Template Name" := PosSetup."Journal Template Name";
                    GenJnLine."Journal Batch Name" := ReceiptNo;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
                    GenJnLine."Shortcut Dimension 1 Code" := PosSetup."Department Code";
                    GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
                    GenJnLine."Account No." := POSSaleHeader."Bank Account";
                    GenJnLine."Posting Date" := POSSaleHeader."Posting Date";
                    GenJnLine."Document No." := ReceiptNo;
                    GenJnLine.Description := 'Food sales for ' + format(POSSaleHeader."Customer Type") + ' at ' + Format(CurrentDateTime);
                    POSSaleHeader.CalcFields("Total Amount");
                    if POSSaleHeader."Total Amount" < 1 then
                        Error(Err);
                    GenJnLine.Amount := POSSaleHeader."Total Amount";
                    GenJnLine.VALIDATE(GenJnLine.Amount);
                    GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
                    GenJnLine."Bal. Account No." := POSSaleHeader."Income Account";
                    IF GenJnLine.Amount <> 0 THEN
                        GenJnLine.INSERT;
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
                    POSSaleHeader.Posted := True;
                    POSSaleHeader.Modify(true);

                    GenJournBatch.setrange("Journal Template Name", PosSetup."Journal Template Name");
                    GenJournBatch.setrange(Name, ReceiptNo);
                    GenJournBatch.Delete();
                end;
            end;

        end;
    end;

    procedure PostSalesStud(ReceiptNo: Code[50])
    begin
        PosSetup.Get();
        POSSaleHeader.Reset();
        POSSaleHeader.SetRange("No.", ReceiptNo);
        if POSSaleHeader.Find('-') then begin
            POSSaleHeader.CalcFields("Total Amount");
            totSalesAmount := POSSaleHeader."Total Amount";
            posLines.Reset();
            posLines.SetRange("Document No.", ReceiptNo);
            if posLines.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := posLines."No.";
                    itemledger."Document No." := posLines."No." + posLines."Document No.";
                    itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
                    itemledger."Posting Date" := POSSaleHeader."Posting Date";
                    itemledger.Quantity := -posLines.Quantity;
                    itemledger.Description := posLines.Description;
                    itemledger.Insert(true);
                    posLines.Posted := true;
                    posLines.Modify();
                    //stud Details
                    // cafestudLedger.Init();
                    // cafestudLedger."Entry No." := GetLastEntryN2 + 1;
                    // cafestudLedger."Item No." := posLines."No.";
                    // cafestudLedger."Document No." := posLines."No." + posLines."Document No.";
                    // cafestudLedger."Entry Type" := cafestudLedger."Entry Type"::"Negative Adjmt.";
                    // cafestudLedger."Posting Date" := POSSaleHeader."Posting Date";
                    // //cafestudLedger.StudentId := POSSaleHeader."Customer No";
                    // cafestudLedger.Amount := (totSalesAmount) * 1;
                    // cafestudLedger.Quantity := -posLines."Line Total";
                    // cafestudLedger.Description := posLines.Description;
                    cafestudLedger.Insert(true);
                    posLines.Posted := true;
                    posLines.Modify();
                until posLines.Next() = 0;
                if POSSaleHeader."Customer Type" <> POSSaleHeader."Customer Type"::NonRevenue then begin
                    POSSaleHeader.Validate("Customer Type");
                    // Delete Lines Present on the General Journal Line
                    GenJnLine.RESET;
                    GenJnLine.SETRANGE(GenJnLine."Journal Template Name", PosSetup."Journal Template Name");
                    GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", ReceiptNo);
                    GenJnLine.DELETEALL;

                    GenJournBatch.Reset();
                    GenJournBatch."Journal Template Name" := PosSetup."Journal Template Name";
                    GenJournBatch.Name := ReceiptNo;
                    IF NOT GenJournBatch.GET(GenJournBatch."Journal Template Name", GenJournBatch.Name) THEN
                        GenJournBatch.INSERT;

                    //post to control account
                    LineNo := GetLastLineNo() + 1000;

                    GenJnLine.INIT;
                    GenJnLine."Journal Template Name" := PosSetup."Journal Template Name";
                    GenJnLine."Journal Batch Name" := ReceiptNo;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
                    GenJnLine."Shortcut Dimension 1 Code" := PosSetup."Department Code";
                    GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                    //GenJnLine."Account No." := PosSetup."Cafeteria Account";
                    GenJnLine."Posting Date" := POSSaleHeader."Posting Date";
                    GenJnLine."Document No." := ReceiptNo;
                    GenJnLine.Description := 'Food sales for ' + format(POSSaleHeader."Customer Type") + ' at ' + Format(CurrentDateTime);
                    if totSalesAmount < 1 then
                        Error(Err);
                    GenJnLine.Amount := totSalesAmount;
                    GenJnLine.VALIDATE(GenJnLine.Amount);
                    GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
                    //GenJnLine."Bal. Account No." := PosSetup."Cafeteria Account";
                    IF GenJnLine.Amount <> 0 THEN
                        GenJnLine.INSERT;
                    GenJnLine.Reset();
                    GenJnLine.SETRANGE("Journal Template Name", PosSetup."Journal Template Name");
                    GenJnLine.SETRANGE("Journal Batch Name", ReceiptNo);
                    IF GenJnLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
                    end;
                    POSSaleHeader.Posted := True;
                    POSSaleHeader.Modify(true);
                    //GenJournBatch.setrange("Journal Template Name", PosSetup."Journal Template Name");
                    //GenJournBatch.setrange(Name, ReceiptNo);
                    //GenJournBatch.Delete();
                end;
            end;

        end;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        PosLedger: Record "POS Item Ledger";
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;

    // procedure GetLastEntryN2(): Integer;
    // begin
    //     cafeStudLedger.Reset();
    //     if cafeStudLedger.FindLast() then
    //         exit(cafeStudLedger."Entry No.")
    //     else
    //         exit(0);
    // end;


    procedure GetLastLineNo(): Integer
    begin
        GenJnLine.Reset();
        if GenJnLine.FindLast() then
            exit(GenJnLine."Line No.") else
            exit(1);
    end;

    procedure HasDocument(DocNo: Code[50]): Boolean
    var
        NoDocErr: Label 'Please attach documents';
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("No.", DocNo);
        if DocAttachment.IsEmpty then
            Error(NoDocErr) else
            exit(true);
    end;

}
