page 50305 "Student Affairs Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Headlines; "Headline RC Student Affairs")
            {
                ApplicationArea = All;
            }
            // part(ClubActivities; "Club Activities Cue")
            // {
            //     ApplicationArea = All;
            // }
            // part(ElectionActivities; "Election Activities Cue")
            // {
            //     ApplicationArea = All;
            // }
            // part(StudentLeaves; "Student Leaves Cue")
            // {
            //     ApplicationArea = All;
            // }
            part(AffairsDashboard; "Student Affairs Dashboard")
            {
                Caption = 'Student Affairs Dashboard';
                ApplicationArea = All;
            }
            part(AffairsAnalytics; "Student Affairs Analytics")
            {
                Caption = 'Student Affairs Analytics';
                ApplicationArea = All;
            }
            part(EngagementAnalytics; "Student Engagement Analytics")
            {
                Caption = 'Student Engagement Analytics';
                ApplicationArea = All;
            }
            part(AffairsDataViz; "Student Affairs Data Viz")
            {
                Caption = 'Student Affairs Data Visualization';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(Students)
            {
                ApplicationArea = All;
                RunObject = Page "ACA-All Students List";
            }
            action(Clubs)
            {
                ApplicationArea = All;
                RunObject = Page "Club List";
            }
            action(Elections)
            {
                ApplicationArea = All;
                RunObject = Page "ELECT-Elections Header List";
            }
            action(LeaveRequests)
            {
                ApplicationArea = All;
                RunObject = Page "Student Leave List";
            }
        }
        area(Sections)
        {
            group("Student Management")
            {
                action("Students List")
                {
                    ApplicationArea = All;
                    RunObject = Page "ACA-All Students List";
                }

            }
            group("Club Management")
            {
                action("Clubs List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Club List";
                }
                action("Club Membership List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Club Member";
                }
            }
            group("Election Management")
            {
                action("Elections List")
                {
                    ApplicationArea = All;
                    RunObject = Page "ELECT-Elections Header List";
                }
            }
            group(LeaveManagement)
            {
                action("Leave Requests List")
                {
                    ApplicationArea = All;
                    Caption = 'Open Leave Requests';
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Open));
                }
                action("Pending Leave Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Leave Requests';
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST("Pending"));
                }
                action("Approved Leave Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Requests';
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Approved));
                }
                action("Rejected Leave Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Leave Requests';
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Rejected));
                }
            }
            group("Student Requests")
            {
                action("Deferral Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Deferment), Status = CONST(Open));
                }
                action("Pending Deferral Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Deferment), Status = CONST("Pending"));
                }
                action("Approved Deferral Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Deferment), Status = CONST(Approved));
                }
                action("Rejected Deferral Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Deferment), Status = CONST(Rejected));
                }
                action("Withdrawal Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Withdrawal), Status = CONST(Open));
                }
                action("Pending Withdrawal Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Withdrawal), Status = CONST("Pending"));
                }
                action("Approved Withdrawal Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Withdrawal), Status = CONST(Approved));
                }
                action("Rejected Withdrawal Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Deferment/Withdrawal";
                    RunPageView = where("Request Type" = CONST(Withdrawal), Status = CONST(Rejected));
                }
                action("Leave Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Open));
                }
                action("Pending Leave Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Pending));
                }
                action("Approved Leave Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Approved));
                }
                action("Rejected Leave Request List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Leave List";
                    RunPageView = where("Approval Status" = CONST(Rejected));
                }
            }
            group("Counseling Management")
            {
                action("Counseling Sessions List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Counseling Session List";
                }
                action("Counselors List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Counselor List";
                }
            }
            group(Setups)
            {
                action("General Setup")
                {
                    ApplicationArea = All;
                    RunObject = Page "Student Welfare Setup";
                }
            }
        }

        area(Reporting)
        {
            action(ClubMembershipReport)
            {
                ApplicationArea = All;
                RunObject = Report "Club Membership Report";
            }
            action("Club Performance Report")
            {
                ApplicationArea = All;
                RunObject = Report "Club Performance Analysis";
            }
            // action(ElectionResultsReport)
            // {
            //     ApplicationArea = All;
            //     RunObject = Report "Election Results Report";
            // }
            action(CounselingReport)
            {
                ApplicationArea = All;
                RunObject = Report "Counselling Session Analysis";
            }
        }
    }
}
