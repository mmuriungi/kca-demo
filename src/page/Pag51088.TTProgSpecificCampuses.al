page 51088 "TT-Prog. Specific Campuses"
{
    Caption = 'Programme Specific Campuses';
    PageType = List;
    SourceTable = "TT-Prog. Spec. Campuses";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Campus Code"; Rec."Campus Code")
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

