report 50826 "Posted Gen Ledgers"
{
    Caption = 'Posted Gen Ledgers';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/gendetailed.rdlc';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true; // Change to true since we're not actually printing anything

    dataset
    {
        dataitem(DetailedEntry; "Custom Gen Ledgers")
        {
            RequestFilterFields = "Posting Date", "Document No", posted;

            trigger OnPreDataItem()
            begin
                // Apply the filters here to ensure they're active during processing
                if StartDate <> 0D then
                    DetailedEntry.SetFilter("Posting Date", '>=%1', StartDate);
                if EndDate <> 0D then
                    DetailedEntry.SetFilter("Posting Date", '<=%1', EndDate);
                if ProcessOnlyUnposted then
                    DetailedEntry.SetRange(Posted, false);

                // Count records that match the filter
                RecordCount := DetailedEntry.Count;
                if RecordCount = 0 then begin
                    Message('No records match your filter criteria. Please check your filters.');
                    CurrReport.Break();
                end;

                Window.Open('Processing record #1#### of #2####');
                CurrentRecord := 0;

                // Clear existing journal entries
                GenJournalLine1.Reset();
                GenJournalLine1.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine1.SetRange("Journal Batch Name", 'DATAUPLOAD');
                GenJournalLine1.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            var
                LastGenJournalLine: Record "Gen. Journal Line";
            begin
                CurrentRecord += 1;
                Window.Update(1, CurrentRecord);
                Window.Update(2, RecordCount);

                // Log information to a temporary storage instead of showing messages
                // Remove the Message calls that were here before

                // Skip records with zero amount or empty account
                if (DetailedEntry.Amount = 0) or (DetailedEntry."Account No" = '') then begin
                    SkippedCount += 1;
                    // Store in a log instead of showing message
                    LogSkippedDocuments += DetailedEntry."Document No" + ', ';
                    exit;
                end;

                // Find the last line number in the journal batch
                LastGenJournalLine.Reset();
                LastGenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                LastGenJournalLine.SetRange("Journal Batch Name", 'DATAUPLOAD');
                if LastGenJournalLine.FindLast() then
                    lineNo := LastGenJournalLine."Line No." + 10000
                else
                    lineNo := 10000;

                // Initialize and set journal line fields
                Clear(GenJournalLine1);
                GenJournalLine1.Init();
                GenJournalLine1."Journal Template Name" := 'GENERAL';
                GenJournalLine1."Journal Batch Name" := 'DATAUPLOAD';
                GenJournalLine1."Line No." := lineNo;
                GenJournalLine1."Document No." := DetailedEntry."Document No";
                GenJournalLine1."Posting Date" := DetailedEntry."Posting Date";
                GenJournalLine1."Account Type" := DetailedEntry."Account Type";
                GenJournalLine1."Account No." := DetailedEntry."Account No";
                GenJournalLine1.Description := DetailedEntry.Description;
                GenJournalLine1.Amount := DetailedEntry.Amount;

                // Validate key fields to ensure proper setup
                GenJournalLine1.Validate("Account No.");
                GenJournalLine1.Validate(Amount);

                if GenJournalLine1.Insert(true) then begin
                    // Update the Posted field
                    DetailedEntry.Posted := true;
                    DetailedEntry.Modify();
                    SuccessCount += 1;
                end else begin
                    ErrorCount += 1;
                    // Store in a log instead of showing message
                    LogErrorDocuments += DetailedEntry."Document No" + ', ';
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();

                // Display message with summary after all records are processed
                if SuccessCount = 0 then
                    Message('No records were processed successfully.')
                else
                    Message('%1 records were successfully processed, %2 were skipped, %3 had errors.',
                        SuccessCount, SkippedCount, ErrorCount);

                // Optionally, if detailed logs are needed, show them in a separate message
                if ShowDetailedLog then begin
                    if LogSkippedDocuments <> '' then
                        Message('Skipped Documents: %1', LogSkippedDocuments);

                    if LogErrorDocuments <> '' then
                        Message('Error Documents: %1', LogErrorDocuments);
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Optional: Filter records from this date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Optional: Filter records until this date';
                    }
                    field(ProcessOnlyUnposted; ProcessOnlyUnposted)
                    {
                        ApplicationArea = All;
                        Caption = 'Process Only Unposted Records';
                        ToolTip = 'Enable this to process only records where Posted = No';
                    }
                    field(ShowDetailedLog; ShowDetailedLog)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Detailed Error Log';
                        ToolTip = 'Enable to see detailed document numbers for skipped and error records';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            // Set default values
            ProcessOnlyUnposted := true;
            ShowDetailedLog := false;
        end;
    }

    var
        GentempCode: code[20];
        genbatchName: code[20];
        StartDate: Date;
        EndDate: Date;
        ShowDetailedLog: Boolean;
        LogSkippedDocuments: Text;
        LogErrorDocuments: Text;
        Window: Dialog;
        SuccessCount: Integer;
        SkippedCount: Integer;
        ErrorCount: Integer;
        GenJournalLine1: Record "Gen. Journal Line";
        lineNo: Integer;
        ProcessOnlyUnposted: Boolean;
        CurrentRecord: Integer;
        RecordCount: Integer;

    trigger OnPreReport()
    begin
        // Initialize variables
        SuccessCount := 0;
        SkippedCount := 0;
        ErrorCount := 0;
        LogSkippedDocuments := '';
        LogErrorDocuments := '';
    end;
}