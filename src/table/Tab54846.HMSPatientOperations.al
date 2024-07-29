table 54846 "HMS-Patient Operations"
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
        field(4; "Operation Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(5; "Bed Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(6; Posted; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Date, "Patient Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

