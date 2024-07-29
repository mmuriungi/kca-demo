page 54513 "DAQA Role Center"
{
    Caption = 'DAQA Role Center';
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
            group("DAQA Forms")
            {

                action("form1")
                {
                    Caption = 'Orientation and Registration Form';
                    ApplicationArea = All;
                    RunObject = Page "Stud Reg Form";
                }
                action("form2")
                {
                    Caption = 'Lecturer Take Off';
                    ApplicationArea = All;
                    RunObject = Page "Lec Take Off List";
                }
                action("form3")
                {
                    Caption = 'Exam Administration';
                    ApplicationArea = All;
                    RunObject = Page "Exam Admin List";
                }
                action(form4)
                {
                    Caption = 'Teaching and Learning Form';
                    ApplicationArea = All;
                    RunObject = page "ACA-Evaluation Semesters List";
                }
                action("Evaluation Results")
                {
                    ApplicationArea = All;
                    RunObject = page "Evaluation Results";
                }
                // action(form5)
                // {
                //     Caption = 'Prac Teaching and Learning';
                //     ApplicationArea = All;
                //     RunObject = page "Practical Evaluation List";
                // }
                action(form6)
                {
                    Caption = 'Lecturer Teaching Experience';
                    ApplicationArea = All;
                    RunObject = page "Lecturer Experience List";
                }
                action(form7)
                {
                    Caption = 'Teaching Practice Feedback';
                    ApplicationArea = All;
                    RunObject = page "Teaching Practice List";
                }

            }
        }
        area(Creation)
        {
            action("SetUps")
            {
                ApplicationArea = All;
                RunObject = Page "DAQA Central Setups";
            }

        }
    }
}
