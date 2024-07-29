page 54890 "HMS Patient History"
{
    PageType = ListPart;
    SourceTable = "HMS-Patient History";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("History Code"; Rec."History Code")
                {
                    ApplicationArea = All;
                }
                field("History Name"; Rec."History Name")
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

