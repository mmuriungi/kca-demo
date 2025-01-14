#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 78077 "Semester Household Buffer"
{

    fields
    {
        field(1; "Student No."; Code[25])
        {
        }
        field(2; "Student Name"; Text[150])
        {
        }
        field(3; "Academic Year"; Code[25])
        {
        }
        field(4; Semester; Code[25])
        {
        }
        field(5; Stage; Code[20])
        {
        }
        field(6; "Current Balance"; Decimal)
        {
        }
        field(7; "Semester Fees"; Decimal)
        {
        }
        field(8; "Household Fees"; Decimal)
        {
        }
        field(9; Qualified; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

