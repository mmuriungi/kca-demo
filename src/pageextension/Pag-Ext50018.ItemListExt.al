pageextension 50018 "Item ListExt" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field(InventoryPostingGroup; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = true;
            }

        }
    }
}
