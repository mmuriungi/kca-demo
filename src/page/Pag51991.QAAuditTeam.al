page 51991 "QA Audit Team"
{
    ApplicationArea = All;
    Caption = 'QA  Audit Team';
    PageType = List;
    SourceTable = "QA Audit Team";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No field.';
                    ApplicationArea = All;
                }
                field("Center Code"; Rec."Center Code")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                    ApplicationArea = All;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Audit No field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
