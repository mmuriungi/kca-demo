page 54533 "Student requests"
{
    Caption = 'Student requests';
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
        area(sections)
        {
            group("Student Reequests")
            {
                action("Open Request")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Open);

                }
                action("Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Approved);
                }
                action("Rejected Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Cancelled);
                }
                action("All Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Deffered Students";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled);
                }
            }
            group("Student Clearance")
            {
                action("Open Requests")
                {
                    Caption = 'Open Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Open);

                }
                action("Pending Approvals")
                {
                    Caption = 'Pending Approval';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved Requestss")
                {
                    Caption = 'Approved Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Approved);
                }
                action("Rejected Requestss")
                {
                    Caption = 'Rejected Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Cancelled);
                }
                action("All Requestss")
                {
                    Caption = 'All Clearance Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Student clearance List";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled);
                }
            }
        }
    }
}
