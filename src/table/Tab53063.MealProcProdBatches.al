table 53063 "Meal Proc. Prod. Batches"
{

    fields
    {
        field(1; "Batch Date"; Date)
        {
        }
        field(99008505; "Product Class"; Option)
        {
            OptionCaption = ' ,Fresh,Yoghurt,Lala,UHT';
            OptionMembers = " ",Fresh,Yoghurt,Lala,UHT;
        }
        field(99008506; "Manufacture Date"; Date)
        {
        }
        field(99008507; "Expiry Date"; Date)
        {
        }
        field(99008508; "Batch No"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Batch Date", "Batch No", "Product Class")
        {
        }
    }

    fieldgroups
    {
    }
}

