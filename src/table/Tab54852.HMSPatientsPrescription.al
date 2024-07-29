table 54852 "HMS-Patients Prescription"
{

    fields
    {
        field(1; Date; Date)
        {
            NotBlank = true;
        }
        field(2; Time; Time)
        {
        }
        field(3; "Patient Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(4; "Doctor Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(5; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Medicine Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(7; "Dosage Code"; Text[200])
        {
            TableRelation = "HMS-Doses".Description;
        }
        field(8; Duratior; Decimal)
        {
        }
        field(9; Quantity; Decimal)
        {
        }
        field(10; Remarks; Text[250])
        {
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Date, "Patient Code", "Medicine Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

