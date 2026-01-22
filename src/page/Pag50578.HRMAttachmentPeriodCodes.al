page 50578 "HRM-Attachment PeriodCodes"
{
    PageType = List;
    SourceTable = "HRM-Attachment PeriodCodes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; rec."Period Code")
                {
                }
                field("Period Description"; rec."Period Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

