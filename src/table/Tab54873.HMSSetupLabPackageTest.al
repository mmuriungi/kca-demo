table 54873 "HMS-Setup Lab Package Test"
{

    fields
    {
        field(1; "Lab Package"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Lab Package".Code;
        }
        field(2; "Package Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Setup Lab Package".Description WHERE(Code = FIELD("Lab Package")));
            FieldClass = FlowField;
        }
        field(3; Test; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Setup Lab Test".Code;
        }
        field(4; "Test Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Setup Lab Test".Description WHERE(Code = FIELD(Test)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Lab Package", Test)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

