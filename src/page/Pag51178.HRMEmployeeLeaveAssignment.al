page 51178 "HRM-Employee Leave Assignment"
{
    PageType = ListPart;
    SourceTable = "HRM-Emp. Leaves";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Leave Code"; Rec."Leave Code")
                {
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
            }
        }
    }

    actions
    {
    }
}

