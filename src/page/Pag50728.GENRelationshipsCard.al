page 50728 "GEN-Relationships Card"
{
    PageType = Card;
    SourceTable = "ACA-Academics Central Setups";
    SourceTableView = WHERE(Category = FILTER(Relationships));

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

