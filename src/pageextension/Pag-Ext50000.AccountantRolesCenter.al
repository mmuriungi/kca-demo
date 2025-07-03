pageextension 50000 "Accountant Roles Center" extends "Accountant Role Center"
{
    layout
    {

    }
    actions
    {


        addafter("Cash Management")
        {
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


                action("Payment Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Vouchers';
                    Image = Journal;
                    RunObject = Page "FIN-Payment Vouchers";
                    ToolTip = 'Payment Vouchers';
                }
                action("Posted Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Vouchers';
                    Image = Journal;
                    RunObject = Page "FIN-Posted Payment Vouch.";
                    ToolTip = 'Posted Payment Vouchers';
                }
                action("Tax Payment Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tax Payment Vouchers';
                    Image = Journal;
                    RunObject = Page "Fin-Tax Payments Vouchers";
                    ToolTip = 'Posted Payment Vouchers';
                }
                action("Tax Ledgers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tax  Ledger Entries';
                    Image = Journal;
                    RunObject = Page "Tax  Ledger Entries";
                    ToolTip = 'Tax  Ledger Entries';
                }
                action("Tax  Payment Ledgers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tax  Payment Ledgers';
                    Image = Journal;
                    RunObject = Page "Tax Payment Ledgers";
                    ToolTip = 'Tax  Payment Ledgers';
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

                action("Asset Movement")
                {
                    ApplicationArea = all;
                    RunObject = page "FIN-Asset Transfer List";
                }
                action("Asset Movement Ledgers")
                {
                    RunObject = page "Asset Movements Ledgers";
                    caption = 'Asset Movement Ledgers';
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
            Group("Imprest Management")
            {
                Caption = 'Imprest Management';
                action("Imprest")
                {//Receipt List
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Warrant';
                    Image = Journal;
                    RunObject = Page "Imprest List Finance";
                    //RunPageView = WHERE("Template Type" = CONST(General),Recurring = CONST(false));
                    ToolTip = 'Imprest Requests';
                }
                action("Imprest Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Vouchers';
                    Image = Journal;
                    RunObject = Page "FIN-Imprest Vouchers";

                    ToolTip = 'Imprest Vouchers';

                }

                action("Posted Imprest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Imprest';
                    Image = Journal;
                    RunObject = Page "FIN-Posted imprest list";
                    ToolTip = 'Posted Imprests';

                }
                action("Outstanding Imprest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Outstanding Imprest';
                    Image = Journal;
                    RunObject = Page "Outstanding Imprest";
                    ToolTip = 'Outstanding Imprests';


                }
                action("Overdue Imprest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Overdue Imprest';
                    Image = Journal;
                    RunObject = Page "FIN-Overdue Imprest";
                    ToolTip = 'OOverdue Imprests';


                }
                action("Imprest Recovered")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Recovered';
                    Image = Journal;
                    RunObject = Page "Imprest Transfer to Payroll";
                    ToolTip = 'Imprest Recovered';


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
                action("Imprest_Register")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Register';
                    Image = Journal;
                    //RunObject = Page "FIN-Travel Advance Acc. UP";
                    RunObject = Report "FIN-Imprest Register Report";
                    //RunObject = Page "FIN-Posted Travel Advs. Acc.";
                    ToolTip = 'Imprest Register';

                }



            }
            group("EFT Management")
            {
                Caption = 'Eft Management';
                action("Eft Batches")
                {
                    ApplicationArea = all;
                    RunObject = page "Eft Batch List";

                }

            }
            group(Budgeting)

            {
                Caption = 'Budgeting';
                action("Budget Control SetUp")
                {
                    ApplicationArea = all;
                    RunObject = page "Budgetary Control Setup";

                }
                action("Budget Virement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Virement';
                    Image = Journal;
                    RunObject = Page "FIN-Budget Virement List";
                    ToolTip = 'Budget Virement';
                }
                action("Cash officer setUp")
                {
                    ApplicationArea = all;
                    RunObject = page "Cash Office Setup UP";

                }
                Action("Budget import")
                {
                    ApplicationArea = all;
                    RunObject = page "Budget Buffer List";


                }
                action("Main Budget")
                {
                    ApplicationArea = all;
                    RunObject = page 121;
                }


            }
            group("Cheaque Buffer")
            {
                Caption = 'Cheque Register';
                action("Cheaque Buffer List")
                {
                    ApplicationArea = all;
                    Caption = 'Cheque Collection Register';
                    RunObject = page "FIN-Cheaque Collection List";
                }


            }
            group("Payroll Setup")
            {

                action("Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Period';
                    Image = Journal;
                    RunObject = Page "PRL-Payroll Periods";
                    ToolTip = 'Payroll Period';

                }
                action("Transaction Codes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Codes';
                    Image = Journal;
                    RunObject = Page "PRL-Transaction Code";
                    ToolTip = 'Transaction Codes';

                }
                action("Salary Card")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Card';
                    Image = Journal;
                    RunObject = Page "HRM-Employee-List";
                    ToolTip = 'Salary Card';

                }


            }




            Group("Imprest Memos")
            {
                action("Regions Setup")
                {
                    ApplicationArea = all;
                    RunObject = page 50891;
                }
                action("Memo Transaction Types")
                {
                    ApplicationArea = all;
                    RunObject = page 50900;
                }


                action("Imprest Memo")
                {
                    ApplicationArea = all;
                    RunObject = page 50867;
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

            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                // action(Action61)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Customers';
                //     Image = Customer;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Customer List";
                //     ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                // }
                // action("Sales Quotes")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales Quotes';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Sales Quotes";
                //     ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                // }
                // action("Sales Orders")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales Orders';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Sales Order List";
                //     ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                // }
                // action("Sales Orders - Microsoft Dynamics 365 Sales")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Sales Orders - Microsoft Dynamics 365 Sales';
                //     RunObject = Page "CRM Sales Order List";
                //     ToolTip = 'View sales orders in Dynamics 365 Sales that are coupled with sales orders in Business Central.';
                // }
                // action("Blanket Sales Orders")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Blanket Sales Orders';
                //     Image = Reminder;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Blanket Sales Orders";
                //     ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                // }
                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';

                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                // action("Sales Return Orders")
                // {
                //     ApplicationArea = SalesReturnOrder;
                //     Caption = 'Sales Return Orders';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Sales Return Order List";
                //     ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders enable you to receive items from multiple sales documents with one sales return, automatically create related sales credit memos or other return-related documents, such as a replacement sales order, and support warehouse documents for the item handling. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                // }
                // action("Sales Credit Memos")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales Credit Memos';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Sales Credit Memos";
                //     ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                // }
                // action("Sales Journals")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales Journals';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "General Journal Batches";
                //     RunPageView = WHERE("Template Type" = CONST(Sales),
                //                         Recurring = CONST(false));
                //     ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                // }
                action("Posted Sales Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memo")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }

                // action("Posted Sales Return Receipts")
                // {
                //     ApplicationArea = SalesReturnOrder;
                //     Caption = 'Posted Sales Return Receipts';
                //     RunObject = Page "Posted Return Receipts";
                //     ToolTip = 'Open the list of posted sales return receipts.';
                // }
                // action("Posted Sales Shipments")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Posted Sales Shipments';
                //     Image = PostedShipment;
                //     RunObject = Page "Posted Sales Shipments";
                //     ToolTip = 'Open the list of posted sales shipments.';
                // }
                action(Action68)
                {
                    ApplicationArea = Location;
                    Caption = 'Transfer Orders';
                    Image = FinChargeMemo;

                    RunObject = Page "Transfer Orders";
                    ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
                }
                // action(Reminders)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Reminders';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Reminder List";
                //     ToolTip = 'Remind customers about overdue amounts based on reminder terms and the related reminder levels. Each reminder level includes rules about when the reminder will be issued in relation to the invoice due date or the date of the previous reminder and whether interests are added. Reminders are integrated with finance charge memos, which are documents informing customers of interests or other money penalties for payment delays.';
                // }
                // action("Finance Charge Memos")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Finance Charge Memos';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Finance Charge Memo List";
                //     ToolTip = 'Send finance charge memos to customers with delayed payments, typically following a reminder process. Finance charges are calculated automatically and added to the overdue amounts on the customer''s account according to the specified finance charge terms and penalty/interest amounts.';
                // }
            }
        }

        addafter("G/L Reports")
        {
            group("TrialBalance")
            {

                Caption = 'Trial Balance Reports';
                action("Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance Old';
                    Image = "Report";
                    RunObject = Report "Trial BalanceTMUC";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Monthly Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monthly Trial Balance';
                    Image = "Report";
                    RunObject = Report "Detailed Trial Bal. (Monthly)";
                    ToolTip = 'View, print, or send a report that shows the balances for the monthly general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("Student Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Student Trial Balance';
                    Image = "Report";
                    RunObject = Report "Student - Trial Balance";
                    ToolTip = 'View, print, or send a report that shows the balances for the Student accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }

            }
        }




    }




}







