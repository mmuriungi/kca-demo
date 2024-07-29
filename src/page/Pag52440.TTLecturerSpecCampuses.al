page 52440 "TT-Lecturer Spec. Campuses"
{
    Caption = 'Lecturer Specific Campuses';
    PageType = List;
    SourceTable = "TT-Lect. Spec. Campuses";

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

