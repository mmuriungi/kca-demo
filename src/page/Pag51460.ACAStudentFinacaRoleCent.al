/// <summary>
/// Page ACA-Student Fin/aca Role Cent (ID 77735).
/// </summary>
page 51460 "ACA-Student Fin/aca Role Cent"
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
                part("StudentBilling"; "ACA-Std Billing List")
#pragma warning restore AL0269
                {
                    Caption = 'Student Billing';
                    Visible = true;
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part("Bank Account"; "Bank Account List")
#pragma warning restore AL0269
                {
                    Caption = 'Bank Account';
                    ApplicationArea = All;
                }
                /* part("OfficialReceipt"; 68207)
                {
                    Caption = 'Official Receipt';
                } */
                part(acaCharge; "ACA-Charge")
                {
                    ApplicationArea = All;
                }
            }
            group(Trasport)
            {
                ShowCaption = false;
                part(HOD; "Approvals Activities One")
                {
                    ApplicationArea = Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Receipts")
            {
                Caption = 'Import Receipts';
                Image = ImportExport;
                ApplicationArea = All;
                // RunObject = XMLport 50019;
            }
            action("Import Receipts Buffer")
            {
                Caption = 'Import Receipts Buffer';
                Image = Bins;
                RunObject = Page "ACA-Imported Receipts Buffer";
                ApplicationArea = All;
            }
            action("Posted Receipts Buffer")
            {
                Caption = 'Posted Receipts Buffer';
                Image = PostedReceipt;
                RunObject = Page "ACA-Posted Receipts Buffer";
                ApplicationArea = All;
            }
            action("Close Current Semester")
            {
                Caption = 'Close Current Semester';
                Image = Report;
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
            action("Genereal Setup")
            {
                Caption = 'Genereal Setup';
                Image = GeneralPostingSetup;

                RunObject = Page "ACA-General Set-Up";
                ApplicationArea = All;
            }
            action("General journal")
            {
                Caption = 'General journal';
                Image = Journal;
                RunObject = Page "General Journal";
                ApplicationArea = All;
            }
            action("OfficialReceipt")
            {
                Caption = 'Official Receipt';
                ApplicationArea = All;
                // RunObject = Page 68207;
            }
            action(Programme)
            {
                Caption = 'Programmes';
                Image = List;

                RunObject = Page "ACA-Programmes List";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action(Customer)
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
            action("Official Receipt")
            {
                Caption = 'Official Receipt';
                ApplicationArea = All;
                //RunObject = Page 68207;
            }
            action("Settlement Types")
            {
                Caption = 'Settlement Types';
                RunObject = Page "ACA-Settlement Types";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group("Reports And Analysis")
            {
                Caption = 'Reports And Analysis';
                Image = Journals;
                action("Fee Structure")
                {
                    Caption = 'Fee Structure';
                    Image = Balance;
                    RunObject = Report "Student Balance Per Stage";
                    ApplicationArea = All;
                }
                // action("Proforma Invoices")
                // {
                //     Caption = 'Proforma Invoices';
                //     Image = PrintVoucher;
                //     RunObject = Report "Student Proforma Invoice";
                //     ApplicationArea = All;
                // }
                action("Student Statements")
                {
                    Caption = 'Student Statements';
                    Image = Journals;
                    RunObject = Report "Student Fee Statement 2";
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
                    Image = Report;
                    RunObject = Report "Student Billings";
                    ApplicationArea = All;
                }
                action("   Student Balances2")
                {
                    Caption = '   Student Balances2';
                    RunObject = Report "ACA-Student Balances";
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
            action("generaljournal")
            {
                Caption = 'general journal';
                Image = Journal;

                RunObject = Page "General Journal";
                ApplicationArea = All;
            }
            group(Periodic)
            {
                Caption = 'Periodic Reports';
                group(AcadReports2)
                {
                    Caption = 'Academic Reports';
                    Image = AnalysisView;
                    action("All Students")
                    {
                        Image = Report2;
                        RunObject = Report "All Students";
                        ApplicationArea = All;
                    }
                    action("Student Applications Report")
                    {
                        Caption = 'Student Applications Report';
                        Image = Report;
                        RunObject = Report "Student Applications Report";
                        ApplicationArea = All;
                    }
                    action("Norminal Roll")
                    {
                        Caption = 'Norminal Roll';
                        Image = Report2;
                        RunObject = Report "Norminal Roll (Cont. Students)";
                        ApplicationArea = All;
                    }
                    action(" List (By Stage)")
                    {
                        Caption = ' List (By Stage)';
                        Image = List;

                        RunObject = Report "ACA-List By Prog Stage";
                        ApplicationArea = All;
                    }
                    action("Signed Norminal Roll")
                    {
                        Caption = 'Signed Norminal Roll';
                        Image = Report2;

                        RunObject = Report "Signed Norminal Role";
                        ApplicationArea = All;
                    }
                    action("Program List By Gender && Type")
                    {
                        Caption = 'Program List By Gender && Type';
                        Image = PrintReport;

                        RunObject = Report "Pop. By Prog./Gender/Settl.";
                        ApplicationArea = All;
                    }
                    action("population By Faculty")
                    {
                        Caption = 'population By Faculty';
                        Image = PrintExcise;

                        RunObject = Report "Population By Faculty";
                        ApplicationArea = All;
                    }
                    action("Multiple Record")
                    {
                        Caption = 'Multiple Record';
                        Image = Report2;
                        RunObject = Report "Official College Transcript Nu";
                        ApplicationArea = All;
                    }
                    action("Classification By Campus")
                    {
                        Caption = 'Classification By Campus';
                        Image = Report2;
                        RunObject = Report "Population Class By Campus";
                        ApplicationArea = All;
                    }
                    action("Population By Campus")
                    {
                        Caption = 'Population By Campus';
                        Image = Report2;
                        RunObject = Report "Population By Campus";
                        ApplicationArea = All;
                    }
                    action("Population by Programme")
                    {
                        Caption = 'Population by Programme';
                        Image = Report2;
                        RunObject = Report "Population By Programme";
                        ApplicationArea = All;
                    }
                    action("Prog. Category")
                    {
                        Caption = 'Prog. Category';
                        Image = Report2;
                        RunObject = Report "Population By Prog. Category";
                        ApplicationArea = All;
                    }
                    action("List By Programme")
                    {
                        Caption = 'List By Programme';
                        Image = Report;
                        RunObject = Report "List By Programme";
                        ApplicationArea = All;
                    }
                    action("List By Programme (With Balances)")
                    {
                        Caption = 'List By Programme (With Balances)';
                        Image = PrintReport;

                        RunObject = Report "ACA-List By Prog.(Balances)";
                        ApplicationArea = All;
                    }
                    action("Type. Study Mode, & Gender")
                    {
                        Caption = 'Type. Study Mode, & Gender';
                        Image = Report;
                        RunObject = Report "Stud Type, Study Mode & Gende";
                        ApplicationArea = All;
                    }
                    action("Study Mode & Gender")
                    {
                        Caption = 'Study Mode & Gender';
                        Image = Report;
                        RunObject = Report "List By Study Mode & Gender";
                        ApplicationArea = All;
                    }
                    action("County & Gender")
                    {
                        Caption = 'County & Gender';
                        Image = Report;
                        RunObject = Report "List By County & Gender";
                        ApplicationArea = All;
                    }
                    action("List By County")
                    {
                        Caption = 'List By County';
                        Image = Report;
                        RunObject = Report "List By County";
                        ApplicationArea = All;
                    }
                    action("Prog. Units")
                    {
                        Caption = 'Prog. Units';
                        Image = Report;
                        RunObject = Report "Programme Units";
                        ApplicationArea = All;
                    }
                    action("Enrollment By Stage")
                    {
                        Caption = 'Enrollment By Stage';
                        Image = Report2;
                        RunObject = Report "Enrollment by Stage";
                        ApplicationArea = All;
                    }
                    action("Import Units")
                    {
                        Caption = 'Import Units';
                        Image = ImportExcel;

                        RunObject = Page "ACA-Prog. Units Buffer";
                        ApplicationArea = All;
                    }
                    // action("Hostel Allocations")
                    // {
                    //     Caption = 'Hostel Allocations';
                    //     Image = PrintCover;
                    //     
                    //     PromotedIsBig = true;
                    //     RunObject = Report "Hostel Allocations";
                    //     ApplicationArea = All;
                    // }
                    action("Students List (By Program)")
                    {
                        Caption = 'Students List (By Program)';
                        Image = Report;

                        RunObject = Report "ACA-Norminal Roll (New Stud)";
                        ApplicationArea = All;
                    }
                    action("Programme Units")
                    {
                        Caption = 'Programme Units';
                        Image = Report;

                        RunObject = Report "Programme Units";
                        ApplicationArea = All;
                    }
                    action("CUE report")
                    {
                        Caption = 'CUE report';
                        Image = AddAction;
                        RunObject = Report "CUE Report";
                        ApplicationArea = All;
                    }
                }
                group("Before Exams")
                {
                    Caption = 'Before Exams';
                    // action("Examination Cards")
                    // {
                    //     Caption = 'Examination Cards';
                    //     Image = Card;
                    //     
                    //     PromotedCategory = Process;
                    //     RunObject = Report "Exam Card Final";
                    //     ApplicationArea = All;
                    // }
                    // action("Exam Card Stickers")
                    // {
                    //     Caption = 'Exam Card Stickers';
                    //     Image = Split;
                    //     
                    //     RunObject = Report "Exam Card Stickers";
                    //     ApplicationArea = All;
                    // }
                }
                group("Students Finance Reports")
                {
                    Image = Statistics;
                    action("Students Balances")
                    {
                        Image = PrintInstallment;

                        RunObject = Report "Student Balances";
                        ApplicationArea = All;
                    }
                    action("Per Programme Balances")
                    {
                        Image = PrintInstallment;

                        RunObject = Report "Summary Enrollment - Programme";
                        ApplicationArea = All;
                    }
                    action("Per Stage Balances")
                    {
                        Image = PrintInstallment;
                        RunObject = Report "Summary Enrollment - Stage";
                        ApplicationArea = All;
                    }
                    action("Students Faculty Income Summary")
                    {
                        Image = PrintInstallment;
                        RunObject = Report "Students Revenue Summary";
                        ApplicationArea = All;
                    }
                    action("Student Invoices Per Charge")
                    {
                        Caption = 'Student Invoices Per Charge';
                        Image = PrintInstallment;

                        ApplicationArea = All;
                        //  RunObject = Report 51747;
                    }
                    action("Fee Structure Report")
                    {
                        Caption = 'Fee Structure Report';
                        Image = Report;
                        RunObject = Report "Fee Structure Summary Report";
                        ApplicationArea = All;
                    }
                    action("Student Receipts per Charge")
                    {
                        Caption = 'Student Receipts per Charge';
                        Image = PrintReport;

                        RunObject = Report "Student Receipts per Charge";
                        ApplicationArea = All;
                    }
                }
            }
        }
        area(sections)
        {
            group(Basics)
            {
                Caption = 'Basics';
                action(Programmes)
                {
                    Caption = 'Programmes';
                    Image = List;

                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action(Customers)
                {
                    Caption = 'Customers';
                    Image = Customer;

                    RunObject = Page "Customer List";
                    ApplicationArea = All;
                }
                action("StuBilling")
                {
                    Caption = 'Student Billing';
                    Image = "Order";

                    RunObject = Page "ACA-Std Billing List";
                    ApplicationArea = All;
                }
            }

            group("Students Management")
            {
                Caption = 'Students Management';
                Image = ResourcePlanning;
                action(Registration)
                {
                    Image = Register;

                    RunObject = Page "ACA-Std Registration List";
                    ApplicationArea = All;
                }
                action("Students Card")
                {
                    Image = Registered;

                    RunObject = Page "ACA-Std Card List";
                    ApplicationArea = All;
                }
                action(Progr)
                {
                    Caption = 'Programmes';
                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action("Signing of Norminal Role")
                {
                    Caption = 'Signing of Norminal Role';
                    RunObject = Page "ACA-Norminal Role Signing";
                    ApplicationArea = All;
                }
                // action("Class Allocations")
                // {
                //     Image = Allocate;
                //     RunObject = Page "HRM-Class Allocation List";
                //     ApplicationArea = All;
                // }
                action("ACA-Students Transfer")
                {
                    RunObject = Page "ACA-Students Transfer";
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
}

