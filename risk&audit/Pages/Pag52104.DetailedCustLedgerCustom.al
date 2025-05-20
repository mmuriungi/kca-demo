report 50823 "Post Detailed Cust Ledger Entr"
{
    Caption = 'Post Cust Ledger Entries';
    /// ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PostCusrLedgers.rdlc';

    dataset
    {
        dataitem("Detailed Cust ledger Custom"; "Detailed Cust ledger Custom")
        {
            RequestFilterFields = "Posting Date", Posted, "Entry Type";

            trigger OnPreDataItem()
            begin
                //Window.OPEN('Processing Records:\ Document No.: #1##############\ Customer No.: //#2##############\ Amount: #3##############\ Records Processed: #4########');
                // TotalRecords := COUNT;
                // MESSAGE('Found %1 records to process', TotalRecords);
                // CurrentRecord := 0;
            end;

            trigger OnAfterGetRecord()
            var
                GenJnlLine: Record "Gen. Journal Line";
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                GenJnlTemplate: Code[10];
                GenJnlBatch: Code[10];
                LineNo: Integer;
            begin
                CALCFIELDS(Description);

                // Update progress window
                // CurrentRecord += 1;
                //  Window.UPDATE(1, "Document No.");
                //  Window.UPDATE(2, "Customer No.");
                //  Window.UPDATE(3, FORMAT(Amount));
                //  Window.UPDATE(4, FORMAT(CurrentRecord) + ' of ' + FORMAT(TotalRecords));

                // Setup Journal Template and Batch 
                GenJnlTemplate := 'GENERAL';
                GenJnlBatch := 'DEFAULT';

                // Get the next available Line No.
                GenJnlLine.RESET();
                GenJnlLine.SETRANGE("Journal Template Name", GenJnlTemplate);
                GenJnlLine.SETRANGE("Journal Batch Name", GenJnlBatch);
                IF GenJnlLine.FINDLAST() THEN
                    LineNo := GenJnlLine."Line No." + 10000
                ELSE
                    LineNo := 10000;

                // Prepare Gen. Journal Line 
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := GenJnlTemplate;
                GenJnlLine."Journal Batch Name" := GenJnlBatch;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := "Posting Date";
                GenJnlLine."Document No." := "Document No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := "Customer No.";
                GenJnlLine.Amount := Amount;
                GenJnlLine.Description := Description;
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '72001';
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert(true);

                // Post the line 
                CLEAR(GenJnlPostLine);
                GenJnlPostLine.RUN(GenJnlLine);

                // Mark as posted 
                Posted := true;
                Modify();
            end;

            trigger OnPostDataItem()
            begin
                // Window.CLOSE();
                // MESSAGE('Processing complete. %1 records were processed.', CurrentRecord);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filter)
                {
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
            StartDate := WORKDATE - 30;
            EndDate := WORKDATE;
        end;
    }

    trigger OnPreReport()
    begin
        "Detailed Cust ledger Custom".SETRANGE("Posting Date", StartDate, EndDate);
        "Detailed Cust ledger Custom".SETRANGE(Posted, FALSE);
        "Detailed Cust ledger Custom".SETRANGE("Entry Type", "Detailed Cust ledger Custom"."Entry Type"::"Initial Entry");
    end;

    var
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
}