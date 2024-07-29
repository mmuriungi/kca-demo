/// <summary>
/// Page Core Values (ID 50034).
/// </summary>
page 51333 "Core Value"
{
    Caption = 'Core Values';
    PageType = List;
    SourceTable = "Core Values";

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
            }
        }
    }
}
