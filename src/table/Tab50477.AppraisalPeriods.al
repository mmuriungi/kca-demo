table 50477 "Appraisal Periods"
{
    DrillDownPageID = "Appraisal Periods";
    LookupPageID = "Appraisal Periods";

    fields
    {
        field(1; Period; Code[30])
        {

        }
        field(2; Description; Text[250])
        {
        }
        field(3; Closed; Boolean)
        { }
    }

    keys
    {
        key(Key1;
        Period)
        {
        }
    }


    fieldgroups
    {
    }

}

