table 54246 "FLT-Fuel/Maint Expense Data"
{

    fields
    {
        field(1; VehicleNo; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(2; Month1Date; Date)
        {
        }
        field(3; Month1Litres; Decimal)
        {
        }
        field(4; Month1Amount; Decimal)
        {
        }
        field(5; Month2Date; Date)
        {
        }
        field(6; Month2Litres; Decimal)
        {
        }
        field(7; Month2Amount; Decimal)
        {
        }
        field(8; Month3Date; Date)
        {
        }
        field(9; Month3Litres; Decimal)
        {
        }
        field(10; Month3Amount; Decimal)
        {
        }
        field(11; EntryNo; Integer)
        {
        }
        field(12; Month1Price; Decimal)
        {
        }
        field(13; Month2Price; Decimal)
        {
        }
        field(14; Month3Price; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; EntryNo, VehicleNo)
        {
        }
        key(Key2; VehicleNo)
        {
            SumIndexFields = Month1Litres, Month1Amount, Month2Litres, Month2Amount, Month3Litres, Month3Amount;
        }
    }

    fieldgroups
    {
    }
}

