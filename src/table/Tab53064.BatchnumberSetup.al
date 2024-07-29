table 53064 "Batch number Setup"
{

    fields
    {
        field(1; "Product Class"; Option)
        {
            OptionCaption = ' ,Drinks,Breakfast,Snacks,Main Meal';
            OptionMembers = " ",Drinks,Breakfast,Snacks,"Main Meal";
        }
        field(2; "Batch No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; "Expiration computation"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Product Class")
        {
        }
    }

    fieldgroups
    {
    }
}

