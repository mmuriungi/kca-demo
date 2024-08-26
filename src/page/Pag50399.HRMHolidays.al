page 50399 "HRM-Holidays"
{
    PageType = ListPart;
    SourceTable = "HRM-Holidays";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Date; Rec.Date)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

