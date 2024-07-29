page 50973 "HRM-Job Responsiblities"
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
                    Caption = 'Responsibilities';
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

