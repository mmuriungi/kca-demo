table 50875 "CAT-Meals Hours"
{
    DrillDownPageID = "ACA-Religions 2";
    LookupPageID = "ACA-Religions 2";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Discription; Text[100])
        {
        }
        field(3; From; Time)
        {
        }
        field(4; "To"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

