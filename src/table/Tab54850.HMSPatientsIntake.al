table 54850 "HMS-Patients Intake"
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
        field(3; "Patient No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(4; "Doctor Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(5; "Nurse Code"; Code[20])
        {
            TableRelation = Resource."No.";
        }
        field(6; Temprature; Decimal)
        {
        }
        field(8; Pressure; Decimal)
        {
        }
        field(9; Respiration; Decimal)
        {
        }
        field(10; "Blood Pressure"; Decimal)
        {
        }
        field(11; AG; Decimal)
        {
        }
        field(12; "Iv Fluid"; Decimal)
        {
        }
        field(13; "Mouth R/T"; Decimal)
        {
        }
        field(14; Urine; Decimal)
        {
        }
        field(15; RTA; Decimal)
        {
        }
        field(16; "SP 02"; Text[100])
        {
        }
        field(17; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Date, "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

