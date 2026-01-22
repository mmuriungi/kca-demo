page 51948 "Displinary Committess"
{
    PageType = List;
    SourceTable = "Displinary Committess";
    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Committe Code"; Rec."Committe Code")
                {
                    ToolTip = 'Specifies the value of the Committe Code field.';
                    ApplicationArea = All;
                }

                field("Commitee Name"; Rec."Commitee Name")
                {
                    ToolTip = 'Specifies the value of the Commitee Name field.';
                    ApplicationArea = All;
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}