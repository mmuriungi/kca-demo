page 51082 "TT-Lect. Spec. Lessons"
{
    Caption = 'Lecturer Specific Lessons';
    PageType = List;
    SourceTable = "TT-Lect. Spec. Lessons";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lesson Code"; Rec."Lesson Code")
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

