page 54373 "Procurement Management RC"
{
    PageType = rolecenter;

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
            group(ProcPlan)
            {
                Caption = 'Procurement Plan';
                action("Workplan List")
                {
                    Caption = 'Workplan List';
                    Image = Worksheet;
                    ApplicationArea = All;
                    RunObject = Page 50156;
                }
                action(planning)
                {
                    ApplicationArea = Suite;
                    Caption = 'Procurement Plan';
                    RunObject = Page "PROC-Procurement Plan Header";
                    ToolTip = 'Create purchase requisition from departments.';
                }

                action("Workplan Card")
                {
                    Caption = 'Workplan Card';
                    RunObject = Page 50164;
                }
                action("Budget Workplan Names")
                {
                    Caption = 'Budget Workplan Names';
                    RunObject = Page 50163;
                }
                action("Procurement Method")
                {
                    Caption = 'Procurement Methods';
                    RunObject = Page 50169;
                }
                action("Workplan Activities")
                {
                    Caption = 'Workplan Activities';
                    RunObject = Page 50157;
                }
                action("Budget")
                {
                    Caption = 'Budget Workplan';
                    RunObject = Page 50161;
                }
                action(WorkPlan_Creation)
                {
                    Caption = 'WorkPlan Creation';
                    RunObject = Page 50165;
                }
            }
            group(Tender)
            {
                Caption = 'Tendering Process';
                Image = LotInfo;
                Visible = False;

                action("Tendering")
                {
                    Caption = 'Tender Applicants';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Applicants List";
                }
                action(Tenders)
                {
                    Caption = 'Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender List";
                }
                action(SubmittedTenders)
                {
                    Caption = 'Submitted Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Submission List View";
                }
                action(PreliminaryQualifiers)
                {
                    Caption = 'Preliminary Qualifiers';
                    ApplicationArea = basic, suite;
                    //RunObject = Page "Tender Preliminary QualfyList";
                    RunObject = Page "Tender Prelim QualifyiedL";
                }
                action(TechnicalQualifiers)
                {
                    Caption = 'Technical Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Technical QualifyiedL";
                    //RunObject = Page "Tender Technical QualifiedList";

                }
                action(DemoQualifiers)
                {
                    Caption = 'Demonstration Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Demo QualifyiedL";
                    //RunObject = Page "Tender Demo QualifiedList";
                }
                action(FinancialQualifiers)
                {
                    Caption = 'Financial Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Fin QualifyiedL";
                }
                action(Award)
                {
                    Caption = 'Awarded';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Awarded List";
                }
                group(TenderSetup)
                {

                    Caption = 'Setups';
                    Visible = False;
                    action(PreliminarySetup)
                    {
                        Caption = 'Preliminary Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Preliminary Reqs Setup";
                    }
                    action(TechnicalSetup)
                    {
                        Caption = 'Technical Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Technical Eval Setup";
                    }
                    action(DemoSetup)
                    {
                        Caption = 'Demonstration Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Demo Setup";
                    }
                    action(financialSetup)
                    {
                        Caption = 'Financial Setups';
                        ApplicationArea = All;
                        RunObject = Page "Tender Financial Setups";
                    }
                }
            }
            group(TenderD)
            {
                Caption = 'Failed Bids';
                Visible = False;
                action(PQTenders)
                {
                    Caption = 'Preliminary Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Preliminary List";
                }
                action(TQTenders)
                {
                    Caption = 'Technical Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Technical List";
                }
                action(DQTenders)
                {
                    Caption = 'Demo Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Demo List";
                }
                action(FQTenders)
                {
                    Caption = 'Financial Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Financial List";
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
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
                }
                // action("Page FLT Transport Requisition2")
                // {
                //     Caption = 'Transport Requisition';
                //     ApplicationArea = All;
                //     RunObject = Page "FLT-Transport Req. List";
                // }

                // action("Meal Booking")
                // {
                //     Caption = 'Meal Booking';
                //     ApplicationArea = All;
                //     RunObject = Page "CAT-Meal Booking List";
                // }
            }
            group("Procurement Process")
            {

                action("Requisitions")
                {
                    Caption = 'Open Requests';
                    ApplicationArea = All;
                    Image = Purchasing;
                    RunObject = page "FIN-Purchase Requisition";
                    RunPageLink = Status = const(Open);
                }
                action("Pending Approval")
                {
                    //Caption = 'Open Requests';
                    ApplicationArea = All;
                    Image = Purchasing;
                    RunObject = page "FIN-Purchase Requisition";
                    RunPageLink = Status = const("Pending Approval");
                }
                action("Approved Requests")
                {
                    Caption = 'Approved Purchase Requests';
                    ApplicationArea = All;
                    Image = Purchasing;
                    RunObject = page "FIN-Purchase Requisition";
                    RunPageLink = Status = const(Released);
                }
                action("RFQ")
                {
                    ApplicationArea = All;
                    Image = Questionaire;
                    RunObject = Page "PROC-Purchase Quote List";

                }
                action("Quotes")
                {
                    ApplicationArea = All;
                    Image = Quote;
                    RunObject = page "Proc-Purchase Quotes List";
                }
                action("Procurement Orders")
                {
                    ApplicationArea = All;
                    Image = OrderList;
                    RunObject = page "Purchase Order List";

                }
            }
            group("Store Requisition")
            {
                Caption = 'Store Requisitions';
                action("Store Requests")
                {
                    ApplicationArea = All;
                    Image = Document;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("All SRNS")
                {
                    ApplicationArea = All;
                    Image = AboutNav;

                    RunObject = page "All Store Requisition";
                }
                action("Approved SRNS")
                {
                    ApplicationArea = All;

                    Image = SettleOpenTransactions;
                    RunObject = Page "PROC-Approved Store Reqs";
                }

                action("Posted Store Requisitions")
                {
                    Caption = 'Posted SRNS';
                    ApplicationArea = All;
                    Image = PostedOrder;
                    RunObject = Page "PROC-Posted Store Reqs";
                }

            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
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

            }

            group("Approval Requests")
            {
                action(approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approval Requests';
                    Image = Approve;
                    RunObject = page "Requests to Approve";

                }
            }



        }
        area(Embedding)
        {
            action("Purchase Orders")
            {
                ApplicationArea = All;
                Image = Order;
                RunObject = page "Purchase Order List";
            }
            action("Purchase Invoices")
            {
                ApplicationArea = All;
                Image = NewPurchaseInvoice;
                RunObject = page "Purchase Invoices";
            }
            action("Vendors")
            {
                ApplicationArea = All;
                Image = Vendor;
                RunObject = page "Vendor List";

            }
            action("Items")
            {
                ApplicationArea = All;
                Image = Item;
                RunObject = Page "Item List";
            }
            action("Fixed Assets")
            {
                ApplicationArea = All;
                Image = FixedAssets;
                RunObject = page "Fixed Asset List";
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Image = InsertFromCheckJournal;
                RunObject = page "Item Journal Templates";
            }
        }

        area(Reporting)
        {

            group(PurchaseInvoices)
            {
                Caption = 'Purchase Invoices';
                action("Purchase Invoice")
                {
                    ApplicationArea = All;
                    Image = PurchaseInvoice;
                    RunObject = page "Purchase Invoices";
                }
            }
            group("Credit Memos")
            {
                action("Credit Memp")
                {
                    ApplicationArea = All;
                    Image = CreditMemo;
                    RunObject = page "Purchase Credit Memos";
                }

            }
            group("Vendor Classification")
            {
                action("Vendor Categories")
                {
                    ApplicationArea = All;
                    Image = VendorContact;
                    RunObject = page "PROC-Vendor Categories";
                }
                action("Prequalification Periods")
                {
                    ApplicationArea = All;
                    Image = VendorContact;
                    RunObject = page "PROC-Vendor Prequalifications";
                }
            }
            group("Reports")
            {
                action("PO Report")
                {
                    ApplicationArea = All;
                    Image = OrderList;
                    RunObject = Report "Order Status Report";
                }
                action("Vendor balances")
                {
                    ApplicationArea = All;
                    Image = MakeAgreement;
                    RunObject = report "Vendor - Trial Balance";
                }
                group(Inventory)
                {
                    Caption = 'Inventory';
                    action("Inventory - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        Image = "Report";
                        RunObject = Report "Inventory - List";
                        ToolTip = 'View various information about the item, such as name, unit of measure, posting group, shelf number, vendor''s item number, lead time calculation, minimum inventory, and alternate item number. You can also see if the item is blocked.';
                    }


                    action("Phys. Inventory List")
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Phys. Inventory List';
                        Image = "Report";
                        RunObject = Report "Phys. Inventory List";
                        ToolTip = 'View a list of the lines that you have calculated in the Phys. Inventory Journal window. You can use this report during the physical inventory count to mark down actual quantities on hand in the warehouse and compare them to what is recorded in the program.';
                    }
                    action("Inventory Availability")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Availability';
                        Image = "Report";
                        RunObject = Report "Inventory Availability";
                        ToolTip = 'View, print, or save a summary of historical inventory transactions with selected items, for example, to decide when to purchase the items. The report specifies quantity on sales order, quantity on purchase order, back orders from vendors, minimum inventory, and whether there are reorders.';
                    }
                    group("Item Register")
                    {
                        Caption = 'Item Register';
                        Image = ItemRegisters;
                        action("Item Register - Quantity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Register - Quantity';
                            Image = "Report";
                            RunObject = Report "Item Register - Quantity";
                            ToolTip = 'View one or more selected item registers showing quantity. The report can be used to document a register''s contents for internal or external audits.';
                        }
                        action("Item Register - Value")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Register - Value';
                            Image = "Report";
                            RunObject = Report "Item Register - Value";
                            ToolTip = 'View one or more selected item registers showing value. The report can be used to document the contents of a register for internal or external audits.';
                        }
                    }

                    group("Inventory Details")
                    {
                        Caption = 'Inventory Details';
                        Image = "Report";
                        action("Inventory - Transaction Detail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Transaction Detail';
                            Image = "Report";
                            RunObject = Report "Inventory - Transaction Detail";
                            ToolTip = 'View transaction details with entries for the selected items for a selected period. The report shows the inventory at the beginning of the period, all of the increase and decrease entries during the period with a running update of the inventory, and the inventory at the close of the period. The report can be used at the close of an accounting period, for example, or for an audit.';
                        }
                        action("Item Age Composition - Quantity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Age Composition - Quantity';
                            Image = "Report";
                            RunObject = Report "Item Age Composition - Qty.";
                            ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.';
                        }
                        action("Item Expiration - Quantity")
                        {
                            ApplicationArea = ItemTracking;
                            Caption = 'Item Expiration - Quantity';
                            Image = "Report";
                            RunObject = Report "Item Expiration - Quantity";
                            ToolTip = 'View an overview of the quantities of selected items in your inventory whose expiration dates fall within a certain period. The list shows the number of units of the selected item that will expire in a given time period. For each of the items that you specify when setting up the report, the printed document shows the number of units that will expire during each of three periods of equal length and the total inventory quantity of the selected item.';
                        }
                    }
                }

            }
            group("Setups")
            {
                Action("Purchases & Payables")
                {
                    ApplicationArea = All;
                    Image = AdministrationSalesPurchases;
                    RunObject = page "Purchases & Payables Setup";
                }
                action("Inventory Setup")
                {
                    ApplicationArea = All;
                    Image = InventorySetup;
                    RunObject = page "Inventory Setup";

                }

            }

        }
    }


}