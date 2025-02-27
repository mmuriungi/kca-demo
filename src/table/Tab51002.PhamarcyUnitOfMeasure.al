table 51002 "Phamarcy Unit Of Measure"
{
    fields
    {
        field(1; "Item Code"; code[30])
        {
            TableRelation = Item;
        }
        field(2; "Unit Code"; Enum "Pharmacy Unit of Measure")
        {

        }
        field(3; "Cost"; Decimal)
        {

        }

    }

    keys
    {
        key(pk; "Item Code", "Unit Code")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "Item Code", "Unit Code", Cost)
        {

        }
    }


}