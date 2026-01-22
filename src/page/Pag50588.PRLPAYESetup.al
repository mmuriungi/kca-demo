page 50588 "PRL-P.A.Y.E Setup"
{
    Editable = true;
    PageType = Card;
    SourceTable = "PRL-PAYE";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = all;
                }
                field("PAYE Tier"; Rec."PAYE Tier")
                {
                    ApplicationArea = all;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

