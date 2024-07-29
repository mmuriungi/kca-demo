page 54990 "HMS ward Setup"
{
    PageType = Card;
    SourceTable = "HMS-Ward Setup";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Ward Code"; Rec."Ward Code")
                {
                    ApplicationArea = All;
                }
                field("Ward Name"; Rec."Ward Name")
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

