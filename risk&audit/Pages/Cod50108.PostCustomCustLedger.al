codeunit 50108 "Post Custom Cust Ledger"
{
    trigger OnRun()
    begin
        // Show the filter page when running the codeunit directly
        ShowDateFilterPage();
    end;
    
    procedure ProcessEntriesByDateRange(StartDate: Date; EndDate: Date)
    begin
        PostUnpostedEntries(StartDate, EndDate);
    end;
    
    local procedure ShowDateFilterPage()
    var
        DateFilterDialog: Page "Post Custom Ledger Filter";
    begin
        DateFilterDialog.RunModal();
        // The page will handle calling ProcessEntriesByDateRange
    end;

    local procedure PostUnpostedEntries(StartDate: Date; EndDate: Date)
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
        // Filter to get only unposted records with entry type 'Initial Entry' within date range
        DetailedCustLedgerCustom.SetRange(Posted, false);
        DetailedCustLedgerCustom.SetRange("Entry Type", DetailedCustLedgerCustom."Entry Type"::"Initial Entry");
        DetailedCustLedgerCustom.SetRange("Posting Date", StartDate, EndDate);
        
        if not DetailedCustLedgerCustom.FindSet() then begin
            Message('No unposted records found within the selected date range.');
            exit;
        end;
            
        // Count total records for progress display
        TotalCount := DetailedCustLedgerCustom.Count;
        
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
            
            // Set up line number
            LineNo := 10000;
            
            // Fill Gen Journal Line
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'DEFAULT';
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Document No." := DetailedCustLedgerCustom."Document No.";
            GenJournalLine."Posting Date" := DetailedCustLedgerCustom."Posting Date";
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := DetailedCustLedgerCustom."Customer No.";
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