page 51531 "Room Setup"
{
    Caption = 'Room Setup';
    PageType = List;
    SourceTable = RoomSetUp;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Room Code"; Rec."Room Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room Code field.';
                }
                field("Room Type";Rec."Room Type")
                {
                    ApplicationArea = All;
                }
                field("Room Description"; Rec."Room Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room Description field.';
                }
            }
        }
    }
}
