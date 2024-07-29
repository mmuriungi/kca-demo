table 54853 "HMS-Patients Status"
{

    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; Date; Code[20])
        {
        }
        field(3; Status; Text[200])
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

