table 51021 "HRM-Emp. Trans. Adjst Buffer"
{

    fields
    {
        field(1; "Transaction Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";
        }
        field(2; "Employee No"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(3; Period; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "No."; integer)
        {
            AutoIncrement = true;
        }

    }

    keys
    {
        key(Key1; "Transaction Code", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

