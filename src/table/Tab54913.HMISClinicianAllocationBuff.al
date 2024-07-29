table 54913 "HMIS-Clinician Allocation Buff"
{

    fields
    {
        field(1; "Record Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Counted Patients"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Record Count")
        {
        }
        key(Key2; "Counted Patients")
        {
        }
    }

    fieldgroups
    {
    }
}

