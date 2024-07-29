table 54818 "HMS-Doctors Advice"
{
    // LookupPageID = "HRM-Job Responsibilities";

    fields
    {
        field(1; Advice; Text[250])
        {
        }
        field(2; "Short Name"; Text[200])
        {
        }
        field(3; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Advice)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

