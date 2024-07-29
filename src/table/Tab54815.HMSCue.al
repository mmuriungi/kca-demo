table 54815 "HMS-Cue"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; Students; Integer)
        {
            CalcFormula = Count("HMS-Patient" WHERE("Patient Type" = FILTER(Student)));
            FieldClass = FlowField;
        }
        field(3; Employees; Integer)
        {
            CalcFormula = Count("HMS-Patient" WHERE("Patient Type" = FILTER(Employee)));
            FieldClass = FlowField;
        }
        field(4; Dependants; Integer)
        {
            CalcFormula = Count("HMS-Patient" WHERE("Patient Type" = FILTER(Dependant)));
            FieldClass = FlowField;
        }
        field(5; "Other Patients"; Integer)
        {
            CalcFormula = Count("HMS-Patient" WHERE("Patient Type" = FILTER(Others)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

