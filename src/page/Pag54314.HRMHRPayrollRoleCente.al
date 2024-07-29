page 54314 "HRM-HR&Payroll Role Cente"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Administration;
    ApplicationArea = All, Basic, Suite, Advance;

    layout
    {
        area(rolecenter)
        {
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }

            part(Registra; "Approvals Activities Three")
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
        area(Embedding)
        {
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = ChartOfAccounts;
                RunObject = Page "Chart of Accounts";
            }
            action("Customers")
            {
                ApplicationArea = Basic, suite;
                Image = CustomerGroup;
                RunObject = page "Customer List";
            }
            action("Asset List")
            {
                ApplicationArea = All;
                Image = FixedAssets;
                RunObject = Page "Fixed Asset List";
            }
            action("Vendors")
            {
                ApplicationArea = Basic, suite;
                image = Vendor;
                RunObject = Page "Vendor List";
            }
            action("Budget List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Budget Names';
                Image = GLRegisters;
                RunObject = Page "G/L Budget Names";
                ToolTip = 'View List of Budgets';
            }
            action("Budget Period")
            {
                ApplicationArea = Basic, Suite;
                Image = PeriodStatus;
                RunObject = Page "Fin Quatery Budget Periods";
            }
        }
        area(reporting)
        {

            group(Reports)
            {

                Caption = 'Payroll Reports';
                Image = Payables;
                action(Payslips)
                {
                    ApplicationArea = area;
                    Caption = 'Payslips';
                    Image = "Report";

                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action("Payroll Summary1")
                {
                    ApplicationArea = all;
                    Caption = 'Departmental Payroll Summary';
                    Image = "Report";

                    RunObject = Report "Detailed Payrol Summary/Dept";
                }
                action("Master Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Company Payroll Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payroll Summary 3";
                }

                action("Deductions Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";

                    Visible = false;
                    //RunObject = Report "PRL-Deductions Summary 2";
                }
                action("Earnings Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";

                    RunObject = Report "PRL-Payments Summary 2 a";
                }
                action("vew payslip")
                {
                    ApplicationArea = all;
                    Caption = 'view payslip';
                    Image = "Report";

                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action("Payroll summary")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll summary';
                    Image = "Report";

                    RunObject = Report "Payroll Summary 2";
                }
                action("Deductions Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Deductions Summary1";
                }
                action("PR Payroll Summary - Detailed")
                {
                    ApplicationArea = all;
                    Caption = 'PR Payroll Summary - Detailed';
                    Image = "Report";

                    RunObject = Report "PR Payroll Summary - Detailed";
                }
                action("PR Trans  Variance Analysis")
                {
                    ApplicationArea = all;
                    Caption = 'PR Trans  Variance Analysis';
                    Image = "Report";

                    RunObject = Report "PR Trans  Variance Analysis";
                }
                action("Earnings Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Earnings Summary 5";
                }

                action("Gross Netpay")
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = "Report";
                    RunObject = Report prGrossNetPay;
                }
                action("Third Rule")
                {
                    ApplicationArea = all;
                    Caption = 'Third Rule';
                    Image = "Report";
                    RunObject = Report "A third Rule Report";
                }
                action("P9 Report")
                {
                    ApplicationArea = all;

                    Caption = 'P9 Report';
                    Image = PrintForm;

                    RunObject = Report "P9 Report (Final)";
                }
                action("Co_op Remittance")
                {
                    Caption = 'Co_op Remittance';
                    Image = "Report";
                    RunObject = Report "prCoop remmitance";
                    ApplicationArea = All;
                }
                action(Transactions)
                {
                    ApplicationArea = all;
                    Caption = 'Transactions';
                    Image = "Report";
                    RunObject = Report "pr Transactions";
                }
                action("bank Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";
                    RunObject = Report "PRL-Bank Schedule";
                }
            }
            group(Reports3)
            {
                Caption = 'HR Reports';
                Image = Payables;
                action("Employee List")
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    Image = "Report";

                    RunObject = Report "HR Employee List";
                }
                action("Employee Beneficiaries")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Beneficiaries';
                    Image = "Report";

                    RunObject = Report "HR Employee Beneficiaries";
                }
                action("Commission Report")
                {
                    ApplicationArea = all;
                    Caption = 'Commission Report';
                    Visible = false;
                    Image = Report2;

                    //RunObject = Report "HRM-Commission For Univ. Rep.";
                }
                action("Leave Balances")
                {
                    ApplicationArea = all;
                    Image = Balance;

                    RunObject = Report "Employee Leaves";
                }
                action("Leave Transactions")
                {
                    ApplicationArea = all;
                    Image = Translation;

                    RunObject = Report "Standard Leave Balance Report";
                }
                action("Leave Statement")
                {
                    ApplicationArea = all;
                    Image = LedgerEntries;

                    RunObject = Report "HR Leave Statement";
                }

                action("Employee CV Sunmmary")
                {
                    ApplicationArea = all;
                    Caption = 'Employee CV Sunmmary';
                    Image = SuggestGrid;

                    RunObject = Report "Employee Details Summary";
                }
            }
            group(Registry)
            {
                action("File Cabinet")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Sections List";
                }

                action("Registry Files")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Files List";
                }

                action("File Movement Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Movement List";
                }
                action("Bring Up")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Move BringUp";
                    RunPageLink = "Issued Out" = filter(true);
                }
                action("File Movement History")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Move History";
                    //RunPageLink = "Folio Returned" = filter(true);
                }
                action("Inward Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Inward Register B";
                }
                action("Outward Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Outward Register List";
                }
                action("Closed Files")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Closed Files Lst";
                }
            }
            group("Archives Register")
            {
                action("File Appraisal Reqests")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Appraisal Req";
                }
                action("Archives")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Archive Register";
                }
                action("Destroy File(s)")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-MarkedforDest";
                }
                action("Destruction History")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-FileDestruction History";
                }

                action("Mail Register")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Mail Register List";
                }
                action("Registry Files List")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-Registry Files List";
                }
                action("File Requisition List")
                {
                    ApplicationArea = All;

                    RunObject = Page "REG-File Requisition List";
                }
                action("File Request Reasons")
                {
                    RunObject = Page "REG-File Request Reasons";
                    ApplicationArea = All;
                }
            }

        }
        area(Processing)
        {

            group("Data Upload")
            {
                Visible = false;
                action("employeeupload")
                {
                    //RunObject = xmlport "Employee Upload";
                    Caption = 'Employee Details bulk upload';
                    ApplicationArea = all;
                    Image = ImplementRegAbsence;


                }
                action("prltransaction codes")
                {
                    // RunObject = xmlport 50022;
                    Caption = 'Transactions Codes';
                    ApplicationArea = all;
                    Image = ImportCodes;


                }
                action("prl employee transaction")
                {
                    // RunObject = xmlport 50022;
                    Caption = 'Employee transactions';
                    ApplicationArea = all;
                    Image = ImportCodes;


                }
                action("prl time sheet")
                {
                    //RunObject = xmlport "Import TimeSheet";
                    Caption = 'Time Sheet';
                    ApplicationArea = all;
                    Image = ImportCodes;


                }

                action("salarygrade")
                {
                    //RunObject = xmlport "Salary Grades";
                    Caption = 'import salary grades';
                    ApplicationArea = all;
                    Image = CashFlow;
                }
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

            }
            group("Payroll Info")
            {

                group(PayRollData)
                {


                    Caption = 'Payroll';

                    action("Salary Card")
                    {
                        ApplicationArea = All;
                        Caption = 'Salary Card';
                        Image = Employee;

                        RunObject = Page "HRM-Employee-List";


                    }

                    action("Payroll Mass Changes")
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll Mass Changes';
                        Image = AddAction;

                        RunObject = Page "HRM-Import Emp. Trans Buff";
                    }
                }
                group(ProcessPCA)
                {
                    Caption = 'Pay Change Advice Processing';
                    action(PCA)
                    {
                        Caption = 'PR-PCA List';
                        Image = Change;

                        RunObject = page "prPCA list";
                        ApplicationArea = All;
                    }
                    action(prPostedPCAMassList)
                    {
                        Caption = 'Mass PCA List';
                        Image = Change;

                        RunObject = page prPCAMassList;
                        ApplicationArea = All;
                    }
                    action(PostedMAssPCAList)
                    {
                        Caption = 'Posted Mass PCA List';
                        Image = Change;

                        RunObject = page prPostedPCAMassList;
                        ApplicationArea = All;
                    }
                    action(OthermPCAList)
                    {
                        Caption = 'Other Mass PCA List';
                        Image = Change;

                        RunObject = page "Other mPCA list";
                        ApplicationArea = All;
                    }
                }

                group(Casuals)
                {

                    Caption = 'Casual Payroll';

                    action("HRM-Casual Pay List")
                    {
                        ApplicationArea = All;
                        Caption = 'Casual Salary Card';
                        Image = Employee;
                        RunObject = Page "HRM-Casual Pay List";
                    }
                    action("PRL-Casual Worked Days ")
                    {
                        ApplicationArea = All;
                        Caption = 'Casuals Worked days';
                        Image = Setup;

                        RunObject = Page "PRL-Casual Worked Days";
                    }
                    action("PRL-Casual Payroll Periods")
                    {
                        ApplicationArea = All;
                        Caption = 'Casuals Payroll Period';
                        Image = SetupLines;

                        RunObject = Page "PRL-Casual Payroll Periods";
                    }

                }
                group(SalInc)
                {
                    Caption = 'Salary Increaments';

                    action("Salary Increament Process")
                    {
                        ApplicationArea = All;
                        Caption = 'Salary Increament Process';
                        Image = AddAction;

                        RunObject = Page "HRM-Emp. Categories";
                    }
                    action("Salary Increament Register")
                    {
                        ApplicationArea = All;
                        Caption = 'Salary Increament Register';
                        Image = Register;

                        RunObject = Page "HRM-Salary Increament Register";
                    }
                    action("Un-Afected Salary Increaments")
                    {
                        ApplicationArea = All;
                        Caption = 'Un-Afected Salary Increaments';
                        Image = UndoCategory;

                        RunObject = Page "HRM-Unaffected Sal. Increament";
                    }
                    action("Leave Allowance Buffer")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Allowance Buffer';
                        Image = Bins;
                        RunObject = Page "HRM-Leave Allowance Buffer";
                    }
                }
            }
            group(LeaveMan)
            {
                Caption = 'Leave Management';
                Image = Capacities;
                action("Leave Roster")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Roster';
                    RunObject = page "Leave Roaster1";
                }
                action("Leave Roster2")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Roster2';
                    RunObject = page "Leave Roaster";
                }
                action("Leave Types")
                {
                    ApplicationArea = all;

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
                action("Leave Journals")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Journals';
                    Image = Journals;

                    RunObject = Page "HRM-Emp. Leave Journal Lines";
                }
                action("Posted Leave")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Leave Journal';
                    RunObject = Page "Posted Leave Journals";
                }
                action("Staff Movement Form")
                {
                    ApplicationArea = all;
                    RunObject = Page "HRM-Back To Office List";
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
                    Caption = 'Employee Requisitions';
                    Image = ApplicationWorksheet;

                    RunObject = Page "HRM-Employee Requisitions List";
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
                    Caption = 'Short Listing';
                    RunObject = Page "HRM-Shortlisting List";
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
            group(train)
            {
                Caption = 'Training Management';
                action("Training Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Training Applications';
                    RunObject = Page "HRM-Training Application List";
                }
                action("Training Courses")
                {
                    ApplicationArea = All;
                    Caption = 'Training Courses';
                    RunObject = Page "HRM-Course List";
                }
                action("Training Providers")
                {
                    ApplicationArea = All;
                    Caption = 'Training Providers';
                    RunObject = Page "HRM-Training Providers List";
                }
                action("Training Needs")
                {
                    ApplicationArea = All;
                    Caption = 'Training Needs';
                    RunObject = Page "HRM-Train Need Analysis List";
                }
                action("Back To Office")
                {
                    ApplicationArea = All;
                    Caption = 'Back To Office';
                    RunObject = Page "HRM-Back To Office List";
                }
            }
            group(Welfare)
            {
                Caption = 'Welfare Management';
                Image = Capacities;
                action("Company Activity")
                {
                    ApplicationArea = All;
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
            group(setups)
            {
                Caption = 'Setups';
                action("Transcation Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Transcation Codes';
                    Image = Setup;

                    RunObject = Page "PRL-Transaction Codes List";
                }
                action("NHIF Setup")
                {
                    ApplicationArea = All;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;

                    RunObject = Page "PRL-NHIF SetUp";
                }
                action("Institutions List")
                {
                    ApplicationArea = All;
                    Caption = 'Institutions List';
                    Image = Line;

                    RunObject = Page "HRM-Institutions List";
                }
                action("Base Calendar")
                {
                    ApplicationArea = All;
                    Caption = 'Base Calendar';
                    RunObject = Page "Base Calendar List";
                }
                action("Hr Setups")
                {
                    ApplicationArea = All;
                    Caption = 'Hr Setups';
                    RunObject = Page "HRM-SetUp List";
                }
                action(Committees)
                {
                    ApplicationArea = All;
                    Caption = 'Committees';
                    RunObject = Page "HRM-Committees";
                }
                action("Look Up Values")
                {
                    ApplicationArea = All;
                    Caption = 'Look Up Values';
                    RunObject = Page "HRM-Lookup Values List";
                }
                action("Hr Calendar")
                {
                    ApplicationArea = All;
                    Caption = 'Hr Calendar';
                    RunObject = Page "Base Calendar List";
                }
                action(" Email Parameters List")
                {
                    ApplicationArea = All;
                    Caption = ' Email Parameters List';
                    RunObject = Page "HRM-Email Parameters List";
                }
                action("No.Series")
                {
                    ApplicationArea = All;
                    Caption = 'No.Series';
                    Visible = false;
                    RunObject = Page "No. Series";
                }
                group(Functions)
                {
                    Caption = 'import data';
                    Visible = false;
                    action("salary grade")
                    {
                        //RunObject = xmlport "Salary Grades";
                        Caption = 'import employees';
                        ApplicationArea = all;

                    }
                    action("job")
                    {
                        // RunObject = xmlport "Employee Upload";
                        Caption = 'Import Employee job';
                        ApplicationArea = all;

                    }

                }
            }
            group(pension)
            {
                Caption = 'Pension Management';
                Image = History;
                Visible = false;
                action(Action40)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Beneficiaries';
                    RunObject = Page "HRM-Emp. Beneficiaries List";
                }
                action("Pension Payments List")
                {
                    ApplicationArea = All;
                    Caption = 'Pension Payments List';
                    RunObject = Page "HRM-Pension Payments List";
                }
            }
            group(exitInterview)
            {
                Caption = 'Exit Interviews';
                Image = Alerts;
                action(" Exit Interview")
                {
                    ApplicationArea = All;
                    Caption = ' Exit Interview';
                    RunObject = Page "HRM-Exit Interview List";
                }
            }


            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {

                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {

                    Caption = 'Approval Request Entries';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
                }
                action("Clearance Requests")
                {

                    Caption = 'Clearance Requests';
                    RunObject = Page "ACA-Clearance Approval Entries";
                    ApplicationArea = All;
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                action("Stores Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprests List";
                }
                action(Action1000000003)
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = All;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
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
                action("Transport Requisition")
                {
                    ApplicationArea = All;
                    Image = MapAccounts;
                    RunObject = Page "FLT-Transport Req. List";
                }
            }
        }
        area(creation)
        {
            action("Change Password")
            {
                ApplicationArea = All;
                Caption = 'Change Password';
                Image = ChangeStatus;
                //  RunObject = Page "Change Password";
            }
            group(Payroll_Setups)
            {
                Visible = false;
                Caption = 'Payroll Setups';
                Image = HRSetup;
                action("Payroll Period")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }
                action("Pr Rates")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll  Rates';
                    Image = SetupColumns;

                    RunObject = Page "PRL-Rates & Ceilings";
                }
                action("paye Setup")
                {
                    ApplicationArea = All;
                    Caption = 'PAYE Setup';
                    Image = SetupPayment;

                    RunObject = Page "PRL-P.A.Y.E Setup";
                }
                action(Action1000000046)
                {
                    ApplicationArea = All;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;

                    RunObject = Page "PRL-NHIF SetUp";
                }
                action(nssf)
                {
                    ApplicationArea = All;
                    Caption = 'NSSF Setup';
                    Image = Allocations;

                    RunObject = Page "prNSSF Tiers List";
                }
                action(Action1000000047)
                {
                    ApplicationArea = All;
                    Caption = 'Transcation Codes';
                    Image = Setup;

                    RunObject = Page "PRL-Transaction Codes List";
                }

                action("Hr Employee Card")
                {
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    // PromotedIsBig = true;
                    Image = Info;
                    RunObject = Page "HRM-Employee (C)";
                }
                action("Bank Structure")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Structure';
                    Image = Bank;

                    RunObject = Page "PRL-Bank Structure (B)";
                }
                action("control information")
                {
                    ApplicationArea = All;
                    Caption = 'control information';
                    Image = CompanyInformation;

                    RunObject = Page "GEN-Control-Information";
                }
                action("Salary Grades")
                {
                    ApplicationArea = All;
                    Caption = 'Salary Grades';
                    Image = EmployeeAgreement;

                    RunObject = Page "PRL-Salary Grades";
                }
                action("posting group")
                {
                    ApplicationArea = All;
                    Caption = 'posting group';
                    Image = PostingEntries;

                    RunObject = Page "PRL-Employee Posting Group";
                }
                action(Action1000000040)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Categories';
                    Image = AddAction;

                    RunObject = Page "HRM-Emp. Categories";
                }
                action(Action1000000039)
                {
                    ApplicationArea = All;
                    Caption = 'Salary Increament Register';
                    Image = Register;

                    RunObject = Page "HRM-Salary Increament Register";
                }
                action(Action1000000038)
                {
                    ApplicationArea = All;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;

                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action(Action1000000037)
                {
                    ApplicationArea = All;
                    Caption = ' payment Vouchers';
                    // RunObject = Page "FIN-Payment Vouchers";
                }
            }
            group("Payroll Reports")
            {
                Visible = false;
                Caption = 'Payroll Reports';
                Image = ResourcePlanning;
                action(Action1000000035)
                {
                    ApplicationArea = All;
                    Caption = 'vew payslip';
                    Image = "Report";

                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action(Action1000000034)
                {
                    ApplicationArea = All;
                    Caption = 'Master Payroll Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                action(Action1000000033)
                {
                    ApplicationArea = All;
                    Caption = 'Detailed Payroll Summary';
                    Image = Report;
                    RunObject = Report "Detailed Payrol Summary/Dept";
                }
                action(Action1000000032)
                {
                    ApplicationArea = All;
                    Caption = 'Deductions Summary';
                    Image = Report;
                    //  RunObject = Report "PRL-Deductions Summary";
                }
                action(Action1000000031)
                {
                    ApplicationArea = All;
                    Caption = 'Earnings Summary';
                    Image = DepositSlip;
                    //  RunObject = Report "PRL-Earnings Summary";
                }
                action(Action1000000030)
                {
                    ApplicationArea = All;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";

                    //  RunObject = Report "PRL-Deductions Summary 2";
                }
                action(Action1000000029)
                {
                    ApplicationArea = All;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";

                    //   RunObject = Report "PRL-Payments Summary 2";
                }
                action(Action1000000028)
                {
                    ApplicationArea = All;
                    Caption = 'Staff pension';
                    Image = Aging;
                    //  RunObject = Report "prStaff Pension Contrib";
                }
                action(Action1000000027)
                {
                    ApplicationArea = All;
                    Caption = 'Gross Netpay';
                    Image = Giro;
                    // RunObject = Report prGrossNetPay;
                }
            }
            group(PayrollPeoro)
            {
                //  Visible = false;
                Caption = 'Periodic Reports';
                Image = RegisteredDocs;
                action(Action1000000025)
                {
                    ApplicationArea = All;
                    Caption = 'P9 Report';
                    Image = PrintForm;

                    RunObject = Report "P9 Report (Final)";
                }
                action(Action1000000024)
                {
                    ApplicationArea = All;
                    Caption = 'Transactions';
                    Image = "Report";

                    // RunObject = Report "pr Transactions";
                }
                action(Action1000000023)
                {
                    ApplicationArea = All;
                    Caption = 'bank Schedule';
                    Image = "Report";

                    RunObject = Report "pr Bank Schedule";
                }

                action("P.10")
                {
                    ApplicationArea = All;
                    Caption = 'P.10';
                    Image = "Report";

                    RunObject = Report "P.10 A mst";
                }
                action("Paye Scheule")
                {
                    ApplicationArea = All;
                    Caption = 'Paye Scheule';
                    Image = "Report";

                    RunObject = Report "prPaye Schedule mst";
                }

                action("NSSF Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'NSSF Schedule';
                    Image = "Report";

                    RunObject = Report "prNSSF mst";
                }
                action(Action1000000017)
                {
                    ApplicationArea = All;
                    Caption = 'Third Rule';
                    Image = AddWatch;
                    RunObject = Report "A third Rule Report";
                }

                action("payroll Journal Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;

                    RunObject = Report prPayrollJournalTransfer;
                }
                action("Casual Journal Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;

                    RunObject = Report "PRl-Casual Journal Transfer";
                }

            }
            action("mass update Transactions")
            {
                ApplicationArea = All;
                Caption = 'mass update Transactions';
                Image = PostBatch;

                // RunObject = Report "Mass Update Transactions";
            }
        }

    }
}

