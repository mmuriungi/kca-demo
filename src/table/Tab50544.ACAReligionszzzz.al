table 50544 "ACA-Religionszzzz"
{
    //   DrillDownPageID = 68738;
    //  LookupPageID = 68738;

    fields
    {
        field(1; Religion; Code[50])
        {
            NotBlank = true;
        }
        field(2; Remarks; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Religion)
        {
        }
    }

    fieldgroups
    {
    }
}
