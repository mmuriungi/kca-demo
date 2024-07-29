page 54322 "ACA-Exam & Acad. Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(slist)
            {
                ShowCaption = false;
#pragma warning disable AL0269
                part("StudentsList"; "ACA-Std Card List")
#pragma warning restore AL0269
                {
                    Caption = 'Students List';
                    ApplicationArea = All;
                }
            }
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }
            part(TOFF; "Approvals Activities Two")
            {
                ApplicationArea = Suite;
            }
            part(Registra; "Approvals Activities Three")
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
                Caption = 'Processes';
                action("Process Marks")
                {
                    Caption = 'Process Marks';
                    Image = AddAction;

                    RunObject = Page "Process Exams Central";
                    ApplicationArea = All;
                }
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
                    action("AcademicYear")
                    {
                        Image = Calendar;

                        RunObject = Page "ACA-Academic Year List";
                        ApplicationArea = All;
                    }
                    action("GeneralSetup")
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
                    action("Exam Setup")
                    {
                        Caption = '<Exam Setup>';
                        Image = SetupColumns;

                        RunObject = Page "ACA-Exams Setup Headers";
                        ApplicationArea = All;
                    }
                    action("GradingSystem")
                    {
                        Image = Setup;

                        RunObject = Page "ACA-Grading Sys. Header";
                        ApplicationArea = All;
                    }
                    action("Lecturer List")
                    {
                        Image = Employee;

                        RunObject = Page "ACA-Lecturers Units";
                        ApplicationArea = All;
                    }
                    action("Import Units")
                    {
                        Caption = 'Import Units';
                        Image = ImportCodes;

                        ApplicationArea = All;
                        // RunObject = XMLport 50155;
                    }
                    action("Import Units (Buffered)")
                    {
                        Caption = 'Import Units (Buffered)';
                        Image = ImportLog;

                        RunObject = Page "ACA-Prog. Units Buffer";
                        ApplicationArea = All;
                    }
                }
                action("Schools Management")
                {
                    Caption = 'Schools Management';
                    Image = DistributionGroup;

                    RunObject = Page "Dimensions For Academics";
                    ApplicationArea = All;
                }
            }
            group("Application and Admission")
            {
                group(AppliAdmin)
                {
                    Caption = 'Applications & General setup';
                    Image = Job;
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
                    action("Admitted Applicants")
                    {
                        Image = Archive;

                        RunObject = Page "ACA-Admitted Applicants List";
                        ApplicationArea = All;
                    }
                }
            }
            group("Admission History")
            {
                group(AdminHist)
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
            }
            group("Admission Reports")
            {
                group(AdminReports)
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
                    action(Enquiries)
                    {
                        Image = Report;

                        ApplicationArea = All;
                        //RunObject = Report 50052;
                    }
                    action("Marketing Strategies Report")
                    {
                        Image = Report;

                        ApplicationArea = All;
                        //RunObject = Report 50049;
                    }
                    action("Direct Applications")
                    {
                        Image = Report;

                        RunObject = Report "Direct Applications Form Reg";
                        ApplicationArea = All;
                    }
                    action("Application List")
                    {
                        Image = Report;

                        RunObject = Report "Application List Academic New";
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
            }
            group(Academics)
            {
                group(Academics2)
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
            }
            group("PeriodicActivities")
            {
                group(PerAc)
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
            }
            group("Academic reports")
            {
                group(AcadReports)
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
                }
                action("Registered Units Summary")
                {
                    Caption = 'Registered Units Summary';
                    Image = SuggestLines;

                    RunObject = Report "ACA-Units Registration Summary";
                    ApplicationArea = All;
                }
            }
            group(ExamPeriodicA)
            {
                Caption = 'Exam Periodic Activities';
                Image = Confirm;
                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    action("Raw Marks")
                    {
                        Caption = 'Raw Marks';
                        Image = ImportExcel;

                        RunObject = Page "ACA-Exam Results Raw Buffer";
                        ApplicationArea = All;
                    }
                    action("Exam Results Buffer")
                    {
                        Caption = 'Exam Results Buffer';
                        Image = UserSetup;
                        RunObject = Page "ACA-Exam Results Buffer 2";
                        ApplicationArea = All;
                    }
                    action("StudList")
                    {
                        Caption = 'Students List';
                        Image = UserSetup;
                        RunObject = Page "ACA-Examination Stds List";
                        ApplicationArea = All;
                    }
                    action("Export Template")
                    {
                        Caption = 'Export Template';
                        Image = Export;

                        ApplicationArea = All;
                        // RunObject = XMLport 39005508;
                    }

                    // action("Validate Exam Marks")
                    // {
                    //     Caption = 'Validate Exam Marks';
                    //     Image = ValidateEmailLoggingSetup;
                    //     
                    //     PromotedCategory = Process;
                    //     RunObject = Report "Validate Exam Marks";
                    //     ApplicationArea = All;
                    // }
                    action("Check Marks")
                    {
                        Caption = 'Check Marks';
                        Image = CheckList;

                        RunObject = Report "Check Marks";
                        ApplicationArea = All;
                    }
                    action(Timetables)
                    {
                        Caption = 'Timetable';
                        Image = Template;

                        RunObject = Page "ACA-Timetable Header";
                        ApplicationArea = All;
                    }
                    action(Examiners)
                    {
                        Caption = 'Examiners';
                        Image = HRSetup;

                        RunObject = Page "ACA-Examiners List";
                        ApplicationArea = All;
                    }
                }
            }
            group("Time Table1")
            {
                Caption = 'Time Tabling';
                Image = Setup;
                group(TimeTable)
                {
                    Caption = 'TimeTable Setups';
                    Image = Statistics;
                    action(Lessons)
                    {
                        Caption = 'Lessons';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Page "ACA-Lessons";
                        ApplicationArea = All;
                    }
                    action(Buildings)
                    {
                        Caption = 'Buildings';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Page "ACA-Buildings";
                        ApplicationArea = All;
                    }
                    action(Days)
                    {
                        Caption = 'Days';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Page "ACA-Days Of Week";
                        ApplicationArea = All;
                    }
                }
                group("Time Table")
                {
                    Caption = 'Time Tabling';
                    Image = Statistics;
                    action("Automatic Timetable")
                    {
                        Caption = 'Automatic Timetable';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Page "ACA-Auto_Time Table";
                        ApplicationArea = All;
                    }
                    action("Manual Timetable")
                    {
                        Caption = 'Manual Timetable';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Page "ACA-Manual Time Table";
                        ApplicationArea = All;
                    }
                    action("Semi Auto Time Table")
                    {
                        Caption = 'Semi Auto Time Table';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Page "ACA-Time Table Header";
                        ApplicationArea = All;
                    }
                }
            }
            group("Time TableReports")
            {
                Caption = 'Time Table Reports';
                Image = Transactions;
                group("Time Table Reports")
                {
                    Caption = 'Time Table Reports';
                    action(Master)
                    {
                        Caption = 'Master';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Report "Time Table";
                        ApplicationArea = All;
                    }
                    // action(Individual)
                    // {
                    //     Caption = 'Individual';
                    //     Image = Report2;
                    //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //     //PromotedIsBig = true;
                    //     RunObject = Report "Individual Time Table-General";
                    //     ApplicationArea = All;
                    // }
                    // action(Stage)
                    // {
                    //     Caption = 'Stage';
                    //     Image = Report2;
                    //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //     //PromotedIsBig = true;
                    //     RunObject = Report "Time Table - By Stage";
                    //     ApplicationArea = All;
                    // }
                    action(TT)
                    {
                        Caption = 'TT';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        RunObject = Report "Time table2";
                        ApplicationArea = All;
                    }
                    // action(Lecturer)
                    // {
                    //     Caption = 'Lecturer';
                    //     Image = Report2;
                    //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //     //PromotedIsBig = true;
                    //     RunObject = Report "Time Table - By Lecturer";
                    //     ApplicationArea = All;
                    // }
                    // action(Exam)
                    // {
                    //     Caption = 'Exam';
                    //     Image = Report2;
                    //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //     //PromotedIsBig = true;
                    //     RunObject = Report "Time Table - By Exam";
                    //     ApplicationArea = All;
                    // }
                    // action(Course)
                    // {
                    //     Caption = 'Course';
                    //     Image = Report2;
                    //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //     //PromotedIsBig = true;
                    //     RunObject = Report "Time Table - By Courses";
                    //     ApplicationArea = All;
                    // }
                    // action("Course 2")
                    // {
                    //     Caption = 'Course 2';
                    //     Image = Report2;
                    //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //     //PromotedIsBig = true;
                    //     RunObject = Report "Time Table - By Courses 2";
                    //     ApplicationArea = All;
                    // }
                }
            }
            group("ExamSetups")
            {
                Caption = 'Exam Setups';
                Image = HRSetup;
            }
            group(Setup)
            {
                Caption = 'Setups';
                action("Exam Setups")
                {
                    Caption = 'Exam Setups';
                    Image = SetupLines;

                    RunObject = Page "ACA-Exams Setup Headers";
                    ApplicationArea = All;
                }
                action("GradSystem")
                {
                    Caption = 'Grading System';
                    Image = Setup;


                    RunObject = Page "ACA-Grading Sys. Header";
                    ApplicationArea = All;
                }
                action("Lecturers Units")
                {
                    Caption = 'Lecturers Units';
                    Image = VendorLedger;

                    RunObject = Page "ACA-Lecturers Units";
                    ApplicationArea = All;
                }
                action("General Setup")
                {
                    Caption = 'General Setup';
                    Image = GeneralPostingSetup;

                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = All;
                }
                action("Academic Year")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;

                    RunObject = Page "ACA-Academic Year Card";
                    ApplicationArea = All;
                }
                action("Results Status List")
                {
                    Caption = 'Results Status List';
                    Image = Status;
                    RunObject = Page "ACA-Senate Report Lubrics";
                    ApplicationArea = All;
                }
                action("Classification Lubrics")
                {
                    Caption = 'Classification Lubrics';
                    Image = AddWatch;

                    RunObject = Page "ACA-Class/Grad. Lubrics";
                    ApplicationArea = All;
                }
                action("Supplementary Lubrics")
                {
                    Caption = 'Supplementary Lubrics';
                    Image = StepInto;
                    RunObject = Page "ACA-Supp. Lubrics List";
                    ApplicationArea = All;
                }
            }
        }
        area(Creation)
        {
            group("Student Management Setups")
            {
                Caption = 'Academic Setups';
                // action("Bulk Units Registration")
                // {
                //     Caption = 'Bulk Units Registration';
                //     RunObject = Page "Bulk Units/Course Registration";
                //     ApplicationArea = All;
                // }
                action("Gratuation Overview")
                {
                    Caption = 'Gratuation Overview';
                    RunObject = Page "ACA-Classification Overview";
                    ApplicationArea = All;
                }
                action("program List")
                {
                    Caption = 'program List';
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
                action("Inter Transfers")
                {
                    RunObject = Page "ACA-Students Transfer";
                    ApplicationArea = All;
                }
            }
            group("Applications/Admissions")
            {
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
            group("General Academics")
            {
                action(Registration2)
                {
                    Image = Register;

                    RunObject = Page "ACA-Std Registration List";
                    ApplicationArea = All;
                }
                action("Students Card2")
                {
                    Image = Registered;

                    RunObject = Page "ACA-Std Card List";
                    ApplicationArea = All;
                }
            }
            group(Examinations)
            {
                action("Students List")
                {
                    Caption = 'Students List';
                    Image = UserSetup;
                    RunObject = Page "ACA-Examination Stds List";
                    ApplicationArea = All;
                }
                action("Grading System")
                {
                    Caption = 'Grading System';
                    Image = SetupColumns;

                    RunObject = Page "ACA-Grading Sys. Header";
                    ApplicationArea = All;
                }
            }
        }
        area(sections)
        {
            group("PSSP Admissions")
            {
                Caption = 'PSSP Admissions';
                Image = RegisteredDocs;
                action("Enquiry list")
                {
                    Caption = 'Enquiry list';
                    RunObject = Page "ACA-Enquiry List";
                    ApplicationArea = All;
                }
                action("Enquiry List (Pending)")
                {
                    Caption = 'Enquiry List (Pending)';
                    RunObject = Page "ACA-Enquiry (Pending Approval)";
                    ApplicationArea = All;
                }
                action("Enquiry List (Rejected)")
                {
                    Caption = 'Enquiry List (Rejected)';
                    RunObject = Page "ACA-Enquiry (Rejected)";
                    ApplicationArea = All;
                }
                action(Applications)
                {
                    Caption = 'Applications';
                    RunObject = Page "ACA-Application Form H. list";
                    ApplicationArea = All;
                }
                action("Dean's Commitee")
                {
                    Caption = 'Dean''s Commitee';
                    RunObject = Page "ACA-Applic. Form Board Process";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Admissionslist")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page "ACA-Print Admn Letter SSP/DIP";
                    Visible = true;
                    ApplicationArea = All;
                }
                action("pendingDocverification")
                {
                    Caption = 'pending documents verification';
                    RunObject = Page "ACA-Pending Admissions List";
                    Visible = true;
                    ApplicationArea = All;
                }
                action("pending paymentsconfirmation")
                {
                    Caption = 'pending payments confirmation';
                    RunObject = Page "ACA-Pending Payments List";
                    ApplicationArea = All;
                }
                action("pending Admissionconfirmation")
                {
                    Caption = 'pending Admission confirmation';
                    RunObject = Page "ACA-Pending Admission Confirm.";
                    ApplicationArea = All;
                }
                action("Admitted Students")
                {
                    Caption = 'Admitted Students';
                    RunObject = Page "ACA-Admitted Applicants List";
                    ApplicationArea = All;
                }
            }
            group("KUCCPS Admission")
            {
                Caption = 'KUCCPS Admission';
                Image = Transactions;
                action("Raw KUCCPS Data")
                {
                    Caption = 'Raw KUCCPS Data';
                    Image = ImportLog;

                    RunObject = Page "ACA-Raw KUCCPS Imports";
                    ApplicationArea = All;
                }
                action("Import Jab Admissions")
                {
                    Caption = 'Import Jab Admissions';
                    RunObject = Page "KUCCPS Imports";
                    ApplicationArea = All;
                }
                action("Processed Jab Admissions")
                {
                    Caption = 'Processed Jab Admissions';
                    RunObject = Page "ACA-Print Admn Letter JAb";
                    ApplicationArea = All;
                }
                action("Admissions letters list")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page "ACA-Print Admn Letter SSP/DIP";
                    ApplicationArea = All;
                }
                action("pending documents verification")
                {
                    Caption = 'pending documents verification';
                    RunObject = Page "ACA-Pending Admissions List";
                    ApplicationArea = All;
                }
                action("pending payments confirmation")
                {
                    Caption = 'pending payments confirmation';
                    RunObject = Page "ACA-Pending Payments List";
                    ApplicationArea = All;
                }
                action("pending Admission confirmation")
                {
                    Caption = 'pending Admission confirmation';
                    RunObject = Page "ACA-Pending Admission Confirm.";
                    ApplicationArea = All;
                }
                action("<Page ACA-Admitted Applicants Li2")
                {
                    Caption = 'Admitted Students';
                    RunObject = Page "ACA-Admitted Applicants List";
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
                action(Programm)
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
                action("Class Allocations")
                {
                    Image = Allocate;
                    RunObject = Page "HRM-Class Allocation List";
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
            group(Timetabling)
            {
                Caption = 'Timetable Management';
                Image = Statistics;
                action(TimetableCentral)
                {
                    Caption = 'Timetable Central';
                    Image = Register;

                    RunObject = Page "TT-Timetable Batches";
                    ApplicationArea = All;
                }
                action("Exam Timetable")
                {
                    Caption = 'Exam Timetable';
                    RunObject = Page "EXT-Timetable Batches";
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
                action("InsurCompanies")
                {
                    Caption = 'Insurance Companies';
                    ApplicationArea = All;
                    //   RunObject = Page 68844;
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
                    action("ImportUnits")
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
                        Image = AddAction;

                        RunObject = Report "CUE Report";
                        ApplicationArea = All;
                    }
                }
                group("BeforeExams")
                {
                    Caption = 'Before Exams';
                    action("ExaminationCards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;

                        RunObject = Report "Exam Card Final";
                        ApplicationArea = All;
                    }

                    action("Class attendance With B")
                    {
                        RunObject = Report "Class Attendance Checklist2";
                        ApplicationArea = All;
                    }
                    action("Class Attendance Without B")
                    {
                        RunObject = Report "Class Attendance Checklist2 S";
                        ApplicationArea = All;
                    }
                    // action("Aca-Special Exams Check List")
                    // {
                    //     Image = Print;
                    //     RunObject = Report "Aca-Special Exams Check List";
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
                group("Before Exams")
                {
                    Caption = 'Before Exams';
                    Image = Report;
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
                    action("Resit Attendance")
                    {
                        ApplicationArea = All;
                        Image = ResetStatus;
                        RunObject = report "Resit Exam Attendance";
                    }
                }
                action("Course Loading")
                {
                    Caption = 'Course Loading';
                    Image = LineDiscount;

                    RunObject = Report "Lecturer Course Loading";
                    ApplicationArea = All;
                }
                action("Class attendance With BA")
                {
                    RunObject = Report "Class Attendance Checklist2";
                    ApplicationArea = All;
                }
                action("Class Attendance Without BA")
                {
                    RunObject = Report "Class Attendance Checklist2 S";
                    ApplicationArea = All;
                }
                // action("Resits Collection Report")
                // {
                //     Image = Print;
                //     RunObject = Report "Resits Collection Report";
                //     ApplicationArea = All;
                // }
                // action("Aca-Special Exams Check Ls")
                // {
                //     Image = Print;
                //     RunObject = Report "Aca-Special Exams Check List";
                //     ApplicationArea = All;
                // }
                group(ExamExams)
                {
                    Caption = 'After Exams';
                    Image = Report;
                    action("Consolidated Marksheet")
                    {
                        Caption = 'Consolidated Marksheet';
                        Image = Completed;

                        RunObject = Report "Sems. Consolidated Marksheet";
                        ApplicationArea = All;
                    }
                    action("Consolidated Marksheet 2")
                    {
                        Caption = 'Consolidated Marksheet 2';
                        Image = CompleteLine;

                        RunObject = Report "Final Consolidated Marksheet";
                        ApplicationArea = All;
                    }
                    action("Consolidated Marksheet 3")
                    {
                        Caption = 'Consolidated Marksheet 3';
                        RunObject = Report "Consolidated Marksheet 2";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Senate Summary Report 1")
                    {
                        Caption = 'Senate Summary Report 1';
                        Image = Report;

                        RunObject = Report "Results Category Summary";
                        ApplicationArea = All;
                    }
                    action("Senate Summary Report 2")
                    {
                        Caption = 'Senate Summary Report 2';
                        Image = Report;

                        RunObject = Report "Results Category Summary 2";
                        ApplicationArea = All;
                    }
                    action(Attendance_Checklist)
                    {
                        Caption = 'Attendance Checklist';
                        RunObject = Report "Exam Attendance Checklist2";
                        ApplicationArea = All;
                    }
                    // action("Class Grade Sheet")
                    // {
                    //     Caption = 'Class Grade Sheet';
                    //     Image = CheckDuplicates;
                    //     
                    //     RunObject = Report "ACA-Class Roster Grade Sheet";
                    //     Visible = false;
                    //     ApplicationArea = All;
                    // }
                    action("Consolidated Gradesheet")
                    {
                        Caption = 'Consolidated Gradesheet';
                        Image = CheckDuplicates;

                        RunObject = Report "ACA-Consolidated Gradesheet";
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Provisional Transcript")
                    {
                        Caption = 'Provisional Transcript';
                        Image = FixedAssets;

                        RunObject = Report "Provisional College Transcript";
                        ApplicationArea = All;
                    }
                    action("Undergaduate Transcript")
                    {
                        Image = Split;

                        RunObject = Report "Official University Transcript";
                        ApplicationArea = All;
                    }
                    action("PostGraduate Transcript")
                    {
                        Image = BreakRulesOff;
                        ApplicationArea = All;
                        RunObject = Report "Official Masters Transcript";
                    }
                    action("Marks Entry Statistics")
                    {
                        Caption = 'Marks Entry Statistics';
                        Image = AgreementQuote;
                        RunObject = Report "Lecturer Exam Entry Statistics";
                        ApplicationArea = All;
                    }
                    action("Confirmation Marksheet")
                    {
                        Caption = 'Confirmation Marksheet';
                        Image = AdjustEntries;
                        RunObject = Report "Check Marks";
                        ApplicationArea = All;
                    }
                    action("Student Progress Report")
                    {
                        Caption = 'Student Progress Report';
                        Image = Agreement;
                        RunObject = Report "Student Progress Report";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}

