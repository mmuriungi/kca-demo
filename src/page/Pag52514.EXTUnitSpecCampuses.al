/// <summary>
/// Page EXT-Unit Spec. Campuses (ID 74566).
/// </summary>
page 52514 "EXT-Unit Spec. Campuses"
{
    Caption = 'Unit Specific Campuses';
    PageType = List;
    SourceTable = "EXT-Unit Spec. Campuses";

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

