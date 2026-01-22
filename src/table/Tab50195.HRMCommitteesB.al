table 50195 "HRM-Committees (B)"
{
    LookupPageID = "PRL-Salary Arrears (B)";

    fields
    {
        field(1; "Code"; Code[70])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            NotBlank = true;
        }
        field(3; Roles; Text[200])
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

