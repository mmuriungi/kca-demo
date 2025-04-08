page 50115 "Audit Subform"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit Code"; "Audit Code")
                {
                }
                field("Audit Description"; "Audit Description")
                {
                }
                field("Audit Type"; "Audit Type")
                {
                }
                field("Audit Type Description"; "Audit Type Description")
                {
                }
                field("Assessment Rating"; "Assessment Rating")
                {
                }
                field("Scheduled End Date"; "Scheduled End Date")
                {
                }
                field("Scheduled Start Date"; "Scheduled Start Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

