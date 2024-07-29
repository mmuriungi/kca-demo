table 50082 "PROC-Procurement Plan Header"
{
    DrillDownPageID = "PROC-Procurement Plan list";
    LookupPageID = "PROC-Procurement Plan list";

    fields
    {
        field(1; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(2; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = filter(2));
        }
        field(3; "Schools"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = filter(3));
        }
        field(4; "Projects"; Code[20])
        {
            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = filter(3));
        }
        field(5; "Procurement Plan Period"; Code[20])
        {
            TableRelation = "PROC-Procurement Plan Period".Code;
        }
        field(6; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
    }

    keys
    {
        key(Key1; "Budget Name", "Department Code", "Campus Code", "Procurement Plan Period")
        {
            Clustered = true;
        }
        key(Key2; "Budget Name", "Department Code", Schools, "Procurement Plan Period")
        {
            // Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Dim: Record 349;
        DptName: Text[50];
}

