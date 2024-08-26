table 50576 "ACA-Exam Category"
{
    DrillDownPageID = "ACA-Exam Category";
    LookupPageID = "ACA-Exam Category";

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

