table 54840 "HMS-Patient Admissions"
{

    fields
    {
        field(1; "Admission Date"; Date)
        {
            NotBlank = true;
        }
        field(2; "Admission Time"; Time)
        {
        }
        field(3; "Patient No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(4; "Doctor Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(5; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Requested Room"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(7; "Allocated Bed"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(8; "Expected Stay"; Decimal)
        {
        }
        field(9; "Rooms Transfar"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(10; "Discharge Date"; Date)
        {
        }
        field(11; "Discharge Time"; Time)
        {
        }
        field(12; Remarks; Text[250])
        {
        }
        field(13; Posted; Boolean)
        {
            Editable = false;
        }
        field(14; "Admission Charges"; Code[20])
        {
            TableRelation = Resource."No.";
        }
    }

    keys
    {
        key(Key1; "Admission Date", "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

