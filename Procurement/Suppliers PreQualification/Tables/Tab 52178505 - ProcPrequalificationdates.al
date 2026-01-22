table 52178505 "Proc-Prequalification dates"
{
    DrillDownPageID = "Proc-Prequalification dates";
    LookupPageID = "Proc-Prequalification dates";

    fields
    {
        field(1; "Preq. Year"; Code[20])
        {
        }
        field(2; "Reference Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Preq. Year", "Reference Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

