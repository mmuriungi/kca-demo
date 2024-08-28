page 50843 "ACA-Religions 2"
{
    PageType = List;
    SourceTable = "ACA-Academics Central Setups";

    layout
    {
        area(content)
        {
            repeater(General)
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

