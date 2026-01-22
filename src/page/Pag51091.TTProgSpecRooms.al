/// <summary>
/// Page TT-Prog. Spec. Rooms (ID 74509).
/// </summary>
page 51091 "TT-Prog. Spec. Rooms"
{
    Caption = 'Programme Specific Rooms';
    PageType = List;
    SourceTable = "TT-Prog. Spec. Rooms";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Room Code"; Rec."Room Code")
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

