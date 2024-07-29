report 53020 "Update Hostels"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Hostels.rdl';

    dataset
    {
        dataitem(DataItem1; "ACA-Hostel Ledger")
        {

            trigger OnAfterGetRecord()
            begin
                Room.RESET;
                Room.SETRANGE(Room."Hostel Code", "Hostel No");
                Room.SETRANGE(Room."Room Code", "Room No");
                IF NOT (Room.FIND('-')) THEN BEGIN
                    // Insert
                    Room.INIT;
                    Room."Hostel Code" := "Hostel No";
                    Room."Room Code" := "Room No";
                    Room.Status := Room.Status::Vaccant;
                    Room.INSERT(TRUE);
                END;
                RoomSpaces.RESET;
                RoomSpaces.SETRANGE(RoomSpaces."Hostel Code", "Hostel No");
                RoomSpaces.SETRANGE(RoomSpaces."Room Code", "Room No");
                RoomSpaces.SETRANGE(RoomSpaces."Space Code", "Space No");
                IF NOT (RoomSpaces.FIND('-')) THEN BEGIN
                    //Insert
                    RoomSpaces.INIT;
                    RoomSpaces."Hostel Code" := "Hostel No";
                    RoomSpaces."Room Code" := "Room No";
                    RoomSpaces."Space Code" := "Space No";
                    RoomSpaces.Status := RoomSpaces.Status::Vaccant;
                    RoomSpaces.INSERT(TRUE);
                END;

                DELETE(TRUE);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Room: Record "ACA-Hostel Block Rooms";
        RoomSpaces: Record "ACA-Room Spaces";
}

