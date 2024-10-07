/// <summary>
/// Page ACA-Academics Role Center (ID 68861).
/// </summary>
page 51456 "ACA-Academics Role Center&"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")

            {
                ApplicationArea = all;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            group(general)

            {
#pragma warning disable AL0269
                part("Students List"; "ACA-Std Card List")
#pragma warning restore AL0269
                {
                    ApplicationArea = All;
                    Caption = 'Students List';
                }
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
                group(SetupsG)
                {

                    Caption = 'General Setups';
                    Image = Administration;
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
                    action("InsuranceCompanies")
                    {
                        Image = Insurance;

                        ApplicationArea = All;
                        //RunObject = Page 50051;
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
                    action("MarketingStrategies")
                    {
                        Image = MarketingSetup;

                        RunObject = Page "ACA-Marketing Strategies 2";
                        ApplicationArea = All;
                    }
                    action("Import Data for Update")
                    {
                        Caption = 'Import Data for Update';
                        Image = ImportDatabase;

                        RunObject = Page "ACA-Std. Data Buffer";
                        ApplicationArea = All;
                    }
                    action("Import Course Reg. Buffer")
                    {
                        Caption = 'Import Course Reg. Buffer';
                        Image = RegisterPutAway;

                        RunObject = Page "ACA-Course Reg. Buffer";
                        ApplicationArea = All;
                    }
                    // action("Exam Setup")
                    // {
                    //     Caption = '<Exam Setup>';
                    //     Image = SetupColumns;
                    //     
                    //     PromotedCategory = Process;
                    //     RunObject = Page "ACA-Exams Setup Headers";
                    //     ApplicationArea = All;
                    // }
                    // action("Grading System")
                    // {
                    //     Image = Setup;
                    //     
                    //     RunObject = Page "ACA-Grading Sys. Header";
                    //     ApplicationArea = All;
                    // }
                    action("Lecturer Units")
                    {
                        Image = Employee;

                        RunObject = Page "ACA-Lecturer List";
                        ApplicationArea = All;
                    }
                    action("ImportUnits")
                    {
                        Caption = 'Import Units';
                        Image = ImportCodes;

                        ApplicationArea = All;
                        //  RunObject = XMLport 50155;
                    }
                    action("Import Units (Buffered)")
                    {
                        Caption = 'Import Units (Buffered)';
                        Image = ImportLog;

                        RunObject = Page "ACA-Prog. Units Buffer";
                        ApplicationArea = All;
                    }
                    action("IntakeFee Setup2")
                    {
                        Caption = 'Intake Setup';
                        Image = Setup;
                        RunObject = page "ACA-Intake List";
                        ApplicationArea = All;
                    }
                }
                group(SetUP)
                {
                    action(KUCCPSMailingLis)
                    {
                        Caption = 'GSS Mailing List';
                        ApplicationArea = all;
                        RunObject = Page "KUCCPS Imports Mailing List";
                        RunPageMode = View;
                    }//"ACA-Mailing List Params"
                    action("Send GSS MailS")
                    {
                        Caption = 'Send Mail';
                        ApplicationArea = all;
                        RunObject = Page "ACA-Mailing List Params";

                    }//"ACA-Mailing List Params"
                    action(SendMail)
                    {
                        Caption = 'Sent Mail';
                        ApplicationArea = all;
                        RunObject = Page "Sent Emails";
                        RunPageMode = View;
                    }
                }
            }
            group("Application and Admission")
            {
                
                    Caption = 'Applications & General setup';
                    Image = Job;
                    // action("Online Enquiries")
                    // {
                    //     Image = NewOrder;

                    //     RunObject = Page "ACA-Enquiry Form";
                    //     ApplicationArea = All;

                    // }
                    // action("Online Applications")
                    // {
                    //     Image = NewCustomer;

                    //     RunObject = Page "ACA-Enquiry List (a)";
                    //     ApplicationArea = All;
                    // }
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
                    action("Admitted Applicants")
                    {
                        Image = Archive;

                        RunObject = Page "ACA-Admitted Applicants List";
                        ApplicationArea = All;
                    }
               
            }
            group("Admission History")
            {
                
                    Caption = 'Admissions History';
                    Image = History;
                    action("Pending Admissions")
                    {
                        Image = History;

                        RunObject = Page "ACA-Pending Admissions List";
                        ApplicationArea = All;
                    }
                    action("Rejected Applications")
                    {
                        Image = Reject;

                        RunObject = Page "ACA-Rejected Applications List";
                        ApplicationArea = All;
                    }
                    action("Cancelled Applications")
                    {
                        Image = Cancel;

                        RunObject = Page "ACA-Cancelled ApplicsList";
                        ApplicationArea = All;
                    }
               
            }
            group("Application Reports")
            {
                 action("New Applications")
                    {
                        Image = Report;

                        RunObject = Report "Application List Academic New";
                        ApplicationArea = All;
                    }
                    action("Online Applications Report")
                    {
                        Image = Report;

                        RunObject = Report "Application List";
                        ApplicationArea = All;
                    }
                    action("Application List")
                    {
                        Image = Report;

                        RunObject = Report "Application List Academic New";
                        ApplicationArea = All;
                    }
                     action("Direct Applications")
                    {
                        Image = Report;

                        RunObject = Report "Direct Applications Form Reg";
                        ApplicationArea = All;
                    }
                    
                    action("Application Summary")
                    {
                        Image = Report;

                        RunObject = Report "Application Summary";
                        ApplicationArea = All;
                    }
                    action("Applicant Shortlisting (Summary)")
                    {
                        Image = Report;

                        RunObject = Report "Shortlisted Students Summary";
                        ApplicationArea = All;
                    }
                    action("Applicant Shortlisting (Detailed)")
                    {
                        Image = Report;

                        RunObject = Report "Shortlisted Students Status";
                        ApplicationArea = All;
                    }
            }
            group("Admission Reports")
            {
                
                    Caption = 'Admission Reports';
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
                   
                    
                    action("Marketing Strategies Report")
                    {
                        Image = Report;

                        RunObject = Report "ACA-Marketing Strategy";
                        ApplicationArea = All;
                    }
                   
                
            }

            group(Academics)
            {
                
                    Caption = 'Academic';
                    Image = Departments;
                    action("Student Registration")
                    {
                        Image = Register;

                        RunObject = Page "ACA-Std Registration List";
                        ApplicationArea = All;
                    }
                    action("Student Card")
                    {
                        Image = Registered;

                        RunObject = Page "ACA-Std Card List";
                        ApplicationArea = All;
                    }
                    action(Alumni)
                    {
                        Image = History;

                        RunObject = Page "ACA-Student Aluminae List";
                        ApplicationArea = All;
                    }
                    action("Lecturers List")
                    {
                        Image = Resource;

                        RunObject = Page "ACA-Lecturer List";
                        ApplicationArea = All;
                    }
               
            }
            group("Periodic Activities")
            {
               
                    Caption = 'Periodic Activities';
                    Image = Transactions;
                    // action("Graduation Charges (Unposted)")
                    // {
                    //     Caption = 'Graduation Charges (Unposted)';
                    //     Image = UnApply;
                    //     
                    //     PromotedIsBig = true;
                    //     RunObject = Page "ACA-Grad. Charges (Unposted)";
                    //     ApplicationArea = All;
                    // }
                    action(GenGraduInd)
                    {
                        Caption = 'Generate Graduation Charges (Individual Students)';
                        Image = GetEntries;

                        RunObject = Report "Graduation Fee Generator";
                        ApplicationArea = All;
                    }
                
            }
            group("Academic reports")
            {
               
                    Caption = 'Academic reports';
                    Image = RegisteredDocs;
                    action("NorminalRoll")
                    {
                        Image = Report;

                        RunObject = Report "Norminal Roll (Cont. Students)";
                        ApplicationArea = All;
                    }
                    action("Enrollment Statistics")
                    {
                        Image = Report;

                        RunObject = Report "Students Enrolment";
                        ApplicationArea = All;
                    }
                    action("Student Balances")
                    {
                        Image = Report;

                        RunObject = Report "stud list new";
                        ApplicationArea = All;
                    }
                    action("Fee Statements")
                    {
                        Image = Report;

                        RunObject = Report "Student Fee Statement 2";
                        ApplicationArea = All;
                    }
                    action("Statistics By Programme Category")
                    {
                        Image = Statistics;

                        RunObject = Report "Population By Prog. Category";
                        ApplicationArea = All;
                    }
                    action("Exam Attendace")
                    {
                        Image = Statistics;
                        RunObject = Report "Exam Attendance Clearance";
                        ApplicationArea = All;
                    }
                    action("Exam Card")
                    {
                        Image = Statistics;
                        RunObject = Report "Exam Card Final";
                        ApplicationArea = All;
                    }
                    action("Auto Register")
                    {
                        Image = Statistics;
                        RunObject = Report AutoRegisterUnits;
                        ApplicationArea = All;
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
            action(Unitsmaster)
            {
                RunObject = page "ACA-Units Master";
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


            // action("Applications (Online)")
            // {
            //     Image = NewCustomer;

            //     RunObject = Page "ACA-Online Application List";
            //     ApplicationArea = All;
            // }
            // action("Applications - Direct ")
            // {
            //     Image = NewCustomer;

            //     RunObject = Page "ACA-Application Form H. list";
            //     ApplicationArea = All;
            // }
            // action("Applicant Admission Letters")
            // {
            //     Image = CustomerList;

            //     RunObject = Page "ACA-Admn Letters Direct";
            //     ApplicationArea = All;
            // }
            // action("Admissions (New)")
            // {
            //     Image = NewItem;

            //     RunObject = Page "ACA-New Admissions List";
            //     ApplicationArea = All;
            // }


            // action(Registration2)
            // {
            //     Image = Register;

            //     RunObject = Page "ACA-Std Registration List";
            //     ApplicationArea = All;
            // }
            // action("Students Card2")
            // {
            //     Image = Registered;

            //     RunObject = Page "ACA-Std Card List";
            //     ApplicationArea = All;
            // }
            // action("Default Exam")
            // {
            //     ApplicationArea = All;
            //     image = Debug;
            //     RunObject = Report "ACA-Update Unit Exam Category";
            // }


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
            group("Mail Management")
            {
                action(KUCCPSMailingList)
                {
                    Caption = 'GSS Mailing List';
                    ApplicationArea = all;
                    RunObject = Page "KUCCPS Imports Mailing List";
                    RunPageMode = View;
                }//"ACA-Mailing List Params"
                action("Send GSS Mail")
                {
                    Caption = 'Send Mail';
                    ApplicationArea = all;
                    RunObject = Page "ACA-Mailing List Params";

                }//"ACA-Mailing List Params"
                action(SendMails)
                {
                    Caption = 'Sent Mail';
                    ApplicationArea = all;
                    RunObject = Page "Sent Emails";
                    RunPageMode = View;
                }
                // action(Pass)
                // {
                //     ApplicationArea = All;
                //     RunObject = Page "Portal Pass"
                // }
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
            group(Defferment)
            {
                action(DefferedStudents)
                {
                    RunObject = Page "Deffered Students";
                    ApplicationArea = All;
                }
            }
            group("Class Attendance")
            {
                action("Attendance Register")
                {
                    RunObject = page "Class Attendance List";
                }
            }
            group("Lecture Evaluation")
            {
                action(Evaluation)
                {
                    ApplicationArea = All;


                    RunObject = page "ACA-Evaluation Semesters List";
                }
                action("Evaluation Results")
                {
                    ApplicationArea = All;
                    RunObject = page "Evaluation Results";
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
            group(LectMan)
            {
                Caption = 'Lecturer Management';
                Image = HumanResources;
                action(SemBatches)
                {
                    Caption = 'Lect. Loading Semester Batches';
                    Image = Register;

                    RunObject = Page "Lect Load Batch List";
                    ApplicationArea = All;
                }
                action(LoadApp)
                {
                    Caption = 'Loading Approvals';
                    Image = Registered;

                    RunObject = Page "Lect Load Approvals";
                    ApplicationArea = All;
                }
                action(ApprovedLoad)
                {
                    Caption = 'Approved Loading';
                    RunObject = Page "Lecturer Load Approved";
                    ApplicationArea = All;
                }
                action(ClaimsGen)
                {
                    Caption = 'Lect. Claim Generation';
                    RunObject = Page "Lect Load Claim Gen.";
                    ApplicationArea = All;
                }
                action(LoadPendingDeptApp)
                {
                    Caption = 'Loading Pending Dept. Approval';
                    Image = Registered;

                    RunObject = Page "Lecturer Load Pending Dept. Ap";
                    ApplicationArea = All;
                }
                action(PostedSemBatches)
                {
                    Caption = 'Posted Load Batches';
                    RunObject = Page "Lect Posted Batches List";
                    ApplicationArea = All;
                }
                action(LoadHist)
                {
                    Caption = 'Loading History';
                    RunObject = Page "Lect Loads History";
                    ApplicationArea = All;
                }
                action(LoadCentralSetup)
                {
                    Caption = 'Loading Central Setup';
                    Image = Registered;

                    RunObject = Page "Lect Load Central Setup";
                    ApplicationArea = All;
                }
            }
            group(Setups)
            {
                Caption = 'Setups';
                Image = Setup;
                action(Programmes)
                {
                    Caption = 'Programmes';
                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action(Nationality)
                {
                    Caption = 'Nationality';
                    RunObject = Page "GEN-Nationality List";
                    ApplicationArea = All;
                }
                action("Marketing Strategies")
                {
                    Caption = 'Marketing Strategies';
                    RunObject = Page "ACA-Marketing Strategies";
                    ApplicationArea = All;
                }
                action("Schools/Faculties")
                {
                    Caption = 'Schools/Faculties';
                    RunObject = Page "ACA-Schools/Faculties";
                    ApplicationArea = All;
                }
                action(Religions)
                {
                    Caption = 'Religions';
                    RunObject = Page "GEN-Religions";
                    ApplicationArea = All;
                }
                action(Denominations)
                {
                    Caption = 'Denominations';
                    RunObject = Page "GEN-Denominations";
                    ApplicationArea = All;
                }
                action("Insurance Companies")
                {
                    Caption = 'Insurance Companies';
                    ApplicationArea = All;
                    //RunObject = Page 68844;
                }
                action(Relationships)
                {
                    Caption = 'Relationships';
                    RunObject = Page "GEN-Relationships";
                    ApplicationArea = All;
                }
                action(Counties)
                {
                    Caption = 'Counties';
                    RunObject = Page "GEN-Counties List";
                    ApplicationArea = All;
                }
                action("Clearance Codes")
                {
                    Caption = 'Clearance Codes';
                    Image = Setup;
                    RunObject = Page "ACA-Clearance Code Levels";
                    ApplicationArea = All;
                }
                action("Registration List")
                {
                    Image = Allocations;
                    RunObject = Page "ACA-Course Reg. Listing";
                    ApplicationArea = All;
                }
                action("IntakeFee Setup")
                {
                    Image = Setup;
                    RunObject = page "Program Intake Fee";
                    ApplicationArea = All;
                }
                action("Central Setups")
                {
                    RunObject = page "ACA-Central Setup List";
                    ApplicationArea = All;
                }
                action(Tribes)
                {
                    RunObject = page "Tribes List";
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
        area(reporting)
        {
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
                    }
                }
                group("Before Exams")
                {
                    Caption = 'Before Exams';
                    action("Examination Cards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;
                        RunObject = Report "Exam Card Final";
                        ApplicationArea = All;
                    }
                    action("Resit Card")
                    {
                        ApplicationArea = All;
                        Image = CreateForm;
                        RunObject = Report "Resit Exam  Card Final";
                    }

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
                    // action("Student Invoices Per Charge")
                    // {
                    //     Caption = 'Student Invoices Per Charge';
                    //     Image = PrintInstallment;
                    //     
                    //     PromotedIsBig = true;
                    //     RunObject = Report "Student Inv. And Payments";
                    //     ApplicationArea = All;
                    // }
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
    }
}

