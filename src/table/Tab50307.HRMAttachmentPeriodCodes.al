table 50307 "HRM-Attachment PeriodCodes"
{
    DrillDownPageID = "HRM-Attachment PeriodCodes";
    LookupPageID = "HRM-Attachment PeriodCodes";

    fields
    {
        field(1; "Period Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Period Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Training Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Period Code", "Training Year")
        {
        }
    }

    fieldgroups
    {
    }
}

