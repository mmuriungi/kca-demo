/// <summary>
/// Page ACA-Admissions Role Center (ID 68975).
/// </summary>
page 51457 "ACA-Admissions Role Center"
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
                part("Admission Enquiries"; "ACA-Enquiry List")
#pragma warning restore AL0269
                {
                    Caption = 'Admission Enquiries';
                    Visible = true;
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part("Application List"; "ACA-Application Form H. list")
#pragma warning restore AL0269
                {
                    Caption = 'Application List';
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part(PA; "ACA-Pending Admissions List")
#pragma warning restore AL0269
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
        area(processing)
        {
            group("General Setups")
            {
                Caption = 'Setups';
                action(Programs)
                {
                    Caption = 'Programs';
                    Image = FixedAssets;

                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action(Semesters)
                {
                    Image = FixedAssetLedger;

                    RunObject = Page "ACA-Semesters List";
                    ApplicationArea = All;
                }
                action("Academic Year")
                {
                    Image = Calendar;

                    RunObject = Page "ACA-Academic Year List";
                    ApplicationArea = All;
                }
                action("General Setup")
                {
                    Image = SetupLines;

                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = All;
                }
                action("Modes of Study")
                {
                    Image = Category;

                    RunObject = Page "ACA-Student Types";
                    ApplicationArea = All;
                }
                action("Insurance Companies")
                {
                    Image = Insurance;

                    ApplicationArea = All;
                    // RunObject = Page 50051;
                }
                action("Application Setups")
                {
                    Image = SetupList;

                    RunObject = Page "ACA-Application Setup";
                    ApplicationArea = All;
                }
                action("Admission Number Setup")
                {
                    Image = SetupColumns;

                    RunObject = Page "ACA-Admn Number Setup";
                    ApplicationArea = All;
                }
                action("Admission Subjects")
                {
                    Image = GeneralPostingSetup;

                    RunObject = Page "ACA-Appication Setup Subject";
                    ApplicationArea = All;
                }
                action("Marketing Strategies")
                {
                    Image = MarketingSetup;

                    RunObject = Page "ACA-Marketing Strategies 2";
                    ApplicationArea = All;
                }
            }
            group("Application and Admission")
            {
                action("Online Enquiries")
                {
                    Image = NewOrder;

                    RunObject = Page "ACA-Enquiry Form";
                    ApplicationArea = All;
                }
                action("Online Applications")
                {
                    Image = NewCustomer;

                    RunObject = Page "ACA-Enquiry List (a)";
                    ApplicationArea = All;
                }
                action("Admission Applications")
                {
                    Image = NewCustomer;

                    RunObject = Page "ACA-Application Form Header a";
                    ApplicationArea = All;
                }
                action("Approved Applications")
                {
                    Image = Archive;

                    RunObject = Page "ACA-Approved Applications List";
                    ApplicationArea = All;
                }
                action("Admission Letters")
                {
                    Image = CustomerList;

                    RunObject = Page "ACA-Admn Letters Direct";
                    ApplicationArea = All;
                }
                // action(" multiplestudents")
                // {
                //     Caption = ' multiplestudents';
                //     RunObject = Page "ACA-Multple Records";
                //     ApplicationArea = All;
                // }
                action("New Admissions")
                {
                    Image = NewItem;

                    ApplicationArea = All;
                    //RunObject = Page 68013;
                }
                action("Admitted Applicants")
                {
                    Image = Archive;

                    RunObject = Page "ACA-Admitted Applicants List";
                    ApplicationArea = All;
                }
            }
            group("Admission Reports")
            {
                action("New Applications")
                {
                    Image = "Report";

                    RunObject = Report "Application List Academic New";
                    ApplicationArea = All;
                }
                action("Online Applications Report")
                {
                    Image = "Report";

                    ApplicationArea = All;
                    // RunObject = Report 50051;
                }
                action(Enquiries)
                {
                    Image = "Report";

                    ApplicationArea = All;
                    // RunObject = Report 50052;
                }
                action("Marketing Strategies Report")
                {
                    Image = "Report";

                    RunObject = Report "ACA-Marketing Strategy";
                    ApplicationArea = All;
                }
                action("Direct Applications")
                {
                    Image = "Report";

                    RunObject = Report "Direct Applications Form Reg";
                    ApplicationArea = All;
                }
                action("Pending Applications")
                {
                    Image = "Report";

                    RunObject = Report "Application List Academic New";
                    ApplicationArea = All;
                }
                action("Application Summary")
                {
                    Image = "Report";

                    RunObject = Report "Application Summary";
                    ApplicationArea = All;
                }
                action("Applicant Shortlisting (Summary)")
                {
                    Image = "Report";

                    RunObject = Report "Shortlisted Students Summary";
                    ApplicationArea = All;
                }
                action("Applicant Shortlisting (Detailed)")
                {
                    Image = "Report";

                    RunObject = Report "Shortlisted Students Status";
                    ApplicationArea = All;
                }
            }
        }
        area(embedding)
        {

            action("Academic Year Manager")
            {
                Caption = 'Academic Year Manager';
                Image = Calendar;

                RunObject = Page "ACA-Academic Year List";
                ApplicationArea = All;
            }


            action("Applications (Online)")
            {
                Image = NewCustomer;

                RunObject = Page "ACA-Online Application List";
                ApplicationArea = All;
            }
            action("Applications - Direct ")
            {
                Image = NewCustomer;

                RunObject = Page "ACA-Application Form H. list";
                ApplicationArea = All;
            }
            action("Applicant Admission Letters")
            {
                Image = CustomerList;

                RunObject = Page "ACA-Admn Letters Direct";
                ApplicationArea = All;
            }
            action("Admissions (New)")
            {
                Image = NewItem;

                RunObject = Page "ACA-New Admissions List";
                ApplicationArea = All;
            }

        }
        area(sections)
        {
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
        }
    }
}

