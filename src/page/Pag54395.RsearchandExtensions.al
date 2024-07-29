page 54395 "Rsearch and Extensions"
{
    Caption = 'Role Center';
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
            group("Projects")
            {
                action("Open Projects")
                {
                    ApplicationArea = All;
                    RunObject = Page "Research Req List";
                }
                action("Project Pending Approval")
                {
                    ApplicationArea = All;
                    RunObject = Page "Research Req(Pending)";
                }
                action("Approved Project")
                {
                    ApplicationArea = All;
                    RunObject = Page "Research Req(Approved)";
                }
            }
            group("Grants Management")
            {
                action("UnPosted Grants")
                {
                    ApplicationArea = All;
                    RunObject = Page "Grants List";
                    RunPageLink = Status = filter(New);
                }
                action("Posted Grants")
                {
                    ApplicationArea = All;
                    RunObject = Page "Grants List";
                    RunPageLink = Status = filter(Posted);
                }
            }
            group("VC'S Grants")
            {
                action("Open Grants")
                {
                    ApplicationArea = All;
                    RunObject = Page "Vc Grants List";
                    RunPageLink = Status = filter(Open);
                }
                action("Internal Review")
                {
                    ApplicationArea = All;
                    RunObject = Page "Vc Grants List";
                    RunPageLink = Status = filter(Pending);
                }
                action("External Review")
                {
                    ApplicationArea = All;
                    RunObject = Page "Vc Grants List";
                    RunPageLink = Status = filter(Pending);
                }
                action("Rejected Grants")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vc Grants List";
                    RunPageLink = Status = const(Rejected);
                }
                action("Cancelled")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vc Grants List";
                    RunPageLink = Status = const(Cancelled);
                }
                action("&All Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vc Grants List";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled | Completed | Closed | Rejected | Scheduled);
                }
            }
            group("Facilities and Resources")
            {
                action("Lab Equipment")
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE-Resources";
                    RunPageLink = "Resource Type" = filter("Lab Equipment");
                }
                action("Research Facilities")
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE-Resources";
                    RunPageLink = "Resource Type" = filter("Research Facilities");
                }
                action("Personel")
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE-Resources";
                    RunPageLink = "Resource Type" = filter(Personel);
                }
            }
            group("Collaboration")
            {
                action("Active MOU/MOA")
                {
                    ApplicationArea = All;
                    RunObject = Page "MOU/MOA";
                    RunPageLink = Status = filter(Active);
                }
                action("Inactive MOU/MOA")
                {
                    ApplicationArea = All;
                    RunObject = Page "MOU/MOA";
                    RunPageLink = Status = filter(Inactive);

                }
                action("Expired MOU/MOA")
                {
                    ApplicationArea = All;
                    RunObject = Page "MOU/MOA";
                    RunPageLink = Status = filter(Expired);

                }
                action("Terminated MOU/MOA")
                {
                    ApplicationArea = All;
                    RunObject = Page "MOU/MOA";
                    RunPageLink = Status = filter(Terminated);

                }
            }
            group("Extension services")
            {
                action("Open")
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE Extension List";
                    RunPageLink = Status = filter(Open);
                }
                action("Pending Approval")
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE Extension List";
                    RunPageLink = Status = filter(Pending);

                }
                action(Approved)
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE Extension List";
                    RunPageLink = Status = filter(Approved);

                }
                action("Rejected Requests")
                {
                    ApplicationArea = All;
                    RunObject = Page "DRE Extension List";
                    RunPageLink = Status = filter(Cancelled);

                }
            }
        }
        area(Reporting)
        {
            group("Reports")
            {
                action(Repairs)
                {
                    Caption = 'Research Publication';
                    ApplicationArea = Basic, Suite;
                    Image = Report;
                    RunObject = report "Research Publications";
                }
                action("Grant")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Grants Lists';
                    Image = Report2;
                    RunObject = report "Grants List";
                }
                action("Dre Resources")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Report2;
                    RunObject = report "DRE-Resources Report";
                }
            }
        }
    }



}


