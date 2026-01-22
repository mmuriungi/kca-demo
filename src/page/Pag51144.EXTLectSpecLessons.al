page 51144 "EXT-Lect. Spec. Lessons"
{
    Caption = 'Lecturer Specific Lessons';
    PageType = List;
    SourceTable = "EXT-Lect. Spec. Lessons";

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

