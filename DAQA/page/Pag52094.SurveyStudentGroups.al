page 52094 "Survey Student Groups"
{
    ApplicationArea = All;
    Caption = 'Survey Student Groups';
    PageType = List;
    SourceTable = "Survey Student Groups";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Survey Code"; Rec."Survey Code")
                {
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ToolTip = 'Specifies the value of the Year of Study field.', Comment = '%';
                }
            }
        }
    }
}
