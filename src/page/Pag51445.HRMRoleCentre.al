page 51445 "HRM-Role Centre"
{
    Caption = 'HRM-Role Center';
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
        area(creation)
        {
            group(Setups)
            {
                action("Institutions List")
                {
                    ApplicationArea = all;
                    Caption = 'Institutions List';
                    Image = Line;

                    RunObject = Page "HRM-Institutions List";
                }
                action(Religions)
                {
                    ApplicationArea = All;
                    Caption = 'Religions';
                    Image = PutAwayWorksheet;
                    //RunObject = page "HRM-Religions";
                }
                action("Base Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Base Calendar';
                    Image = Calendar;
                    RunObject = Page "Base Calendar List";
                }
                action("Hr Setups")
                {
                    ApplicationArea = all;
                    Caption = 'Hr Setups';
                    Image = Setup;
                    RunObject = Page "HRM-SetUp List";
                }
                action("Hr Number Series")
                {
                    ApplicationArea = all;
                    Caption = 'Hr Number Series';
                    Image = NumberSetup;
                    RunObject = Page "Human Resource Setup";
                }
                action(Committees)
                {
                    ApplicationArea = all;
                    Caption = 'Committees';
                    Image = Employee;
                    RunObject = Page "HRM-Committees";
                }
                action("Look Up Values")
                {
                    ApplicationArea = all;
                    Caption = 'Look Up Values';
                    Image = ValueLedger;
                    RunObject = Page "HRM-Lookup Values List";
                }
                action("Hr Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Hr Calendar';
                    Image = Calendar;
                    RunObject = Page "Base Calendar List";
                }
                action(" Email Parameters List")
                {
                    ApplicationArea = all;
                    Caption = ' Email Parameters List';
                    Image = Email;
                    RunObject = Page "HRM-Email Parameters List";
                }
                action("No.Series")
                {
                    ApplicationArea = all;
                    Caption = 'No.Series';
                    Visible = false;
                    RunObject = Page "No. Series";
                }
                action("Salary Steps")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Steps';
                    Image = Line;
                    RunObject = Page "HRM-Job_Salary Grade/Steps";
                }


            }
            group("Leave Reports")
            {
                // Caption = 'MNU HRM Reports';
                action("Leave")
                {
                    Caption = 'Leave Types';
                    ApplicationArea = all;
                    image = Report;

                    RunObject = report "Leave Types";
                }
                action("Appraisal report")
                {

                    ApplicationArea = all;
                    image = Report;
                    RunObject = report "Appraisal Report";
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
                    Caption = 'Employee CV Sunmmary';
                    Image = SuggestGrid;

                    RunObject = Report "Employee Details Summary";
                }


                action(Commission_Report)
                {
                    ApplicationArea = all;
                    Caption = 'Commission Report';
                    Image = Report2;

                    //RunObject = Report "HRM-Commission For Univ. Rep.";
                }

            }


            // action(HRMJobs)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Jobs List';
            //     Image = Job;
            //     
            //     RunObject = Page "HRM-Jobs List";

            // }

            // action(HRMemployee)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Employee List';
            //     RunObject = Page "HRM-Employee List";
            // }
            // action(HRMEmployees)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Inactive Employee List';
            //     Image = Job;
            //     
            //     RunObject = Page "HRM-Employee-List (Inactive)";

            // }


            // action(LeaveJournal)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Leave Journals';
            //     Image = Journals;
            //     
            //     ToolTip = 'Allocate and Post leave days for Employees';
            //     RunObject = Page "HRM-Emp. Leave Journal Lines";

            // }
            // action(HRMLeaves)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Leave Applications';
            //     RunObject = Page 68107;
            // }
            // action(HRMLeavesApplies)
            // {
            //     ApplicationArea = all;
            //     Caption = 'View Leave Applications';
            //     RunObject = Page "HRM-View Leave List";
            // }
            // action(HRMPostedLeaves)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Posted Leave';
            //     RunObject = Page "HRM-Leave Requisition Posted";
            // }

        }



        area(Embedding)
        {
            action(employeelsting)
            {
                ApplicationArea = all;
                Caption = 'Employee List';
                Visible = false;
                RunObject = Page "HRM-Employee List";
            }

            action(payrolldata)
            {
                ApplicationArea = all;
                Caption = 'Payroll data';
                Visible = false;
                RunObject = Page "PRL-Payroll Raw Data";
            }

        }

        area(sections)
        {
            group(EmployeeMan)
            {
                Caption = 'Employee Manager';
                Image = HumanResources;
                action(Action22)
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    RunObject = Page "HRM-Employee List";
                }
                action(Casuals)
                {
                    ApplicationArea = all;
                    Caption = 'Casuals';
                    RunObject = Page "HRM-Casuals Lists";
                }
                action(LeavePlanner)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Planner';
                    RunObject = Page "HR Leave Planner List";
                }

                action("Leave Applications")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";

                }
                action("View Leave Applications")
                {
                    ApplicationArea = all;
                    Caption = 'View Leave Applications';
                    RunObject = Page "HRM-View Leave List";
                }
            }
            group(Payroll)
            {
                Visible = false;
                Caption = 'Payroll';
                Image = SNInfo;
                action("Salary Card")
                {

                    Caption = 'Salary Card';
                    Image = Employee;

                    RunObject = Page "HRM-Employee-List";
                    ApplicationArea = All;
                }
                action("Transcation Codes")
                {

                    Caption = 'Transcation Codes';
                    Image = Setup;

                    RunObject = Page "PRL-Transaction Codes List";
                    ApplicationArea = All;
                }
                action("NHIF Setup")
                {

                    Caption = 'NHIF Setup';
                    Image = SetupLines;

                    RunObject = Page "PRL-NHIF SetUp";
                    ApplicationArea = All;
                }
                action("Payroll Mass Changes")
                {

                    Caption = 'Payroll Mass Changes';
                    Image = AddAction;

                    RunObject = Page "HRM-Import Emp. Trans Buff";
                    ApplicationArea = All;
                }
                action(" payment Vouchers")
                {

                    Caption = ' payment Vouchers';
                    ApplicationArea = All;
                    //RunObject = Page "FIN-Payment Vouchers";
                }
            }
            group("Salary Increaments")
            {
                Caption = 'Salary Increaments';
                Image = Intrastat;
                action("Salary Increament Process")
                {

                    Caption = 'Salary Increament Process';
                    Image = AddAction;

                    RunObject = Page "HRM-Emp. Categories";
                    ApplicationArea = All;
                }
                action("Salary Increament Register")
                {

                    Caption = 'Salary Increament Register';
                    Image = Register;

                    RunObject = Page "HRM-Salary Increament Register";
                    ApplicationArea = All;
                }
                action("Un-Afected Salary Increaments")
                {

                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;

                    RunObject = Page "HRM-Unaffected Sal. Increament";
                    ApplicationArea = All;
                }

            }
            group(Appraisals)
            {
                Caption = 'Perfomance Appraisal';
                action("Performance Appraisal Module Setup")
                {
                    RunObject = page "Corparate Affairs Setup";
                    ApplicationArea = All;
                }
                action("PA Indicators")
                {
                    RunObject = page "PC Category list";
                    ApplicationArea = All;
                }
                action("University Targets")
                {
                    RunObject = page "PC Work Plan Setup";
                    ApplicationArea = All;
                    caption = 'Annual university Performance Contract';
                }
                action("University and Departmental Targets")
                {
                    RunObject = page "PC SubCategories List";
                    ApplicationArea = all;
                    caption = 'Annual University and Departmental Targets';
                }

                action("Departmental PC")
                {
                    RunObject = page "Department WorkPlan  List";
                    ApplicationArea = All;
                    Caption = 'Annual Departmental PC';
                }
                action("Vetting By PC Secretariat")
                {
                    ApplicationArea = All;
                    //Caption = 'PC Secretariat';
                    RunObject = Page "Vetting List ";
                }
                action("HR PC Approval")
                {
                    ApplicationArea = All;
                    //Caption = 'PC Secretariat';
                    RunObject = Page "Work Plan Executive Committee";
                }
                // action(" Director's Approval")
                // {
                //     ApplicationArea = all;
                //     RunObject = page "Work Plan Consult Comimttee";
                // }
                action("Approved Departmental PC")
                {
                    RunObject = page "Approved WorkPlan List";
                    ApplicationArea = All;
                }
                action("Employee Performance Target List")
                {
                    RunObject = page "Employee Perf Target List";
                    ApplicationArea = All;
                }
                action("Employee Performance Target Pending Approval")
                {
                    RunObject = page "Targets Pending Approvals";
                    ApplicationArea = All;
                }
                action("Approved Performance Target List")
                {
                    RunObject = page "Approved Employee Targets";
                    ApplicationArea = All;
                }
                action("Appraisal List")
                {
                    RunObject = page "Appraisal List";
                    ApplicationArea = All;
                }//"PC Reports"
                action("PC Reports")
                {
                    RunObject = page "PC Reports";
                    ApplicationArea = All;
                }

            }
            group("Salary Advances")
            {
                Caption = 'Salary Advance';
                Visible = false;

                action("Salary Advance")
                {
                    ApplicationArea = all;

                    //RunObject=page "FIN-Staff Advance List";
                }
                action("Salary Advance retiring")
                {
                    ApplicationArea = all;
                    Caption = 'Advance Surrender';
                    //RunObject=page "FIN-Staff Advance Surr. List";


                }
            }
            group(Internships)
            {
                action("Interns List")
                {
                    ApplicationArea = all;

                    RunObject = page "HRM-Intern&Attach List";
                }
                action("Application List")
                {
                    Caption = 'Register';
                    ApplicationArea = all;


                    RunObject = page "HRM-Attachment Register";
                }

            }
            group(ATT)
            {
                Caption = 'Attendance';
                Visible = false;
                action("Staff Register")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Register';
                    RunObject = Page "Staff Reg.Ledger List";
                }
                action("Staff Register History")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Register History';
                    RunObject = Page "Staff Ledger History";
                }
                action("Casuals Register")
                {
                    ApplicationArea = all;
                    Caption = 'Casuals Register';
                    RunObject = Page "Casuals  Reg.Ledger List";
                }
                action("Casuals History")
                {
                    ApplicationArea = all;
                    Caption = 'Casuals History';
                    RunObject = Page "Casuals Ledger History";
                }
            }
            group(Attnd)
            {
                Caption = 'Staff Attendance';
                Image = Statistics;
                action(ParmStaffCurr)
                {
                    ApplicationArea = all;
                    Caption = 'Permanent Staff (Present)';
                    Image = AddContacts;

                    RunObject = Page "Staff Attendance (Current)";
                    ToolTip = 'Open List of Staff register (Daily Attendance)';
                }
                action(CasualStaffCurr)
                {
                    ApplicationArea = all;
                    Caption = 'Casual Staff (Present)';
                    Image = Purchasing;

                    RunObject = Page "Casual Attendance (Current)";
                    ToolTip = 'Open Attendance List for Casual Employees';
                }
                action(ParmStaff)
                {
                    ApplicationArea = all;
                    Caption = 'Permanent Staff (History)';
                    Image = AddContacts;

                    RunObject = Page "Staff Attendance View";
                    ToolTip = 'Open List of Staff register (Daily Attendance)';
                }
                action(CasualStaff)
                {
                    ApplicationArea = all;
                    Caption = 'Casual Staff (History)';
                    Image = Purchasing;

                    RunObject = Page "Casual Staff Attendance View";
                    ToolTip = 'Open Attendance List for Casual Employees';
                }
            }
            group(LeaveMan)
            {
                Caption = 'Leave Management';
                Image = Capacities;
                action(leaveSchedule)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Types';
                    RunObject = page "Leave Roaster";

                }
                action(leaveSchedule2)
                {
                    ApplicationArea = all;
                    Caption = 'leave Roaster';

                    RunObject = page "Leave Roaster1";

                }
                action(leavetypes)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Types';

                    RunObject = page "HRM-Leave Types";

                }

                action(Action14)
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
                action("Back To Office")
                {
                    ApplicationArea = all;
                    RunObject = Page "HRM-Return to Office";
                    ToolTip = 'Is filled by staff when they return from leave';
                }
                action("Leave Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Journals';
                    Image = Journals;

                    RunObject = Page "HRM-Emp. Leave Journal Lines";
                }
                action("Leave Allowance Buffer")
                {

                    Caption = 'Leave Allowance Buffer';
                    Image = Bins;

                    RunObject = Page "HRM-Leave Allowance Buffer";
                    ApplicationArea = All;
                }
                action("Posted Leave")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Leave journals';
                    RunObject = Page "HRM-Posted Leave Journal";
                }
            }
            group(JobMan)
            {
                Caption = 'Jobs Management';
                Image = ResourcePlanning;
                action("Jobs List")
                {
                    ApplicationArea = all;
                    Caption = 'Jobs List';
                    Image = Job;
                    RunObject = Page "HRM-Jobs List";
                }

            }
            group(Recruit)
            {
                Caption = 'Recruitment Management';
                action("Employee Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Recruitment Requisitions';
                    Image = ApplicationWorksheet;

                    RunObject = Page "HRM-Employee Requisitions List";
                }
                action("CIR")
                {
                    Caption = 'Advert Verification';
                    ApplicationArea = All;
                    Image = ApplicationWorksheet;

                    RunObject = Page "HRM List Submitted to CIRO";
                }
                action("Advertised Jobs")
                {
                    ApplicationArea = all;
                    Caption = 'Advertised Jobs';
                    RunObject = Page "HRM-Advertised Job List";
                }
                action("Job Applications List")
                {
                    ApplicationArea = all;
                    Caption = 'Job Applications List';
                    RunObject = Page "HRM-Job Applications List";
                }
                action("Short Listing")
                {
                    ApplicationArea = all;
                    Caption = 'Applicant Short Listing';
                    RunObject = Page "HRM-Shortlisting List";
                }
                action("Shortlisted Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Shortlisted Applications';
                    RunObject = page "HRM-Applications ShortList";
                    ToolTip = 'Shows List of all Shortlisted Applications';
                }
                action(sifted)
                {
                    ApplicationArea = All;
                    Caption = 'Sifted Applications';
                    RunObject = page "HRM-Sifted Applications";
                    ToolTip = 'Shows a list of all the sifted applications';
                }
                action("Interview Candidates")
                {
                    ApplicationArea = All;
                    Caption = 'Interview Candidates';
                    RunObject = page "HRM-Interview Invite";
                    ToolTip = 'Shows List of all Candidates awaiting interview';
                }
                action(coverLet)
                {
                    ApplicationArea = All;
                    Caption = 'Awaiting Offer Letter';
                    RunObject = page "HRM-Interview Passed";
                    Tooltip = 'Shows Candidates Awaiting cover letter';
                }

                action("Failed Interview")
                {
                    ApplicationArea = All;
                    Caption = 'Failed Interview';
                    RunObject = page "HRM-Interview Failed";
                    ToolTip = 'Shows Applicants Who Failed The Interview';
                }
                action("Rejected Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Applications';
                    RunObject = page "HRM-Rejected App";
                    ToolTip = 'Shows List of all Rejected Applications';
                }

                // action("Qualified Job Applicants")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Qualified Job Applicants';
                //     RunObject = Page "HRM-Job Applicants Qualified";
                // }
                // action("Unqualified Applicants")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Unqualified Applicants';
                //     RunObject = Page "HRM-Job Applicants Unqualified";
                // }

            }
            group(Induction)
            {
                Caption = 'Induction';
                action("Induction Activity")
                {
                    ApplicationArea = all;
                    Caption = 'Induction List';
                    RunObject = page "HRM-Induction Schedule List";
                }
            }
            group(Welfare)
            {
                Caption = 'Welfare Management';
                Image = Capacities;
                Visible = false;
                action("Company Activity")
                {
                    ApplicationArea = all;
                    Caption = 'Company Activity';
                    RunObject = Page "HRM-Company Activities List";
                }
                action("Welfare Application")
                {
                    ApplicationArea = all;
                    Caption = 'Welfare Application';
                    RunObject = page "HRM-Welfare Application";
                }
            }
            group(setus)
            {
                Caption = 'Setups';
                Image = HRSetup;

            }
            group(pension)
            {
                Caption = 'Pension Management';
                Image = History;
                Visible = false;
                action(Action40)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Beneficiaries';
                    RunObject = Page "HRM-Emp. Beneficiaries List";
                }
                action("Pension Payments List")
                {
                    ApplicationArea = all;
                    Caption = 'Pension Payments List';
                    RunObject = Page "HRM-Pension Payments List";
                }
            }
            group(train)
            {
                Caption = 'Training Management';
                action("Training Applications")
                {
                    ApplicationArea = all;
                    Caption = 'Training Applications';
                    RunObject = Page "HRM-Training Application List";
                }
                action("Training Courses")
                {
                    ApplicationArea = all;
                    Caption = 'Training Courses';
                    RunObject = Page "HRM-Course List";
                }
                action("Training Providers")
                {
                    ApplicationArea = all;
                    Caption = 'Training Providers';
                    RunObject = Page "HRM-Training Providers List";
                }
                action("Training Needs")
                {
                    ApplicationArea = all;
                    Caption = 'Training Needs';
                    RunObject = Page "HRM-Train Need Analysis List";
                }

            }
            group(exitInterview)
            {
                Caption = 'Interviews';
                Image = Alerts;
                action("Interview")
                {
                    ApplicationArea = all;
                    RunObject = page "HRM-Interview Details List";
                    Visible = false;

                }
                action(" Exit Interview")
                {
                    ApplicationArea = all;
                    Caption = ' Exit Interview';
                    RunObject = Page "HRM-Exit Interview List";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;

                action("My Approval requests")
                {
                    ApplicationArea = all;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                }
                action("MyApprovarequests")
                {
                    Caption = 'My Approval Entries';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
                }

            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Stores Requisitions';

                    RunObject = Page "PROC-Store Requisition";
                }

                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    Visible = false;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
                action("Claim  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Claim Requisitions';
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Create Claim requisition from Users.';
                }
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }


                action("Meal Booking")
                {
                    ApplicationArea = All;
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                }

                action("Transport Requisition")
                {
                    ApplicationArea = All;
                    Image = MapAccounts;
                    RunObject = Page "FLT-Transport Req. List";
                }
            }

        }




    }
}

