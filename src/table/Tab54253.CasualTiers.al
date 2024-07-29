table 54253 "Casual Tiers."
{

    fields
    {
        field(1; "Occupation Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Casual AFA';
        }
        field(2; "Occupation Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Casual AFA';
        }
        field(3; "Rate Per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Casual AFA';
        }
        field(4; "Rate per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Casual AFA';
        }
    }

    keys
    {
        key(Key1; "Occupation Code")
        {
        }
    }

    fieldgroups
    {
    }
}

