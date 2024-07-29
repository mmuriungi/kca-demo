page 52512 "EXT-Prog. Spec. Days"
{
    Caption = 'Programme Specific Days';
    PageType = List;
    SourceTable = "EXT-Prog. Spec. Days";

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

