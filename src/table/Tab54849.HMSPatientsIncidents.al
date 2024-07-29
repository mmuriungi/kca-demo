table 54849 "HMS-Patients Incidents"
{

    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Incident; Text[200])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

