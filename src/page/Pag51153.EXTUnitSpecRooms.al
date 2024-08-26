/// <summary>
/// Page EXT-Unit Spec. Rooms (ID 74567).
/// </summary>
page 51153 "EXT-Unit Spec. Rooms"
{
    Caption = 'Unit Specific Rooms';
    PageType = List;
    SourceTable = "EXT-Unit Spec. Rooms";

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

