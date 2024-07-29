pageextension 50005 "Item Card Extension" extends "Item Card"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            ShowMandatory = false;
        }
        addafter("Item Category Code")
        {
            field("Item G/L Budget Account"; Rec."Item G/L Budget Account")
            {
                ApplicationArea = All;
            }
            field("Is Controlled"; Rec."Is Controlled")
            {
                ApplicationArea = All;
            }
            field("Location Filter"; Rec."Location Filter")
            {
                ApplicationArea = All;
            }
            field("Prevent Negative Inventory"; Rec."Prevent Negative Inventory")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addafter(AdjustInventory)
        {
            action("Import Unit of Measure")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Unit of Measure';
                Image = Journal;
                RunObject = xmlport "Item Unit of measure";
                ToolTip = 'Item Unit of Measure';
            }
        }
    }
}