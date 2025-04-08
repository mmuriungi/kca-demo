table 50156 "Risk Ratio"
{

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(2; Description; Text[20])
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(3; "Risk Category"; Code[20])
        {
            TableRelation = "Risk Categories";
            DataClassification = ToBeClassified;
        }
        field(4; "Min.Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Max.Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Risk Category")
        {

        }

    }

    fieldgroups
    {
    }
}

