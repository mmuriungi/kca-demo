page 50970 "HRM-Disciplinary Cases (B)"
{
    PageType = ListPart;
    SourceTable = "HRM-Disciplinary Cases";

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
                field(Rating; Rec.Rating)
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

