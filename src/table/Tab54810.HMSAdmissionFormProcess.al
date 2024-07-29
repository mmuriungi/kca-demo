table 54810 "HMS-Admission Form Process"
{

    fields
    {
        field(1; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Process Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "PROC-Store Requistion Header"."No.";
        }
        field(3; Process; Date)
        {
            CalcFormula = Lookup("PROC-Store Requistion Header"."Request date" WHERE("No." = FIELD("Process Code")));
            FieldClass = FlowField;
        }
        field(4; Mandatory; Boolean)
        {
        }
        field(5; Performed; Boolean)
        {
        }
        field(6; Date; Date)
        {
        }
        field(7; Time; Time)
        {
        }
        field(8; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Process Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

