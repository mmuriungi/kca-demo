table 50285 "HRM-Appraisal Category"
{
    //DrillDownPageID = 75045;
    //LookupPageID = 75045;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Series; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Series, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

