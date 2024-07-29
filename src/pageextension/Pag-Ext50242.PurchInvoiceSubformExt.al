pageextension 50242 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {

        addafter("VAT Prod. Posting Group")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}