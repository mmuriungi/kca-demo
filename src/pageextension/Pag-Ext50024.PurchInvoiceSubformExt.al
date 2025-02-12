pageextension 50024 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {


            modify("Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = true;
            }
            modify("Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = true;
            }
            modify("VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = true;
            }
            modify("VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = true;
            }
    }
}