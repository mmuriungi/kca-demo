tableextension 53003 itemsext extends Item
{
    fields
    {
        field(88888; "Control Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));

        }  //"Product Class"
        field(88889; "Production  Area"; Option)
        {
            OptionCaption = ' ,Kitchen,Location a,Location b';
            OptionMembers = " ",Kitchen,"Location a","Location b";
            DataClassification = ToBeClassified;
        }
        field(88890; "Product Class"; Option)
        {
            OptionCaption = ' ,Drinks,Breakfast,Snacks,Main Meal';
            OptionMembers = " ",Drinks,Breakfast,Snacks,"Main Meal";
            DataClassification = ToBeClassified;
        }
        field(88891; "Control Category"; Option)
        {
            OptionCaption = '" ","500 CUP","500 BOTTLE","250 CUP","150 CUP","CRATES","CANS"';
            OptionMembers = " ","500 CUP","500 BOTTLE","250 CUP","150 CUP","CRATES","CANS";
        }
        field(88892; "Expiry Window"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88893; "Credit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88894; "POS Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88895; "POS Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88896; "BarCode No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(88897; "Product Group Code"; code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }		
    }

}