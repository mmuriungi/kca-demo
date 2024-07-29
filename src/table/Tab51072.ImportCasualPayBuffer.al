table 51072 "Import Casual Pay Buffer"
{

    fields
    {
        field(1; "F. Name"; Text[30])
        {
        }
        field(2; "M. Name"; Text[30])
        {
        }
        field(3; "L. Name"; Text[30])
        {
        }
        field(4; "No."; Code[20])
        {
        }
        field(5; "Bank Code"; Code[30])
        {
        }
        field(6; "A/C No."; Code[10])
        {
        }
        field(7; Days; Decimal)
        {
        }
        field(8; "Daily Rate"; Decimal)
        {
        }
        field(9; "Period Month"; Integer)
        {
        }
        field(10; "Period Year"; Integer)
        {
        }
        field(11; Instalment; Integer)
        {
        }
        field(12; "Department Code"; Code[20])
        {
        }
        field(13; "Branch Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

