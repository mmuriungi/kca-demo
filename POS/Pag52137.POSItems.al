page 52137 "POS Items"
{
    Caption = 'POS Items';
    PageType = List;
    SourceTable = "POS Items";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item description.';
                }
                field("Unit Of measure"; Rec."Unit Of measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure for the item.';
                }
                field("Student Price"; Rec."Student Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price for students.';
                }
                field("Staff Price"; Rec."Staff Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price for staff members.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current inventory level.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Unit of Measure';
                Image = VoucherGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "POS Item Units of Measure"; // Page 99403
                RunPageLink = "Item Code" = field("No.");
                ToolTip = 'View or edit the units of measure for this item.';
            }
        }
    }
}