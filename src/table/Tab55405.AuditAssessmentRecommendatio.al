table 55405 "Audit Assessment Recommendatio"
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
        field(3; "Risk recommendations"; Text[100])
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

