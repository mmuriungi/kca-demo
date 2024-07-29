table 54905 "HMIS-Central Setup Values"
{
    //DrillDownPageID = 68187;
    //LookupPageID = 68187;

    fields
    {
        field(1; "Setup Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
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
        key(Key1; "Setup Group", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

