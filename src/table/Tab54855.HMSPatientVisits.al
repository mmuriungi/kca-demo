table 54855 "HMS-Patient Visits"
{

    fields
    {
        field(1; "Patient Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; "Visit Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Visit Time"; Time)
        {
        }
        field(4; "Visit Charges"; Code[20])
        {
            TableRelation = Resource."No." WHERE(Type = CONST(Person));
        }
        field(5; "Department Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Doctor Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(8; "Ref. Letter No"; Text[100])
        {
        }
        field(9; "Ref. Letter Date"; Text[100])
        {
        }
        field(10; Status; Text[50])
        {
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Visit Date", "Patient Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

