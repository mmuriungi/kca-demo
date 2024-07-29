table 54220 "FLT-Transport Places"
{
    DrillDownPageID = "FLT-Transport Places";
    LookupPageID = "FLT-Transport Places";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Request No."; Code[20])
        {
        }
        field(3; Place; Text[50])
        {
        }
        field(4; "From Date"; Date)
        {
        }
        field(5; "To Date"; Date)
        {
        }
        field(6; Remarks; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Request No.", Place)
        {
        }
    }

    fieldgroups
    {
    }
}

