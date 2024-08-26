page 50422 "HRM-Contract Types"
{
    PageType = Card;
    SourceTable = "HRM-Contract Types";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Contract; Rec.Contract)
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

