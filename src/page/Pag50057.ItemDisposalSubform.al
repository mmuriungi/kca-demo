page 50057 "Item Disposal Subform"
{
    PageType = ListPart;
    SourceTable = "Item Disposal Line";
    AutoSplitKey = true;
    
    LAYOUT
    {
        AREA(Content)
        {
            REPEATER(GroupName)
            {
                FIELD("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number to be disposed.';
                }
                FIELD(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item.';
                }
                FIELD(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity to be disposed.';
                }
                FIELD("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure code.';
                }
                FIELD("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit cost of the item.';
                }
                FIELD("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total cost amount of the disposed items.';
                }
                FIELD("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location code for the item.';
                }
                FIELD("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bin code for the item.';
                }
                FIELD("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant code for the item.';
                    Visible = false;
                }
                FIELD("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number of the item.';
                }
                FIELD("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lot number of the item.';
                }
                FIELD("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for disposing this specific item.';
                }
            }
        }
    }
    
    ACTIONS
    {
        AREA(Processing)
        {
            ACTION(FindItemEntries)
            {
                ApplicationArea = All;
                Caption = 'Find Item Entries';
                Image = ItemLedger;
                ToolTip = 'Look for available inventory for the selected item.';
                
                TRIGGER OnAction()
                VAR
                    ItemDisposalMgt: Codeunit "Item Disposal Management";
                    Header: Record "Item Disposal Header";
                BEGIN
                    IF Rec."Item No." <> '' THEN
                        IF Header.GET(Rec."Document No.") THEN
                            ItemDisposalMgt.FindItemEntries(Rec);
                END;
            }
        }
    }
}