page 50964 "HRM-Appraisal Periods"
{
    PageType = Worksheet;
    SourceTable = "HRM-Appraisal Periods";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Period; Rec.Period)
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

