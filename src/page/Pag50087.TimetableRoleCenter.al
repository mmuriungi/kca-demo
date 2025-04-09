page 50087 "Timetable Role Center"
{
    ApplicationArea = All;
    Caption = 'Timetabling Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")
            {
                ApplicationArea = all;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            // group(general)
            // {
            //     part("Timetable Overview"; "ACA-Std Card List")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Timetable Overview';
            //     }
            // }
        }
    }

    actions
    {
        area(Sections)
        {
            group("Teaching Timetable")
            {
                Caption = 'Teaching Timetable';
                action("Timetable Header List")
                {
                    Image = Report;

                    RunObject = Page "Timetable Header List";
                    RunPageView = where("Type" = const(Class));
                    ApplicationArea = All;
                }
                action(timeslots)
                {
                    Caption = 'Time Slots';
                    Image = Setup;
                    RunObject = Page "Time Slots";
                    ApplicationArea = All;
                }
                action("Online Preferences")
                {
                    ApplicationArea = All;
                    Caption = 'Online Preferences';
                    RunObject = Page "Online Preferences";
                    Image = ConditionalBreakpoint;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
            }
            group("Exam Timetable")
            {
                Caption = 'Exam Timetable';
                action("Exam Timetable Header List")
                {
                    Image = Report;

                    RunObject = Page "Timetable Header List";
                    RunPageView = where("Type" = const(Exam));
                    ApplicationArea = All;
                }
                action("Invigilator Setup")
                {
                    Image = Setup;
                    RunObject = Page "Invigilator Setup";
                    ApplicationArea = All;
                }
                action("First Day Preference")
                {
                    Image = Setup;
                    RunObject = Page "Exam First Day Units";
                    ApplicationArea = All;
                }
                action("Exam Time Slots")
                {
                    Image = Report;

                    RunObject = Page "Exam Time Slots";
                }
            }
        }
        area(processing)
        {
            group("Timetable Setup")
            {
                Caption = 'Timetable Setup';
                Image = Setup;

                action("General Timetable Setup")
                {
                    Caption = 'General Timetable Setup';
                    Image = Setup;
                    RunObject = Page "Timetable Setup";
                    ApplicationArea = All;
                }

                action("Lecture Halls")
                {
                    Caption = 'Lecture Halls';
                    Image = FixedAssets;
                    RunObject = Page "ACA-LectureHalls Setup";
                    ApplicationArea = All;
                }

                action("Time Slots")
                {
                    Caption = 'Time Slots';
                    Image = Calendar;
                    RunObject = Page "Time Slots";
                    ApplicationArea = All;
                }

                action("Lecturer Constraints")
                {
                    Caption = 'Lecturer Timetable Constraints';
                    Image = Constraint;
                    RunObject = Page "Lecturer Timetable Constraints";
                    ApplicationArea = All;
                }

                action("Lecturer Units")
                {
                    Caption = 'Lecturer Units';
                    Image = Employee;
                    RunObject = Page "ACA-Lecturer List";
                    ApplicationArea = All;
                }

                action("Academic Year")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;
                    RunObject = Page "ACA-Academic Year List";
                    ApplicationArea = All;
                }

                action("Semesters")
                {
                    Caption = 'Semesters';
                    Image = Period;
                    RunObject = Page "ACA-Semesters List";
                    ApplicationArea = All;
                }
            }


        }

        area(reporting)
        {
            group("Timetable Reports")
            {
                Caption = 'Timetable Reports';
                Image = Report;

                action("Class Timetable Report")
                {
                    Caption = 'Class Timetable Report';
                    Image = Report;
                    RunObject = Report "Class Timetable Report";
                    ApplicationArea = All;
                }
                action("Exam Timetable Report")
                {
                    Caption = 'Exam Timetable Report';
                    Image = Report;
                    RunObject = Report "Exam Timetable";
                    ApplicationArea = All;
                }

            }

            group("Exam Reports")
            {
                Caption = 'Exam Reports';
                Image = Report;

                action("Exam Master Timetable")
                {
                    Caption = 'Exam Master Timetable';
                    Image = Report;
                    // RunObject = Report "EXT-Master Timetable Final";
                    ApplicationArea = All;
                }
            }
        }
    }
}

profile "Timetable"
{
    Caption = 'Timetable';
    RoleCenter = "Timetable Role Center";
}