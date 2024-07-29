page 50925 "HRM-Score Setup"
{
    PageType = Worksheet;
    SourceTable = "HRM-Score Setup";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Score ID"; Rec."Score ID")
                {
                }
                field(Score; Rec.Score)
                {
                }
            }
        }
    }

    actions
    {
    }
}

