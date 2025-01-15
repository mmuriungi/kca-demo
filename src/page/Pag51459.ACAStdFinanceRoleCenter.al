/// <summary>
/// Page ACA-Std Finance Role Center (ID 68914).
/// </summary>
page 51459 "ACA-Std Finance Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(general)
            {
#pragma warning disable AL0269
                part("Student Bills"; "ACA-Std Billing List")
#pragma warning restore AL0269
                {
                    Caption = 'Student Bills';
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
        area(reporting)
        {
            action("Student Balances BF")
            {
                Image = Balance;
                RunObject = report "Student Balances BF";
                ApplicationArea = All;
            }
            group("Finance reports")
            {
                Caption = 'Finance reports';
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
                action("Statement 2")
                {
                    Caption = 'Statement 2';
                    ApplicationArea = All;
                    // RunObject = Report 51751;
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
            group("Receipts Reports")
            {
                Caption = 'Receipts Reports';
                action("Cashier Transactions")
                {
                    Caption = 'Cashier Transactions';
                    ApplicationArea = All;
                    // RunObject = Report 51633;
                }
                action("Receipt Entries By User")
                {
                    Caption = 'Receipt Entries By User';
                    RunObject = Report "Receipts Entries - By Users";
                    ApplicationArea = All;
                }
            }
        }
        area(embedding)
        {
            action("Student Billing")
            {
                Caption = 'Student Billing';
                Image = UserSetup;
                RunObject = Page "ACA-Std Billing List";
                ApplicationArea = All;
            }
            action("Missing Balance Imports")
            {
                Caption = 'Missing Balance Imports';
                Image = Migration;

                ApplicationArea = All;
                // RunObject = Page 68014;
            }
            action("No. Series")
            {
                Caption = 'No. Series';
                RunObject = Page "No. Series";
                ApplicationArea = All;
            }
            action("Approval Entries")
            {
                Caption = 'Approval Entries';
                RunObject = Page 658;
                ApplicationArea = All;
            }
            action("Approval Request Entries")
            {
                Caption = 'Approval Request Entries';
                RunObject = Page 662;
                ApplicationArea = All;
            }
            action("Reason Codes")
            {
                Caption = 'Reason Codes';
                RunObject = Page "ACA-Programmes List";
                ApplicationArea = All;
            }
            action("Students Card")
            {
                Caption = 'Students Card';
                RunObject = Page "ACA-All Students List";
                ApplicationArea = All;
            }
            action("Official Receipts")
            {
                Caption = 'Official Receipts';
                ApplicationArea = All;
                //RunObject = Page 68207;
            }
            action("Official Receipt")
            {
                Caption = 'Official Receipt';
                ApplicationArea = All;
                //  RunObject = Page 68207;
            }
            action("Settlement Types")
            {
                Caption = 'Settlement Types';
                RunObject = Page "ACA-Settlement Types";
                ApplicationArea = All;
            }


        }
        area(processing)
        {
            group(Setups)
            {
                Caption = 'Setups';
                action("Master Fee Structure")
                {
                    Caption = 'Master Fee Structure';
                    Image = Setup;

                    RunObject = Page "ACA-Master Fee Structure";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Charge Items")
                {
                    Caption = 'Charge Items';
                    Image = Invoice;

                    RunObject = Page "ACA-Charge";
                    ApplicationArea = All;
                }
                action("GeneralSet-Up")
                {
                    Caption = 'General Set-Up';
                    Image = GeneralPostingSetup;

                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = All;
                }
                action("AcademicYear")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;

                    RunObject = Page "ACA-Academic Year Card";
                    ApplicationArea = All;
                }
                action("General Set-Up")
                {
                    Caption = 'General Set-Up';
                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = All;
                }
                action("Programmes List")
                {
                    Caption = 'Programmes List';
                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action("general journal")
                {
                    Caption = 'general journal';
                    Image = Journal;
                    RunObject = Page "General Journal";
                    ApplicationArea = All;
                }
                action("Academic Year")
                {
                    Caption = 'Academic Year';
                    RunObject = Page "ACA-Academic Year Card";
                    ApplicationArea = All;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                action("Import Receipts")
                {
                    Caption = 'Import Receipts';
                    Image = ImportExport;
                    ApplicationArea = All;
                    //  RunObject = XMLport 50019;
                }
                action("Close CurrentSemester")
                {
                    Caption = 'Close Current Semester';
                    Image = "Report";
                    RunObject = Report "Generate Registration";
                    ApplicationArea = All;
                }
                action("Post Batch Billing")
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
                    // RunObject = XMLport 50019;
                }
                action("Imported Bank Receipts")
                {
                    Caption = 'Imported Bank Receipts';
                    Image = ReceiptLines;

                    RunObject = Page "ACA-Imported Receipts Buffer";
                    ApplicationArea = All;
                }
                action("Posted Receipts Buffer")
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
                action("Close Current Semester")
                {
                    Caption = 'Close Current Semester';
                    RunObject = Report "Generate Registration";
                    ApplicationArea = All;
                }
                action("Incomplete Student Charges")
                {
                    Caption = 'Incomplete Student Charges';
                    RunObject = Report "Incomplete Student Charges";
                    ApplicationArea = All;
                }
                action("Registered Students")
                {
                    Caption = 'Registered Students';
                    Image = PostingEntries;

                    RunObject = Report "Norminal Roll (Cont. Students)";
                    ApplicationArea = All;
                }
            }
            group("Bank Intergrations")
            {
                action("Bank Transactions")
                {
                    ApplicationArea = All;

                    RunObject = Page "Bank Intergration Transactions";
                }
            }
        }
        area(sections)
        {
            group("Scholarship")
            {
                action("Official Rece")
                {
                    Caption = 'Acknowledgement Receipt';
                    RunObject = Page "FIN-Receipts List";
                    ApplicationArea = All;
                }
                action("Scholarships")
                {
                    RunObject = Page "ACA-Scholarships";
                    ApplicationArea = All;
                }
                action("Scholarship Batches")
                {
                    RunObject = Page "ACA-Scholarship Batches";
                    ApplicationArea = All;
                }

            }
            group("NFM")
            {
                action("NFM Bands")
                {
                    RunObject = page "Fund Band Categories";
                    ApplicationArea = all;

                }
                action("NFM Batch List")
                {
                    RunObject = page "Fund Band Batch List";
                    ApplicationArea = all;
                }
                action("NFM Batch Archived")
                {
                    RunObject = page "Band Batch List Archived";
                    ApplicationArea = all;
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
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
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

    var
        cust: Record Customer;
        process: Dialog;
}
// Creates a profile that uses the Role Center
profile "Research Profile"
{
    ProfileDescription = 'STudentFinance';
    RoleCenter = "ACA-Std Finance Role Center";
    Caption = 'Student Finance Profile';
}

