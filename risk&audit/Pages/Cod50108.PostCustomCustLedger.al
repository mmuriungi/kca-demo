codeunit 50108 "Post Custom Cust Ledger"
{
    trigger OnRun()
    begin
        ShowDateFilterPage();
    end;

    local procedure ShowDateFilterPage()
    var
        DateFilterDialog: Page "Post Custom Ledger Filter";
    begin
        // Configure dialog in lookup mode to ensure it returns properly
        DateFilterDialog.LookupMode(true);

        // Run the dialog and check if user clicked OK
        if DateFilterDialog.RunModal() = Action::LookupOK then begin
            // Get the date range
            DateFilterDialog.GetDateFilter(GlobalStartDate, GlobalEndDate);

            // Process the records directly
            ProcessRecords();
        end;
    end;

    local procedure ProcessRecords()
    var
        DetailedCustLedgerCustom: Record "Detailed Cust ledger Custom";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Window: Dialog;
        LineNo: Integer;
        RecordCount: Integer;
        TotalRecords: Integer;
        RecordNo: Integer;
    begin
        // First get all records without applying any filters
        if not DetailedCustLedgerCustom.FindSet() then begin
            Message('No records found in the table.');
            exit;
        end;

        // Count total records for the confirmation message
        TotalRecords := DetailedCustLedgerCustom.Count;


        if not Confirm('Found %1 total records. Process those within date range %2..%3?',
                      true, TotalRecords, Format(GlobalStartDate), Format(GlobalEndDate)) then
            exit;

        // Setup progress window
        Window.Open('Processing Records\' +
                    'Current: #1####\' +
                    'Document No.: #2##########\' +
                    'Customer: #3##########\' +
                    'Posting Date: #4############\' +
                    'Amount: #5############');

        RecordCount := 0;
        RecordNo := 0;

        repeat
            RecordNo += 1;

            // Only process records that match our criteria
            if (DetailedCustLedgerCustom."Entry Type" = DetailedCustLedgerCustom."Entry Type"::"Initial Entry") and
               (DetailedCustLedgerCustom."Posting Date" >= GlobalStartDate) and
               (DetailedCustLedgerCustom."Posting Date" <= GlobalEndDate) then begin
                // Update progress window
                Window.Update(1, RecordNo);
                Window.Update(2, DetailedCustLedgerCustom."Document No.");
                Window.Update(3, DetailedCustLedgerCustom."Customer No.");
                Window.Update(4, Format(DetailedCustLedgerCustom."Posting Date"));
                Window.Update(5, Format(DetailedCustLedgerCustom.Amount));

                // We need to calculate FlowFields for each record
                DetailedCustLedgerCustom.CalcFields(Description);

                // Clear Gen Journal Line to prepare for new entry
                GenJournalLine.Init();

                // Set up line number
                LineNo := 10000 + RecordCount;

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
            end;

        until DetailedCustLedgerCustom.Next() = 0;

        // Close progress window
        Window.Close();

        Message('Posted %1 records successfully.', RecordCount);
    end;

    var
        GlobalStartDate: Date;
        GlobalEndDate: Date;
}