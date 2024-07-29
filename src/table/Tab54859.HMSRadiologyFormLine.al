table 54859 "HMS-Radiology Form Line"
{

    fields
    {
        field(1; "Radiology no."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Radiology Type Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Radiology Type".Code;
        }
        field(3; "Radiology Type Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Setup Radiology Type".Description WHERE(Code = FIELD("Radiology Type Code")));
            FieldClass = FlowField;
        }
        field(4; "Assigned User ID"; Code[20])
        {
            // TableRelation = Table2000000002.Field1;
        }
        field(5; Completed; Boolean)
        {
        }
        field(6; "Performed Date"; Date)
        {
        }
        field(7; "Performed Time"; Time)
        {
        }
        field(8; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Radiology no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

