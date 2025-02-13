page 51448 "PRL-Payroll Role Center"
{
    Caption = ' Payroll Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part(Control1902899408; "PRL-Emp. Cue (Payroll)")
            {
                ApplicationArea = All;
            }
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

            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = All;
                }
                part(Control1; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

        area(reporting)
        {

            group(Reports2)
            {
                Caption = 'Payroll Reports';
                Image = Payables;
                action(Action1000000038)
                {
                    ApplicationArea = all;
                    Caption = 'P9 Report';
                    Image = PrintForm;

                    RunObject = Report "P9 Report (Final)";
                }
                action(Action1000000037)
                {
                    ApplicationArea = all;
                    Caption = 'Transactions';
                    Image = "Report";

                    RunObject = Report "pr Transactions";
                }
                action(Action1000000040)
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = Giro;
                    RunObject = Report prGrossNetPay;
                }
                action(Action1000000035)
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";

                    RunObject = Report "PRL-Bank Schedule";
                    Visible = false;
                }
                action("Employer Certificate")
                {

                    Caption = 'Employer Certificate';
                    Image = "Report";

                    RunObject = Report "Employer Certificate P.10 mst";
                    ApplicationArea = All;
                }
                action("Payroll Analysis")
                {
                    Caption = 'Payroll Analysis Report';
                    Image = "Report";
                    RunObject = report "Payroll Analysis Report";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("PR Payroll Summary - Detailed")
                {
                    ApplicationArea = all;
                    Caption = 'PR Payroll Summary - Detailed';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "PR Payroll Summary - Detailed";
                }
                action("Payroll Variance Report")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Variance Report';
                    Image = Report;
                    RunObject = Report "Payroll Variance Report Ext";
                }
                action("PR Trans  Variance Analysis")
                {
                    ApplicationArea = all;
                    Caption = 'PR Trans  Variance Analysis';
                    Image = "Report";
                    RunObject = Report "PR Trans  Variance Analysis";
                }
                action("P.10")
                {
                    ApplicationArea = all;
                    Caption = 'P.10';
                    Image = "Report";

                    RunObject = Report "P.10 A mst";
                }
                action("Paye Scheule")
                {
                    ApplicationArea = all;
                    Caption = 'PAYE Schedule';
                    Image = "Report";

                    RunObject = Report "prPaye Schedule 1a";
                }
                action("NHIF Scheule")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Schedule';
                    Image = "Report";

                    RunObject = Report "NHIF Schedule Report";
                }
                action("NSSF Scheule")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Schedule';
                    Image = "Report";

                    RunObject = Report "NSSF Schedule Report";
                }
                action("NHIF Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Schedule';
                    Image = "Report";

                    //RunObject = Report "prNHIF mst";
                }
                action("NSSF Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Schedule';
                    Image = "Report";

                    RunObject = Report "prNSSF mst";
                    Visible = false;
                }
                action(Action1000000029)
                {
                    ApplicationArea = all;
                    Caption = 'Third Rule';
                    Image = AddWatch;
                    RunObject = Report "A third Rule Report";
                }
                action(Action1000000028)
                {

                    Caption = 'Co_op Remittance';
                    Image = CreateForm;
                    ApplicationArea = All;
                    //todo  RunObject = Report "prCoop remmitance";
                }
                action("payroll Journal Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;

                    //todo RunObject = Report prPayrollJournalTransfer;
                }
                action("mass update Transactions")
                {
                    ApplicationArea = all;
                    Caption = 'mass update Transactions';
                    Image = PostBatch;

                    //todo  RunObject = Report "Mass Update Transactions";
                }
                action("Pension Report")
                {
                    ApplicationArea = all;
                    Caption = 'Pension Report';
                    Image = PrintForm;

                    RunObject = Report "PRL-Pension Report";
                }
                action("Bank Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Schedule';
                    Image = "Report";

                    RunObject = Report "PRL-Bank Schedule";
                }
                action("NHIF Report")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Report';
                    Image = "Report";

                    RunObject = Report "PRL-NHIF Report";
                }
                action("SACCO Report")
                {
                    ApplicationArea = all;
                    Caption = 'SACCO Report';
                    Image = "Report";

                    RunObject = Report "PRL-Welfare Report";
                }
                action("HELB Report")
                {
                    ApplicationArea = all;
                    Caption = 'HELB Report';
                    Image = "Report";

                    RunObject = Report "PRL-HELB Report";
                }
                action("NSSF Report (A)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (A)';
                    Image = "Report";

                    RunObject = Report "PRL-NSSF Report (A)";
                }
                action("NSSF Report (B)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (B)';
                    Image = "Report";

                    RunObject = Report "PRL-NSSF Report (B)";
                    Visible = false;
                }
                action("NSSF Report (Combined)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (Combined)';
                    Image = "Report";

                    RunObject = Report "PRL-NSSF Report Combined";
                    Visible = true;
                }

                action("Individual Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Individual Payslip';
                    Image = Report2;

                    RunObject = Report "IndividualPayslipsV113";
                    Visible = false;
                }
                action("Individual Payslip 2")
                {
                    ApplicationArea = all;
                    Caption = 'Individual Payslip 2';
                    Image = Report2;

                    RunObject = Report "IndividualPayslipsV113";
                    Visible = false;
                }
                action("Detailed Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Master Payroll ';
                    Image = Report2;

                    RunObject = Report "Payroll Summary 3";
                }

                action("Departmental Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Departmental Summary';
                    Image = "Report";

                    RunObject = Report "Detailed Payrol Summary/Dept";
                }

                action(Action1000000047)
                {
                    ApplicationArea = all;
                    Caption = 'Company Payslip';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                action("Company Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Company Payslip 2';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payslip";
                    Visible = false;
                }

                action(Action1000000044)
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = DepositSlip;
                    RunObject = Report "PRL-Earnings Summary 5";
                }

                action(Action1000000043)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Deductions Summary 2 a";
                }
                action(Action1000000045)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = Report;
                    RunObject = Report "PRL-Deductions Summary1";
                    Visible = false;
                }
                action(Action1000000041)
                {
                    ApplicationArea = all;
                    Caption = 'Staff pension';
                    Image = Aging;
                    RunObject = Report "prStaff Pension Contrib";
                }
                action(Payslips)
                {
                    ApplicationArea = all;
                    Caption = 'Payslips';
                    Image = Report;

                    RunObject = Report "IndividualPayslipsV113";
                }
                /* action(payrollvariace)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll variance';
                    Image = Aging;
                    RunObject = Report "Payroll Variance Report 2";
                }
                action(payrollvar2)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Variance 2';
                    Image = Aging;
                    RunObject = Report "Payroll Variance Report";
                } */
                action("Master Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = ' Payroll deduction Summary';
                    Image = Report;

                    RunObject = Report "PRL-Deductions Summary1";
                    Visible = false;
                }
                action("Payroll Summary2")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payroll Summary 3";
                    Visible = false;
                }
                action("Deductions Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "PRL-Deductions Summary 2 a";
                }
                action("Earnings Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "PRL-Earnings Summary 5";
                }
                action("view payslip")
                {
                    ApplicationArea = all;
                    Caption = 'view payslip';
                    Image = "Report";

                    RunObject = Report "PRL-Payslips V 1.1.1";
                }
                action("Payroll summary")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll summary';
                    Image = "Report";

                   // RunObject = Report "Payroll Summary 3";
                    RunObject = Report "Payroll Summary Ext";
                }
                action("Deductions Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "PRL-Deductions Summary1";
                }
                action("Earnings Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "PRL-Earnings Summary 5";
                }
                action("Staff pension")
                {
                    ApplicationArea = all;
                    Caption = 'Staff pension';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "prStaff Pension Contrib";
                }
                action("Gross Netpay")
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = "Report";
                    RunObject = Report prGrossNetPay;
                    Visible = false;
                }
                action("Third Rule")
                {
                    Caption = 'Third Rule';
                    Image = "Report";
                    RunObject = Report "A third Rule Report Two";
                    ApplicationArea = All;
                    Visible = false;
                }
                action("P9 Report")
                {
                    ApplicationArea = all;
                    Caption = 'P9 Report';
                    Image = PrintForm;
                    Visible = false;
                    RunObject = Report "P9 Report (Final)";
                }

                action("bank Schedule2")
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";
                    RunObject = Report "pr Bank Schedule";
                    Visible = false;
                }
                action("Co-op Remittance")
                {
                    ApplicationArea = All;
                    Caption = 'Co-op Remittance';
                    Image = Report;
                    RunObject = Report "Co-op Remmitance";
                }
            }
            group(PeriodicActivities)
            {
                action("Journal Transfer")
                {
                    ApplicationArea = all;
                    Image = Journal;
                    RunObject = report PrPayrollJournalTransfer;
                }
                action("Casual Journal Transfer")
                {
                    ApplicationArea = all;
                    Image = Journal;
                    RunObject = report "PRl-Casual Journal Transfer";
                }
            }
            group("Finance Operations")
            {
                Caption = 'Finance Operations';
                Image = Journals;
                ToolTip = 'Imprests, Payment and bank transfers';

                action("Receipts List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipts List';
                    Image = Journal;
                    RunObject = Page "FIN-Receipts List";
                    ToolTip = 'Receipts List';
                }

                action("Posted Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Receipts List';
                    Image = Journal;
                    RunObject = Page "FIN-Posted Receipts list";
                    ToolTip = 'Posted Receipts';
                }


                action("Imprest")
                {//Receipt List
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Warrant';
                    Image = Journal;
                    RunObject = Page "Imprest List Finance";
                    //RunPageView = WHERE("Template Type" = CONST(General),Recurring = CONST(false));
                    ToolTip = 'Imprest Requests';
                }

                action("Posted Imprest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Imprest';
                    Image = Journal;
                    RunObject = Page "FIN-Posted imprest list";
                    ToolTip = 'Posted Imprests';
                }
                action("Imprest Accounting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Accounting';
                    Image = Journal;
                    RunObject = Page "FIN-Imprest Accounting";
                    ToolTip = 'Imprest Accounting';
                }
                action("Posted Imprest Accounting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Imprest Accounting';
                    Image = Journal;
                    //RunObject = Page "FIN-Travel Advance Acc. UP";
                    RunObject = Page "FIN-Posted Imprest Accounting";
                    //RunObject = Page "FIN-Posted Travel Advs. Acc.";
                    ToolTip = 'Posted Imprest Accounting';
                }
                action("Payment Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FIN-Payment Vouchers copy';
                    Image = Journal;
                    RunObject = Page "FIN-Payment Vouchers";
                    ToolTip = 'FIN-Payment Vouchers copy';
                }
                action("Posted Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Vouchers';
                    Image = Journal;
                    RunObject = Page "FIN-Posted Payment Vouch.";
                    ToolTip = 'Posted Payment Vouchers';
                }
                action("Petty Cash")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Petty Cash';
                    Image = Journal;
                    RunObject = Page "FIN-Petty Cash Vouchers List";
                    ToolTip = 'Petty Cash Vouchers';
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Petty Cash';
                    Image = Journal;
                    RunObject = Page "FIN-Posted petty cash";
                    ToolTip = 'Posted Petty Cash Vouchers';
                }
                action(Claims)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Claims List';
                    Image = Journal;
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Claims List';
                    //FIN-Staff Claim List Posted
                }
                action("Posted Claims")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Claims List';
                    Image = Journal;
                    RunObject = Page "FIN-Staff Claim List Posted";
                    ToolTip = 'posted Claims List';
                    //FIN-Staff Claim List Posted
                }

                action("Inter Bank Tranfers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Transfers';
                    Image = Journal;
                    RunObject = Page "FIN-Interbank Transfer";
                    ToolTip = 'Bank Trasfers';
                }
                action("Posted Bank Trasfers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Bank Transfers';
                    Image = Journal;
                    RunObject = Page "FIN-Posted Interbank Trans2";
                    ToolTip = 'Posted Bank Trasfers';
                }
                action("Payment Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Schedule';
                    Image = Journal;
                    RunObject = Page "Payment Schedule  List";
                    ToolTip = 'Payment Schedule';
                }
                action("Posted Payment Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Payment Schedule';
                    Image = Journal;
                    RunObject = Page "Posted Payment Schedule List";
                    ToolTip = 'Posted Payment Schedule';
                }


            }

            group("Financial Setups")
            {
                Caption = 'Financial Setups';
                Image = Setup;
                ToolTip = 'Financial Setups';

                action("Cash Office User Templet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Office User Templet';
                    Image = Setup;
                    RunObject = Page "Cash Office User Template UP";
                    ToolTip = 'Cash Office User Templet';
                }

                action("Imprests Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprests Types';
                    Image = Journal;
                    RunObject = Page "FIN-Imprest Types";
                    //RunPageView = WHERE("Template Type" = CONST(General),Recurring = CONST(false));
                    ToolTip = 'Imprest Requests';
                }

                action("Payment Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Types';
                    Image = Journal;
                    RunObject = Page "FIN-Payment Types";
                    //RunPageView = WHERE("Template Type" = CONST(General),Recurring = CONST(false));
                    ToolTip = 'Payment Types';
                }

                action("Receipt Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipt Types';
                    Image = Journal;
                    RunObject = Page "FIN-Receipts Types";
                    ToolTip = 'Receipt Types';
                }

                action("Claim Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Claim Types';
                    Image = Journal;
                    RunObject = Page "FIN-Claim Types";
                    ToolTip = 'Claim Types';

                }
                action("Tarrif Codes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tarriff Codes Setup';
                    Image = Journal;
                    RunObject = Page "FIN-Tarriff Codes List";
                    ToolTip = 'FIN-Tarriff Codes List';
                }

                action("Cash Office Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Office Setup';
                    Image = Journal;
                    RunObject = Page "Cash Office Setup UP";
                    //RunPageView = WHERE("Template Type" = CONST(General),Recurring = CONST(false));
                    ToolTip = 'Cash Office Setup';
                }

                action("Budgetary Control setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budgetary Control setup';
                    Image = Journal;
                    RunObject = Page "Budgetary Control Setup";
                    //RunPageView = WHERE("Template Type" = CONST(General),Recurring = CONST(false));
                    ToolTip = 'Budgetary Control setup';
                }
                action("Budget Periods")
                {
                    ApplicationArea = All;
                    Image = Journal;
                    RunObject = Page "FIN-Budget Periods Setup";
                }
            }
            Group("Student Finance")
            {
                action("Student Billing")
                {
                    Caption = 'Student Billing';
                    Image = UserSetup;
                    RunObject = Page "ACA-Std Billing List";
                    ApplicationArea = All;
                }

                action("Student Balances")
                {
                    Caption = 'Student Balances';
                    RunObject = Report "ACA-Student Balances";
                    ApplicationArea = All;
                }
                action("Statement 1")
                {
                    Caption = 'Statement 1';
                    RunObject = Report Statement;
                    ApplicationArea = All;
                }
                action("Stud. List With Balances")
                {
                    Caption = 'Stud. List With Balances';
                    RunObject = Report "Students List with Balances";
                    ApplicationArea = All;
                }
                action("Fee Collection")
                {
                    Caption = 'Fee Collection';
                    RunObject = Report "Fee Collection";
                    ApplicationArea = All;
                }
                action("Fee Receipt")
                {
                    Caption = 'Fee Receipt';
                    RunObject = Report "Student Receipts";
                    ApplicationArea = All;
                }
            }
            Group("Trial Balances")
            {
                action("Trial Balance")
                {
                    ApplicationArea = All;
                    image = TraceOppositeLine;
                    RunObject = Report "Trial Balance";
                }
                action("Detailled Trial Balance")
                {
                    ApplicationArea = All;
                    image = TraceOppositeLine;
                    RunObject = Report "Detail Trial Balance";
                }

                action("Bank Trial Balance")
                {
                    ApplicationArea = All;
                    image = TraceOppositeLine;
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                }
            }
            group("PartTime Claims")
            {
                action("PartTime")
                {
                    Caption = 'PartTime Claims';
                    ApplicationArea = All;
                    Image = PriceAdjustment;
                    RunObject = page "Parttime Claim List";
                }
                action("PostedTime")
                {
                    Caption = 'Posted Claims';
                    ApplicationArea = All;
                    Image = PriceAdjustment;
                    RunObject = Page "Posted Parttime Claim List";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View posted purchase invoices and credit memos, and analyze G/L registers.';
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Payment Voucher")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Payment Voucher';
                    RunObject = Page "FIN-Posted Payment Vouch.";
                }
                action("Posted Receipt")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Receipts';
                    RunObject = Page "FIN-Posted Receipts list";
                }
                action("Posted Imprest ")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Imprest';
                    RunObject = Page "FIN-Posted imprest list";
                }
                action("Posted Imprest Surr")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Imprest Accounting';
                    RunObject = Page "FIN-Posted Travel Advs. Acc.";
                }
                action("G/L Registers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View posted G/L entries.';
                }
            }
            /* group(ProcessPCA)
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
            } */
        }
        area(sections)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = SNInfo;
                action("Salary Card")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Card';
                    Image = Employee;

                    RunObject = Page "HRM-Employee-List";
                    RunPageView = WHERE(Status = FILTER(Active));
                }
                action("Inactive Employees")
                {
                    ApplicationArea = all;
                    Caption = 'Inactive Employees';
                    Image = Employee;

                    RunObject = Page "HRM-Employee-List";
                    RunPageView = WHERE(Status = FILTER(<> active));
                }

                action("Payroll Mass Changes")
                {
                    Caption = 'Payroll Mass Changes';
                    Image = AddAction;

                    RunObject = Page "HRM-Import Emp. Trans Buff";
                    ApplicationArea = All;
                }

            }
            group("Casual Payroll")
            {
                Caption = 'Casual payroll';
                action("HRM-Casual Pay List")
                {
                    ApplicationArea = all;
                    Caption = 'Casual Employee List';
                    Image = Employee;

                    RunObject = Page "HRM-Casual Pay List";

                }
                action("Casual Worked Days")
                {
                    ApplicationArea = all;
                    Caption = 'Casual Worked Days';
                    Image = Employee;

                    RunObject = Page "PRL-Casual Worked Days";
                }
                action("Casual Payroll Periods")
                {
                    ApplicationArea = all;
                    Caption = 'Casual Payroll Periods';
                    Image = Employee;

                    RunObject = Page "PRL-Casual Payroll Periods";
                }
                action("NSSF Tiers")
                {
                    ApplicationArea = All;
                    Image = NewSalesInvoice;
                    RunObject = page "PRL-NSSF";
                }
            }
            group("Board Payroll")
            {
                Caption = 'Board Payroll';
                Visible = false;

                action("Board List")
                {
                    ApplicationArea = all;
                    Caption = 'Board Almanac List';
                    Visible = false;

                    //RunObject = Page "Board Almanac List";

                }
                action("Board commitee")
                {
                    ApplicationArea = all;
                    Caption = 'Board Commitee List';


                    //RunObject = Page "Board Committes Listing";

                }
                action("Board Period")
                {
                    ApplicationArea = all;
                    Caption = 'Board Periods';


                    //RunObject = Page "NW-Board Payroll Periods";

                }

            }
            group("Salary Advances")
            {

                Caption = 'Salary Advance';
                visible = false;


                action("Salary Advance")
                {
                    ApplicationArea = all;

                    //RunObject = page "FIN-Staff Advance List";
                }
                action("Salary Advance retiring")
                {
                    ApplicationArea = all;
                    Caption = 'Advance Surrender';
                    //RunObject = page "FIN-Staff Advance Surr. List";


                }
            }
            group("Salary Increaments")
            {
                Caption = 'Salary Increaments';
                Image = Intrastat;
                action("Salary Increament Process")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;

                    RunObject = Page "HRM-Emp. Categories";
                }
                action("Salary Increament Register")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;

                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Afected Salary Increaments")
                {
                    ApplicationArea = all;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;

                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action("Leave Allowance Buffer")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Allowance Buffer';
                    Image = Bins;

                    //todo  RunObject = Page "HRM-Leave Allowance Buffer";
                }
            }
            group(ATT)
            {
                Caption = 'Attendance';
                action("Staff Register")
                {

                    Caption = 'Staff Register';
                    ApplicationArea = All;
                    //todo RunObject = Page "Staff Reg.Ledger List";
                }
                action("Staff Register History")
                {

                    Caption = 'Staff Register History';
                    ApplicationArea = All;
                    //todo  RunObject = Page "Staff Ledger History";
                }
                action("Casuals Register")
                {

                    Caption = 'Casuals Register';
                    ApplicationArea = All;
                    //todo   RunObject = Page "Casuals  Reg.Ledger List";
                }
                action("Casuals History")
                {

                    Caption = 'Casuals History';
                    ApplicationArea = All;
                    //todo  RunObject = Page "Casuals Ledger History";
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
                Visible = false;
                Image = LotInfo;
                action("Stores Requisitions")
                {

                    Caption = 'Stores Requisitions';
                    Visible = false;
                    RunObject = Page "PROC-Store Requisition";
                    ApplicationArea = All;
                }
                action("Imprest Requisitions")
                {

                    Caption = 'Imprest Requisitions';
                    Visible = false;
                    RunObject = Page "FIN-Imprests list";
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
                action("Meal Booking")
                {

                    Caption = 'Meal Booking';
                    Visible = false;
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
                }


                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
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
        area(Embedding)
        {

            action("employeeupload")
            {
                // RunObject = xmlport "Employee Upload";
                visible = false;
                Caption = 'Import Employee Data';
                ApplicationArea = all;


            }

            action("salarygrade")
            {
                //RunObject = xmlport "Salary Grades";
                visible = false;
                Caption = 'Import salary grades';
                ApplicationArea = all;


            }
            action("Salarycard")
            {
                //RunObject = xmlport "Salary Data";
                visible = false;
                Caption = 'Import Salary Card Data';
                ApplicationArea = all;
            }
        }
        area(creation)
        {
            group(Payroll_Setups)
            {
                Caption = 'Payroll Setups';
                Image = HRSetup;
                action("Import Salary Card")
                {
                    ApplicationArea = All;
                    Caption = 'Import Data';
                    Image = Import;

                    RunObject = xmlport "Data Import";

                }
                action("Payroll Period")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }

                action("Pr Rates")
                {
                    ApplicationArea = all;
                    Caption = 'Pr Rates';
                    Image = SetupColumns;

                    RunObject = Page "PRL-Rates & Ceilings";
                }
                action("paye Setup")
                {
                    ApplicationArea = all;
                    Caption = 'PAYE Setup';
                    Image = SetupPayment;

                    RunObject = Page "PRL-P.A.Y.E Setup";
                }
                action(Action7)
                {
                    ApplicationArea = all;
                    Caption = 'Transcation Codes';
                    Image = Setup;

                    RunObject = Page "PRL-Transaction Codes List";
                }
                action(Action6)
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Tiers';
                    Image = SetupLines;

                    RunObject = Page "PRL-NHIF SetUp";
                }
                action("prNSSTier")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Tiers';
                    Image = SetupLines;

                    RunObject = page "prNSSF List";
                }
                action("prNSSTier2")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Tiers';
                    Image = SetupLines;

                    RunObject = page "PRL-NSSF2";
                }

                action("Bank Structure")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Structure';
                    Image = Bank;

                    RunObject = Page "PRL-Bank Structure (B)";
                }
                action("control information")
                {
                    ApplicationArea = all;
                    Caption = 'control information';
                    Image = CompanyInformation;

                    RunObject = Page "GEN-Control-Information";
                }
                action("Salary Grades")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Grades';
                    Image = EmployeeAgreement;

                    RunObject = Page "PRL-Salary Grades";
                }
                action("posting group")
                {
                    ApplicationArea = all;
                    Caption = 'posting group';
                    Image = PostingEntries;

                    RunObject = Page "PRL-Employee Posting Group";
                }
                action(Action69)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;

                    RunObject = Page "HRM-Emp. Categories";
                }
                action(Action68)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;

                    RunObject = Page "HRM-Salary Increament Register";
                }
                action(Action66)
                {
                    ApplicationArea = all;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;

                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action(Action9)
                {
                    ApplicationArea = all;
                    Caption = ' payment Vouchers';
                    visible = false;
                    // RunObject = Page "FIN-Payment Vouchers";
                }
                action("Staff Welfare Loan Tires")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Welfare Loan Tires';
                    RunObject = Page "HRM Welfare Loan Tiers";
                }
            }

            group(prlComparision)
            {

                action("Variance Report")
                {
                    ApplicationArea = all;
                    Caption = 'Details Payroll Variance';
                    Image = Aging;
                    RunObject = Report "PRL-Payroll Variance Report2";
                }
                action("Variance Report Two")
                {
                    ApplicationArea = all;
                    Image = Aging;
                    RunObject = Report "Gross Pay Per Period Report";
                }
                action("Variance Report Three")
                {
                    ApplicationArea = all;
                    Image = Aging;
                    RunObject = Report "PRL Payroll Comparison";
                }
                action("Variance Report Four")
                {
                    ApplicationArea = all;
                    Image = Aging;
                    RunObject = Report "PRL Payroll Trans Comparison";
                }
            }
        }
    }
}

