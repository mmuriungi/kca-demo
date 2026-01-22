table 51223 "Audit Risk Impacts"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Risk Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Title; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Risk Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

