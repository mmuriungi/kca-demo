report 50821 "Post Customer Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Post Customer Ledger Entries to G/L';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/detailed.rdlc';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DetailedEntry; "Detailed Cust ledger Custom")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Entry Type", Posted;

            trigger OnAfterGetRecord()
            begin
                // Always set template and batch before using GenJournalLine1
                GenJournalLine1."Journal Template Name" := 'GENERAL';
                GenJournalLine1."Journal Batch Name" := 'DEFAULT';

                // Get last Line No. only once
                if lineNo = 0 then begin
                    GenJournalLine1.Reset();
                    GenJournalLine1.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine1.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine1.FindLast() then
                        lineNo := GenJournalLine1."Line No.";
                end;

                lineNo := lineNo + 10000;

                GenJournalLine1.Init();
                GenJournalLine1."Journal Template Name" := 'GENERAL';
                GenJournalLine1."Journal Batch Name" := 'DEFAULT';
                GenJournalLine1."Line No." := lineNo;
                GenJournalLine1."Document No." := DetailedEntry."Document No.";
                GenJournalLine1."Posting Date" := DetailedEntry."Posting Date";
                GenJournalLine1."Account Type" := GenJournalLine1."Account Type"::Customer;
                GenJournalLine1."Account No." := DetailedEntry."Customer No.";
                GenJournalLine1."Bal. Account Type" := GenJournalLine1."Bal. Account Type"::"G/L Account";
                GenJournalLine1."Bal. Account No." := '72001';
                GenJournalLine1.Description := DetailedEntry.Description;

                if DetailedEntry.Amount <> 0 then
                    GenJournalLine1.Amount := DetailedEntry.Amount;

                GenJournalLine1.Insert(true);

                DetailedEntry.Posted := true;
                DetailedEntry.Modify();
            end;


            trigger OnPostDataItem()
            begin
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine1);
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
    }

    var
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        SuccessCount: Integer;
        GenJournalLine1: Record "Gen. Journal Line";
        lineNo: Integer;
}
