page 51493 "Finance Management Rolecenter"
{

    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }

        }
    }

    actions
    {
        area(Sections)
        {
            group("Journals")
            {
                action(PurchaseJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases), Recurring = CONST(false));
                    ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments), Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                action(Action17)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Assets List-Cust";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("FA Report")
                {
                    ApplicationArea = All;
                    Image = AbsenceCategory;
                    RunObject = Report "Assets Register";
                }
                action(Insurance)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("<Action3>")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
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
            group("Medical Claims")
            {
                action("Open Medical Claims")
                {
                    Caption = 'Open Medical Claims';
                    ApplicationArea = All;
                    Image = CalculateSimulation;
                    RunObject = Page "Medical Claims List";
                    RunPageView = WHERE(Status = FILTER(Open));
                }
                action("Pending Medical Claims")
                {
                    Caption = 'Pending Medical Claims';
                    ApplicationArea = All;
                    Image = CalculateSimulation;
                    RunObject = Page "Medical Claims List";
                    RunPageView = WHERE(Status = FILTER(Pending));
                }
                action("Approved Medical Claims")
                {
                    Caption = 'Approved Medical Claims';
                    ApplicationArea = All;
                    Image = CalculateSimulation;
                    RunObject = Page "Medical Claims List";
                    RunPageView = WHERE(Status = FILTER(Approved));
                }
                action("Rejected Medical Claims")
                {
                    Caption = 'Rejected Medical Claims';
                    ApplicationArea = All;
                    Image = CalculateSimulation;
                    RunObject = Page "Medical Claims List";
                    RunPageView = WHERE(Status = FILTER(Rejected));
                }
                action("Posted Medical Claims")
                {
                    Caption = 'Posted Medical Claims';
                    ApplicationArea = All;
                    Image = CalculateSimulation;
                    RunObject = Page "Medical Claims List";
                    RunPageView = WHERE(Posted = const(true));
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
            group(Common_req)
            {
                Caption = 'Common Requisitions';

                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
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
                action("Page FLT Transport Requisition2")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action(Travel_Notices2)
                {
                    Caption = 'Travel Notice';
                    Image = Register;
                    RunObject = Page "FLT-Safari Notices List";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    RunObject = Page "CAT-Meal Booking List";
                }

                action("File Requisitions")
                {
                    Image = Register;
                    ApplicationArea = All;
                    RunObject = Page "REG-File Requisition List";
                }
                action("Purchase Requisition Header")
                {
                    Caption = 'Purchase Requisition';
                    RunObject = page "Purchase Requisition Header";
                    ApplicationArea = All;
                }

            }
        }

        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Payment &Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
                ToolTip = 'View or edit the payment journal where you can register payments to vendors.';
            }
            action("P&urchase Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&urchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
                ToolTip = 'Post any purchase transaction for the vendor. ';
            }
            action(VendorPayments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Vendor Payments';
                Image = SuggestVendorPayments;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Vendor Ledger Entries";
                RunPageView = WHERE("Document Type" = FILTER(Invoice),
                                    "Remaining Amount" = FILTER(< 0),
                                    "Applies-to ID" = FILTER(''));
                ToolTip = 'Opens vendor ledger entries for all vendors with invoices that have not been paid yet.';
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Purchases && Payables &Setup")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchases && Payables &Setup';
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
                ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                RunObject = Page Navigate;
                ShortCutKey = 'Shift+Ctrl+I';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
            }
        }
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

        area(Reporting)
        {
            group("Finance Reports")
            {
                action("General Ledger Report")
                {
                    ApplicationArea = All;
                    Image = Report;
                    RunObject = Report GeneralLedgerv3;
                }
            }
            group(Reports)
            {

                Caption = 'Payroll Reports';
                Image = Payables;
                action(Payslips)
                {
                    ApplicationArea = area;
                    Caption = 'Payslips';
                    Image = "Report";

                    RunObject = Report "Individual Payslips 2";
                }
                action("Master Summary")
                {
                    ApplicationArea = all;
                    Image = "Report";

                    RunObject = Report "Payroll Summary 3";
                }

                action("Deductions Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = "Report";
                    RunObject = Report "PRL-Deductions Summary 2 a";
                }
                action("Earnings Summary")
                {
                    ApplicationArea = All;
                    Image = Report;
                    RunObject = Report "PRL-Earnings Summary 5";

                }
                action("Payee Schedule")
                {
                    ApplicationArea = All;
                    Image = Report;
                    RunObject = Report "prPaye Schedule mst";
                }
                action("PR Payroll Summary - Detailed")
                {
                    ApplicationArea = all;
                    Caption = 'PR Payroll Summary - Detailed';
                    Image = "Report";

                    RunObject = Report "PR Payroll Summary - Detailed";
                }
                action("bank Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";
                    RunObject = Report "PRL-Bank Schedule";
                }
                action("P9 Report")
                {
                    ApplicationArea = all;

                    Caption = 'P9 Report';
                    Image = PrintForm;

                    RunObject = Report "P9 Report (Final)";
                }
                action("PR Trans  Variance Analysis")
                {
                    ApplicationArea = all;
                    Caption = 'PR Trans  Variance Analysis';
                    Image = "Report";

                    RunObject = Report "PR Trans  Variance Analysis";
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
            }
            Group("Accounts Payables")
            {
                action("&Vendor - List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Vendor - List';
                    Image = "Report";
                    RunObject = Report "Vendor - List";
                    ToolTip = 'View the list of your vendors.';
                }
                action("Vendor - &Balance to date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - &Balance to date';
                    Image = "Report";
                    RunObject = Report "Vendor - Balance to Date";
                    ToolTip = 'View, print, or save a detail balance to date for selected vendors.';
                }
                action("Vendor - &Summary Aging")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - &Summary Aging';
                    Image = "Report";
                    RunObject = Report "Vendor - Summary Aging";
                    ToolTip = 'View a summary of the payables owed to each vendor, divided into three time periods.';
                }
                action("Aged &Accounts Payable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged &Accounts Payable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Vendor - &Purchase List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - &Purchase List';
                    Image = "Report";
                    RunObject = Report "Vendor - Purchase List";
                    ToolTip = 'View a list of your purchases in a period, for example, to report purchase activity to customs and tax authorities.';
                }
                action("Pa&yments on Hold")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pa&yments on Hold';
                    Image = "Report";
                    RunObject = Report "Payments on Hold";
                    ToolTip = 'View a list of all vendor ledger entries on which the On Hold field is marked.';
                }
                action("P&urchase Statistics")
                {
                    ApplicationArea = Suite;
                    Caption = 'P&urchase Statistics';
                    Image = "Report";
                    RunObject = Report "Purchase Statistics";
                    ToolTip = 'View a list of amounts for purchases, invoice discount and payment discount in $ for each vendor.';
                }

                group("Purchases")
                {
                    action("Purchase Orders")
                    {
                        ApplicationArea = All;
                        Image = Order;
                        RunObject = Page "Purchase Orders";
                    }
                    action("Credit Memo")
                    {
                        ApplicationArea = All;
                        Image = CreditMemo;
                        RunObject = Page "Purchase Credit Memos";

                    }

                }


            }
            Group("Receivables")
            {
                action("C&ustomer - List")
                {
                    ApplicationArea = Suite;
                    Caption = 'C&ustomer - List';
                    Image = "Report";
                    RunObject = Report "Customer - List";
                    ToolTip = 'View various information for customers, such as customer posting group, discount group, finance charge and payment information, salesperson, the customer''s default currency and credit limit (in LCY), and the customer''s current balance (in LCY).';
                }
                action("Customer - &Balance to Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - &Balance to Date';
                    Image = "Report";
                    RunObject = Report "Customer - Balance to Date";
                    ToolTip = 'View a list with customers'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                }
                action("Aged &Accounts Receivable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged &Accounts Receivable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                    ToolTip = 'View an overview of when your receivables from customers are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Customer - &Summary Aging Simp.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Customer - &Summary Aging Simp.';
                    Image = "Report";
                    RunObject = Report "Customer - Summary Aging Simp.";
                    ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                }
                action("Customer - Trial Balan&ce")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Trial Balan&ce';
                    Image = "Report";
                    RunObject = Report "Customer - Trial Balance";
                    ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                }
                action("Cus&tomer/Item Sales")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cus&tomer/Item Sales';
                    Image = "Report";
                    RunObject = Report "Customer/Item Sales";
                    ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.';
                }
                action("Sales Invoices")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    RunObject = page "Sales Invoice List";
                }
                action("Posted Invoices")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    RunObject = page "Posted Sales Invoices";
                }
                action("Credit Notes")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    RunObject = page "Sales Credit Memos";
                }
                action("Posted Credit Notes")
                {
                    ApplicationArea = All;
                    Image = PostedCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                }

            }
            group("PosSalesRep.")
            {
                Caption = 'POS Reports';
                Image = "Report";
                action("POS REPORT")
                {
                    ApplicationArea = All;
                    image = PostDocument;
                    RunObject = report "POS cashier Sales Report";
                }
                action("Daily Summary")
                {
                    ApplicationArea = All;
                    Image = ViewDetails;
                    RunObject = Report "POS Daily Totals";
                }
                action("Summary Report")
                {
                    ApplicationArea = All;
                    Image = PostedInventoryPick;
                    RunObject = Report "POS cashier Sales Totals";
                }
                action("Sales Per Item")
                {
                    ApplicationArea = All;
                    Image = SalesPerson;
                    RunObject = Report "Sales Per Item POS";
                }
                action("Sales Per item Summary")
                {
                    ApplicationArea = All;
                    Image = AddWatch;
                    RunObject = Report "Sales Per Item Summary";
                }
            }

        }
    }


}