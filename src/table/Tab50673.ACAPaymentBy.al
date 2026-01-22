table 50673 "ACA-Payment By"
{
    DrillDownPageID = "ACA-Payment By";
    LookupPageID = "ACA-Payment By";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
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

