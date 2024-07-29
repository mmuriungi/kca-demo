table 54296 RoomSetUp
{
    Caption = 'RoomSetUp';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Room Code"; Code[20])
        {
            Caption = 'Room Code';
        }
        field(2; "Room Type"; Option)
        {
            OptionMembers = " ",BoardRoom,Other;
        }
        field(3; "Room Description"; text[100])
        {

        }
    }
    keys
    {
        key(PK; "Room Code")
        {
            Clustered = true;
        }
    }
}
