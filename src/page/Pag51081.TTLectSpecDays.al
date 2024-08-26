page 51081 "TT-Lect. Spec. Days"
{
    Caption = 'Lecturer Specific Days';
    PageType = List;
    SourceTable = "TT-Lect. Spec. Days";

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

