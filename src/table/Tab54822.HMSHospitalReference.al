table 54822 "HMS-Hospital Reference"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Disease,Poison,Clinical';
            OptionMembers = Disease,Poison,Clinical;
        }
        field(4; Symptoms; Text[250])
        {
        }
        field(5; Recomendations; Text[250])
        {
        }
        field(6; Remarks; Text[250])
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

