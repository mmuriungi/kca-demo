page 52138 "POS Item Units of Measure"
{
    Caption = 'POS Item Units of Measure';
    PageType = List;
    SourceTable ="Pos Unit of Measure";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item code this unit of measure belongs to.';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the unit of measure.';
                }
                field("Student Price"; Rec."Student Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price for students for this unit of measure.';
                }
                field("Staff Price"; Rec."Staff Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price for staff members for this unit of measure.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // Add any relevant actions here if needed
        }
    }
}