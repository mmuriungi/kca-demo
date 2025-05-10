report 50822 "Post Detailed Cust Ledger"
{
 ApplicationArea = All;
    Caption = 'Post Detailed Cust Ledger';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Detailed Cust ledger Custom"; "Detailed Cust ledger Custom")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Customer No.";
            DataItemTableView = where(Posted = const(false), "Entry Type" = const("Initial Entry"));

            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                GenJournalLine: Record "Gen. Journal Line";
                LineNo: Integer;
                PostingSuccess: Boolean;
            begin
                // Check if the record exists in Customer Ledger Entries
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Document No.", "Detailed Cust ledger Custom"."Document No.");
                CustLedgerEntry.SetRange("Customer No.", "Detailed Cust ledger Custom"."Customer No.");
                CustLedgerEntry.SetRange(Amount, "Detailed Cust ledger Custom".Amount);
                if not CustLedgerEntry.IsEmpty then
                    CurrReport.Skip();

                // Get the next line number
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLine.FindLast() then
                    LineNo := GenJournalLine."Line No." + 10000
                else
                    LineNo := 10000;

                // Insert into Gen. Journal Line
                GenJournalLine.Init();
                GenJournalLine.Validate("Journal Template Name", 'GENERAL');
                GenJournalLine.Validate("Journal Batch Name", 'DEFAULT');
                GenJournalLine.Validate("Line No.", LineNo);
                GenJournalLine.Validate("Posting Date", "Detailed Cust ledger Custom"."Posting Date");
                GenJournalLine.Validate("Document No.", "Detailed Cust ledger Custom"."Document No.");
                GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::Customer);
                GenJournalLine.Validate("Account No.", "Detailed Cust ledger Custom"."Customer No.");
                GenJournalLine.Validate(Description, "Detailed Cust ledger Custom".Description);
                GenJournalLine.Validate(Amount, "Detailed Cust ledger Custom".Amount);
                GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                GenJournalLine.Validate("Bal. Account No.", '72001');
                GenJournalLine.Validate("Source Code", 'GENJNL');
                GenJournalLine.Insert(true);

                // Post the journal line
                Commit();
                PostingSuccess := PostGenJournalLine(GenJournalLine);

                if PostingSuccess then begin
                    // Update Posted field to true
                    "Detailed Cust ledger Custom".Posted := true;
                    "Detailed Cust ledger Custom".Modify();
                    TotalPosted += 1;
                end else begin
                    TotalFailed += 1;
                end;
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
                    field(PostingDate; PostingDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the posting date filter.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if "Detailed Cust ledger Custom".GetFilters = '' then
            if not Confirm('No filters set. Do you want to process all unposted entries?', false) then
                Error('Report canceled by user.');

        TotalPosted := 0;
        TotalFailed := 0;
    end;

    trigger OnPostReport()
    begin
        Message('Process completed: %1 transactions posted, %2 transactions failed.', TotalPosted, TotalFailed);
    end;

    local procedure PostGenJournalLine(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    var
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        exit(GenJnlPostLine.Run(GenJournalLine));
    end;

    var
        PostingDateFilter: Date;
        TotalPosted: Integer;
        TotalFailed: Integer;
}