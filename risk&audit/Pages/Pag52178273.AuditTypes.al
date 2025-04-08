page 50111 "Audit Types"
{
    PageType = List;
    SourceTable = "Audit Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Name; Name)
                {
                }
            }
        }
    }

    actions
    {
    }
}

