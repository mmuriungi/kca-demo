page 50106 "Risk Score Colours"
{
    ApplicationArea = All;
    Caption = 'Risk Score Colours';
    PageType = List;
    SourceTable = "Risk Scores Colours";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field.';
                }
                field(Colour; Rec.Colour)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Colour field.';
                }
            }
        }
    }
}
