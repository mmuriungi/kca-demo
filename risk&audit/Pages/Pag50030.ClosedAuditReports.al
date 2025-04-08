page 50030 "Closed Audit Reports"
{
    CardPageID = "Audit Report Card";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE (Type = FILTER ("Audit Report"), Archived=FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(Date;Date)
                {
                }
                field("Created By";"Created By")
                {
                }
                field(Status;Status)
                {
                }
                field(Description;Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

