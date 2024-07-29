table 54829 "HMS Lab Test Results Parameter"
{
    //DrillDownPageID = 39006158;
    //LookupPageID = 39006158;

    fields
    {
        field(1; "Test Code"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Results Parameters"; Text[100])
        {
        }
        field(4; "Normal Ranges"; Text[50])
        {
        }
        field(5; Results; Text[100])
        {
        }
        field(6; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(7; "Laboratory Test Code"; Code[20])
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Line No", "Test Code", "Laboratory No.", "Laboratory Test Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

