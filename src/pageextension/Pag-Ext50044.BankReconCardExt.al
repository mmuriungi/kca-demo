pageextension 50044 "Bank Recon Card Ext" extends "Bank Acc. Reconciliation"
{
    layout
    {
        modify(ApplyBankLedgerEntries)
        {
            Visible = false;
        }
    }
}
