pageextension 50038 "Inventory Setup Extension" extends "Inventory Setup"
{
    LAYOUT
    {
        ADDAFTER("Item Nos.")
        {
            FIELD("Item Disposal Nos."; Rec."Item Disposal Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series code for item disposal documents.';
            }
        }
    }
}
