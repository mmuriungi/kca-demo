/// <summary>
/// Page ACA-Student Fin. Role Center (ID 68852).
/// </summary>
page 54326 "ACA-Student Fin. Role Center"

{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control99; "ACA-Std Billing List")
                {
                    Caption = 'Student Billing';
                    Visible = true;
                    ApplicationArea = all;

                }
                part("Bank Account"; "Bank Account List")
                {
                    Caption = 'Bank Account';
                    ApplicationArea = All;
                }
                part(Control7; "FIN-Receipts List")
                {
                    Caption = 'Official Receipt';
                    ApplicationArea = All;
                }
                part(Control22; "ACA-Charge")
                {
                    Caption = 'Charges';
                    Visible = true;
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

        area(embedding)
        {
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;

                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Student Billing")
            {
                Caption = 'Student Billing';
                Image = "Order";

                RunObject = Page "ACA-Std Billing List";
                ApplicationArea = All;
            }
            action(Action21)
            {
                Caption = 'Official Receipt';
                RunObject = Page "FIN-Receipts List";
                ApplicationArea = All;
            }
            action("Settlement Types")
            {
                Caption = 'Settlement Types';
                RunObject = Page "ACA-Settlement Types";
                ApplicationArea = All;
            }
            action("Chart of Accounts")
            {
                ApplicationArea = All;
                RunObject = page "Chart of Accounts";
            }
        }
        area(reporting)
        {
            group(Imports)
            {
                Caption = 'Periodic Activities';


                action("Import Receipts")
                {
                    Caption = 'Import Receipts';
                    Image = ImportExport;

                    ApplicationArea = all;
                    RunObject = XMLport "Import Student Receipts";
                }
                action("Import Receipts Buffer")
                {
                    Caption = 'Import Receipts Buffer';
                    Image = Bins;
                    RunObject = Page "ACA-Imported Receipts Buffer";
                    ApplicationArea = all;
                }
                action("Posted Receipts Buffer")
                {
                    Caption = 'Posted Receipts Buffer';
                    Image = PostedReceipt;

                    RunObject = Page "ACA-Posted Receipts Buffer";
                    ApplicationArea = all;
                }
                action("Close Current Semester")
                {
                    Caption = 'Close Current Semester';
                    Image = "Report";
                    RunObject = Report "Generate Registration";
                    ApplicationArea = all;
                }
                action("Post Batch Billing")
                {
                    Caption = 'Post Batch Billing';
                    Image = Report2;

                    RunObject = Report "Post Billing";
                    ApplicationArea = all;
                }
                action("Genereal Setup")
                {
                    Caption = 'Genereal Setup';
                    Image = GeneralPostingSetup;

                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = all;
                }
                action("Generaljournal")
                {
                    Caption = 'General journal';
                    Image = Journal;
                    RunObject = Page "General Journal";
                    ApplicationArea = all;
                }
                action("Official Receipt")
                {
                    Caption = 'Official Receipt';
                    RunObject = Page "FIN-Receipts List";
                    ApplicationArea = all;
                }
                action(Programmes)
                {
                    Caption = 'Programmes';
                    Image = List;

                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = all;
                }
                action("Charge Items")
                {
                    Caption = 'Charge Items';
                    Image = Accounts;

                    RunObject = Page "ACA-Charge";
                    ApplicationArea = all;

                }
                action("Student Charge list")
                {
                    Caption = 'Student Charge List';
                    Image = Accounts;

                    RunObject = Page "ACA-Student Charges List";
                    ApplicationArea = all;

                }
                action("New Charge list")
                {
                    Caption = 'New Charge List';
                    Image = Accounts;

                    RunObject = Page "ACA-New Student Charges";
                    ApplicationArea = all;

                }
                action("Stage Charge list")
                {
                    Caption = 'Stage Charge List';
                    Image = Accounts;

                    RunObject = Page "ACA-Stage Charges";
                    ApplicationArea = all;

                }
            }
            group("Reports And Analysis")
            {
                Caption = 'Reports And Analysis';
                Image = Journals;
                action("Proforma Invoice")
                {
                    Caption = 'Proforma Invoice';
                    Image = "Report";
                    RunObject = Report "Students Proforma";
                    ApplicationArea = All;
                }
                action("Fee Structure")
                {
                    Caption = 'Fee Structure';
                    RunObject = Report "Fee Structure Summary Report";
                    ApplicationArea = All;
                }
                action("Student Balances")
                {
                    Caption = 'Student Balances';
                    RunObject = Report "Student Balances";
                    ApplicationArea = All;
                }
                action("Statement 1")
                {
                    Caption = 'Statement 1';
                    RunObject = Report Statement;
                    ApplicationArea = All;
                }
                action("Statement 2")
                {
                    Caption = 'Statement 2';
                    RunObject = Report "Customer Statement";
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
                action("Student List")
                {
                    Caption = 'Student List';
                    RunObject = Report "Student List";
                    ApplicationArea = All;
                }
                action("Cashier Transactions")
                {
                    Caption = 'Cashier Transactions';
                    ApplicationArea = All;
                    //RunObject = Report 
                }
                action("Receipt Entries By User")
                {
                    Caption = 'Receipt Entries By User';
                    RunObject = Report "Receipts Entries - By Users";
                    ApplicationArea = All;
                }
                action(Action1000000017)
                {
                    Caption = 'Import Receipts';
                    Image = ImportExport;
                    ApplicationArea = All;
                    // RunObject = XMLport 
                }
                action(Action1000000016)
                {
                    Caption = 'Post Batch Billing';
                    Image = Report2;

                    RunObject = Report "Post Billing";
                    ApplicationArea = All;
                }
                action("Import Bank Receipts")
                {
                    Caption = 'Import Bank Receipts';
                    Image = ImportExcel;
                    ApplicationArea = All;

                    //RunObject = XMLport 
                }
                action("Imported Bank Receipts")
                {
                    Caption = 'Imported Bank Receipts';
                    Image = ReceiptLines;

                    RunObject = Page "ACA-Imported Receipts Buffer";
                    ApplicationArea = All;
                }
                action(Action1000000013)
                {
                    Caption = 'Posted Receipts Buffer';
                    Image = PostedReceipts;

                    RunObject = Page "ACA-Posted Receipts Buffer";
                    ApplicationArea = All;
                }
                action("Post Billings (Batch)")
                {
                    Caption = 'Post Billings (Batch)';
                    Image = Post;

                    RunObject = Report "Post Billing";
                    ApplicationArea = All;
                }
                action(Action117)
                {
                    Caption = 'Fee Structure';
                    Image = Balance;
                    RunObject = Report "Student Balance Per Stage";
                    ApplicationArea = All;
                }
                action("Proforma Invoices")
                {
                    Caption = 'Proforma Invoices';
                    Image = PrintVoucher;
                    RunObject = Report "Students Proforma";
                    ApplicationArea = All;
                }
                action("Student Statements")
                {
                    Caption = 'Student Statements';
                    Image = Journals;
                    RunObject = Report "Customer Statement";
                    ApplicationArea = All;
                }
                action("Payment Journals")
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ApplicationArea = All;
                }
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ApplicationArea = All;
                }
                action("Student Billings Analysis")
                {
                    Caption = 'Student Billings Analysis';
                    Image = "Report";
                    RunObject = Report "Student Billings";
                    ApplicationArea = All;
                }
                action("Student Monthly Trial Bal.")
                {
                    Caption = 'Detailed Trial Bal. (Monthly)';
                    Image = "Report";
                    RunObject = Report "Detailed Trial Bal. (Monthly)";
                    ApplicationArea = All;
                }
                action("Student Balances BF")
                {
                    Image = Balance;
                    RunObject = report "Student Balances BF";
                    ApplicationArea = All;
                }
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
            action("general journal")
            {
                Caption = 'general journal';
                Image = Journal;

                RunObject = Page "General Journal";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group(Basics)
            {
                Caption = 'Basics';

                action(Action20)
                {
                    Caption = 'Programmes';
                    Image = List;

                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = all;
                }
                action(Action5)
                {
                    Caption = 'Customers';
                    Image = Customer;

                    RunObject = Page "Customer List";
                    ApplicationArea = All;
                }
                action(Action6)
                {
                    Caption = 'Student Billing';
                    Image = "Order";

                    RunObject = Page "ACA-Std Billing List";
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
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
                }
                action("Purchase Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Internal purchase Requisitions';
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
    }
}



