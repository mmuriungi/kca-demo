page 50420 "HRM-Training Sources"
{
    PageType = ListPart;
    SourceTable = "HRM-Training Source";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Source; Rec.Source)
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

