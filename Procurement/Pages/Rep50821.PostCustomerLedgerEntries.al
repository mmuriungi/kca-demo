report 50821 "Post Customer Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Post Customer Ledger Entries to G/L';
    //ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/detailed.rdlc';
    PreviewMode = PrintLayout;

    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DetailedEntry; "Detailed Cust ledger Custom")
        {
            RequestFilterFields = "Posting Date", "Document No.";

            trigger OnPreDataItem()
            begin
                // Apply filters
                //DetailedEntry.SetRange(Posted, false);
                DetailedEntry.SetRange("Entry Type", DetailedEntry."Entry Type"::"Initial Entry");

                if (StartDate <> 0D) and (EndDate <> 0D) then
                    DetailedEntry.SetRange("Posting Date", StartDate, EndDate);

                TotalCount := DetailedEntry.Count;

                if TotalCount = 0 then begin
                    Message('No unposted customer ledger entries found.');
                    CurrReport.Break();
                end;

                if not Confirm('Do you want to post %1 unposted customer ledger entries?', false, TotalCount) then
                    CurrReport.Break();

                // Only open dialog when you're sure the report will run
                Window.Open('Posting entry #1#### of #2####');
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
                PostTransactionToGL(DetailedEntry);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Posted %1 entries successfully.', SuccessCount);
                if SkippedCount > 0 then
                    Message('%1 entries were skipped (duplicate in Cust. Ledger Entry).', SkippedCount);
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if EndDate = 0D then
                EndDate := WorkDate();
            if StartDate = 0D then
                StartDate := CalcDate('<-CM>', EndDate);
        end;
    }

    trigger OnPreReport()
    begin
        if (StartDate <> 0D) and (EndDate <> 0D) then
            DetailedEntry.SetRange("Posting Date", StartDate, EndDate);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        SuccessCount: Integer;
        ErrorCount: Integer;
        lineNo: Integer;
        SkippedCount: Integer;

    local procedure PostTransactionToGL(var CustLedgerEntry: Record "Detailed Cust ledger Custom")
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //  CustomerLedgerEntry.SetRange("Document No.", CustLedgerEntry."Document No.");
        //CustomerLedgerEntry.SetRange(Amount, CustLedgerEntry.Amount);
        //CustomerLedgerEntry.SetRange("Customer No.", CustLedgerEntry."Customer No.");

        // if not CustomerLedgerEntry.IsEmpty then begin
        //  CustLedgerEntry.Posted := true;
        // CustLedgerEntry.Modify();
        // SkippedCount += 1;
        // exit;
        // end;

        //if not GenJournalBatch.Get('GENERAL', 'DEFAULT') then begin
        //  ErrorCount += 1;
        //   exit;
        //  end;
        lineNo := lineNo + 1;
        ;

        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'DEFAULT';
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Document No." := CustLedgerEntry."Document No.";
        GenJournalLine."Posting Date" := CustLedgerEntry."Posting Date";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := CustLedgerEntry."Customer No.";
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := '72001';
        //GenJournalLine.Amount := CustLedgerEntry.Amount;
        GenJournalLine.Description := CustLedgerEntry.Description;
        if CustLedgerEntry.Amount <> 0 then
            GenJournalLine.Amount := CustLedgerEntry.Amount;

        if GenJournalLine.Insert() then begin
            if CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine) then begin
                CustLedgerEntry.Posted := true;
                CustLedgerEntry.Modify();
                SuccessCount += 1;
            end else
                ErrorCount += 1;
        end else
            ErrorCount += 1;
    end;
}
