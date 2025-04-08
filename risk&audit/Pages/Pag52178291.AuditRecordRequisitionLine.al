page 52178291 "Audit Record Requisition Line"
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
                field("Assessment Rating"; "Assessment Rating")
                {
                }
                field("Audit Type"; "Audit Type")
                {
                }
                field("Audit Type Description"; "Audit Type Description")
                {
                }
                field("Scheduled Start Date"; "Scheduled Start Date")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Scheduled End Date"; "Scheduled End Date")
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

