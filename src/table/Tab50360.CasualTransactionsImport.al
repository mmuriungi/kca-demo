table 50360 "Casual Transactions Import"
{

    fields
    {
        field(1; "Emp. No."; Code[20])
        {
        }
        field(2; "Trans. Code"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Period Month"; Integer)
        {
        }
        field(5; "Period Year"; Integer)
        {
        }
        field(6; Instalment; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Emp. No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

