page 52142 "HR Role Center"
{
    ApplicationArea = All;
    Caption = 'HR Role Center';
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

            group(Control26)
            {
                ShowCaption = false;

                systempart(Control24; Links)
                {
                    ApplicationArea = All;
                }
                systempart(Control23; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Reporting)
        {
            group("HRM Reports")
            {

                action("Leave")
                {
                    Caption = 'Leave Types';
                    ApplicationArea = all;
                    image = Report;

                    RunObject = report "Leave Types";
                }
                action(LeaveBalances)
                {
                    Caption = 'Employee Leave Balances';
                    ApplicationArea = all;
                    Image = Balance;

                    RunObject = Report "Employee Leaves";
                }
                action(LeaveTransactions)
                {
                    Caption = 'Employee Leave Tansaction';
                    ApplicationArea = all;
                    Image = Translation;

                    RunObject = Report "Standard Leave Balance Report";
                }
                action(LeaveStatement)
                {
                    Caption = 'Employee Leave Statement';
                    ApplicationArea = all;
                    Image = LedgerEntries;

                    RunObject = Report "HR Leave Statement";
                }
                action(EmployeeList)
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    Image = Employee;

                    RunObject = Report "HR Employee List";
                }
                action(mployeeBeneficiaries)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Beneficiaries';
                    Image = "Report";

                    RunObject = Report "HR Employee Beneficiaries";
                }
                action(EmployeeCVSunmmary)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Details Summary';
                    Image = SuggestGrid;

                    RunObject = Report "Employee Details Summary";
                }

            }
        }
        area(Processing)
        {
            group(New)
            {
                Caption = 'New';
                Image = NewDocument;

                action(NewEmployee)
                {
                    ApplicationArea = All;
                    Caption = 'Employee';
                    Image = Employee;
                    RunObject = Page "HRM-Employee (B)";
                    RunPageMode = Create;
                    ToolTip = 'Create a new employee';
                }
            }
        }

        area(Sections)
        {
            group(EmployeeSection)
            {
                Caption = 'Employee Management';
                Image = HumanResources;

                action(EmployeesList)
                {
                    ApplicationArea = All;
                    Caption = 'Active Employees';
                    RunObject = Page "HRM-Employee List";
                    RunPageView = where("Full / Part Time" = filter(<> "Part Time"), Status = const(Active));
                    Image = Employee;
                    ToolTip = 'View employees';
                }

                action("Inactive Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Inactive Employees';
                    RunObject = Page "HRM-Employee List";
                    RunPageView = where("Full / Part Time" = filter(<> "Part Time"), Status = const(Inactive));
                    Image = Employee;
                    ToolTip = 'View inactive employees';
                }

                action("Part Time Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Part Time Lecturers';
                    RunObject = Page "HRM-Employee List";
                    RunPageView = where("Full / Part Time" = const("Part Time"));
                    Image = Employee;
                    ToolTip = 'View part time employees';
                }

                action(CreateEmployee)
                {
                    ApplicationArea = All;
                    Caption = 'Create Employee';
                    RunObject = Page "HRM-Employee (B)";
                    RunPageMode = Create;
                    Image = NewEmployee;
                    ToolTip = 'Create a new employee';
                }
            }

            group(LeaveSection)
            {
                Caption = 'Leave Management';
                Image = Absence;

                action("Leave Types")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Types';

                    RunObject = page "HRM-Leave Types";

                }

                action("Leave Applications")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    Image = Register;

                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("Posted Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Leaves';
                    RunObject = Page "HRM-Leave Requisition Posted";
                }
                action("Leave Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Journals';
                    Image = Journals;

                    RunObject = Page "HRM-Emp. Leave Journal Lines";
                }
            }
        }
    }
}
