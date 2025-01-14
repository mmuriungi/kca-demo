#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 78073 "Funding Band Categories"
{

    fields
    {
        field(1; "Band Code"; Code[20])
        {
        }
        field(2; "Band Description"; Text[150])
        {
        }
        field(3; "Scholarship Percentage"; Decimal)
        {
        }
        field(4; "Loan Percentage"; Decimal)
        {
        }
        field(5; "Household Percentage"; Decimal)
        {
        }
        field(6; "Academic Year"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Band Code", "Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

