#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77389 "Admissions Billable Items"
{
    //DrillDownPageID = UnknownPage77368;
    //LookupPageID = UnknownPage77368;

    fields
    {
        field(1; Index; Code[20])
        {
        }
        field(2; Admin; Code[20])
        {
        }
        field(3; "Charge Code"; Code[20])
        {
        }
        field(4; "Charge Description"; Text[150])
        {
        }
        field(5; "Charge Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Index, Admin, "Charge Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

