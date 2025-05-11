codeunit 50108 "Post Custom Cust Ledger"

{
    trigger OnRun()
    begin
        PostAllRecords();
    end;

    local procedure PostAllRecords()
    var
        DetailedCustLedgerCustom: Record "Detailed Cust ledger Custom";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Window: Dialog;
        LineNo: Integer;
        RecordCount: Integer;
        TotalCount: Integer;
        RecordNo: Integer;
    begin
        // Get all records without any filters
        if not DetailedCustLedgerCustom.FindSet() then begin
            Message('No records found in the table.');
            exit;
        end;

        // Count total records for progress display
        TotalCount := DetailedCustLedgerCustom.Count;

        if not Confirm('Ready to process %1 records. Continue?', true, TotalCount) then
            exit;

        // Setup progress window
        Window.Open('Processing Record #1#### of #2####\' +
                    'Document No.: #3##########\' +
                    'Customer: #4##########');

        RecordCount := 0;
        RecordNo := 0;

        repeat
            RecordNo += 1;

            // Update progress window
            Window.Update(1, RecordNo);
            Window.Update(2, TotalCount);
            Window.Update(3, DetailedCustLedgerCustom."Document No.");
            Window.Update(4, DetailedCustLedgerCustom."Customer No.");

            // We need to calculate FlowFields for each record
            DetailedCustLedgerCustom.CalcFields(Description);

            // Clear Gen Journal Line to prepare for new entry
            GenJournalLine.Init();

            // Set up line number (unique for each entry)
            LineNo := 10000 * RecordNo;

            // Fill Gen Journal Line
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'DEFAULT';
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Document No." := DetailedCustLedgerCustom."Document No.";
            GenJournalLine."Posting Date" := DetailedCustLedgerCustom."Posting Date";

            // Account side (Customer)
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := DetailedCustLedgerCustom."Customer No.";

            // Balancing account side (G/L Account)
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
            GenJournalLine."Bal. Account No." := '72001';

            GenJournalLine.Description := DetailedCustLedgerCustom.Description;
            GenJournalLine.Amount := DetailedCustLedgerCustom.Amount;

            // Insert the line
            if GenJournalLine.Insert() then
                RecordCount += 1;

            // Post the journal line
            GenJnlPostLine.RunWithCheck(GenJournalLine);

        // NOTE: Not marking the record as posted as requested
        // DetailedCustLedgerCustom.Posted := true;
        // DetailedCustLedgerCustom.Modify();

        until DetailedCustLedgerCustom.Next() = 0;

        // Close progress window
        Window.Close();

        Message('Posted %1 records successfully.', RecordCount);
    end;
}