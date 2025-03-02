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
            field("Drug Category"; Rec."Drug Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Drug Category field.';
            }
            field("Reorder Threshold";Rec."Reorder Threshold")
            {
                ApplicationArea=all;
            }

        }
        addafter(Item)
        {
            group(Sports)
            {
                Caption = 'Sports Equipment';
                Visible = Rec."Item Category" = Rec."Item Category"::"Sporting Equipment";

                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                }
                field("Game Code"; Rec."Game Code")
                {
                    ApplicationArea = All;
                }
                field("Game Name"; Rec."Game Name")
                {
                    ApplicationArea = All;
                }
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