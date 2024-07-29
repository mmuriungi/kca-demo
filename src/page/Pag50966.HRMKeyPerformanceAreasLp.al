page 50966 "HRM-Key Performance Areas Lp"
{
    PageType = ListPart;
    SourceTable = "HRM-Key Performance Areas";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Self; Rec.Self)
                {
                }
                field(Reviewer; Rec.Reviewer)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }
}

