table 50099 Stages
{

    fields
    {
        field(1; Stage; Code[20])
        {
        }
        field(2; Duration; Integer)
        {
        }
        field(3; Description; Text[60])
        {
        }
        field(15; "Contract Line Type"; Code[10])
        {
            NotBlank = true;
            //TableRelation = "Contract Lines Types"."Contract Line Type";
        }
    }

    keys
    {
        key(Key1; Stage)
        {
        }
    }

    fieldgroups
    {
    }
}

