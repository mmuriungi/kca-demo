table 54811 "HMS-Admission Injection"
{

    fields
    {
        field(1; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Injection Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Injection".Code;
        }
        field(3; "Injection Name"; Text[100])
        {
            CalcFormula = Lookup("HMS-Setup Injection".Description WHERE(Code = FIELD("Injection Code")));
            FieldClass = FlowField;
        }
        field(4; Date; Date)
        {
        }
        field(5; Time; Time)
        {
        }
        field(6; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Injection Code", Date, Time)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Date := TODAY;
        Time := Time;
    end;
}

