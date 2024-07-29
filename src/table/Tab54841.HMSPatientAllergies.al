table 54841 "HMS-Patient Allergies"
{

    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; Allergy; Text[200])
        {
        }
        field(3; Remarks; Text[250])
        {
        }
        field(4; Posted; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Allergy, "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

