/// <summary>
/// Page ACA-Hostels Role Center (ID 69177).
/// </summary>
page 54321 "ACA-Hostels Role Center"
{
    Caption = 'Hostels/Cafeteria Roles';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            // group(gre)
            // {
            //     part("POS Menu Items"; "POS Menu List")
            //     {
            //         Caption = 'Food Menu List';
            //         Visible = true;
            //         ApplicationArea = All;
            //     }
            //     part("POS Adjustment"; "POS Stock Adjustments")
            //     {
            //         Caption = 'Food Adjustment List';
            //         Visible = true;
            //         ApplicationArea = All;
            //     }
            // }
            // part(HOD; "Approvals Activities One")
            // {
            //     ApplicationArea = Suite;
            // }

        }
    }

    actions
    {

        area(creation)
        {
            action("Hostel Status Summary Report")
            {
                Caption = 'Hostel Status Summary Report';
                Image = Status;


                RunObject = Report "Hostel Status Summary Report";
                ApplicationArea = All;
            }
            action("AlloCation Analysis")
            {
                Caption = 'AlloCation Analysis';
                Image = Interaction;


                RunObject = Report "Hostel Status Summary Graph";
                ApplicationArea = All;
            }
            action("Incidents Report")
            {
                Caption = 'Incidents Report';
                Image = Register;


                RunObject = Report "Hostel Incidents Report";
                ApplicationArea = All;
            }
            action("Hostel Allocations")
            {
                Caption = 'Hostel Allocations';
                Image = Allocations;


                RunObject = Report "Hostel Allocations Per Block";
                ApplicationArea = All;
            }
            action("Detailled Allocations")
            {
                Caption = 'Detailled Allocations';
                Image = AllocatedCapacity;


                RunObject = Report "Hostel Allo. Per Room/Block";
                ApplicationArea = All;
            }
            action("Room Status")
            {
                Caption = 'Room Status';
                Image = Status;


                RunObject = Report "Hostel Vaccant Per Room/Block";
                ApplicationArea = All;
            }
            action("Allocations List")
            {
                Caption = 'Allocations List';
                Image = Allocate;


                RunObject = Report "Hostel Allo. Per Room (Det.)";
                ApplicationArea = All;
            }
            action("Hostels Collection Report")
            {
                Image = "Report";
                RunObject = Report "Aca-Hostel Charge Collection";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesRep)
                {
                    Caption = 'Damage Reports';
                    Image = "Report";
                    action(DamageReport)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Damage Report';
                        Image = "Report";


                        RunObject = Report "Damage reports";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action(StockTake)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stock Take';
                        Image = "Report";


                        RunObject = Report "Hostel Sub-Store ";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action("Sub Store Issuance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sub Store Issuance';
                        Image = "Report";


                        RunObject = Report "Sub Store Issuance";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    // action(CustStatement)"Hostel Sub-Store "  "Sub Store Issuance"
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Customer Inv./Item';
                    //     Image = "Report";


                    //     RunObject = Report "Summary Cust. Invoices/Item";
                    //     ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    // }
                    // action(GraphicalCustInv)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Graphical Customer Invoices';
                    //     Image = "Report";


                    //     RunObject = Report "Graphical Cust. Invoices";
                    //     ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    // }
                    // action("Graphical Cust. In. 2")
                    // {
                    //     Caption = 'Graphical Cust. In. 2';
                    //     Image = "Report";
                    //     RunObject = Report "Graphical Cust. Invoices 2";
                    //     ToolTip = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    //     ApplicationArea = All;
                    // }
                    // action("Sales By Sales Person/Date")
                    // {
                    //     Caption = 'Sales By Sales Person/Date';
                    //     Image = "Report";
                    //     RunObject = Report "Sales By Sales Person/Date";
                    //     ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    //     ApplicationArea = All;
                    // }
                    // action("Sales by Salesp./Month")
                    // {
                    //     Caption = 'Sales by Salesp./Month';
                    //     Image = "Report";
                    //     RunObject = Report "Sales By Sales Person/Month";
                    //     ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    //     ApplicationArea = All;
                    // }
                    // action("Sales By Salesp./Item")
                    // {
                    //     Caption = 'Sales By Salesp./Item';
                    //     Image = "Report";
                    //     RunObject = Report "Sales By SalesPerson/Item";
                    //     ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    //     ApplicationArea = All;
                    // }
                    // action("Sales Person and Item Class")
                    // {
                    //     Caption = 'Sales Person and Item Class';
                    //     Image = "Report";
                    //     RunObject = Report "Sales By SalesP./Item/Class";
                    //     ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    //     ApplicationArea = All;
                    // }
                    // action("Meal Booking Reports")
                    // {
                    //     Caption = 'Meal Booking Reports';
                    //     Image = Agreement;
                    //     RunObject = Report "Meal Booking Lists";
                    //     ApplicationArea = All;
                    // }
                }
                // group("PosSalesRep.")
                // {
                //     Caption = 'POS Sales';
                //     Image = "Report";
                //     action("POS REPORT")
                //     {
                //         ApplicationArea = All;
                //         image = PostDocument;
                //         RunObject = report "POS cashier Sales Report";
                //     }
                //     action("Summary Report")
                //     {
                //         ApplicationArea = All;
                //         Image = PostedInventoryPick;
                //         RunObject = Report "POS cashier Sales Totals";
                //     }
                //     action("Sales Per Item")
                //     {
                //         ApplicationArea = All;
                //         Image = SalesPerson;
                //         RunObject = Report "Sales Per Item POS";
                //     }
                //     action("Sales Per item Summary")
                //     {
                //         ApplicationArea = All;
                //         Image = AddWatch;
                //         RunObject = Report "Sales Per Item Summary";
                //     }
                // }
                /* group(Cafeteria_Reports)
                {
                    Caption = 'Cafe Reports';
                    Image = Receipt;
                    Visible = false;
                    action("Receipts Register")
                    {
                        Caption = 'Receipts Register';
                        Image = Report2;
                        
                        
                        RunObject = Report "CAT-Sales Register";
                    }
                    action("Daily Summary Saless")
                    {
                        Caption = 'Daily Summary Saless';
                        Image = Report2;
                        
                        
                        RunObject = Report "CAT-Catering Daily Sum. Saless";
                    }
                    action("Daily Sales Summary")
                    {
                        Caption = 'Daily Sales Summary';
                        Image = Report2;
                        
                        
                        RunObject = Report "CAT-Daily Sales Summary (All)";
                    }
                    action("Cafe Revenue Report")
                    {
                        Caption = 'Cafe Revenue Report';
                        Image = Report2;
                        
                        
                        RunObject = Report "CAT-Cafe Revenue Reports";
                        ApplicationArea = All;
                    }
                    action("Sales Summary")
                    {
                        Caption = 'Sales Summary';
                        Image = Report2;
                        
                        
                        RunObject = Report "CAT-Daily Sales Summary (Std)";
                    }
                    action("Cafe` Menu")
                    {
                        Caption = 'Cafe Menu';
                        Image = Report2;
                        
                        
                        Visible = false;
                        RunObject = Report "CAT-Cafeteria Menu";
                        ApplicationArea = All;
                    }
                } */

            }
        }
        area(sections)
        {
            // group(CafeMan)
            // {
            //     Caption = 'POS';

            //     action(MealsPhyInvJournal)

            //     {
            //         Caption = 'Meals Phy. Inv. Journa';
            //         RunObject = Page "Meals Phy. Inv. Journal";
            //         Image = InventoryJournal;
            //     }
            //     action("Food Item Inventory ")
            //     {
            //         Caption = 'Cafe Menu Items';
            //         RunObject = page "Food Item Inventory";
            //         Image = LinesFromTimesheet;
            //     }
            //     action("CAFE Food Item List")
            //     {
            //         Caption = 'Food Inventory';
            //         RunObject = page "CAFE Food Item List";

            //     }
            //     action(CafeteriaMenuPrices)

            //     {
            //         Caption = 'Food Price List';
            //         RunObject = Page "Cafeteria Menu Prices";
            //         Image = PostedCreditMemo;
            //     }

            //     action("Cash Sale Header-Staff")
            //     {
            //         Caption = 'Staff Cash Sale';
            //         RunObject = Page "Cash Sale Header-Staff";
            //         
            //         PromotedOnly = true;
            //         Visible = false;
            //         
            //     }
            //     action("Cash Sale Header-Student")
            //     {
            //         Caption = 'Student Cash Sale';
            //         RunObject = Page "Cash Sale Header-Student";
            //         
            //         PromotedOnly = true;
            //         Visible = false;
            //         
            //     }
            //     action("POS Reports")
            //     {
            //         Caption = 'POS Reports';
            //         RunObject = Page "POS Sales Reports";
            //         
            //         Visible = false;
            //         PromotedOnly = true;
            //         
            //     }
            //     action(PostedMealProcBatches)
            //     {
            //         Caption = 'Posted Batches';
            //         RunObject = Page "Posted Meal-Proc. Batches";
            //         Image = ProfileCalendar;
            //     }
            //     action("Sales Receipts (New)")
            //     {
            //         Caption = 'Sales Receipts (New)';
            //         RunObject = Page "CAT-Cafe. Rec. List (Filtered)";
            //         
            //         PromotedOnly = true;
            //         Visible = false;
            //         
            //     }
            //     action("Receipts (Unprinted)")
            //     {
            //         Caption = 'Receipts (Unprinted)';
            //         RunObject = Page "CAT-Unprinted Cafeteria Recpts";
            //     }
            //     action("Receipts (UnPosted)")
            //     {
            //         Caption = 'Receipts (UnPosted)';
            //         RunObject = Page "CAT-Unposted Cafeteria Recpts";
            //     }
            //     action("Receipts (Cancelled)")
            //     {
            //         Caption = 'Receipts (Cancelled)';
            //         Visible = false;
            //         RunObject = Page "CAT-Cancelled Cafeteria Recpts";
            //     }
            //     action("Receipts (Posted)")
            //     {
            //         Caption = 'Receipts (Posted)';
            //         RunObject = Page "CAT-Posted Cafeteria Receipts";
            //     }






            //     action(MealsCentralSetup)

            //     {
            //         Caption = 'Meals Proc. Central Setup';
            //         RunObject = Page "Meal-Proc. Central Setup";
            //         Image = CancelledEntries;
            //     }
            //     action(MealBatchNoSetup)

            //     {
            //         Caption = 'Meal Batch No Setup';
            //         RunObject = Page "Meal Batch No. Setup";
            //         Image = ChangeBatch;
            //     }
            //     action(CafeteriaLocations)

            //     {
            //         Caption = 'Cafeteria Locations';
            //         RunObject = Page "Cafeteria Locations";
            //         Image = PostedDeposit;
            //     }

            //     action(MealsProductionPermissions)

            //     {
            //         Caption = 'Meals Prod. Permissions';
            //         RunObject = Page "Meal-Proc. Permissions";
            //         Image = PrepaymentInvoice;
            //     }

            //     action(CashUserTemplate)

            //     {
            //         Caption = 'Cash Office User Template';
            //         RunObject = Page "Cash Office User Template UP";
            //         Visible = false;
            //         Image = CashFlowSetup;
            //     }
            //     action(PostedFoodStocksDate)

            //     {
            //         Caption = 'Posted Stocks';
            //         RunObject = Page "Posted Food Stocks/Date";
            //         Image = PostedCreditMemo;
            //     }
            //     action("Cash Sale List-Student")
            //     {
            //         Caption = 'Staff Sales';
            //         RunObject = page "Cash Sale List-Student";
            //     }
            // }
            // group("POS Sales")
            // {

            //     action("POS Setup")
            //     {
            //         ApplicationArea = All;
            //         Image = SetupPayment;
            //         RunObject = Page "POS Setup";

            //     }
            //     action("POS Items")
            //     {
            //         ApplicationArea = All;


            //         Image = SalesInvoice;
            //         RunObject = Page "POS Items";

            //     }
            //     action("Stock Adjuctment")
            //     {
            //         ApplicationArea = All;


            //         Image = AdjustEntries;
            //         RunObject = Page "POS Stock Header List";
            //     }
            //     action("POSSales")
            //     {
            //         Caption = 'POS Sales';
            //         ApplicationArea = All;


            //         Image = PostedPayment;
            //         RunObject = Page "POS Sales Header List";
            //     }

            // }
            // group(SalesPos)
            // {
            //     action("StudentsSales")
            //     {
            //         AccessByPermission = TableData "POS Sales Header" = IMD;
            //         ApplicationArea = Basic, suite;
            //         Caption = 'Student sales';

            //         Image = ExportMessage;
            //         ShortcutKey = 'F7';
            //         RunObject = Page "POS Sales Student Card";
            //         RunPageMode = Create;
            //     }
            //     action("StaffSales")
            //     {

            //         AccessByPermission = TableData "POS Sales Header" = IMD;
            //         ApplicationArea = Basic, suite;
            //         Caption = 'Staff sales';

            //         Image = ExportMessage;
            //         ShortcutKey = 'F9';
            //         RunObject = Page "POS Sales Staff";
            //         RunPageMode = Create;
            //     }
            // }



            group("Hostel Management")
            {
                Caption = 'Hostel Management';
                Image = FixedAssets;
                action(HostelsList)
                {
                    Caption = 'Hostels';
                    Image = Register;



                    RunObject = Page "ACA-Hostel List";
                    ApplicationArea = All;
                }
                action(Allocations)
                {
                    Caption = 'Hostel Room Allocations';
                    Image = Registered;



                    RunObject = Page "ACA-Std Hostel Lists";
                    ApplicationArea = All;
                }
                action("Hostel Bookings ")
                {
                    Caption = 'Online Hostel Bookings (Unallocated)';
                    RunObject = Page "ACA-Hostel Bookings (Unalloc.)";
                    ApplicationArea = All;
                }
                action("Posted Allocations")
                {
                    Caption = 'Allocations';
                    Image = Aging;

                    RunObject = Page "ACA-Std Hostel Lists Hist";
                    ApplicationArea = All;
                }
                action("Student Information")
                {
                    Caption = 'Student Information';
                    RunObject = Page "ACA-Std Information (Hostels)";
                    ApplicationArea = All;
                }
                action("Hostel Billing")
                {
                    Caption = 'Hostel Billing';
                    Image = Invoice;

                    RunObject = Page "ACA-Std Billing List";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Hostel Sub-Store")
                {
                    Caption = 'Hostel Sub-Store';
                    Image = Invoice;

                    RunObject = Page "Hostel items";
                    ApplicationArea = All;
                }
                action("Store Adjustments")
                {
                    Caption = 'Store Adjustments';
                    image = VendorBill;
                    RunObject = page "Hostel Stock Header";
                    ApplicationArea = all;

                }

            }
            group(Setups)
            {
                Caption = 'Hostel Setups';
                Image = Setup;
                action(ACAHostelPermissions)

                {
                    Caption = 'Hostel Permissions';
                    RunObject = Page "ACA-Hostel Permissions";
                    Image = Permission;
                    ApplicationArea = All;
                }
                action("Hostels List")
                {
                    Caption = 'Hostels List';
                    RunObject = Page "ACA-Hostel List";
                    ApplicationArea = All;
                }
                action("Inventory Items")
                {
                    Caption = 'Inventory Items';
                    Image = InventorySetup;


                    RunObject = Page "ACA-Hostel Invtry Items List";
                    ApplicationArea = All;
                }
            }
            group(hist)
            {
                Caption = 'Hostel History';
                Image = History;
                action("Allocation (Uncleared)")
                {
                    Caption = 'Allocation (Uncleared)';
                    RunObject = Page "ACAHostel Bookings (All. List)";
                    ApplicationArea = All;
                }
                action("Allocation History (Cleared)")
                {
                    Caption = 'Allocation History (Cleared)';
                    Image = Invoice;

                    RunObject = Page "ACA-Hostel Bookings (History)";
                    ApplicationArea = All;
                }
                action("Historical Allocations")
                {
                    Caption = 'Historical Allocations';
                    Image = History;

                    RunObject = Page "ACA-Std Information (Hostels)h";
                    ApplicationArea = All;
                }
                action("Help Desk")
                {
                    Caption = 'Communication Help Desk';
                    image = Help;
                    RunObject = page "Help Desk";
                    ApplicationArea = all;
                }
            }
            group("Students Management")
            {
                Visible = false;
                Caption = 'Students Management';
                Image = ResourcePlanning;
                action(Registration)
                {
                    Image = Register;



                    RunObject = Page "ACA-Std Registration List";

                    Visible = false;
                    ApplicationArea = All;
                }
                action("Students Card")
                {
                    Image = Registered;



                    RunObject = Page "ACA-Std Card List";
                    ApplicationArea = All;
                }
                action(Programmes)
                {
                    Caption = 'Programmes';
                    RunObject = Page "ACA-Programmes List";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Signing of Norminal Role")
                {
                    Caption = 'Signing of Norminal Role';
                    RunObject = Page "ACA-Norminal Role Signing";
                    Visible = false;
                    ApplicationArea = All;
                }
                // action("Class Allocations")
                // {
                //     Image = Allocate;
                //     RunObject = Page "HRM-Class Allocation List";
                //     Visible = false;
                //     ApplicationArea = All;
                // }
            }

            group(CafeSetups)
            {
                Caption = 'Cafe Setups';
                Visible = false;
                action("Sales Sections")
                {
                    Caption = 'Sales Sections';
                    Image = SelectEntries;


                    RunObject = Page "CAT-Catering Sale Points";
                    ApplicationArea = All;
                }
                action("Cafe` Staff")
                {
                    Caption = 'Cafe Staff';
                    RunObject = Page "CAT-Staff List";
                    ApplicationArea = All;
                }
                action("Meals Setup")
                {
                    Caption = 'Meals Setup';
                    RunObject = Page "CAT-Cafe. Meals Setup List";
                    ApplicationArea = All;
                }
                action("General Setup")
                {
                    Caption = 'General Setup';
                    RunObject = Page "CAT-Cafe. General Setup List";
                    ApplicationArea = All;
                }
                action("Meals Inventory2")
                {
                    Caption = 'Meals Inventory';
                    RunObject = Page "CAT-Cafe. Item Inventory List2";
                    ApplicationArea = All;
                }
                action("Staff Setup")
                {
                    Caption = 'Staff Setup';
                    RunObject = Page "CAT-Waiters List";
                    ApplicationArea = All;
                }
            }
            group("Accomodation Sub-Store")
            {
                Caption = 'Accomodation Sub-store';
                action("Main Store  inventory ")
                {
                    Caption = 'Main Store Inventory';
                    ApplicationArea = all;
                    RunObject = page "Item List";
                    RunPageLink = "Inventory Posting Group" = filter('HOSTEL');
                }
                action("Main Store  issued  ")
                {
                    Caption = 'Main Store  issued ';
                    ApplicationArea = all;
                    RunObject = page "PROC-Posted Store Reqs";
                    RunPageLink = "Department Name" = filter('HOSTEL');

                }
                action("sub-store item List")
                {
                    Caption = 'sub-store item List';
                    ApplicationArea = all;
                    RunObject = page "Hostel sub-store items";

                }
                action("Sub-Store Adjustments  List")
                {
                    Caption = 'Sub-Store Adjustments  List';
                    ApplicationArea = all;
                    RunObject = page "Stock Hostel Header list";
                }

            }
            group("Hostel Online Repairs")
            {
                Caption = 'Hostel Online Repairs';

                action("Pending Repaire Request")
                {
                    ApplicationArea = all;
                    Caption = 'Repair Request Pending Assignment ';
                    RunObject = page "Repair Requests";
                    RunPageLink = Status = filter(Open);
                    Enabled = false;
                }
                action("Approved Repaire Request")
                {
                    ApplicationArea = all;
                    Caption = 'Assigned Request OnProgress ';
                    RunObject = page "Repair Requests";
                    RunPageLink = Status = filter(Approved);
                    Enabled = false;
                }
                action("Closed Repaire Request")
                {
                    ApplicationArea = all;
                    Caption = 'Assigned Request OnProgress ';
                    RunObject = page "Repair Requests";
                    RunPageLink = Status = filter(Closed);
                    Enabled = false;
                }

            }
            group("Hostel Damages")
            {
                Caption = 'Hostel Damages';

                action("Recorded Damage list")
                {
                    ApplicationArea = all;
                    Caption = 'Recorded Damage list ';
                    RunObject = page "damage list";
                    RunPageLink = Status = filter(initiated);
                    Enabled = false;
                }
                action("DVC ARE pending Approval ")
                {
                    ApplicationArea = all;
                    Caption = 'DVC(ARE) pending Approval ';
                    RunObject = page "damage list";
                    RunPageLink = Status = filter(dvc);
                    Enabled = false;
                }
                action("DVC ARE Cancelled  Approval ")
                {
                    ApplicationArea = all;
                    Caption = 'canceled DVC(ARE) request ';
                    RunObject = page "damage list";
                    RunPageLink = Status = filter(cancel);
                    Enabled = false;
                }
                action("Finance Pending Approval ")
                {
                    ApplicationArea = all;
                    Caption = 'Finance Pending processing ';
                    RunObject = page "damage list";
                    RunPageLink = Status = filter(finance);
                    Enabled = false;
                }
                action("Billed Damages ")
                {
                    ApplicationArea = all;
                    Caption = 'Billed Damages ';
                    RunObject = page "damage list";
                    RunPageLink = Status = filter(billed);
                    Enabled = false;
                }

            }

            group(Common_req)
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
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    RunObject = Page "CAT-Meal Booking List";
                }
                action("Approved Meal booking")
                {
                    Caption = 'Approved Meal Bookings';
                    RunObject = page "CAT-Meal Booking Approved";
                    ApplicationArea = All;
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
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


        }
        area(processing)
        {
            group(Sales)
            {
                action("Students Sales")
                {
                    AccessByPermission = TableData "POS Sales Header" = IMD;
                    ApplicationArea = Basic, suite;

                    Image = ExportMessage;
                    RunObject = Page "POS Sales Student Card";
                    RunPageMode = Create;
                }
                action("Staff Sales")
                {
                    AccessByPermission = TableData "POS Sales Header" = IMD;
                    ApplicationArea = Basic, suite;

                    Image = ExportMessage;
                    RunObject = Page "POS Sales Staff";
                    RunPageMode = Create;
                }

            }
        }
    }
}

profile "Hostels"
{
    ProfileDescription = 'HostelMan';
    RoleCenter = "CAT-Cafeteria Role Center";
    Caption = 'Hostel Manager';
}

