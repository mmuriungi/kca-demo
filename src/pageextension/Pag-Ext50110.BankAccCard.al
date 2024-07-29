pageextension 50110 "Bank Acc.Card" extends "Bank Account Card"
{
    layout
    {
        addafter("Creditor No.")
        {
            field("Receipt No. Series"; Rec."Receipt No. Series")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }
        }

    }
}
