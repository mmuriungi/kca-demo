table 50900 "Venue Booking Permissions"
{

    fields
    {
        field(1; "User Id"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Can Edit/Create Venues"; Boolean)
        {
        }
        field(3; "Can Approve Booking"; Boolean)
        {
        }
        field(4; "Can Edit Pending Bookings"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User Id")
        {
        }
    }

    fieldgroups
    {
    }
}

