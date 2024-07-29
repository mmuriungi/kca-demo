table 54897 "HMS-Ward Setup"
{
    LookupPageID = "HMS ward Setup";

    fields
    {
        field(1; "Ward Code"; Code[20])
        {
        }
        field(2; "Ward Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Ward Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

