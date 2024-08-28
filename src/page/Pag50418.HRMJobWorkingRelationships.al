page 50418 "HRM-Job Working Relationships"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Working Relationships";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                }
                field(Relationship; Rec.Relationship)
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

