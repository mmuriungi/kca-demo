page 51208 "PRL-Payroll Periods List"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PRL-Payroll Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Opened"; Rec."Date Opened")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Period Year"; Rec."Period Year")
                {
                }
                field("Period Name"; Rec."Period Name")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field("Date Closed"; Rec."Date Closed")
                {
                }
                field(Closed; Rec.Closed)
                {
                }
            }
        }
    }

    actions
    {
    }
}

