table 54814 "HMS-Clinical Reference"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Symptoms; Text[250])
        {
        }
        field(4; Recomendations; Text[250])
        {
        }
        field(5; Remarks; Text[250])
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

