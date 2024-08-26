table 50610 "ACA-Buildings"
{
    DrillDownPageID = "ACA-Buildings";
    LookupPageID = "ACA-Buildings";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

