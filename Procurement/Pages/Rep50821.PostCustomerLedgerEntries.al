report 50821 "Post Customer Ledger Entries"
{

    ApplicationArea = All;
    Caption = 'Post Customer Ledger Entries to G/L';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem("Cust Ledger Entries Custom"; "Cust Ledger Entries Custom")
        {
            DataItemTableView = WHERE(Posted = CONST(false));
            RequestFilterFields = "Posting Date";
            
            trigger OnPreDataItem()
            begin
                if not Confirm('Do you want to post %1 unposted customer ledger entries?', false, Count) then
                    CurrReport.Break();
                
                Window.Open('Posting entries #1#### of #2####');
                TotalCount := Count;
                Counter := 0;
            end;
            
            trigger OnAfterGetRecord()
            begin
                Counter += 1;
                Window.Update(1, Counter);
                Window.Update(2, TotalCount);
                
                PostTransactionToGL("Cust Ledger Entries Custom");
            end;
            
            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Posted %1 entries successfully.', SuccessCount);
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
            "Cust Ledger Entries Custom".SetRange("Posting Date", StartDate, EndDate);
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
    
    local procedure PostTransactionToGL(var CustLedgerEntry: Record "Cust Ledger Entries Custom")
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
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
        GenJournalLine.Description :=CustLedgerEntry.Description;
        
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