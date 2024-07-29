/// <summary>
/// Page TT-Prog. Specific Days (ID 74508).
/// </summary>
page 52447 "TT-Prog. Specific Days"
{
    Caption = 'Programme Specific Days';
    PageType = List;
    SourceTable = "TT-Prog. Spec. Days";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Day Code"; Rec."Day Code")
                {
                    ApplicationArea = All;
                }
                field("Constraint Category"; Rec."Constraint Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

