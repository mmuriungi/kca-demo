page 54318 "CAFE Role Center"
{
    Caption = 'Cafeteria';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Invt)
            {
                ShowCaption = false;
                part(x; "Food Item Inventory")
                {
                    ApplicationArea = All;
                }
            }
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }

        }
    }

    actions
    {
        area(sections)
        {
            group(sales)
            {
                action("Cash Sale List-Staff")
                {
                    Caption = 'Staff Sales';
                    RunObject = page "Cash Sale List-Staff";
                    Visible = false;
                    ApplicationArea = All;



                }
                action("Cash Sale List-Student")
                {
                    Caption = 'Student Sales';
                    RunObject = page "Cash Sale List-Student";
                    ApplicationArea = All;
                }

            }
            group(History)
            {
                action("Posted Direct Sales")
                {
                    Caption = 'Posted Sales';
                    RunObject = page "Posted Direct Sales";
                    ApplicationArea = All;
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
                action("Meal booking")
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
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }
                action("Claim  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Claim Requisitions';
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Create Claim requisition from Users.';
                }

                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("Transport Requisition")
                {
                    ApplicationArea = All;
                    Image = MapAccounts;
                    RunObject = Page "FLT-Transport Req. List";
                }
                action("Meal Bookings")
                {
                    ApplicationArea = All;
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                }

            }
        }
        area(creation)
        {
            group(SalesRep)
            {
                Caption = 'Sales Reports';
                Image = "Report";
                action(CustStatement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Inv./Item';
                    Image = "Report";

                    RunObject = Report "Summary Cust. Invoices/Item";
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                }
                action(GraphicalCustInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Graphical Customer Invoices';
                    Image = "Report";

                    RunObject = Report "Graphical Cust. Invoices";
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                }
                action("Graphical Cust. In. 2")
                {
                    Caption = 'Graphical Cust. In. 2';
                    Image = "Report";
                    RunObject = Report "Graphical Cust. Invoices 2";
                    ToolTip = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    ApplicationArea = All;
                }
                action("Sales By Sales Person/Date")
                {
                    Caption = 'Sales By Sales Person/Date';
                    Image = "Report";
                    RunObject = Report "Sales By Sales Person/Date";
                    ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    ApplicationArea = All;
                }
                action("Sales by Salesp./Month")
                {
                    Caption = 'Sales by Salesp./Month';
                    Image = "Report";
                    RunObject = Report "Sales By Sales Person/Month";
                    ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    ApplicationArea = All;
                }
                action("Sales By Salesp./Item")
                {
                    Caption = 'Sales By Salesp./Item';
                    Image = "Report";
                    RunObject = Report "Sales By SalesPerson/Item";
                    ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    ApplicationArea = All;
                }
                action("Sales Person and Item Class")
                {
                    Caption = 'Sales Person and Item Class';
                    Image = "Report";
                    RunObject = Report "Sales By SalesP./Item/Class";
                    ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    ApplicationArea = All;
                }
            }
            group("PosSalesRep.")
            {
                Caption = 'POS Sales';
                Image = "Report";
                action(DirectSalesReg)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Direct Sales Register';
                    Image = "Report";

                    RunObject = Report "Direct Sales Register";
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                }
                action(DetailedDirectSales)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Det. Direct Sales';
                    Image = "Report";

                    RunObject = Report "Det. Direct Sales Register";
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                }
                action("Direct Sales Reg./User")
                {
                    Caption = 'Direct Sales Reg./User';
                    Image = "Report";
                    RunObject = Report "Direct Sales Register/User";
                    ToolTip = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    ApplicationArea = All;
                }
                action("Direct Sales by User/Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Direct Sales by User/Date';
                    Image = "Report";
                    RunObject = Report "Direct Sales User/Date";
                    ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                }
                action("Sales By User/Trans. Type/Month")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales By User/Trans. Type/Month';
                    Image = "Report";
                    RunObject = Report "Sales Person/Month/Trans T.";
                    ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                }
                action("Sales Register By Trans. type")
                {
                    Caption = 'Sales Register By Trans. type';
                    Image = "Report";
                    RunObject = Report "Direct Sales Register T. Type";
                    ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    ApplicationArea = All;
                }
            }
            group(FinanceReports)
            {
                Caption = 'Finance Reports';
                Image = "Report";
                Visible = false;
                action(Top10)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Top 10 List';
                    Image = "Report";
                    RunObject = Report "Customer - Top 10 List";
                    ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                }
                action(CustSales)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Sales List';
                    Image = "Report";
                    RunObject = Report "Customer - Sales List";
                    ToolTip = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                }
                action(CustSalesStats)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Statistics';
                    Image = "Report";
                    //  RunObject = Report "Customer Sales Statistics";
                    ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                }
                action("Customer - Summary Aging")
                {
                    Caption = 'Customer - Summary Aging';
                    Image = "Report";
                    RunObject = Report "Customer - Summary Aging Simp.";
                    ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    ApplicationArea = All;
                }
                action("Aged Accounts Receivable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                    ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Customer - Payment Receipt")
                {
                    ApplicationArea = Suite;
                    Caption = 'Customer - Payment Receipt';
                    Image = "Report";
                    RunObject = Report 211;
                    ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
                }
                action(CustListWithBalances)
                {
                    Caption = 'Customer Listing With Balances';
                    Image = "Report";

                    // RunObject = Report "Customer Listing";
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    ApplicationArea = All;
                }
                action(CustItemStats)
                {
                    Caption = 'Customer/Item Statistics';
                    Image = "Report";

                    //  RunObject = Report "Customer/Item Statistics";
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    ApplicationArea = All;
                }
                action(CustItemStatsSalesP)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cust. Item. Stat. by Salesp.';
                    Image = "Report";
                    // RunObject = Report "Cust./Item Stat. by Salespers.";
                    ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                }
                action(DailyInvRep)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Daily Invoicing Report';
                    Image = "Report";
                    //  RunObject = Report "Daily Invoicing Report";
                    ToolTip = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                }
                action(ItemStatusBySalesp)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Status By salesp.';
                    Image = "Report";
                    // RunObject = Report "Item Status by Salesperson";
                    ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                }
                action("Customer Register")
                {
                    Caption = 'Customer Register';
                    Image = "Report";
                    ApplicationArea = All;
                    // RunObject = Report 10046;
                }
                action("Customer - Top 10 List")
                {
                    Caption = 'Customer - Top 10 List';
                    Image = "Report";
                    RunObject = Report 111;
                    ApplicationArea = All;
                }
            }
        }
    }
}

