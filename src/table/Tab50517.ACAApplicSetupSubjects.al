table 50517 "ACA-Applic. Setup Subjects"
{
    DrillDownPageID = "ACA-Appic. Setup Subj. List";
    LookupPageID = "ACA-Appic. Setup Subj. List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the subject in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the name of the subject';
        }
        field(3; "Sort No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Sort No")
        {
        }
    }

    fieldgroups
    {
    }
}

