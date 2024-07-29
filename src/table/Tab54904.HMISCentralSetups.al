table 54904 "HMIS-Central Setups"
{
    //DrillDownPageID = 68184;
    //LookupPageID = 68184;

    fields
    {
        field(2; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

