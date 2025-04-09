page 50238 "Risk Exposure"
{
    Caption = 'Risk Exposure';
    PageType = ListPart;
    SourceTable = "Risk Exposure";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Risk Exposure"; Rec."Risk Exposure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Risk Exposure field.';
                }
                field("Risk Exposure Description"; Rec."Risk Exposure Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Risk Exposure Description field.';
                }

            }
        }
    }
}
