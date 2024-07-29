table 54817 "HMS-Diagnosis"
{
    //LookupPageID = 68713;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; FDBC; Text[200])
        {
        }
        field(4; Category; Code[20])
        {
        }
        field(5; Charge; Decimal)
        {
        }
        field(6; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

