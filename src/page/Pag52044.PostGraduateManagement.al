page 52044 "Post Graduate Management"
{
    ApplicationArea = All;
    Caption = 'Post Graduate Management';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(HeadlineOrdersActivities; "Headline RC Postgrad Director")
            {
                ApplicationArea = All;
            }
            // part(O365ActivityFeed; "O365 Activity Feed")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part(PostgradActivities; "Postgrad Activites Cue")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(PostgradManagement)
            {
                Caption = 'Postgraduate Management';
                Image = Graduate;

                action(PostgradStudents)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Postgraduate Students';
                    RunObject = Page "ACA-All Students List";
                    ///RunPageView = where("Student Type" = const(Postgraduate));
                    ToolTip = 'View and manage postgraduate students';
                }
                action(Supervisors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Supervisors';
                    RunObject = Page "ACA-Lecturer List";
                    ToolTip = 'View and manage supervisors';
                }
                action(SupervisorApplications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Supervisor Applications';
                    RunObject = Page "Supervisor Applications";
                    ToolTip = 'Review and process supervisor applications';
                    //Visible = false;
                }
                action(StudentSubmissions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Student Submissions';
                    RunObject = Page "Postgrad Submission List";
                    ToolTip = 'View and manage student submissions';
                }
                action(CommunicationLogs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Communication Logs';
                    RunObject = Page "Student Communication Log";
                    ToolTip = 'View communication logs between students and supervisors';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                Image = Report;

                action(GraduatedStudents)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Graduated Students';
                    Image = Report;
                    RunObject = Report "Graduated Students";
                    ToolTip = 'View a report of graduated students';
                }
                action(StudentsWithSupervisors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Students with Supervisors';
                    Image = Report;
                    RunObject = Report "Students with Supervisors";
                    ToolTip = 'View a report of students assigned to supervisors';
                }
                action(StudentsQualifiedToGraduate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Students Qualified to Graduate';
                    Image = Report;
                    RunObject = Report "Students Qualified to Graduate";
                    ToolTip = 'View a report of students who are qualified to graduate';
                }
                action(StudentsByStudyStage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Students by Study Stage';
                    Image = Report;
                    RunObject = Report "Students by Study Stage";
                    ToolTip = 'View a report of students categorized by their study stage';
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                action(PostgradSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Postgraduate Setup';
                    RunObject = Page "PostGraduate Setup";
                    ToolTip = 'Setup postgraduate management settings';
                }
            }
        }
        area(Embedding)
        {
            action(PostgradStudentsEmbed)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Postgraduate Students';
                RunObject = Page "ACA-All Students List";
                ToolTip = 'View and manage postgraduate students';
            }
            action(SupervisorApplicationsEmbed)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Supervisor Applications';
                RunObject = Page "Supervisor Applications";
                RunPageView = where(Status = const(Pending));
                ToolTip = 'View and process pending supervisor applications';
            }
            action(RecentSubmissionsEmbed)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Recent Submissions';
                RunObject = Page "Postgrad Submission List";
                RunPageView = sorting("Submission Date") order(descending);
                ToolTip = 'View recent student submissions';
            }
        }
        area(Processing)
        {
            action(AssignSupervisor)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Assign Supervisor';
                Image = Approve;
                RunObject = Page "Postgrad Submission List";
                RunPageView = where(Status = const(Pending));
                ToolTip = 'Assign supervisors to students';
            }
        }
    }
}
