table 50963 "FLT-Daily Work Ticked Drivers"
{
    DrillDownPageID = "FLT-Daily Work Ticket Drivers";
    LookupPageID = "FLT-Daily Work Ticket Drivers";

    fields
    {
        field(1; "line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Driver No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(3; "Driver Name"; Text[50])
        {
            CalcFormula = Lookup("HRM-Employee C"."First Name" WHERE("No." = FIELD("Driver No.")));
            FieldClass = FlowField;
        }
        field(4; "Total Milleage"; Decimal)
        {
        }
        field(5; "Total Fuel Consumed"; Decimal)
        {
        }
        field(6; "Ticket No."; Code[20])
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "line No.", "Ticket No.", "Driver No.")
        {
        }
    }

    fieldgroups
    {
    }
}

