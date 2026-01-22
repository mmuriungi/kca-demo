table 50865 "ACA-Host Reservation Reasons"
{
    DrillDownPageID = "ACA-Hostels Reservation Reason";
    LookupPageID = "ACA-Hostels Reservation Reason";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

