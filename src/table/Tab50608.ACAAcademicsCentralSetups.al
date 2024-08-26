table 50608 "ACA-Academics Central Setups"
{
    DrillDownPageID = "ACA-Central Setup List";
    LookupPageID = "ACA-Central Setup List";

    fields
    {
        field(1; "Title Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Category; Option)
        {
            //OptionCaption = ' ,Titles,Religions,Denominations,Relationships,Counties,Countries,Nationality,Districts,Positions';
            OptionMembers = " ",Titles,Religions,Denominations,Relationships,Counties,Countries,Nationality,Districts,Positions,Ethnicity;
        }
        field(4; "Country Code"; code[20])
        {
            
        }
    }

    keys
    {
        key(Key1; Category, "Title Code")
        {
        }
    }

    fieldgroups
    {
    }
}

