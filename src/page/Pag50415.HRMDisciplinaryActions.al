page 50415 "HRM-Disciplinary Actions"
{
    PageType = ListPart;
    SourceTable = "HRM-Disciplinary Actions";

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
                field(Terminate; Rec.Terminate)
                {
                }
                field(Document; Rec.Document)
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

