pageextension 50039 "Item ledger Ext" extends "Item Ledger Entries"
{
layout
{
    addafter("Item No.")
    {
        field("Unit of Measure Code";Rec."Unit of Measure Code")
        {
            ApplicationArea = All;
        }
    }
}

}
