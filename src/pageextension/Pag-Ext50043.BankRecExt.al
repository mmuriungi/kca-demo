pageextension 50043 "Bank Rec Ext" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
      
            modify("Document No.")
            {
                ApplicationArea = all;
                Visible=true;

            }
            modify("Check No.")
            {
                ApplicationArea = all;
                
                Visible=true;
            }
            addafter("Check No.")
            {
                // field(Type;Rec.Type)
                // {

                // }
            }
        addafter(Difference)
        {
            field("Reconciled"; Rec."Reconciled")
            {
                ApplicationArea = All;
            }
        }
    }
}
