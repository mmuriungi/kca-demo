table 54816 "HMS-Details Types"
{

    fields
    {
        field(1; Status; Text[200])
        {
        }
        field(2; Remarks; Text[250])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Patient,Incidents';
            OptionMembers = Patient,Incidents;
        }
    }

    keys
    {
        key(Key1; Status)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

