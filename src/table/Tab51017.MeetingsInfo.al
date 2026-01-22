table 51017 MeetingsInfo
{
    Caption = 'MeetingsInfo';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meeting Code"; Code[20])
        {

        }
        field(2; "Meeting Type"; Option)
        {
            OptionMembers = "Internal",Extenal;
        }
        field(4; "Meeting Title"; Text[1000])
        {

        }
        field(5; "Meeting Start Time"; Time)
        {

        }
        field(6; "Meeting End Time"; Time)
        {
            trigger OnValidate()
            var
                ErrMettingEndT: Label 'Meeting End time Cannot be before %1';
            begin
                TestField("Meeting Start Time");
                if "Meeting End Time" < "Meeting Start Time" then
                    Error(ErrMettingEndT, "Meeting Start Time");
            end;
        }
        field(7; "Venue Type"; Option)
        {
            OptionMembers = " ",BoardRoom,Other;
        }

        field(8; "Meeting Venue"; code[20])
        {
            TableRelation = if ("Venue Type" = const(BoardRoom)) RoomSetUp where("Room Type" = filter(BoardRoom))
            else if ("Venue Type" = const(Other)) RoomSetUp where("Room Type" = filter(Other));
        }
        field(9; "User Id"; code[20])
        {

        }
        field(10; "Request Date"; Date)
        {

        }
        field(11; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled;
        }
        field(12; "Invite Sent"; Boolean)
        {
        }
        //field(13; "Vc Booked "; code)


    }

    keys
    {
        key(PK; "Meeting Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        genSetUp: Record "ACA-General Set-Up";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "Meeting Code" = '' then begin
            genSetUp.Get();
            genSetUp.TestField("Allow Posting To");
            // NoSeriesMgnt.InitSeries(genSetUp."Meeting Nos", genSetUp."Meeting Nos", Today, "Meeting Code", genSetUp."Meeting Nos");
            "Request Date" := Today;
            "User ID" := UserId;
        end;
    end;
}


