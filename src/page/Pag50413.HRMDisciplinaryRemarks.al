page 50413 "HRM-Disciplinary Remarks"
{
    PageType = ListPart;
    SourceTable = "HRM-Disciplinary Remarks";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Remark; Rec.Remark)
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

