page 50422 "HRM-Contract Types"
{
    PageType = Card;
    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

