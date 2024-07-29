table 54867 "HMS-Setup Diagnosis"
{
    LookupPageID = "HMS-Setup Diagnosis List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            NotBlank = true;
        }
        field(3; "Male Counter"; Integer)
        {
            CalcFormula = Count("HMS-Treatment Form Diagnosis" WHERE("Diagnosis No." = FIELD(Code),
                                                                      Gender = FILTER(Male),
                                                                      "Treatment Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(4; "Female Counter"; Integer)
        {
            CalcFormula = Count("HMS-Treatment Form Diagnosis" WHERE("Diagnosis No." = FIELD(Code),
                                                                      Gender = FILTER(Female),
                                                                      "Treatment Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(5; "Total Treatments"; Integer)
        {
            CalcFormula = Count("HMS-Treatment Form Diagnosis" WHERE("Diagnosis No." = FIELD(Code),
                                                                      "Treatment Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(6; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(7; Edit; Boolean)
        {
        }
        field(8; "New Appointments"; Integer)
        {
            CalcFormula = Count("HMS-Treatment Form Diagnosis" WHERE("Diagnosis No." = FIELD(Code),
                                                                      "Treatment Date" = FIELD("Date Filter"),
                                                                      "Patient Appointments" = CONST(1)));
            FieldClass = FlowField;
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

