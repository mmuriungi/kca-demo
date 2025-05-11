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
            RequestFilterFields = "Posting Date", "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF DetailedEntry."Entry Type" = DetailedEntry."Entry Type"::"Initial Entry" then begin
                    CUstLedger.RESET;
                    CUstLedger.SETRANGE("Document No.", DetailedEntry."Document No.");
                    CUstLedger.SETRANGE("Customer No.", DetailedEntry."Customer No.");
                    CUstLedger.SETRANGE(Posted, false);
                    CUstLedger.SetRange("Posting Date", StartDate, EndDate);

                    IF CUstLedger.FindSet() then begin
                        repeat
                            lineNo := lineNo + 10000;
                            CUstLedger.CalcFields(Description);

                            GenJournalLine1.Init();
                            GenJournalLine1."Journal Template Name" := 'GENERAL';
                            GenJournalLine1."Journal Batch Name" := 'DEFAULT';
                            GenJournalLine1."Line No." := lineNo;
                            GenJournalLine1."Document No." := CUstLedger."Document No.";
                            GenJournalLine1."Posting Date" := CUstLedger."Posting Date";
                            GenJournalLine1."Account Type" := GenJournalLine1."Account Type"::Customer;
                            GenJournalLine1."Account No." := CUstLedger."Customer No.";
                            GenJournalLine1."Bal. Account Type" := GenJournalLine1."Bal. Account Type"::"G/L Account";
                            GenJournalLine1."Bal. Account No." := '72001';
                            GenJournalLine1.Description := CUstLedger.Description;

                            if CUstLedger.Amount <> 0 then
                                GenJournalLine1.Amount := CUstLedger.Amount;

                            if GenJournalLine1.Insert(True) then begin
                                if CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine1) then begin
                                    CUstLedger.Posted := true;
                                    CUstLedger.Modify();
                                    SuccessCount += 1;
                                end;
                            end;
                        until CUstLedger.Next() = 0;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Processing...');
                lineNo := 0;
                SuccessCount := 0;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Successfully posted %1 records.', SuccessCount);
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
            if StartDate = 0D then begin
                StartDate := CalcDate('<-CM>', WorkDate());
                EndDate := WorkDate();
            end;
        end;
    }

    var
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        CUstLedger: Record "Detailed Cust ledger Custom";
        SuccessCount: Integer;
        GenJournalLine1: Record "Gen. Journal Line";
        lineNo: Integer;
}