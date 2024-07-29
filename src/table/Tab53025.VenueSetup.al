table 53025 "Venue Setup"
{
    DrillDownPageID = "Venue Setup List";
    LookupPageID = "Venue Setup List";

    fields
    {
        field(1; "Venue Code"; Code[20])
        {
            TableRelation = "Fixed Asset"."No." WHERE("FA Subclass Code" = FILTER('BUILDING' | 'BUILDINGS' | 'BLOCKS' | 'BUILD'));
        }
        field(2; "Venue Description"; Code[250])
        {
            CalcFormula = Lookup("Fixed Asset".Description WHERE("No." = FIELD("Venue Code")));
            FieldClass = FlowField;
        }
        field(3; Capacity; Integer)
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Occupied,Out of Order,Reserved';
            OptionMembers = Vaccant,Occupied,"Out of Order",Reserved;
        }
        field(5; "Book Id"; Code[20])
        {
        }
        field(6; "Booked From Date"; Date)
        {
        }
        field(7; "Booked To Date"; Date)
        {
        }
        field(8; "Booked From Time"; Time)
        {
        }
        field(9; "Booked To Time"; Time)
        {
        }
        field(10; "Booked Department"; Code[20])
        {
        }
        field(11; "Booked Department Name"; Text[150])
        {
        }
        field(12; "Booked By Name"; Code[100])
        {
        }
        field(13; "Booked By Phone"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Venue Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // VenueBookingPermissions.RESET;
        // VenueBookingPermissions.SETRANGE("User Id",USERID);
        // IF VenueBookingPermissions.FIND('-') THEN BEGIN
        //   VenueBookingPermissions.TESTFIELD("Can Edit/Create Venues");
        //   END ELSE ERROR('Access Denied!');
    end;

    trigger OnInsert()
    begin
        // VenueBookingPermissions.RESET;
        // VenueBookingPermissions.SETRANGE("User Id",USERID);
        // IF VenueBookingPermissions.FIND('-') THEN BEGIN
        //   VenueBookingPermissions.TESTFIELD("Can Edit/Create Venues");
        //   END ELSE ERROR('Access Denied!');
    end;

    trigger OnModify()
    begin
        // VenueBookingPermissions.RESET;
        // VenueBookingPermissions.SETRANGE("User Id",USERID);
        // IF VenueBookingPermissions.FIND('-') THEN BEGIN
        //   VenueBookingPermissions.TESTFIELD("Can Edit/Create Venues");
        //   END ELSE ERROR('Access Denied!');
    end;

    trigger OnRename()
    begin
        // VenueBookingPermissions.RESET;
        // VenueBookingPermissions.SETRANGE("User Id",USERID);
        // IF VenueBookingPermissions.FIND('-') THEN BEGIN
        //   VenueBookingPermissions.TESTFIELD("Can Edit/Create Venues");
        //   END ELSE ERROR('Access Denied!');
    end;

    var
    //   UserSetup: Record "91";
    //VenueBookingPermissions: Record "77710";
}

