/// <summary>
/// Page TT-Unit Spec. Rooms (ID 74514).
/// </summary>
page 51128 "TT-Unit Spec. Rooms"
{
    Caption = 'Unit Specific Rooms';
    PageType = List;
    SourceTable = "TT-Unit Spec. Rooms";

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

