codeunit 50108 "Post Custom Cust Ledger"

{
    trigger OnRun()
    begin
        ShowDateFilter();
    end;

    local procedure ShowDateFilter()
    var
        DateFilterPage: Page "Post Custom Ledger Filter";
        StartDate: Date;
        EndDate: Date;
    begin
        DateFilterPage.LookupMode(true);

        if DateFilterPage.RunModal() = Action::LookupOK then begin
            DateFilterPage.GetDateFilter(StartDate, EndDate);
            ProcessRecordsWithinDateRange(StartDate, EndDate);
        end;
    end;

    local procedure ProcessRecordsWithinDateRange(FromDate: Date; ToDate: Date)
    var
        DetailedCustLedgerCustom: Record "Detailed Cust ledger Custom";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Window: Dialog;
        LineNo: Integer;
        RecordCount: Integer;
        ProcessedCount: Integer;
    begin
        // Open all records
        DetailedCustLedgerCustom.Reset();

        if not DetailedCustLedgerCustom.FindSet() then begin
            Message('No records found in the table.');
            exit;
        end;

        // Setup progress window
        Window.Open('Processing Records\' +
                    'Document: #1##########\' +
                    'Date: #2##########\' +
                    'Amount: #3##########\' +
                    'Processed: #4#### of #5####');

        // Count total records for display
        RecordCount := DetailedCustLedgerCustom.Count;
        ProcessedCount := 0;
        LineNo := 10000;

        repeat
            // Check if record should be processed
            if (DetailedCustLedgerCustom."Entry Type" = DetailedCustLedgerCustom."Entry Type"::"Initial Entry") and
               (DetailedCustLedgerCustom."Posting Date" >= FromDate) and
               (DetailedCustLedgerCustom."Posting Date" <= ToDate) then begin
                // Update progress dialog
                Window.Update(1, DetailedCustLedgerCustom."Document No.");
                Window.Update(2, Format(DetailedCustLedgerCustom."Posting Date"));
                Window.Update(3, Format(DetailedCustLedgerCustom.Amount));
                Window.Update(4, ProcessedCount);
                Window.Update(5, RecordCount);

                // Calculate flowfields
                DetailedCustLedgerCustom.CalcFields(Description);

                // Create journal line
                GenJournalLine.Init();
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'DEFAULT';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := DetailedCustLedgerCustom."Document No.";
                GenJournalLine."Posting Date" := DetailedCustLedgerCustom."Posting Date";
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine."Account No." := DetailedCustLedgerCustom."Customer No.";
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '72001';
                GenJournalLine.Description := DetailedCustLedgerCustom.Description;
                GenJournalLine.Amount := DetailedCustLedgerCustom.Amount;

                // Insert and post
                if GenJournalLine.Insert() then begin
                    GenJnlPostLine.RunWithCheck(GenJournalLine);

                    // Mark as posted
                    DetailedCustLedgerCustom.Posted := true;
                    DetailedCustLedgerCustom.Modify();

                    ProcessedCount += 1;
                end;

                LineNo += 10000;
            end;
        until DetailedCustLedgerCustom.Next() = 0;

        Window.Close();

        Message('Successfully posted %1 records.', ProcessedCount);
    end;
}