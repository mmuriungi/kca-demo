table 54847 "HMS-Patients Diagnosis"
{

    fields
    {
        field(1; "Patient Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(2; "Doctor Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(3; Date; Date)
        {
            NotBlank = true;
        }
        field(4; Time; Time)
        {
        }
        field(5; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Diagnosis  Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS-Diagnosis".Code;
        }
        field(7; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Date, "Patient Code", "Diagnosis  Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

