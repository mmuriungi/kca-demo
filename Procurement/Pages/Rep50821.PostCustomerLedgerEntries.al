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
            CalcFields = description;

            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                // Check if record already exists in customer ledger entries
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Document No.", DetailedEntry."Document No.");
                CustLedgerEntry.SetRange(Amount, DetailedEntry.Amount);
                CustLedgerEntry.SetRange("Customer No.", DetailedEntry."Customer No.");

                // If record exists, skip insertion
                if not CustLedgerEntry.IsEmpty then begin
                    // Optionally mark as posted if it exists elsewhere
                    DetailedEntry.Posted := true;
                    DetailedEntry.Modify();
                    exit;  // Skip the rest of the trigger
                end;

                // Only proceed if no matching record was found
                GenJournalLine1.Init();
                GenJournalLine1."Journal Template Name" := 'GENERAL';
                GenJournalLine1."Journal Batch Name" := 'DATAUPLOAD';
                GenJournalLine1."Line No." := GenJournalLine1."Line No." + 10000;

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
            var
                GenJournalLineToPost: Record "Gen. Journal Line";
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
        GentempCode: code[20];
        genbatchName: code[20];
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        SuccessCount: Integer;
        GenJournalLine1: Record "Gen. Journal Line";
        lineNo: Integer;

    trigger OnPreReport()
    begin
        GenJournalLine1.Reset();
        GenJournalLine1.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine1.SetRange("Journal Batch Name", 'DEFAULT');
        GenJournalLine1.DeleteAll();

        lineNo := 0;

        // Convert boolean filter to numeric filter
        if DetailedEntry.GetFilter(Posted) = 'Yes' then
            DetailedEntry.SetRange(Posted, true)
        else if DetailedEntry.GetFilter(Posted) = 'No' then
            DetailedEntry.SetRange(Posted, false);
    end;
}