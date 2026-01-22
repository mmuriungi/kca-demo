page 50605 "PRL-PeriodTransaction List"
{
    DeleteAllowed = true;
    InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = List;
    SourceTable = "PRL-Period Transactions";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field(Membership; Rec.Membership)
                {
                }
                field("Reference No"; Rec."Reference No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

