report 50824 "Post Detailed Cust Ledger"
{
    Caption = 'Post Detailed Cust Ledger Entries';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Detailed Cust ledger Custom"; "Detailed Cust ledger Custom")
        {
            RequestFilterFields = "Posting Date", Posted, "Entry Type";

            trigger OnAfterGetRecord()
            var
                GenJnlLine: Record "Gen. Journal Line";
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                GenJnlTemplate: Code[10];
                GenJnlBatch: Code[10];
                LineNo: Integer;
            begin
                CALCFIELDS(Description);

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
                GenJnlLine.Insert(true);

                // Post the line 
                CLEAR(GenJnlPostLine);
                GenJnlPostLine.RUN(GenJnlLine);

                // Mark as posted 
                Posted := true;
                Modify();
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
   
    end;

    var
        StartDate: Date;
        EndDate: Date;
}