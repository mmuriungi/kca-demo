page 51649 NonRangedResultsCard
{
    Caption = 'NonRangedResultsCard';
    PageType = Card;
    SourceTable = NonRangedResults;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
