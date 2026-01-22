page 50471 "HRM-Commitee Members"
{
    PageType = List;
    SourceTable = "HRM-Commitee Members (KNCHR)";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Member type"; Rec."Member type")
                {
                }
                field("Member No."; Rec."Member No.")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field(Role; Rec.Role)
                {
                }
                field("Date Appointed"; Rec."Date Appointed")
                {
                }
                field(Active; Rec.Active)
                {
                }
            }
        }
    }

    actions
    {
    }
}

