/// <summary>
/// Page EXT-Lect. Spec. Campuses (ID 74563).
/// </summary>
page 51142 "EXT-Lect. Spec. Campuses"
{
    Caption = 'Lecturer Specific Campuses';
    PageType = List;
    SourceTable = "EXT-Lect. Spec. Campuses";

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

