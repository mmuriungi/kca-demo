codeunit 50067 "Bank Reconciliation Management"

{
   procedure CloseBankLedgerEntriesNotInStatement(BankAccountNo: Code[20]; var ProcessedCount: Integer): Boolean
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        BankStatementLine: Record "Bank Statement Lines 2";
    begin
        ProcessedCount := 0;
        
        BankLedgerEntry.SetRange("Bank Account No.", BankAccountNo);
        BankLedgerEntry.SetRange(Open, true);
        BankLedgerEntry.SetRange("Statement Status", BankLedgerEntry."Statement Status"::Open);
        
        if BankLedgerEntry.FindSet() then
            repeat
                // Check if entry exists in statement lines
                BankStatementLine.SetRange("Bank Account No.", BankLedgerEntry."Bank Account No.");
                BankStatementLine.SetRange("Document No.", BankLedgerEntry."Document No.");
                BankStatementLine.SetRange("Transaction Date", BankLedgerEntry."Posting Date");
                BankStatementLine.SetRange("Statement Amount", BankLedgerEntry.Amount);
                
                if BankStatementLine.IsEmpty() then begin
                    BankLedgerEntry.Open := false;
                    BankLedgerEntry."Statement Status" := BankLedgerEntry."Statement Status"::Closed;
                    BankLedgerEntry.Modify();
                    ProcessedCount += 1;
                end;
            until BankLedgerEntry.Next() = 0;
            
        exit(ProcessedCount > 0);
    end;
    
    procedure GetUnreconciledEntriesCount(BankAccountNo: Code[20]): Integer
    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankLedgerEntry.SetRange("Bank Account No.", BankAccountNo);
        BankLedgerEntry.SetRange(Open, true);
        BankLedgerEntry.SetRange("Statement Status", BankLedgerEntry."Statement Status"::Open);
        exit(BankLedgerEntry.Count());
    end;
}