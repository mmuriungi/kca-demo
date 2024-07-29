page 54832 "HMS Beds"
{
    PageType = Card;
    SourceTable = "HMS-Beds";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Ward No"; Rec."Ward No")
                {
                    ApplicationArea = All;
                }
                field("Bed No"; Rec."Bed No")
                {
                    ApplicationArea = All;
                }
                field("Bed Name"; Rec."Bed Name")
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

