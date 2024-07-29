table 54843 "HMS-Patient History"
{
    //LookupPageID = 68655;

    fields
    {
        field(1; "History Code"; Code[20])
        {
        }
        field(2; "History Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "History Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

