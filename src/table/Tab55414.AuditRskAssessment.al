table 55414 "Audit Rsk Assessment"
{

    fields
    {
        field(1; "Risk Assessment No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Risk Findings"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Risk Assessment No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

