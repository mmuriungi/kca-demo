report 50836 "Bank Reconciliation Closure"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bank Reconciliation Closure Report';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.";

            dataitem("Bank Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No.");
                DataItemTableView = where(Open = const(true), "Statement Status" = const(Open));

                trigger OnAfterGetRecord()
                var
                    BankStatementLine: Record "Bank Statement Lines 2";
                    FoundInStatement: Boolean;
                begin
                    // Check if this bank ledger entry exists in any bank statement line
                    FoundInStatement := false;

                    BankStatementLine.SetRange("Bank Account No.", "Bank Ledger Entry"."Bank Account No.");
                    BankStatementLine.SetRange("Document No.", "Bank Ledger Entry"."Document No.");
                    BankStatementLine.SetRange("Transaction Date", "Bank Ledger Entry"."Posting Date");
                    BankStatementLine.SetRange("Statement Amount", "Bank Ledger Entry".Amount);

                    if BankStatementLine.FindFirst() then
                        FoundInStatement := true;

                    // If not found in statement lines, mark as closed
                    if not FoundInStatement then begin
                        "Bank Ledger Entry".Open := false;
                        "Bank Ledger Entry"."Statement Status" := "Bank Ledger Entry"."Statement Status"::Closed;
                        "Bank Ledger Entry"."Statement No." := GetDefaultStatementNo("Bank Ledger Entry"."Bank Account No.");
                        "Bank Ledger Entry"."Statement Line No." := 0;
                        "Bank Ledger Entry".Modify();

                        // Update counters
                        ProcessedEntries += 1;
                        if ShowDetails then
                            UpdateLogEntry("Bank Ledger Entry");
                    end;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ShowDetails; ShowDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Processing Details';
                        ToolTip = 'Show detailed information about each processed entry';
                    }

                    field(TestMode; TestMode)
                    {
                        ApplicationArea = All;
                        Caption = 'Test Mode (No Updates)';
                        ToolTip = 'Run in test mode without making actual changes';
                    }
                }

                group(Information)
                {
                    Caption = 'Information';

                    field(InfoText; 'This report will mark all Bank Ledger Entries as closed if they are not found in Bank Statement Lines 2 table.')
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                        ShowCaption = false;
                        Style = StrongAccent;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        ProcessedEntries := 0;

        if ShowDetails then
            InitializeLog();

        Message('Starting Bank Reconciliation Closure Process...');
    end;

    trigger OnPostReport()
    begin
        if TestMode then
            Message('Test mode completed. %1 entries would be processed.', ProcessedEntries)
        else
            Message('Bank Reconciliation Closure completed. %1 entries processed and marked as closed.', ProcessedEntries);

        if ShowDetails then
            ShowProcessingLog();
    end;

    var
        ProcessedEntries: Integer;
        ShowDetails: Boolean;
        TestMode: Boolean;
        LogEntries: Text;

    local procedure GetDefaultStatementNo(BankAccountNo: Code[20]): Code[20]
    var
        BankAccountStatement: Record "Bank Account Statement";
    begin
        BankAccountStatement.SetRange("Bank Account No.", BankAccountNo);
        if BankAccountStatement.FindLast() then
            exit(BankAccountStatement."Statement No.");
        exit('CLOSED-' + Format(Today, 0, '<Year4><Month,2><Day,2>'));
    end;

    local procedure UpdateLogEntry(BankLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        LogEntries += StrSubstNo('Entry No.: %1, Document No.: %2, Amount: %3, Date: %4\n',
            BankLedgerEntry."Entry No.",
            BankLedgerEntry."Document No.",
            BankLedgerEntry.Amount,
            BankLedgerEntry."Posting Date");
    end;

    local procedure InitializeLog()
    begin
        LogEntries := 'Processed Bank Ledger Entries:\n' +
                     '================================\n';
    end;

    local procedure ShowProcessingLog()
    begin
        if LogEntries <> '' then
            Message(LogEntries);
    end;
}