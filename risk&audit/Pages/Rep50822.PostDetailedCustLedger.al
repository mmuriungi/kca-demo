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
            RequestFilterFields = "Document No.", "Customer No.", "Posting Date", "Entry Type", Posted;
            DataItemTableView = where("Entry Type" = const("Initial Entry"));

            trigger OnPreDataItem()
            begin
                Window.Open('Processing Records:\ Document No.: #1##############\ Customer No.: #2##############\ Amount: #3##############\ Total Processed: #4########\ Total Failed: #5########');
                TotalCount := Count;
                Counter := 0;
            end;

            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                GenJournalLine: Record "Gen. Journal Line";
                LineNo: Integer;
                PostingSuccess: Boolean;
            begin
                Counter += 1;
                Window.Update(1, "Document No.");
                Window.Update(2, "Customer No.");
                Window.Update(3, Format(Amount));
                Window.Update(4, TotalPosted);
                Window.Update(5, TotalFailed);

                // Check if the record exists in Customer Ledger Entries
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DeleteAll();
                end;

                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Document No.", "Detailed Cust ledger Custom"."Document No.");
                CustLedgerEntry.SetRange("Customer No.", "Detailed Cust ledger Custom"."Customer No.");
                CustLedgerEntry.SetRange(Amount, "Detailed Cust ledger Custom".Amount);
                if not CustLedgerEntry.IsEmpty then begin
                    Message('Skipping: Document %1 for Customer %2 - Already exists in Customer Ledger', "Document No.", "Customer No.");
                    CurrReport.Skip();
                end;

                // Get the next line number
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLine.FindLast() then
                    LineNo := GenJournalLine."Line No." + 10000
                else
                    LineNo := 10000;
                "Detailed Cust ledger Custom".CalcFields(Description);

                // Insert into Gen. Journal Line
                GenJournalLine.Init();
                GenJournalLine.Validate("Journal Template Name", 'GENERAL');
                GenJournalLine.Validate("Journal Batch Name", 'DEFAULT');
                GenJournalLine.Validate("Line No.", LineNo);
                GenJournalLine.Validate("Posting Date", "Detailed Cust ledger Custom"."Posting Date");
                GenJournalLine.Validate("Document No.", "Detailed Cust ledger Custom"."Document No.");
                //GenJournalLine.Validate("Shortcut Dimension 1 Code", "Detailed Cust ledger Custom".glo);
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
                Message('Posting: Document %1 for Customer %2 with Amount %3', "Document No.", "Customer No.", Amount);
                PostingSuccess := PostGenJournalLine(GenJournalLine);

                if PostingSuccess then begin
                    // Update Posted field to true
                    "Detailed Cust ledger Custom".Posted := true;
                    "Detailed Cust ledger Custom".Modify();
                    TotalPosted += 1;
                    Message('Posted Successfully: Document %1 for Customer %2', "Document No.", "Customer No.");
                end else begin
                    TotalFailed += 1;
                    Message('Posting Failed: Document %1 for Customer %2', "Document No.", "Customer No.");
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
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
                    Caption = 'Date Filter';
                    field(StartDate; StartDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the start date for filtering records.';
                        ShowMandatory = true;
                    }
                    field(EndDate; EndDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the end date for filtering records.';
                        ShowMandatory = true;
                    }
                }
            }
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = Action::OK then begin
                if StartDateFilter = 0D then
                    Error('Start Date is required.');

                if EndDateFilter = 0D then
                    Error('End Date is required.');

                if StartDateFilter > EndDateFilter then
                    Error('Start Date cannot be later than End Date.');
            end;
            exit(true);
        end;
    }

    trigger OnPreReport()
    begin
        // Validate and apply date filter
        if (StartDateFilter = 0D) or (EndDateFilter = 0D) then
            Error('Both Start Date and End Date are required.');

        if StartDateFilter > EndDateFilter then
            Error('Start Date cannot be later than End Date.');

        // Apply the date filter
        "Detailed Cust ledger Custom".SetRange("Posting Date", StartDateFilter, EndDateFilter);

        // Confirm if only date filters are set
        if "Detailed Cust ledger Custom".GetFilters = '' then
            if not Confirm('Only date filters are set (%1 to %2). Do you want to process all unposted initial entries within this date range?',
                            false, StartDateFilter, EndDateFilter) then
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
        Window: Dialog;
        StartDateFilter: Date;
        EndDateFilter: Date;
        TotalPosted: Integer;
        TotalFailed: Integer;
        TotalCount: Integer;
        Counter: Integer;
}