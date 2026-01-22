table 51216 "Audit Assessment Findings"
{

    fields
    {
        field(1; "Risk Assessment Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Findings; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Risks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Recommendations; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Actions Taken"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Risk Assessment Code", No)
        {
            Clustered = true;
        }
        key(Key2; No)
        {
        }
    }

    fieldgroups
    {
    }
}

