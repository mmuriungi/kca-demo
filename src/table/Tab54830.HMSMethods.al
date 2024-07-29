table 54830 "HMS-Methods"
{
    //LookupPageID = 68732;

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; Remarks; Text[250])
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

