report 50821 "Post Customer Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Post Customer Ledger Entries to G/L';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem("Detailed Cust ledger Custom"; "Detailed Cust ledger Custom")
        {
            DataItemTableView = WHERE(Posted = CONST(false),"Entry Type"=const("Initial Entry"));
            RequestFilterFields = "Posting Date";
            
            trigger OnPreDataItem()
            begin
                if not Confirm('Do you want to post %1 unposted customer ledger entries?', false, Count) then
                    CurrReport.Break();
                
                Window.Open('Posting entries #1#### of #2####');
                TotalCount := Count;
                Counter := 0;
                SuccessCount := 0;
                ErrorCount := 0;
                SkippedCount := 0;
            end;
            
            trigger OnAfterGetRecord()
            begin
                Counter += 1;
                Window.Update(1, Counter);
                Window.Update(2, TotalCount);
                
                PostTransactionToGL("Detailed Cust ledger Custom");
            end;
            
            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Posted %1 entries successfully.', SuccessCount);
                if SkippedCount > 0 then
                    Message('%1 entries were skipped because they already exist in Customer Ledger Entries.', SkippedCount);
                if ErrorCount > 0 then
                    Message('%1 entries had errors during posting.', ErrorCount);
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDateCtrl; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the starting date for the posting period.';
                    }
                    field(EndDateCtrl; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the ending date for the posting period.';
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            EndDate := WorkDate();
            StartDate := CalcDate('<-CM>', EndDate);
        end;
    }
    
    trigger OnPreReport()
    begin
        if (StartDate <> 0D) and (EndDate <> 0D) then begin
           "Detailed Cust ledger Custom".SetRange("Posting Date", StartDate, EndDate);
        end;
    end;
    
    var
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        SuccessCount: Integer;
        ErrorCount: Integer;
        SkippedCount: Integer;
    
    local procedure PostTransactionToGL(var CustLedgerEntry: Record "Detailed Cust ledger Custom")
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DuplicateExists: Boolean;
    begin
        // Check for duplicate entries in standard Customer Ledger Entries
        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetRange("Document No.", CustLedgerEntry."Document No.");
        CustomerLedgerEntry.SetRange("Posting Date", CustLedgerEntry."Posting Date");
        CustomerLedgerEntry.SetRange("Customer No.", CustLedgerEntry."Customer No.");
        DuplicateExists := not CustomerLedgerEntry.IsEmpty;
        
        if DuplicateExists then begin
            // Mark as processed to avoid future processing attempts
            CustLedgerEntry.Posted := true;
            CustLedgerEntry.Modify();
            // Increment counter for skipped entries
            SkippedCount += 1;
            exit;
        end;
        
        // Find or create a batch
        GenJournalBatch.Reset();
        GenJournalBatch.SetRange("Journal Template Name", 'GENERAL');
        if not GenJournalBatch.FindFirst() then begin
            ErrorCount += 1;
            exit;
        end;
        
        // Create journal line
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := GenJournalBatch.Name;
        GenJournalLine."Line No." := 10000;
        GenJournalLine."Document No." := CustLedgerEntry."Document No.";  
        GenJournalLine."Posting Date" := CustLedgerEntry."Posting Date";  
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := CustLedgerEntry."Customer No.";
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := '72001';
        GenJournalLine.Amount := CustLedgerEntry.Amount;
        GenJournalLine.Description := CustLedgerEntry.Description;
        
        if GenJournalLine.Insert() then begin
            // Post the journal
            if CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine) then begin
                // Update Posted field
                CustLedgerEntry.Posted := true;
                CustLedgerEntry.Modify();
                SuccessCount += 1;
            end else
                ErrorCount += 1;
        end else
            ErrorCount += 1;
    end;
}