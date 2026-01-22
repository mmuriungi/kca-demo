pageextension 50017 "Inventory Setups" extends "Inventory Setup"
{

    layout
    {
        addafter("Invt. Receipt Nos.")
        {
            field("Item Issue Batch"; Rec."Item Issue Batch")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Item Issue Template"; Rec."Item Issue Template")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Item Transfer Nos."; Rec."Item Transfer Nos.")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}

