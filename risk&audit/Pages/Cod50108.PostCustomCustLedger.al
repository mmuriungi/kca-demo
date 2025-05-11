codeunit 50108 "Post Custom Cust Ledger"


{
    trigger OnRun()
    begin
        // Simply process all unposted records
        ProcessUnpostedRecords(false);
    end;

    local procedure ProcessUnpostedRecords(FilterByEntryType: Boolean)
    var
        DetailedCustLedgerCustom: Record "Detailed Cust ledger Custom";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Window: Dialog;
        LineNo: Integer;
        RecordCount: Integer;
        TotalCount: Integer;
        RecordNo: Integer;
        EntryTypeText: Text;
    begin
        // Filter for unposted records
        DetailedCustLedgerCustom.SetRange(Posted, false);

        // Only apply Entry Type filter if requested
        if FilterByEntryType then
            DetailedCustLedgerCustom.SetRange("Entry Type", DetailedCustLedgerCustom."Entry Type"::"Initial Entry");

        if not DetailedCustLedgerCustom.FindSet() then begin
            Message('No matching unposted records found.');
            exit;
        end;

        // Count total records for progress display
        TotalCount := DetailedCustLedgerCustom.Count;

        if not Confirm('Ready to process %1 records. Continue?', true, TotalCount) then
            exit;

        // Setup progress window
        Window.Open('Processing Record #1#### of #2####\' +
                    'Document No.: #3##########\' +
                    'Customer: #4##########\' +
                    'Entry Type: #5##########');

        RecordCount := 0;
        RecordNo := 0;

        repeat
            RecordNo += 1;

            // Get Entry Type as text for display
            if DetailedCustLedgerCustom."Entry Type" = DetailedCustLedgerCustom."Entry Type"::"Initial Entry" then
                EntryTypeText := 'Initial Entry'
            else
                EntryTypeText := Format(DetailedCustLedgerCustom."Entry Type");

            // Update progress window
            Window.Update(1, RecordNo);
            Window.Update(2, TotalCount);
            Window.Update(3, DetailedCustLedgerCustom."Document No.");
            Window.Update(4, DetailedCustLedgerCustom."Customer No.");
            Window.Update(5, EntryTypeText);

            // We need to calculate FlowFields for each record
            DetailedCustLedgerCustom.CalcFields(Description);

            // Clear Gen Journal Line to prepare for new entry
            GenJournalLine.Init();

            // Set up line number
            LineNo := 10000;

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

            // Update the original record to mark as posted
            DetailedCustLedgerCustom.Posted := true;
            DetailedCustLedgerCustom.Modify();

            LineNo += 10000;  // Increment line number for next entry

        until DetailedCustLedgerCustom.Next() = 0;

        // Close progress window
        Window.Close();

        Message('Posted %1 records successfully.', RecordCount);
    end;
}