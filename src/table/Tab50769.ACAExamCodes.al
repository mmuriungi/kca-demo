table 50769 "ACA-Exam Codes"
{
    // LookupPageID = 68788;

    fields
    {
        field(1; "Exam Code"; Code[50])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Exam Code")
        {
        }
    }

    fieldgroups
    {
    }
}

