table 50161 "PROC-Procurement Plan Period1"
{
    DrillDownPageID = "PROC-Procure. Plan Period";
    LookupPageID = "PROC-Procure. Plan Period";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Period Name"; Text[30])
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

