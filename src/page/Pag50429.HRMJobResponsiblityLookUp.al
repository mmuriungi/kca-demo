page 50429 "HRM-Job Responsiblity Look Up"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Responsiblities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Responsibility; Rec.Responsibility)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

