table 51899 "ACA-Library Codes"
{
    DrillDownPageID = "ACA-Library Codes";
    LookupPageID = "ACA-Library Codes";

    fields
    {
        field(1; "Lib Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Duration; Decimal)
        {
        }
        field(4; "Expiry Duration"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Lib Code")
        {
        }
    }

    fieldgroups
    {
    }
}

