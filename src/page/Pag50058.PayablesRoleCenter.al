page 50058 "Payables Role Center"
{
    PageType = RoleCenter;
    Caption = 'Payables';

    layout
    {
        area(RoleCenter)
        {
            part(Headlines; "Headline RC Accountant")
            {
                ApplicationArea = All;
            }
            part(Activities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(ApprovalsActivities; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }
            part(Control1901377608; "My Accounts Payable")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control1907692008; "My Vendors")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Payables)
            {
                Caption = 'Payables';
                Image = FiledPosted;

                action(Vendors)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with.';
                }

                action("Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to register your purchases and costs.';
                }

                action("Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Orders';
                    RunObject = page "Purchase Order List";
                    ToolTip = 'Create purchase orders to register your purchase agreements with vendors.';
                }

                action("Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to register returns to vendors.';
                }

                action("Aged Accounts Payable")
                {
                    ApplicationArea = All;
                    Caption = 'Aged Accounts Payable';
                    RunObject = report "Aged Accounts Payable 2";
                    ToolTip = 'View a report of your payables by age.';
                }
            }

            group(Payments)
            {
                Caption = 'Payments';
                Image = Payment;

                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments), Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors.';
                }

                action("Payment Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Vouchers';
                    Image = Journal;
                    RunObject = Page "FIN-Payment Vouchers";
                    ToolTip = 'Create and manage payment vouchers.';
                }

                action("Posted Payment Vouchers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Payment Vouchers';
                    Image = PostedPayment;
                    RunObject = Page "FIN-Posted Payment Vouch.";
                    ToolTip = 'View posted payment vouchers.';
                }

                action("Bank Transfers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Transfers';
                    Image = BankStatement;
                    RunObject = Page "FIN-Interbank Transfer";
                    ToolTip = 'Create and manage bank transfers.';
                }

                action("Posted Bank Transfers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Bank Transfers';
                    Image = PostedPayment;
                    RunObject = Page "FIN-Posted Interbank Trans2";
                    ToolTip = 'View posted bank transfers.';
                }
            }

            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;

                action(PurchaseJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases), Recurring = CONST(false));
                    ToolTip = 'Post purchase-related transactions directly to vendor, bank, or general ledger accounts.';
                }

                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts.';
                }
            }

            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'View the posted purchase invoices.';
                }

                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'View the posted purchase credit memos.';
                }

                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'View the posted purchase receipts.';
                }
            }

            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;

                action("Purchases & Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchases & Payables Setup';
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Configure your company''s purchases and payables processes.';
                }

                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select in sales and purchase documents to define when the customer must pay.';
                }

                action("Payment Methods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Methods';
                    RunObject = Page "Payment Methods";
                    ToolTip = 'Set up the payment methods that you select in sales and purchase documents to define how the customer must pay.';
                }
            }

            group(Reports)
            {
                Caption = 'Reports';
                Image = Reports;

                action("Vendor - Summary Aging")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Summary Aging';
                    RunObject = Report "Vendor - Summary Aging";
                    ToolTip = 'View a summary of vendor aging.';
                }

                action("Vendor - Detail Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Detail Trial Balance';
                    RunObject = Report "Vendor - Detail Trial Balance";
                    ToolTip = 'View a detailed trial balance for selected vendors.';
                }

                action("Vendor - List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - List';
                    RunObject = Report "Vendor - List";
                    ToolTip = 'View a list of all vendors.';
                }
            }
        }

        area(Embedding)
        {
            action(EmbedVendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                RunObject = page "Vendor List";
            }

            action(EmbedPurchaseInvoices)
            {
                ApplicationArea = All;
                Caption = 'Purchase Invoices';
                RunObject = page "Purchase Invoices";
            }

            action(EmbedPurchaseOrders)
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = page "Purchase Order List";
            }

            action(EmbedPaymentVouchers)
            {
                ApplicationArea = All;
                Caption = 'Payment Vouchers';
                RunObject = Page "FIN-Payment Vouchers";
            }
        }
    }
}