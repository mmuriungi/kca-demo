page 54400 "CORPRATE AFFAIRS"
{
    Caption = 'CORPRATE AFFAIRS';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")

            {
                ApplicationArea = all;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group("Meeting Booking Procedure")
            {
                action("Open")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Open);
                }
                action("Pending")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Approved);
                }
                action("Closed")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Closed);
                }
                action("Rejected")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Rejected);
                }
                action("Cancelled")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Cancelled);
                }
                action("Completed")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = const(Completed);
                }
                action("&All Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Meeting List";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled | Completed | Closed | Rejected | Scheduled);
                }
            }
            group("Graphic Desing Request")
            {
                action("Open Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Open);
                }
                action("Pending Request")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Approved);
                }
                action("Closed Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Closed);
                }
                action("Rejected Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Rejected);
                }
                action("Cancelled Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Cancelled);
                }
                action("Completed Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = const(Completed);
                }
                action("&All Desing Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Design Request";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled | Completed | Closed | Rejected | Scheduled);
                }
            }
        }
        area(Processing)
        {
            group(Setups)
            {
                action(General)
                {
                    ApplicationArea = Basic, Suite;
                    Image = GainLossEntries;
                    RunObject = page "ACA-General Set-Up";
                }
                action("Room Setups")
                {
                    ApplicationArea = Basic, Suite;
                    Image = AccountingPeriods;
                    RunObject = page "Room Setup";
                }
            }
        }
    }
}
