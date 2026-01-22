page 51143 "EXT-Lect. Spec. Days"
{
    Caption = 'Lecturer Specific Days';
    PageType = List;
    SourceTable = "EXT-Lect. Spec. Days";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Code"; Rec."Date Code")
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

