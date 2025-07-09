pageextension 50044 "Bank Recon Card Ext" extends "Bank Acc. Reconciliation"
{
    layout
    {
        addafter(StatementNo)
        {
            
        }
        modify(ApplyBankLedgerEntries)
        {
            Visible = false;
        }
    }
}
