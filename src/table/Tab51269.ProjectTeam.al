table 51269 "Project Team"
{

    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Header";
        }
        field(2; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Company; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Project No", "ID No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

