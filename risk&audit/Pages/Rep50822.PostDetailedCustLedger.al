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
            DataItemTableView = where("Entry Type" = const("Initial Entry"), Posted = const(false));

            trigger OnPreDataItem()
            begin
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('Both Start Date and End Date must be specified.');

                if StartDate > EndDate then
                    Error('Start Date cannot be later than End Date.');

                // Apply date filter
                "Detailed Cust ledger Custom".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);

                // Check if any records match criteria
                // if "Detailed Cust ledger Custom".IsEmpty then
                //   Error('No records found matching the filter criteria. Please check your date range and other filters.');

                // Clean up existing journal entries
                GenLine.Reset();
                GenLine.SetRange("Journal Batch Name", 'DEFAULT');
                GenLine.SetRange("Journal Template Name", 'GENERAL');
                if not GenLine.IsEmpty() then
                    GenLine.DeleteAll();

                // Find and exclude records that already exist in Customer Ledger
                // ExcludeExistingEntries();

                // Check again if we have records to process
                //  if "Detailed Cust ledger Custom".IsEmpty then
                // Error('All found records already exist in Customer Ledger Entries. No records to process.');

                Window.Open('Processing Records:\ Document No.: #1##############\ Customer No.: #2##############\ Amount: #3##############\ Records Processed: #4########');
                TotalRecords := Count;
                Message('Found %1 records to process', TotalRecords);
                TotalPosted := 0;
                TotalFailed := 0;
                CurrentRecord := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                CurrentRecord += 1;
                Window.Update(1, "Document No.");
                Window.Update(2, "Customer No.");
                Window.Update(3, Format(Amount));
                Window.Update(4, Format(CurrentRecord) + ' of ' + Format(TotalRecords));

                // Skip if amount is zero
                if Amount = 0 then
                    CurrReport.Skip();

                // Get next line number
                GenLine.Reset();
                GenLine.SetRange("Journal Template Name", 'GENERAL');
                GenLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenLine.FindLast() then
                    LineNo := GenLine."Line No." + 10000
                else
                    LineNo := 10000;

                // Make sure Description is calculated
                "Detailed Cust ledger Custom".CalcFields(Description);

                // Create journal line
                GenLine.Init();
                GenLine."Journal Template Name" := 'GENERAL';
                GenLine."Journal Batch Name" := 'DEFAULT';
                GenLine."Line No." := LineNo;
                GenLine."Posting Date" := "Detailed Cust ledger Custom"."Posting Date";
                GenLine."Document No." := "Detailed Cust ledger Custom"."Document No.";
                GenLine."Account Type" := GenLine."Account Type"::Customer;
                GenLine."Account No." := "Detailed Cust ledger Custom"."Customer No.";
                GenLine.Description := "Detailed Cust ledger Custom".Description;
                GenLine.Amount := "Detailed Cust ledger Custom".Amount;
                GenLine."Bal. Account Type" := GenLine."Bal. Account Type"::"G/L Account";
                GenLine."Bal. Account No." := '72001';

                GenLine.Insert(true);
                Commit();

                PostingSuccess := PostGenLine(GenLine);

                if PostingSuccess then begin
                    // Update Posted field to true
                    "Detailed Cust ledger Custom".Posted := true;
                    "Detailed Cust ledger Custom".Modify();
                    TotalPosted += 1;
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
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                }
            }
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = Action::OK then begin
                if StartDate = 0D then
                    Error('Start Date is required.');

                if EndDate = 0D then
                    Error('End Date is required.');

                if StartDate > EndDate then
                    Error('Start Date cannot be later than End Date.');
            end;
            exit(true);
        end;
    }

    local procedure ExcludeExistingEntries()
    var
        TempDetailedCustLedger: Record "Detailed Cust ledger Custom" temporary;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        RecordsToExclude: Integer;
    begin
        // First, copy all matching records to a temporary table
        "Detailed Cust ledger Custom".FindSet();
        repeat
            TempDetailedCustLedger := "Detailed Cust ledger Custom";
            TempDetailedCustLedger.Insert();
        until "Detailed Cust ledger Custom".Next() = 0;

        // Now check each record against Customer Ledger Entries
        RecordsToExclude := 0;
        TempDetailedCustLedger.FindSet();
        repeat
            CustLedgerEntry.Reset();
            CustLedgerEntry.SetRange("Document No.", TempDetailedCustLedger."Document No.");
            CustLedgerEntry.SetRange("Customer No.", TempDetailedCustLedger."Customer No.");
            CustLedgerEntry.SetRange(Amount, TempDetailedCustLedger.Amount);

            if not CustLedgerEntry.IsEmpty() then begin
                // This record already exists in Customer Ledger - exclude it by adding a filter
                "Detailed Cust ledger Custom".SetFilter("Entry No.", '<>%1', TempDetailedCustLedger."Entry No.");
                RecordsToExclude += 1;
            end;
        until TempDetailedCustLedger.Next() = 0;

        if RecordsToExclude > 0 then
            Message('%1 records already exist in Customer Ledger Entries and will be skipped.', RecordsToExclude);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        LineNo: Integer;
        GenLine: Record "Gen. Journal Line";
        TotalPosted: Integer;
        TotalFailed: Integer;
        TotalRecords: Integer;
        CurrentRecord: Integer;
        PostingSuccess: Boolean;
        Window: Dialog;

    trigger OnPostReport()
    begin
        if (TotalPosted = 0) and (TotalFailed = 0) then
            Message('No records were processed. Please check your filter criteria and try again.')
        else
            Message('Process completed: %1 transactions posted, %2 transactions failed.', TotalPosted, TotalFailed);
    end;

    local procedure PostGenLine(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    var
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        exit(GenJnlPostLine.Run(GenJournalLine));
    end;
}