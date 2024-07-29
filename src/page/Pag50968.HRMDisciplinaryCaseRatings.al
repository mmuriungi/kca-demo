page 50968 "HRM-Disciplinary Case Ratings"
{
    PageType = ListPart;
    SourceTable = "HRM-Disciplinary Case Ratings";

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

