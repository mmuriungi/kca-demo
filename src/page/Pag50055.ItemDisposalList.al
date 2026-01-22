page 50055 "Item Disposal List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Disposal Header";
    CardPageId = "Item Disposal Card";
    Editable = false;

    LAYOUT
    {
        AREA(Content)
        {
            REPEATER(GroupName)
            {
                FIELD("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the disposal document number.';
                }
                FIELD("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the disposal document was created.';
                }
                FIELD("Disposal Date"; Rec."Disposal Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the items were disposed.';
                }
                FIELD("Disposal Method"; Rec."Disposal Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the method used for disposal.';
                }
                FIELD("Disposal Reason Code"; Rec."Disposal Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason code for the disposal.';
                }
                FIELD("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location from which items are being disposed.';
                }
                FIELD(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the disposal document.';
                }
            }
        }
        AREA(FactBoxes)
        {
            SYSTEMPART(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            SYSTEMPART(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    ACTIONS
    {
        AREA(Navigation)
        {
            ACTION("Item Disposal Card")
            {
                ApplicationArea = All;
                Caption = 'Card';
                Image = EditLines;
                RunObject = Page "Item Disposal Card";
                RunPageLink = "No." = FIELD("No.");
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the item disposal.';
            }
        }
    }
}