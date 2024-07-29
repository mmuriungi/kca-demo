page 54516 NonRangedResults
{
    Caption = 'NonRangedResults';
    PageType = List;
    CardPageId = NonRangedResultsCard;
    SourceTable = NonRangedResults;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("result Code"; Rec."result Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the result Code field.', Comment = '%';
                }
                field("result Name"; Rec."result Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the result Name field.', Comment = '%';
                }
            }
        }
    }
}
