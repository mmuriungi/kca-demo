table 54891 "HMS-Treatment Form Process"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Process No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Process".Code;
        }
        field(3; "Process Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Setup Process".Description WHERE(Code = FIELD("Process No.")));
            FieldClass = FlowField;
        }
        field(4; Mandatory; Boolean)
        {
            FieldClass = Normal;
        }
        field(5; "Process Remarks"; Text[100])
        {
        }
        field(6; Performed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Process No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

