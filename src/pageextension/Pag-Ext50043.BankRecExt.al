pageextension 50043 "Bank Rec Ext" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addafter(Difference)
        {
            field("Reconciled"; Rec."Reconciled")
            {
                ApplicationArea = All;
            }
        }
    }
}
