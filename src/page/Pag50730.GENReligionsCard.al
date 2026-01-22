page 50730 "GEN-Religions Card"
{
    PageType = Card;
    SourceTable = "ACA-Academics Central Setups";
    SourceTableView = WHERE(Category = FILTER(Religions));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Title Code"; Rec."Title Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

