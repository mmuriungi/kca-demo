page 51461 "Management Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout

    {

        area(rolecenter)
        {
            part(ApprovalsActivities; "Approvals Activities")
            {
                Caption = 'Approvals';
                ApplicationArea = Suite;
            }
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control21; "Finance Performance")
                {
                    ApplicationArea = All;
                }
                part(Control4; "Finance Performance")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }

            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control24; "Cash Flow Forecast Chart")
                {
                    ApplicationArea = All;
                }
                part(Control27; "Sales Performance")
                {
                    ApplicationArea = All;
                }
                part(Control28; "Sales Performance")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control29; "Report Inbox Part")
                {
                    ApplicationArea = All;
                }
                part(Control25; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1902476008; "My Vendors")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1905989608; "My Items")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
            group(Trasport)
            {
                ShowCaption = false;
                part(HOD; "Approvals Activities One")
                {
                    ApplicationArea = Suite;
                }
                part(TOFF; "Approvals Activities Two")
                {
                    ApplicationArea = Suite;
                }
                part(Registra; "Approvals Activities Three")
                {
                    ApplicationArea = Suite;
                }
            }

        }
    }

    actions
    {
        area(reporting)
        {
            Description = 'Reports';
            group(FinRep)
            {
                Caption = 'Financial Reports';
                Description = 'Financial Reports';
                Image = Ledger;
                group(Fin_Reports)
                {
                    Caption = 'Financial Reports';
                    Description = 'Financial Reports';
                    Image = Ledger;
                    action("Recei&vables-Payables")
                    {
                        Caption = 'Recei&vables-Payables';
                        Image = ReceivablesPayables;
                        RunObject = Report "Receivables-Payables";
                        ApplicationArea = All;
                    }
                    action("&Trial Balance/Budget")
                    {
                        Caption = '&Trial Balance/Budget';
                        Image = "Report";
                        RunObject = Report "Trial Balance/Budget";
                        ApplicationArea = All;
                    }
                    action("&Closing Trial Balance")
                    {
                        Caption = '&Closing Trial Balance';
                        Image = "Report";
                        ApplicationArea = All;
                        // RunObject = Report "Closing Trial BalanceX";
                    }
                    action("&Fiscal Year Balance")
                    {
                        Caption = '&Fiscal Year Balance';
                        Image = "Report";
                        RunObject = Report "Fiscal Year Balance";
                        ApplicationArea = All;
                    }
                    separator(Separator6)
                    {
                    }
                    action("Customer - &Balance")
                    {
                        Caption = 'Customer - &Balance';
                        Image = "Report";
                        RunObject = Report "Customer - Balance to Date";
                        ApplicationArea = All;
                    }
                    action("Customer - T&op 10 List")
                    {
                        Caption = 'Customer - T&op 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ApplicationArea = All;
                    }
                    action("Customer - S&ales List")
                    {
                        Caption = 'Customer - S&ales List';
                        Image = "Report";
                        RunObject = Report "Customer - Sales List";
                        ApplicationArea = All;
                    }
                    action("Customer Sales Statistics")
                    {
                        Caption = 'Customer Sales Statistics';
                        Image = "Report";
                        ApplicationArea = All;
                        // RunObject = Report "Customer Sales StatisticX";
                    }
                    separator(Separator11)
                    {
                    }
                    action("Vendor - &Purchase List")
                    {
                        Caption = 'Vendor - &Purchase List';
                        Image = "Report";
                        RunObject = Report "Vendor - Purchase List";
                        ApplicationArea = All;
                    }
                    action("Detailed Trial Balance")
                    {
                        Caption = 'Detailed Trial Balance';
                        RunObject = Report "Detail Trial Balance";
                        ApplicationArea = All;
                    }
                    action("Balance Sheet")
                    {
                        Caption = 'Balance Sheet';
                        RunObject = Report "Account Schedule";
                        ApplicationArea = All;
                    }
                    action("Dimension Details")
                    {
                        Caption = 'Dimension Details';
                        RunObject = Report "Dimensions - Detail";
                        ApplicationArea = All;
                    }
                    action("Trial Balance/Prev. Year")
                    {
                        Caption = 'Trial Balance/Prev. Year';
                        RunObject = Report "Trial Balance/Previous Year";
                        ApplicationArea = All;
                    }
                    action("Bank Ac. Detailed TB")
                    {
                        Caption = 'Bank Ac. Detailed TB';
                        RunObject = Report "Bank Acc. - Detail Trial Bal.";
                        ApplicationArea = All;
                    }
                    action("Inventory Valuation")
                    {
                        Caption = 'Inventory Valuation';
                        ApplicationArea = All;
                        // RunObject = Report "Inventory ValuationX";
                    }
                    separator("Ageing Reports")
                    {
                        Caption = 'Ageing Reports';
                    }
                    action("Customer Ageing Report")
                    {
                        Caption = 'Customer Ageing Report';
                        ApplicationArea = All;
                        //  RunObject = Report "Aged AccountX Receivable";
                    }
                    action("Vendor Ageing Balances")
                    {
                        Caption = 'Vendor Ageing Balances';
                        ApplicationArea = All;
                        // RunObject = Report "Aged AccountX Payable";
                    }
                }
            }
            group(FundsRep)
            {
                Caption = 'Funds Reports';
                Description = 'Funds Reports';
                Image = FiledPosted;
                group(Funds_Rep)
                {
                    Caption = 'Funds Reports';
                    Description = 'Funds Reports';
                    Image = FiledPosted;
                    action("Imprest Register")
                    {
                        Caption = 'Imprest Register';
                        ApplicationArea = All;
                        // RunObject = Report "Imprest Register1";
                    }
                    action("Claim Statement")
                    {
                        Caption = 'Claim Statement';
                        RunObject = Report Statement;
                        ApplicationArea = All;
                    }
                }
            }
            group(Admissions_Reps1)
            {
                Caption = 'Admissions Reports';
                Description = 'Admissions Reports';
                Image = Intrastat;
                group(Admissions_Reps)
                {
                    Caption = 'Admissions Reports';
                    Description = 'Admissions Reports';
                    Image = Intrastat;
                    action("Admissions Summary")
                    {
                        Caption = 'Admissions Summary';
                        Image = "Report";

                        RunObject = Report "KUCCPS & PSSP Admissions List";
                        ApplicationArea = All;
                    }
                    action("Admission By Program")
                    {
                        Caption = 'Admission By Program';
                        Image = "Report";

                        RunObject = Report "KUCCPS & PSSP Adm. By Program";
                        ApplicationArea = All;
                    }
                    action("Admission Summary 2")
                    {
                        Caption = 'Admission Summary 2';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report "PRL-Payroll Variance Report2";
                    }
                    action("New Applications")
                    {


                        RunObject = Report "Application List Academic New";
                        ApplicationArea = All;
                    }
                    action("Online Applications Report")
                    {
                        ApplicationArea = All;


                        // RunObject = Report Report50051;
                    }
                    action(Enquiries)
                    {


                        RunObject = Report "ACA-Enquiry List";
                        ApplicationArea = All;
                    }
                    action("Marketing Strategies Report")
                    {


                        RunObject = Report "ACA-Marketing Strategy";
                        ApplicationArea = All;
                    }
                    action("Direct Applications")
                    {


                        RunObject = Report "Direct Applications Form Reg";
                        ApplicationArea = All;
                    }
                    action("Pending Applications")
                    {


                        RunObject = Report "Application List Academic New";
                        ApplicationArea = All;
                    }
                    action("Application Summary")
                    {


                        RunObject = Report "Application Summary";
                        ApplicationArea = All;
                    }
                    action("Applicant Shortlisting (Summary)")
                    {


                        RunObject = Report "Shortlisted Students Summary";
                        ApplicationArea = All;
                    }
                    action("Applicant Shortlisting (Detailed)")
                    {


                        RunObject = Report "Shortlisted Students Status";
                        ApplicationArea = All;
                    }
                }
            }
            group(Acad_Reports1)
            {
                Caption = 'Academic Reports';
                Description = 'Academic Reports';
                Image = Departments;
                group(Acad_Reports)
                {
                    Caption = 'Academic Reports';
                    Description = 'Academic Reports';
                    Image = Departments;
                    action("All Students")
                    {
                        Image = Report2;
                        RunObject = Report "All Students";
                        ApplicationArea = All;
                    }
                    action("Norminal Roll")
                    {
                        Caption = 'Norminal Roll';
                        Image = Report2;
                        RunObject = Report "Norminal Roll (Cont. Students)";
                        ApplicationArea = All;
                    }
                    action("Class List (By Stage)")
                    {
                        Caption = 'Class List (By Stage)';
                        Image = List;

                        RunObject = Report "ACA-Class List (List By Stage)";
                        ApplicationArea = All;
                    }
                    action("Signed Norminal Roll")
                    {
                        Caption = 'Signed Norminal Roll';
                        Image = Report2;

                        RunObject = Report "Signed Norminal Role";
                        ApplicationArea = All;
                    }
                    action("Program List By Gender && Type")
                    {
                        Caption = 'Program List By Gender && Type';
                        Image = PrintReport;

                        RunObject = Report "Pop. By Prog./Gender/Settl.";
                        ApplicationArea = All;
                    }
                    action("population By Faculty")
                    {
                        Caption = 'population By Faculty';
                        Image = PrintExcise;

                        RunObject = Report "Population By Faculty";
                        ApplicationArea = All;
                    }
                    action("Multiple Record")
                    {
                        Caption = 'Multiple Record';
                        Image = Report2;
                        ApplicationArea = All;
                        ///RunObject = Report "Multiple Student Records";
                    }
                    action("Classification By Campus")
                    {
                        Caption = 'Classification By Campus';
                        Image = Report2;
                        RunObject = Report "Population Class By Campus";
                        ApplicationArea = All;
                    }
                    action("Population By Campus")
                    {
                        Caption = 'Population By Campus';
                        Image = Report2;
                        RunObject = Report "Population By Campus";
                        ApplicationArea = All;
                    }
                    action("Population by Programme")
                    {
                        Caption = 'Population by Programme';
                        Image = Report2;
                        RunObject = Report "Population By Programme";
                        ApplicationArea = All;
                    }
                    action("Prog. Category")
                    {
                        Caption = 'Prog. Category';
                        Image = Report2;
                        RunObject = Report "Population By Prog. Category";
                        ApplicationArea = All;
                    }
                    action("List By Programme")
                    {
                        Caption = 'List By Programme';
                        Image = Receipt;
                        RunObject = Report "List By Programme";
                        ApplicationArea = All;
                    }
                    action("List By Programme (With Balances)")
                    {
                        Caption = 'List By Programme (With Balances)';
                        Image = PrintReport;

                        RunObject = Report "ACA-List By Prog.(Balances)";
                        ApplicationArea = All;
                    }
                    action("Type. Study Mode, & Gender")
                    {
                        Caption = 'Type. Study Mode, & Gender';

                        RunObject = Report "Stud Type, Study Mode & Gende";
                        ApplicationArea = All;
                    }
                    action("Study Mode & Gender")
                    {
                        Caption = 'Study Mode & Gender';

                        RunObject = Report "List By Study Mode & Gender";
                        ApplicationArea = All;
                    }
                    action("County & Gender")
                    {
                        Caption = 'County & Gender';

                        RunObject = Report "List By County & Gender";
                        ApplicationArea = All;
                    }
                    action("List By County")
                    {
                        Caption = 'List By County';

                        RunObject = Report "List By County";
                        ApplicationArea = All;
                    }
                    action("Prog. Units")
                    {
                        Caption = 'Prog. Units';

                        RunObject = Report "Programme Units";
                        ApplicationArea = All;
                    }
                    action("Enrollment By Stage")
                    {
                        Caption = 'Enrollment By Stage';
                        Image = Report2;
                        RunObject = Report "Enrollment by Stage";
                        ApplicationArea = All;
                    }
                    action("Import Units")
                    {
                        Caption = 'Import Units';
                        Image = ImportExcel;

                        RunObject = Page "ACA-Prog. Units Buffer";
                        ApplicationArea = All;
                    }
                    action("Hostel Allocations")
                    {
                        Caption = 'Hostel Allocations';
                        Image = PrintCover;
                        ApplicationArea = All;

                        // RunObject = Report "Hostel Allocations";
                    }
                    action("Students List (By Program)")
                    {
                        Caption = 'Students List (By Program)';
                        Image = "Report";

                        RunObject = Report "ACA-Norminal Roll (New Stud)";
                        ApplicationArea = All;
                    }
                    action("Programme Units")
                    {
                        Caption = 'Programme Units';


                        RunObject = Report "Programme Units";
                        ApplicationArea = All;
                    }
                }
            }
            group("Students Finance Reports1")
            {
                Description = 'Students Finance Reports';
                Image = Statistics;
                group("Students Finance Reports")
                {
                    Description = 'Students Finance Reports';
                    Image = Statistics;
                    action("Students Balances")
                    {
                        Image = PrintInstallment;

                        RunObject = Report "Student Balances";
                        ApplicationArea = All;
                    }
                    action("Per Programme Balances")
                    {
                        Image = PrintInstallment;

                        RunObject = Report "Summary Enrollment - Programme";
                        ApplicationArea = All;
                    }
                    action("Per Stage Balances")
                    {
                        Image = PrintInstallment;
                        RunObject = Report "Summary Enrollment - Stage";
                        ApplicationArea = All;
                    }
                    action("Students Faculty Income Summary")
                    {
                        Image = PrintInstallment;
                        RunObject = Report "Students Revenue Summary";
                        ApplicationArea = All;
                    }
                    action("Student Invoices Per Charge")
                    {
                        Caption = 'Student Invoices Per Charge';
                        Image = PrintInstallment;
                        ApplicationArea = All;

                        //RunObject = Report "Student Inv. And Payments";
                    }
                    action("Fee Structure Report")
                    {
                        Caption = 'Fee Structure Report';
                        Image = "Report";
                        RunObject = Report "Fee Structure Summary Report";
                        ApplicationArea = All;
                    }
                    action("Student Receipts per Charge")
                    {
                        Caption = 'Student Receipts per Charge';
                        Image = PrintReport;

                        RunObject = Report "Student Receipts per Charge";
                        ApplicationArea = All;
                    }
                }
            }
            group(Exams_Reports1)
            {
                Caption = 'Examination Reports';
                Description = 'Examination Reports';
                Image = ExecuteBatch;
                group(Exams_Reports)
                {
                    Caption = 'Examination Reports';
                    Description = 'Examination Reports';
                    Image = ExecuteBatch;
                    action("Course Loading")
                    {
                        Caption = 'Course Loading';
                        Image = LineDiscount;

                        RunObject = Report "Lecturer Course Loading";
                        ApplicationArea = All;
                    }
                    action("Examination Cards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;
                        ApplicationArea = All;

                        // RunObject = Report "Exam Card Final";
                    }
                    action("Exam Card Stickers")
                    {
                        Caption = 'Exam Card Stickers';
                        Image = Split;
                        ApplicationArea = All;

                        //RunObject = Report "Exam Card Stickers";
                    }
                    action("Consolidated Marksheet")
                    {
                        Caption = 'Consolidated Marksheet';
                        Image = Completed;

                        RunObject = Report "Sems. Consolidated Marksheet";
                        ApplicationArea = All;
                    }
                    action("Consolidated Marksheet 2")
                    {
                        Caption = 'Consolidated Marksheet 2';
                        Image = CompleteLine;

                        RunObject = Report "Final Consolidated Marksheet";
                        ApplicationArea = All;
                    }
                    action("Consolidated Marksheet 3")
                    {
                        Caption = 'Consolidated Marksheet 3';
                        RunObject = Report "Consolidated Marksheet 2";
                        ApplicationArea = All;
                    }
                    action(Attendance_Checklist)
                    {
                        Caption = 'Attendance Checklist';
                        RunObject = Report "Exam Attendance Checklist2";
                        ApplicationArea = All;
                    }
                    action("Class Grade Sheet")
                    {
                        Caption = 'Class Grade Sheet';
                        Image = CheckDuplicates;
                        ApplicationArea = All;

                        //RunObject = Report "ACA-Class Roster Grade Sheet";
                    }
                    action("Consolidated Gradesheet")
                    {
                        Caption = 'Consolidated Gradesheet';
                        Image = CheckDuplicates;

                        RunObject = Report "ACA-Consolidated Gradesheet";
                        ApplicationArea = All;
                    }
                    action("Official College Transcript")
                    {
                        Caption = 'Official College Transcript';
                        Image = FixedAssets;

                        RunObject = Report "Provisional College Transcript";
                        ApplicationArea = All;
                    }
                    action("Official College Resultslip")
                    {
                        Caption = 'Official College Resultslip';
                        Image = Split;

                        RunObject = Report "Official College Transcript";
                        ApplicationArea = All;
                    }
                    action("Resultslip 2")
                    {
                        Caption = 'Resultslip 2';
                        Image = CheckList;
                        ApplicationArea = All;

                        //RunObject = Report "Provisional Transcript Duplica";
                    }
                    action("Resultslip 3")
                    {
                        Caption = 'Resultslip 3';
                        Image = CheckJournal;
                        ApplicationArea = All;

                        // RunObject = Report "Official University Resultslip";
                    }
                }
            }
            group(Cafe_Man1)
            {
                Caption = 'Cafeteria Reports';
                Description = 'Cafeteria Reports';
                Image = CashFlow;
                group(Cafe_Man)
                {
                    Caption = 'Cafeteria Reports';
                    Description = 'Cafeteria Reports';
                    Image = CashFlow;
                    action("Receipts Register")
                    {
                        Caption = 'Receipts Register';
                        Image = Report2;
                        ApplicationArea = All;

                        // RunObject = Report "CAT-Sales Register";
                    }
                    action("Daily Summary Saless")
                    {
                        Caption = 'Daily Summary Saless';
                        Image = Report2;
                        ApplicationArea = All;

                        // RunObject = Report "CAT-Catering Daily Sum. Saless";
                    }
                    action("Daily Sales Summary")
                    {
                        Caption = 'Daily Sales Summary';
                        Image = Report2;
                        ApplicationArea = All;

                        // RunObject = Report "CAT-Daily Sales Summary (All)";
                    }
                    action("Cafe Revenue Report")
                    {
                        Caption = 'Cafe Revenue Report';
                        Image = Report2;
                        ApplicationArea = All;

                        // RunObject = Report "CAT-Cafe Revenue Reports";
                    }
                    action("Sales Summary")
                    {
                        Caption = 'Sales Summary';
                        Image = Report2;
                        ApplicationArea = All;

                        //RunObject = Report "CAT-Daily Sales Summary (Std)";
                    }
                    action("Cafe` Menu")
                    {
                        Caption = 'Cafe` Menu';
                        Image = Report2;
                        ApplicationArea = All;

                        //RunObject = Report "CAT-Cafeteria Menu";
                    }
                }
            }
            group(Host_Reps1)
            {
                Caption = 'Hostel Reports';
                Description = 'Hostel Reports';
                Image = Alerts;
                group(Host_Reps)
                {
                    Caption = 'Hostel Reports';
                    Description = 'Hostel Reports';
                    Image = Alerts;
                    action("Hostel Status Summary Report")
                    {
                        Caption = 'Hostel Status Summary Report';
                        Image = Status;
                        ApplicationArea = All;


                        //  RunObject = Report "Hostel Status Summary Report";
                    }
                    action("AlloCation Analysis")
                    {
                        Caption = 'AlloCation Analysis';
                        Image = Interaction;
                        ApplicationArea = All;

                        //RunObject = Report "Hostel Status Summary Graph";
                    }
                    action("Incidents Report")
                    {
                        Caption = 'Incidents Report';
                        Image = Register;
                        ApplicationArea = All;


                        // RunObject = Report "Hostel Incidents Report";
                    }
                    action(Action1000000133)
                    {
                        Caption = 'Hostel Allocations';
                        Image = Allocations;
                        ApplicationArea = All;


                        //RunObject = Report "Hostel Allocations Per Block";
                    }
                    action("Detailled Allocations")
                    {
                        Caption = 'Detailled Allocations';
                        Image = AllocatedCapacity;
                        ApplicationArea = All;


                        /// RunObject = Report "Hostel Allo. Per Room/Block";
                    }
                    action("Room Status")
                    {
                        Caption = 'Room Status';
                        Image = Status;
                        ApplicationArea = All;


                        // RunObject = Report "Hostel Vaccant Per Room/Block";
                    }
                    action("Allocations List")
                    {
                        Caption = 'Allocations List';
                        Image = Allocate;
                        ApplicationArea = All;


                        // RunObject = Report "Hostel Allo. Per Room (Det.)";
                    }
                }
            }
            group(HR_Rep1)
            {
                Caption = 'HR Reports';
                Description = 'HR Reports';
                Image = AdministrationSalesPurchases;
                group(HR_Rep)
                {
                    Caption = 'HR Reports';
                    Description = 'HR Reports';
                    Image = AdministrationSalesPurchases;
                    action("Employee List")
                    {
                        Caption = 'Employee List';
                        Image = "Report";

                        RunObject = Report "HR Employee List";
                        ApplicationArea = All;
                    }
                    action("Employee Beneficiaries")
                    {
                        Caption = 'Employee Beneficiaries';
                        Image = "Report";

                        RunObject = Report "HR Employee Beneficiaries";
                        ApplicationArea = All;
                    }
                    action("Commission Report")
                    {
                        Caption = 'Commission Report';
                        Image = Report2;
                        ApplicationArea = All;

                        //RunObject = Report "HRM-Commission For Univ. Rep.";
                    }
                    action("Leave Balances")
                    {
                        Image = Balance;

                        RunObject = Report "Employee Leaves";
                        ApplicationArea = All;
                    }
                    action("Leave Transactions")
                    {
                        Image = Translation;

                        RunObject = Report "Standard Leave Balance Report";
                        ApplicationArea = All;
                    }
                    action("Leave Statement")
                    {
                        Image = LedgerEntries;

                        RunObject = Report "HR Leave Statement";
                        ApplicationArea = All;
                    }
                    action("Employee By Tribe")
                    {
                        Caption = 'Employee By Tribe';
                        Image = DepositLines;
                        ApplicationArea = All;

                        //RunObject = Report "Employee Distribution by Tribe";
                    }
                    action("Employee CV Sunmmary")
                    {
                        Caption = 'Employee CV Sunmmary';
                        Image = SuggestGrid;

                        RunObject = Report "Employee Details Summary";
                        ApplicationArea = All;
                    }
                }
            }
            group(Payroll_Reps1)
            {
                Caption = 'Payroll Reports';
                Description = 'Payroll Reports';
                Image = Administration;
                group(Payroll_Reps)
                {
                    Caption = 'Payroll Reports';
                    Description = 'Payroll Reports';
                    Image = Administration;
                    action("vew payslip")
                    {
                        Caption = 'view payslip';

                        RunObject = Report "PRL-Payslips V 1.1.1";
                        ApplicationArea = All;
                    }
                    action("P9 Report")
                    {
                        Caption = 'P9 Report';
                        Image = PrintForm;

                        RunObject = Report "P9 Report (Final)";
                        ApplicationArea = All;
                    }
                    action("bank Schedule")
                    {
                        Caption = 'bank Schedule';

                        RunObject = Report "pr Bank Schedule";
                        ApplicationArea = All;
                    }
                    action("Master Payroll Summary")
                    {
                        Caption = 'Master Payroll Summary';

                        RunObject = Report "PRL-Company Payroll Summary 3";
                        ApplicationArea = All;
                    }
                    action("Payroll summary")
                    {
                        Caption = 'Payroll summary';

                        RunObject = Report "PRL-Company Payroll Summary 3";
                        ApplicationArea = All;
                    }
                    action("Deductions Summary")
                    {
                        Caption = 'Deductions Summary';
                        ApplicationArea = All;

                        // RunObject = Report "PRL-Deductions Summary";
                    }
                    action("Earnings Summary")
                    {
                        Caption = 'Earnings Summary';
                        Image = DepositSlip;
                        ApplicationArea = All;
                        //RunObject = Report "PRL-Earnings Summary";
                    }
                    action("Deductions Summary 2")
                    {
                        Caption = 'Deductions Summary 2';
                        ApplicationArea = All;

                        // RunObject = Report "PRL-Deductions Summary 2";
                    }
                    action("Earnings Summary 2")
                    {
                        Caption = 'Earnings Summary 2';
                        ApplicationArea = All;

                        // RunObject = Report "PRL-Payments Summary 2";
                    }
                    action("Staff pension")
                    {
                        Caption = 'Staff pension';
                        Image = Aging;
                        RunObject = Report "prStaff Pension Contrib";
                        ApplicationArea = All;
                    }
                    action("Gross Netpay")
                    {
                        Caption = 'Gross Netpay';
                        Image = Giro;
                        RunObject = Report prGrossNetPay;
                        ApplicationArea = All;
                    }
                    action("Employer Certificate")
                    {
                        Caption = 'Employer Certificate';

                        RunObject = Report "Employer Certificate P.10 mst";
                        ApplicationArea = All;
                    }
                    action("P.10")
                    {
                        Caption = 'P.10';

                        RunObject = Report "P.10 A mst";
                        ApplicationArea = All;
                    }
                    action("Paye Scheule")
                    {
                        Caption = 'Paye Scheule';

                        RunObject = Report "prPaye Schedule mst";
                        ApplicationArea = All;
                    }
                    action("NHIF Schedult")
                    {
                        Caption = 'NHIF Schedult';
                        ApplicationArea = All;

                        // RunObject = Report "prNHIF mst";
                    }
                    action("NSSF Schedule")
                    {
                        Caption = 'NSSF Schedule';

                        RunObject = Report "prNSSF mst";
                        ApplicationArea = All;
                    }
                    action("Third Rule")
                    {
                        Caption = 'Third Rule';
                        Image = AddWatch;
                        RunObject = Report "A third Rule Report";
                        ApplicationArea = All;
                    }
                    action("Co_op Remittance")
                    {
                        Caption = 'Co_op Remittance';
                        Image = CreateForm;
                        RunObject = Report "prCoop remmitance";
                        ApplicationArea = All;
                    }
                    action("payroll Journal Transfer")
                    {
                        Caption = 'payroll Journal Transfer';
                        Image = Journals;
                        ApplicationArea = All;

                        // RunObject = Report prPayrollJournalTransfer;
                    }
                    action("mass update Transactions")
                    {
                        Caption = 'mass update Transactions';
                        Image = PostBatch;
                        ApplicationArea = All;

                        //RunObject = Report "Mass Update Transactions";
                    }
                }
            }
        }
        area(embedding)
        {
            action("<Page FIN-Posted Interbank Trans1")
            {
                Caption = 'Posted Intetrbank Transfers';
                ApplicationArea = All;
                //RunObject = Page "FIN-Posted Interbank Trans.";
            }
            action("<Page FIN-Posted Receipts list1>")
            {
                Caption = 'Posted Receipts';
                RunObject = Page "FIN-Posted Receipts list";
                ApplicationArea = All;
            }
            action("Posted PVs")
            {
                Caption = 'Posted PVs';
                RunObject = Page "FIN-Posted Payment Vouch.";
                ApplicationArea = All;
            }
            action("Posted Imprest")
            {
                Caption = 'Posted Imprest';
                RunObject = Page "FIN-Posted imprest list";
                ApplicationArea = All;
            }
            action("Posted Imp. Surrender")
            {
                Caption = 'Posted Imp. Surrender';
                RunObject = Page "FIN-Posted Travel Advs. Acc.";
                ApplicationArea = All;
            }
            action("Poste Staff Advance")
            {
                Caption = 'Poste Staff Advance';
                ApplicationArea = All;
                // RunObject = Page "FIN-Posted Staff Advance List";
            }
            action("Posted Advance Retiring")
            {
                Caption = 'Posted Advance Retiring';
                ApplicationArea = All;
                // RunObject = Page "FIN-Posted staff Advance Surr.";
            }
            action("Account Schedules")
            {
                Caption = 'Account Schedules';
                RunObject = Page "Account Schedule Names";
                ApplicationArea = All;
            }
            action("Analysis by Dimensions")
            {
                Caption = 'Analysis by Dimensions';
                Image = AnalysisViewDimension;
                RunObject = Page "Analysis View List";
                ApplicationArea = All;
            }
            action("Sales Analysis Report")
            {
                Caption = 'Sales Analysis Report';
                RunObject = Page "Analysis Report Sale";
                RunPageView = WHERE("Analysis Area" = FILTER(Sales));
                ApplicationArea = All;
            }
            action(Budgets)
            {
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
                ApplicationArea = All;
            }
            action("Sales Budgets")
            {
                Caption = 'Sales Budgets';
                RunObject = Page "Item Budget Names";
                RunPageView = WHERE("Analysis Area" = FILTER(Sales));
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action(Contacts)
            {
                Caption = 'Contacts';
                Image = CustomerContact;
                RunObject = Page "Contact List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            Description = 'Management Menu Items';
            group(Financial_Management)
            {
                Caption = 'Financial Management';
                Description = 'Financial Management';
                Image = ResourcePlanning;
                action("Accounts/Votes")
                {
                    Caption = 'Accounts/Votes';
                    RunObject = Page "Chart of Accounts";
                    ApplicationArea = All;
                }
                action(Budget)
                {
                    Caption = 'Budget';
                    RunObject = Page "G/L Budget Names";
                    ApplicationArea = All;
                }
                action(A_C_Categories)
                {
                    Caption = 'Account Categories';
                    RunObject = Page "G/L Budget Names";
                    ApplicationArea = All;
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    RunObject = Page "Bank Account List";
                    ApplicationArea = All;
                }
                action(Custo)
                {
                    Caption = 'Customers';
                    RunObject = Page "Bank Account List";
                    ApplicationArea = All;
                }
                action("Vendor/Suppliers")
                {
                    Caption = 'Vendor/Suppliers';
                    RunObject = Page "Bank Account List";
                    ApplicationArea = All;
                }
                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = All;
                }

                action("Posted Shipments")
                {
                    Caption = 'Posted Shipments';
                    RunObject = Page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Receipt returns")
                {
                    Caption = 'Posted Receipt returns';
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = All;
                }
                action("Posted Sales Credir memos")
                {
                    Caption = 'Posted Sales Credir memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = All;
                }

                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }

                action("FA Register")
                {
                    Caption = 'FA Register';
                    RunObject = Page "FA Registers";
                    ApplicationArea = All;
                }
                action("Insurance Register")
                {
                    Caption = 'Insurance Register';
                    RunObject = Page "Insurance Registers";
                    ApplicationArea = All;
                }
                action("Maintenance Register")
                {
                    Caption = 'Maintenance Register';
                    RunObject = Page "Maintenance Ledger Entries";
                    ApplicationArea = All;
                }
            }
            group(Funds_Man)
            {
                Caption = 'Funds Management';
                Description = 'Funds Management';
                Image = ReferenceData;
                action("Posted Inter-Bank Transfer")
                {
                    Caption = 'Posted Inter-Bank Transfer';
                    ApplicationArea = All;
                    //RunObject = Page "FIN-Posted Interbank Trans.";
                }
                action("Posted Receipts")
                {
                    Caption = 'Posted Receipts';
                    RunObject = Page "FIN-Posted Receipts list";
                    ApplicationArea = All;
                }
                action(Action1000000111)
                {
                    Caption = 'Posted PVs';
                    RunObject = Page "FIN-Posted Payment Vouch.";
                    ApplicationArea = All;
                }
                action(Action1000000112)
                {
                    Caption = 'Posted Imprest';
                    RunObject = Page "FIN-Posted imprest list";
                    ApplicationArea = All;
                }
                action(Action1000000113)
                {
                    Caption = 'Posted Imp. Surrender';
                    RunObject = Page "FIN-Posted Travel Advs. Acc.";
                    ApplicationArea = All;
                }
                action(Action1000000114)
                {
                    Caption = 'Poste Staff Advance';
                    ApplicationArea = All;
                    //RunObject = Page "FIN-Posted Staff Advance List";
                }
                action(Action1000000115)
                {
                    Caption = 'Posted Advance Retiring';
                    ApplicationArea = All;
                    //RunObject = Page "FIN-Posted staff Advance Surr.";
                }
            }
            group(Admissions)
            {
                Caption = 'Student Applications';
                Description = 'Student Applications';
                Image = LotInfo;
                action("Enquiry list")
                {
                    Caption = 'Enquiry list';
                    RunObject = Page "ACA-Enquiry List";
                    ApplicationArea = All;
                }
                action("Import Jab Admissions")
                {
                    Caption = 'Import Jab Admissions';
                    RunObject = Page "KUCCPS Imports";
                    ApplicationArea = All;
                }
                action("Processed Jab Admissions")
                {
                    Caption = 'Processed Jab Admissions';
                    RunObject = Page "ACA-Processed GOK Admn Buffer";
                    ApplicationArea = All;
                }
                action("<Page ACA-Print Admn Letter SSP")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page "ACA-Print Admn Letter SSP/DIP";
                    ApplicationArea = All;
                }
            }
            group(Student_Man)
            {
                Caption = 'Student Management';
                Description = 'Student Management';
                Image = Receivables;
                action(Registration)
                {
                    Image = Register;


                    RunObject = Page "ACA-Std Registration List";
                    ApplicationArea = All;
                }
                action(Cleared)
                {
                    Caption = 'Student Clearance(Cleared)';
                    RunObject = Page "ACA-Student Clearance(Cleared)";
                    ApplicationArea = All;
                }
                action(AllumniList)
                {
                    Caption = 'Student Aluminae List';
                    RunObject = Page "ACA-Student Aluminae List";
                    ApplicationArea = All;
                }
            }
            group(Exams)
            {
                Caption = 'Exams Management';
                Description = 'Exams Management';
                Image = SNInfo;
                action("Programmes List")
                {
                    Caption = 'Programmes List';
                    Image = FixedAssets;
                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action("Grading System")
                {
                    Caption = 'Grading System';
                    Image = SetupColumns;

                    RunObject = Page "ACA-Grading Sys. Header";
                    ApplicationArea = All;
                }
                action(Examiners)
                {
                    Caption = 'Examiners';
                    Image = HRSetup;

                    RunObject = Page "ACA-Examiners List";
                    ApplicationArea = All;
                }
            }
            group(Cafeteria_Management)
            {
                Caption = 'Cafeteria Management';
                Description = 'Cafeteria Management';
                Image = CostAccounting;
                action("Receipts (Cancelled)")
                {
                    Caption = 'Receipts (Cancelled)';
                    ApplicationArea = All;
                    // RunObject = Page "CAT-Cancelled Cafeteria Recpts";
                }
                action("Receipts (Posted)")
                {
                    Caption = 'Receipts (Posted)';
                    ApplicationArea = All;
                    //RunObject = Page "CAT-Posted Cafeteria Receipts";
                }
            }
            group(Hostel_Management)
            {
                Caption = 'Hostel Management';
                Description = 'Hostel Management';
                Image = Marketing;
                action("Allocation (Uncleared)")
                {
                    Caption = 'Allocation (Uncleared)';
                    ApplicationArea = All;
                    //RunObject = Page "ACAHostel Bookings (All. List)";
                }
                action("Allocation History (Cleared)")
                {
                    Caption = 'Allocation History (Cleared)';
                    Image = Invoice;
                    ApplicationArea = All;

                    // RunObject = Page "ACA-Hostel Bookings (History)";
                }
            }
            group(HRM)
            {
                Caption = 'Human Resources Man.';
                Description = 'Human Resources Man.';
                Image = HumanResources;
                action(Action1000000158)
                {
                    Caption = 'Employee List';
                    RunObject = Page "HRM-Employee List";
                    ApplicationArea = All;
                }
                action("Posted Leaves")
                {
                    Caption = 'Posted Leaves';
                    RunObject = Page "HRM-Leave Requisition Posted";
                    ApplicationArea = All;
                }
                action("Employee Requisitions")
                {
                    Caption = 'Employee Requisitions';
                    Image = ApplicationWorksheet;


                    RunObject = Page "HRM-Employee Requisitions List";
                    ApplicationArea = All;
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll management';
                Description = 'Payroll management';
                Image = HRSetup;
                action("Salary Card")
                {
                    Caption = 'Salary Card';
                    Image = Employee;

                    RunObject = Page "HRM-Employee-List";
                    ApplicationArea = All;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Description = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
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

                Image = FixedAssets;
                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                    ApplicationArea = All;
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprests List";
                    ApplicationArea = All;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                    ApplicationArea = All;
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                    ApplicationArea = All;
                }
                action("File Requisitions")
                {
                    Image = Register;

                    RunObject = Page "REG-File Requisition List";
                    ApplicationArea = All;
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
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
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

