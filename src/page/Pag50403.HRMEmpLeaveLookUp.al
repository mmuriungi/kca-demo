page 50403 "HRM-Emp. Leave Look Up"
{
    Editable = false;
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
                field("Acrued Days"; Rec."Acrued Days")
                {
                }
            }
        }
    }

    actions
    {
    }
}

