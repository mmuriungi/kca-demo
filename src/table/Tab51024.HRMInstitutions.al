table 51024 "HRM-Institutions"
{
    DrillDownPageID = "HRM-Institutions List";
    LookupPageID = "HRM-Institutions List";

    fields
    {
        field(1; "Institution Code"; Code[30])
        {
        }
        field(2; "Institution Name"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Institution Code")
        {
        }
    }

    fieldgroups
    {
    }
}

