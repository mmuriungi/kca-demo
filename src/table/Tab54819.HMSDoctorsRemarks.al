table 54819 "HMS-Doctors Remarks"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Remarks; Text[250])
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

