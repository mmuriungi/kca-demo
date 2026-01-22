table 50353 "HRM-Training Years"
{

    fields
    {
        field(1; "Training Year Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Training Year Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Training Year Code")
        {
        }
    }

    fieldgroups
    {
    }
}

