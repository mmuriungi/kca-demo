pageextension 50035 "Item Category Card Ext" extends "Item Category Card"
{
    layout
    {
        addafter("Parent Category")
        {
            field("Item Category Type"; Rec."Item Category Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
