page 54598 "Stores Requisition Role Centre"
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
        area(Reporting)
        {
            group("Resources")
            {
                Action(Items)
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
                action("Purchase Orders")
                {
                    ApplicationArea = All;
                    image = "Order";
                    RunObject = page "Purchase Orders";
                }
            }
        }



        area(sections)
        {
            group("Credit Nemos")
            {
                action("Credit Memo")
                {
                    ApplicationArea = Basic, Suite;
                    Image = CreditMemo;
                    RunObject = page "Purchase Credit Memos";
                }
                action("Posted Credit Memo")
                {
                    ApplicationArea = Basic, Suite;
                    Image = CreditMemo;
                    RunObject = page "Posted Purchase Credit Memos";
                }

            }
            group("All SRNS")
            {
                action("Store Requisitions")
                {
                    ApplicationArea = All;
                    Image = SelectMore;
                    RunObject = page "All Store Requisition";
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
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;

                action("Pending Approval")
                {
                    ApplicationArea = all;
                    Caption = 'Requests to Approve';
                    RunObject = Page "Requests to Approve";
                }
                action("Pending My Approval")
                {
                    ApplicationArea = all;
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                }
                /*   action("My Approval requests")
                  {
                      ApplicationArea = all;
                      Caption = 'My Approval request Entries';
                      RunObject = Page "Approval Request Entries";
                  } */

            }
            group(Inventory)
            {
                action("Inventory - &Availability Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory - &Availability Plan';
                    Image = ItemAvailability;
                    RunObject = Report "Inventory - Availability Plan";
                    ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                }
                action("Inventory &Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory &Purchase Orders';
                    Image = "Report";
                    RunObject = Report "Inventory Purchase Orders";
                    ToolTip = 'View a list of items on order from vendors. The report also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
                }
                action("Inventory - &Vendor Purchases")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory - &Vendor Purchases';
                    Image = "Report";
                    RunObject = Report "Inventory - Vendor Purchases";
                    ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
                }
                action("Inventory &Cost and Price List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory &Cost and Price List';
                    Image = "Report";
                    RunObject = Report "Inventory Cost and Price List";
                    ToolTip = 'View price information for your items or stockkeeping units, such as direct unit cost, last direct cost, unit price, profit percentage, and profit.';
                }
            }

        }


    }

}

