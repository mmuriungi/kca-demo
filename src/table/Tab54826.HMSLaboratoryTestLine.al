table 54826 "HMS-Laboratory Test Line"
{

    fields
    {
        field(1; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(4; "Laboratory Test Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Lab Test".Code;
        }
        field(5; "Laboratory Test Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Setup Lab Test".Description WHERE(Code = FIELD("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(6; "Specimen Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Specimen".Code;
        }
        field(7; "Specimen Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Setup Specimen".Description WHERE(Code = FIELD("Specimen Code")));
            FieldClass = FlowField;
        }
        field(8; "Assigned User ID"; Code[20])
        {
            // TableRelation = Table2000000002.Field1;
        }
        field(9; "Collection Date"; Date)
        {
        }
        field(10; "Collection Time"; Time)
        {
        }
        field(11; "Measuring Unit Code"; Code[20])
        {
            TableRelation = "HMS-Setup Measuring Unit".Code;
        }
        field(12; "Measuring Unit Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Setup Measuring Unit".Description WHERE(Code = FIELD("Measuring Unit Code")));
            FieldClass = FlowField;
        }
        field(13; "Count Value"; Decimal)
        {
        }
        field(14; Remarks; Text[100])
        {
        }
        field(15; Completed; Boolean)
        {
        }
        field(16; Positive; Boolean)
        {
        }
        field(17; "Test Count"; Integer)
        {
            CalcFormula = Count("HMS-Laboratory Test Line" WHERE("Laboratory Test Code" = FIELD("Laboratory Test Code"),
                                                                  "Test Date" = FIELD("Test Date")));
            FieldClass = FlowField;
        }
        field(18; "Test Date"; Date)
        {
            CalcFormula = Lookup("HMS-Laboratory Form Header"."Laboratory Date" WHERE("Laboratory No." = FIELD("Laboratory No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Laboratory No.", "Laboratory Test Code", "Specimen Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

