page 51149 "EXT-Prog. Spec. Campuses"
{
    Caption = 'Programme Specific Campuses';
    PageType = List;
    SourceTable = "EXT-Prog. Spec. Campuses";

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

