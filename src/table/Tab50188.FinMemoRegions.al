table 50188 "Fin Memo Regions"
{
    fields
    {
        field(1; "No."; Code[10])
        {

        }
        field(2; "Regions"; code[30])
        {

        }
        field(3; "Classification"; Code[30])
        {

        }
        field(4; "Grade"; Code[20])
        {

        }
        field(5; "Amount"; Decimal)
        {

        }

    }

    keys
    {
        key(Key1; "No.", Regions, Classification, Grade, Amount)
        {

        }
    }
}