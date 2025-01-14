/// <summary>
/// Page Response Scales (ID 50035).
/// </summary>
page 50719 "Response Scales"
{
    Caption = 'Response Scales';
    PageType = List;
    SourceTable = "Response Scales";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rating field.';
                }
            }
        }
    }
}
