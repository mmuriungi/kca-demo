page 50747 "ACA-Central Setup List"
{
    PageType = List;
    SourceTable = "ACA-Academics Central Setups";

    layout
    {
        area(content)
        {
            repeater(Group)
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

