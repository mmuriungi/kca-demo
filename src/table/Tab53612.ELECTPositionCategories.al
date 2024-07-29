table 53612 "ELECT-Position Categories"
{
    DrillDownPageID = "ELECT-Position Categories LKP";
    LookupPageID = "ELECT-Position Categories LKP";

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Category Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

