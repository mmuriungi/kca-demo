page 51049 "HRM-Commitee Membership"
{
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Commitee Members (KNCHR)";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Committee; Rec.Committee)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

