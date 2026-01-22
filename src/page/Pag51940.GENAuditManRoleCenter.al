page 51940 "GEN-Audit Man. Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Group)
            {
                part(Page; 9030)
                {
                    ApplicationArea = All;
                }
                systempart(Notes; MyNotes)
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
            group(Finance_01)
            {
                Caption = 'Finance';
                group(Finance)
                {
                    Caption = 'Finance';
                    Image = LotInfo;
                    action("&G/L Trial Balance")
                    {
                        Caption = '&G/L Trial Balance';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 6;
                    }
                    action("&Bank Detail Trial Balance")
                    {
                        Caption = '&Bank Detail Trial Balance';
                        Image = "Report";
                        RunObject = Report 1404;
                        ApplicationArea = All;
                    }
                    action("&Account Schedule")
                    {
                        Caption = '&Account Schedule';
                        Image = "Report";
                        RunObject = Report 25;
                        ApplicationArea = All;
                    }
                    /* action("Bu&dget")
                    {
                        Caption = 'Bu&dget';
                        Image = "Report";
                        RunObject = Report 8;
                    } */
                    action("Trial Bala&nce/Budget")
                    {
                        Caption = 'Trial Bala&nce/Budget';
                        Image = "Report";
                        RunObject = Report 9;
                        ApplicationArea = All;
                    }
                    action("Trial Balance by &Period")
                    {
                        Caption = 'Trial Balance by &Period';
                        Image = "Report";
                        RunObject = Report 38;
                        ApplicationArea = All;
                    }
                    action("&Fiscal Year Balance")
                    {
                        Caption = '&Fiscal Year Balance';
                        Image = "Report";
                        RunObject = Report 36;
                        ApplicationArea = All;
                    }
                    action("Balance Comp. - Prev. Y&ear")
                    {
                        Caption = 'Balance Comp. - Prev. Y&ear';
                        Image = "Report";
                        RunObject = Report 37;
                        ApplicationArea = All;
                    }
                    /*  action("&Closing Trial Balance")
                     {
                         Caption = '&Closing Trial Balance';
                         Image = "Report";
                         RunObject = Report 10;
                     } */
                    separator("   ")
                    {
                    }
                    action("Cash Flow Date List")
                    {
                        Caption = 'Cash Flow Date List';
                        Image = "Report";
                        RunObject = Report 846;
                        ApplicationArea = All;
                    }
                    separator("    ")
                    {
                    }
                    action("Aged Accounts &Receivable")
                    {
                        Caption = 'Aged Accounts &Receivable';
                        Image = "Report";
                        RunObject = Report 120;
                        ApplicationArea = All;
                    }
                    action("Aged Accounts Pa&yable")
                    {
                        Caption = 'Aged Accounts Pa&yable';
                        Image = "Report";
                        RunObject = Report 322;
                        ApplicationArea = All;
                    }
                    action("Reconcile Cus&t. and Vend. Accs")
                    {
                        Caption = 'Reconcile Cus&t. and Vend. Accs';
                        Image = "Report";
                        RunObject = Report 33;
                        ApplicationArea = All;
                    }
                    separator("T")
                    {
                    }
                    action("&VAT Registration No. Check")
                    {
                        Caption = '&VAT Registration No. Check';
                        Image = "Report";
                        RunObject = Report 32;
                        ApplicationArea = All;
                    }
                    action("VAT E&xceptions")
                    {
                        Caption = 'VAT E&xceptions';
                        Image = "Report";
                        RunObject = Report 31;
                        ApplicationArea = All;
                    }
                    action("VAT &Statement")
                    {
                        Caption = 'VAT &Statement';
                        Image = "Report";
                        RunObject = Report 12;
                        ApplicationArea = All;
                    }
                    action("VAT - VIES Declaration Tax Aut&h")
                    {
                        Caption = 'VAT - VIES Declaration Tax Aut&h';
                        Image = "Report";
                        RunObject = Report 19;
                        ApplicationArea = All;
                    }
                    action("VAT - VIES Declaration Dis&k")
                    {
                        Caption = 'VAT - VIES Declaration Dis&k';
                        Image = "Report";
                        RunObject = Report 88;
                        ApplicationArea = All;
                    }
                    action("EC Sales &List")
                    {
                        Caption = 'EC Sales &List';
                        Image = "Report";
                        RunObject = Report 130;
                        ApplicationArea = All;
                    }
                    separator(" ")
                    {
                    }
                    action("&Intrastat - Checklist")
                    {
                        Caption = '&Intrastat - Checklist';
                        Image = "Report";
                        // RunObject = Report intrastat;
                        // ApplicationArea = All;
                    }
                    action("Intrastat - For&m")
                    {
                        Caption = 'Intrastat - For&m';
                        Image = "Report";
                        // RunObject = Report 501;
                        // ApplicationArea = All;
                    }
                    separator("  ")
                    {
                    }
                    action("Cost Accounting P/L Statement")
                    {
                        Caption = 'Cost Accounting P/L Statement';
                        Image = "Report";
                        RunObject = Report 1126;
                        ApplicationArea = All;
                    }
                    action("CA P/L Statement per Period")
                    {
                        Caption = 'CA P/L Statement per Period';
                        Image = "Report";
                        RunObject = Report 1123;
                        ApplicationArea = All;
                    }
                    action("CA P/L Statement with Budget")
                    {
                        Caption = 'CA P/L Statement with Budget';
                        Image = "Report";
                        RunObject = Report 1133;
                        ApplicationArea = All;
                    }
                    action("Cost Accounting Analysis")
                    {
                        Caption = 'Cost Accounting Analysis';
                        Image = "Report";
                        RunObject = Report 1127;
                        ApplicationArea = All;
                    }
                    separator("s")
                    {
                    }
                    action("Vendor - T&op 10 List")
                    {
                        Caption = 'Vendor - T&op 10 List';
                        Image = "Report";
                        ApplicationArea = All;
                        //RunObject = Report 311;
                    }
                    action("Vendor/&Item Purchases")
                    {
                        Caption = 'Vendor/&Item Purchases';
                        Image = "Report";
                        ApplicationArea = All;
                        //RunObject = Report 313;
                    }
                    separator("p")
                    {
                    }
                }
            }
            group("Procurement Reports")
            {
                Caption = 'Procurement Reports';
                group(Procurement)
                {
                    Caption = 'Procurement Reports';
                    Image = ProductDesign;
                    action("Inventory - &Availability Plan")
                    {
                        Caption = 'Inventory - &Availability Plan';
                        Image = ItemAvailability;

                        RunObject = Report 707;
                        ApplicationArea = All;
                    }
                    action("Inventory &Purchase Orders")
                    {
                        Caption = 'Inventory &Purchase Orders';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 709;
                    }
                    action("Inventory - &Vendor Purchases")
                    {
                        Caption = 'Inventory - &Vendor Purchases';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 714;
                    }
                    action("Inventory &Cost and Price List")
                    {
                        Caption = 'Inventory &Cost and Price List';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 716;
                    }
                    /* action("Purchase Quote Request Report")
                    {
                        Caption = 'Purchase Quote Request Report';
                        Image = "Report";
                        
                        RunObject = Report 51074;
                    } */
                    action("Purchase Quote Request Report")
                    {
                        Caption = 'Purchase Quote Request Report';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 39005490;
                    }
                    action("Local Purchase Orders")
                    {
                        Caption = 'Local Purchase Orders';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 51092;
                    }
                    action("Purchase Requisition")
                    {
                        Caption = 'Purchase Requisition';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 51242;
                    }
                    action("Purchase Order")
                    {
                        Caption = 'Purchase Order';
                        Image = "Report";
                        ApplicationArea = All;

                        //RunObject = Report 51574;
                    }
                }
            }
            group("PayrollReports")
            {
                Caption = 'Payroll Reports';
                group(payroll_Reports)
                {
                    Caption = 'Payroll Reports';
                    Image = Receivables;
                    action("Company Payroll Master")
                    {
                        Caption = 'Company Payroll Master';
                        Image = CompanyInformation;
                        ApplicationArea = All;

                        //RunObject = Report 51082;
                    }
                    action("view payslip")
                    {
                        Caption = 'view payslip';
                        Visible = false;
                        RunObject = Report "Individual Payslips V.1.1.3";
                        ApplicationArea = All;
                    }

                    /* action(deductions)
                    {
                        Caption = 'deductions';
                        RunObject = Report 51096;
                    } */
                    /* action("Staff pension 3")
                    {
                        Caption = 'Staff pension';
                        RunObject = Report 51099;
                    } */

                    /*  action("payroll summary2")
                     {
                         Caption = 'payroll summary2';
                         Image = summary;
                         RunObject = Report 51101;
                     } */
                    /* action(deductions)
                    {
                        Caption = 'deductions';
                        Image = DepositSlip;
                        RunObject = Report 51096;
                    } */
                    action("Staff pension")
                    {
                        Caption = 'Staff pension';
                        Image = Aging;
                        ApplicationArea = All;
                        //RunObject = Report 51099;
                    }
                    action("Gross Netpay")
                    {
                        Caption = 'Gross Netpay';
                        Image = Giro;
                        RunObject = Report prGrossNetPay;
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
                    separator("setup finance")
                    {
                        Caption = 'setup finance';
                    }
                    action("receipt type")
                    {
                        Caption = 'receipt type';
                        Image = ServiceSetup;
                        Visible = false;
                        ApplicationArea = All;
                        // RunObject = Page "FIN-Receipt Types";
                    }
                    action(Transactions)
                    {
                        Caption = 'Transactions';
                        RunObject = Report "pr Transactions";
                        ApplicationArea = All;
                    }
                    action("bank Schedule")
                    {
                        Caption = 'bank Schedule';
                        RunObject = Report "pr Bank Schedule";
                        ApplicationArea = All;
                    }
                    separator("a")
                    {
                    }
                    action("Paye Scheule")
                    {
                        Caption = 'Paye Scheule';
                        RunObject = Report "prPaye Schedule mst";
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
                    action(NSSF)
                    {
                        Caption = 'NSSF';
                        Image = Replan;

                        Visible = false;
                        ApplicationArea = All;
                        // RunObject = Report 51780;
                    }
                    action(PAYE)
                    {
                        Caption = 'PAYE';
                        Image = Reconcile;
                        ApplicationArea = All;

                        //RunObject = Report 51781;
                    }
                    action(HELB)
                    {
                        Caption = 'HELB';
                        Image = Hierarchy;
                        ApplicationArea = All;

                        //RunObject = Report 52017866;
                        // RunObject = "PRL-HELB Report";
                    }
                    action(NHIF)
                    {
                        Caption = 'NHIF';
                        Image = RefreshText;

                        RunObject = Report "PRL-NHIF Report";
                        ApplicationArea = All;
                    }
                }
            }
            group("FixedReports")
            {
                Caption = 'Fixed Reports';
                group(Fixed_Reports)
                {
                    Caption = 'Fixed Reports';
                    Image = Worksheets;
                    separator("Fixed Assets")
                    {
                        Caption = 'Fixed Assets';
                    }
                    action("Fixed Assets List")
                    {
                        Caption = 'Fixed Assets List';
                        Image = "Report";
                        RunObject = Report 5601;
                        ApplicationArea = All;
                    }
                    action("Acquisition List")
                    {
                        Caption = 'Acquisition List';
                        Image = "Report";

                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 5608;
                        ApplicationArea = All;
                    }
                    action(Details)
                    {
                        Caption = 'Details';
                        Image = View;
                        RunObject = Report 5604;
                        ApplicationArea = All;
                    }
                    action("Book Value 01")
                    {
                        Caption = 'Book Value 01';
                        Image = "Report";

                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 5605;
                        ApplicationArea = All;
                    }
                    action("Book Value 02")
                    {
                        Caption = 'Book Value 02';
                        Image = "Report";

                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 5606;
                        ApplicationArea = All;
                    }
                    action(Analysis)
                    {
                        Caption = 'Analysis';
                        Image = "Report";
                        RunObject = Report 5600;
                        ApplicationArea = All;
                    }
                    action("Projected Value")
                    {
                        Caption = 'Projected Value';
                        Image = "Report";
                        RunObject = Report 5607;
                        ApplicationArea = All;
                    }
                    action("G/L Analysis")
                    {
                        Caption = 'G/L Analysis';
                        Image = "Report";

                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 5610;
                        ApplicationArea = All;
                    }
                    action("Student Balance")
                    {
                        Caption = 'Student Balance';
                        Image = Confirm;
                        ApplicationArea = All;
                        //RunObject = Report "Students List with Balances";
                    }
                }
            }
            group(Approvals2)
            {
                Caption = 'Approvals';
                Image = Alerts;
                Visible = false;
                group(Approvals)
                {
                    Caption = 'Approvals';
                    Image = LotInfo;
                    Visible = false;
                    action("Pending My Approval")
                    {
                        Caption = 'Pending My Approval';
                        RunObject = Page 658;
                        ApplicationArea = All;
                    }
                    action("My Approval requests")
                    {
                        Caption = 'My Approval requests';
                        RunObject = Page 662;
                        ApplicationArea = All;
                    }
                    action("Clearance Requests")
                    {
                        Caption = 'Clearance Requests';
                        ApplicationArea = All;
                        //RunObject = Page 68970;
                    }
                }
            }
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';
                Image = Capacities;
                group(Common_req)
                {
                    Caption = 'Common Requisitions';
                    Image = Payables;
                    /* action("Stores Requisitions")
                    {
                        Caption = 'Stores Requisitions';
                        RunObject = Page 68218;
                    } */
                    action("Imprest Requisitions 2")
                    {
                        Caption = 'Imprest Requisitions';
                        ApplicationArea = All;
                        //RunObject = Page 68125;
                    }
                    action("Leave Applications 2")
                    {
                        Caption = 'Leave Applications';
                        RunObject = Page "HRM-Leave Requisition List";
                        ApplicationArea = All;
                    }
                    action("My Approved Leaves 2")
                    {
                        Caption = 'My Approved Leaves';
                        Image = History;
                        RunObject = Page "HRM-My Approved Leaves List";
                        ApplicationArea = All;
                    }
                    /* action("File Requisitions")
                    {
                        Image = Register;
                        
                        RunObject = Page 69183;
                    }
                    action("Meal Booking")
                    {
                        Caption = 'Meal Booking';
                        RunObject = Page 69302;
                    } */
                }
            }
        }
        area(processing)
        {
            group(Group2)
            {
                Visible = false;
                separator(Tasks)
                {
                    Caption = 'Tasks';
                    IsHeader = true;
                }
                action("Calculate Deprec&iation")
                {
                    Caption = 'Calculate Deprec&iation';
                    Ellipsis = true;
                    Image = CalculateDepreciation;
                    RunObject = Report 5692;
                    ApplicationArea = All;
                }
                action("Import Co&nsolidation from Database")
                {
                    Caption = 'Import Co&nsolidation from Database';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report 90;
                    ApplicationArea = All;
                }
                action("Adjust E&xchange Rates")
                {
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                    // RunObject = Report 595;
                    // ApplicationArea = All;
                }
                action("P&ost Inventory Cost to G/L")
                {
                    Caption = 'P&ost Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    RunObject = Report 1002;
                    ApplicationArea = All;
                }
                separator("q")
                {
                }
                action("C&reate Reminders")
                {
                    Caption = 'C&reate Reminders';
                    Ellipsis = true;
                    Image = CreateReminders;
                    RunObject = Report 188;
                    ApplicationArea = All;
                }
                action("Create Finance Charge &Memos")
                {
                    Caption = 'Create Finance Charge &Memos';
                    Ellipsis = true;
                    Image = CreateFinanceChargememo;
                    RunObject = Report 191;
                    ApplicationArea = All;
                }
                separator("r")
                {
                }
                action("Calc. and Pos&t VAT Settlement")
                {
                    Caption = 'Calc. and Pos&t VAT Settlement';
                    Image = SettleOpenTransactions;
                    RunObject = Report 20;
                    ApplicationArea = All;
                }
                action("Audit Register")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(sections)
        {
            ToolTip = 'Risk Register';
            group("Risks Register")
            {
                Image = RegisteredDocs;
                action("Risk List")
                {
                    RunObject = Page "AUDIT - Risk analysis lines";
                    ApplicationArea = All;
                }
                action("Submitted Risks Under Audit")
                {
                    RunObject = Page "Audit List in Unde Auditing";
                    ApplicationArea = All;
                }
            }
            group("Audit Planner")
            {
                Image = Job;
                action("Audit-Plan-Master")
                {
                    RunObject = Page "Audit-Plan-Master";
                    ApplicationArea = All;
                }
            }
            group("Audit Assessment")
            {
                Image = AnalysisView;
                action("Audit Assessment List")
                {
                    RunObject = Page "Audit Assessment";
                    ApplicationArea = All;
                }
                action("Audit Review List")
                {
                    RunObject = Page "Audit Assessmnt Review List";
                    ApplicationArea = All;
                }
                action("Archived Audit List")
                {
                    RunObject = Page "Audit Assemnt Archived";
                    ApplicationArea = All;
                }
            }
            group(Common_req1)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
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


                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    //RunObject = Page "CAT-Meal Booking List";
                }
                action("Departmental Requisition")
                {
                    ApplicationArea = All;
                    //RunObject = Page 68217;
                }
            }
        }
    }
}

