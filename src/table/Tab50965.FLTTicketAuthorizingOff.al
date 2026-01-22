table 50965 "FLT-Ticket Authorizing Off."
{
    DrillDownPageID = "FLT-Ticket Authorizing Off.";
    LookupPageID = "FLT-Ticket Authorizing Off.";

    fields
    {
        field(1; "Officer Line no."; Integer)
        {
        }
        field(2; "Ticket No."; Code[10])
        {
        }
        field(3; "Officer No."; Code[10])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(4; "Officer Name"; Text[30])
        {
            CalcFormula = Lookup("HRM-Employee C"."First Name" WHERE("No." = FIELD("Officer No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Officer Line no.", "Ticket No.", "Officer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

