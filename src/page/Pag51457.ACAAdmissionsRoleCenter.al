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
                Caption = 'Application Reports';
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

            group("&Admission Reports")
            {

                //Caption = 'Admission Reports';
                Image = ResourcePlanning;
                action("Admissions Summary")
                {
                    Caption = 'Admissions Summary';
                    Image = Report;

                    RunObject = Report "KUCCPS & PSSP Admissions List";
                    ApplicationArea = All;
                }
                action("Admission By Program")
                {
                    Caption = 'Admission By Program';
                    Image = Report;

                    RunObject = Report "KUCCPS & PSSP Adm. By Program";
                    ApplicationArea = All;
                }
                action("Admission Per School")
                {
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "ACA-Senate Report";
                }


            }
        }
        area(embedding)
        {
            action("Program List")
            {

                Image = FixedAssets;

                RunObject = Page "ACA-Programmes List";
                ApplicationArea = All;
            }
            action("Semester Setup")
            {
                Caption = 'Semester Setup';
                Image = FixedAssetLedger;

                RunObject = Page "ACA-Semesters List";
                ApplicationArea = All;
            }

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
            group("SSS Admissions")
            {

                Image = RegisteredDocs;
                // action("Enquiry list")
                // {
                //     Caption = 'Enquiry list';
                //     RunObject = Page "ACA-Enquiry List";
                //     ApplicationArea = All;
                // }
                // action("Enquiry List (Pending)")
                // {
                //     Caption = 'Enquiry List (Pending)';
                //     RunObject = Page "ACA-Enquiry (Pending Approval)";
                //     ApplicationArea = All;
                // }
                // action("Enquiry List (Rejected)")
                // {
                //     Caption = 'Enquiry List (Rejected)';
                //     RunObject = Page "ACA-Enquiry (Rejected)";
                //     ApplicationArea = All;
                // }
                action(Applications)
                {
                    Caption = 'Applications';
                    RunObject = Page "ACA-Application Form H. list";
                    ApplicationArea = All;
                }
                action(HOD)
                {
                    //Caption = 'Deans Commitee';
                    RunObject = Page "HOD-Applicants";
                    ApplicationArea = All;
                }
                action("HOD Rejected")
                {
                    RunObject = Page "HOD Rejections";
                    ApplicationArea = All;
                }
                action("Deans Applicantions")
                {
                    RunObject = page "Dean-Applicants";
                    ApplicationArea = All;
                }
                action("Dean Rejections")
                {
                    RunObject = Page "Dean Rejections";
                    ApplicationArea = All;
                }
                action(Registrar)
                {
                    RunObject = page "Deans comitte";
                    ApplicationArea = All;
                }

                action("Admissionsletters list")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page "ACA-Print Admn Letter SSP/DIP";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("pending documents verification (PSSP)")
                {
                    Caption = 'Registration';
                    RunObject = Page "ACA-Pending Admissions PSSP";
                    ApplicationArea = All;
                }
                action(Admitted_PSSP)
                {
                    Caption = 'Admitted Students';
                    RunObject = Page "ACA-Admitted PSSP";
                    ApplicationArea = All;
                }
            }
            group("KUCCPS Admission")
            {
                Caption = 'KUCCPS Admission';
                Image = Transactions;
                action("Import Jab Admissions")
                {
                    Caption = 'Import KUCCPS Admissions';
                    RunObject = Page "KUCCPS Imports";
                    ApplicationArea = All;
                }
                action("Registration KUCCP")
                {
                    RunObject = Page "ACA-KUCCPS Student Reg";
                    Visible = true;
                    ApplicationArea = All;
                }
                action("Processed Jab Admissions")
                {
                    Caption = 'Processed Jab Admissions';
                    RunObject = Page "ACA-Print Admn Letter JAb";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Admissions letters list")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page "ACA-Print Admn Letter SSP/DIP";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("pending documents verification")
                {
                    Visible = false;
                    Caption = 'pending documents verification';
                    RunObject = Page "ACA-Pending Admissions List";
                    ApplicationArea = All;
                }
                action("pending payments confirmation")
                {
                    Caption = 'pending payments confirmation';
                    RunObject = Page "ACA-Pending Payments List";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("pending Admission confirmation")
                {
                    Caption = 'pending Admission confirmation';
                    RunObject = Page "ACA-Pending Admission Confirm.";
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Admitted_Kuccps)
                {
                    Caption = 'Admitted Students - KUCCPS';
                    RunObject = Page "ACA-Admitted KUCCPS";
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
                action(Programme)
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

            group(Defferment)
            {
                action(DefferedStudents)
                {
                    RunObject = Page "Deffered Students";
                    ApplicationArea = All;
                }
            }
            group(Clearances)
            {
                Caption = 'Student Clearance';
                Image = Intrastat;
                action(OpenClearance)
                {
                    Caption = 'Student Clearance (Open)';
                    Image = Register;

                    RunObject = Page "ACA-Student Clearance (Open)";
                    ApplicationArea = All;
                }
                action(ActiveClearance)
                {
                    Caption = 'Student Clearance (Active)';
                    Image = Registered;

                    RunObject = Page "ACA-Student Clearance (Active)";
                    ApplicationArea = All;
                }
                action(Cleared)
                {
                    Caption = 'Student Clearance(Cleared)';
                    RunObject = Page "ACA-Student Clearance(Cleared)";
                    ApplicationArea = All;
                }
                action(AllumniList)
                {
                    Caption = 'Student Aluminae List';
                    RunObject = Page "ACA-Student Aluminae List";
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

        area(reporting)
        {
            group("Student Reports")
            {
                action("KNBS Enrollment Report")
                {
                    Image = Report;

                    RunObject = Report "KNBS Enrollment Data";
                    ApplicationArea = All;
                }
                //Cue report
                action("CUE & Report")
                {
                    Image = Report;
                    Caption = 'CUE Report';

                    RunObject = Report "CUE Report";
                    ApplicationArea = All;
                }
            }

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
                action("Class List (By Stage)")
                {
                    Caption = 'Class List (By Stage)';
                    Image = List;

                    RunObject = Report "ACA-Class List (List By Stage)";
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
                // action("Multiple Record")
                // {
                //     Caption = 'Multiple Record';
                //     Image = Report2;
                //     RunObject = Report "Official College Transcript Nu";
                //     ApplicationArea = All;
                // }
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
                action("CUE Report")
                {
                    Caption = 'CUE Report';
                    Image = Agreement;

                    RunObject = Report "CUE Report";
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}

