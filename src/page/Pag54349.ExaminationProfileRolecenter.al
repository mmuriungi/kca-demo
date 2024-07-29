page 54349 "Examination Profile Rolecenter"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part(Control1904484608; "ACA-Programmes Part")
            {
                Caption = 'Programmes List';
                ApplicationArea = All;
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
            action("Students List")
            {
                Caption = 'Students List';
                Image = UserSetup;
                RunObject = Page "ACA-Examination Stds List";
                ApplicationArea = All;
            }
            action("<Page ACA-Std Card List>")
            {
                Caption = 'Students Card';
                Image = Registered;
                ApplicationArea = All;
                RunObject = Page "ACA-Std Card List";
            }
            action("Programmes List")
            {
                Caption = 'Programmes List';
                Image = FixedAssets;
                RunObject = Page "ACA-Programmes List";
                ApplicationArea = All;
            }
            action("Grading System")
            {
                Caption = 'Grading System';
                Image = SetupColumns;

                RunObject = Page "ACA-Grading Sys. Header";
                ApplicationArea = All;
            }
            action("Results Status List")
            {
                Caption = 'Results Status List';
                Image = Status;

                RunObject = Page "ACA-Senate Report Lubrics";
                ApplicationArea = All;
            }

        }
        area(processing)
        {
            group("Processes")
            {
                Caption = 'Processing';
                action("Marks Capture")
                {
                    Caption = 'Marks Capture';
                    Image = Administration;

                    RunObject = Page "Results Capture List";
                    ApplicationArea = All;
                }
                action("Process Marks")
                {
                    Caption = 'Process Marks';
                    Image = AdjustEntries;

                    RunObject = Page "Process Exams Central Gen.";
                    ApplicationArea = All;
                }
                action("Process Graduation")
                {
                    Caption = 'Process Graduation';
                    Image = AddAction;

                    RunObject = Page "Process Exams Central";
                    ApplicationArea = All;
                }
                action("Senate Preview")
                {
                    Caption = 'Senate Preview';
                    Image = PreviewChecks;

                    RunObject = Page "ACA-Exam. Senate Review";
                    ApplicationArea = All;
                }
                action("Graduation Review")
                {
                    Caption = 'Graduation Review';
                    Image = AddToHome;

                    RunObject = Page "Graduation Overview";
                    ApplicationArea = All;
                }
                action("Student List")
                {
                    Caption = 'Student List';
                    Image = CalculateConsumption;

                    RunObject = Page "Deans Student List";
                    ApplicationArea = All;
                }
                action("Examination Module Guide")
                {
                    Caption = 'Examination Module Guide';
                    Image = GLRegisters;

                    RunObject = Report "Examination Module Guide";
                    ApplicationArea = All;
                }
                action("Import Results")
                {
                    Caption = 'Import Results';
                    Image = UserSetup;

                    RunObject = Page "ACA-Exam Results Buffer 2";
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
                action("Resit Attendance")
                {
                    ApplicationArea = All;
                    Image = ResetStatus;
                    RunObject = report "Resit Exam Attendance";
                }
            }
            group(ExamExams)
            {
                Caption = 'After Exams';
                Image = "Report";
                action(ConsMarkssheet)
                {
                    Caption = 'Consolidated Marksheet';
                    Image = CompleteLine;

                    RunObject = Report "ACA-Consolidated Marksheet 1";
                    ApplicationArea = All;
                }
                action("Consolidated Marksheet")
                {
                    Caption = 'Consolidated Marksheet';
                    Image = Completed;

                    RunObject = Report "Supp. Final Cons. Marksheet";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Consolidated Marksheet 2")
                {
                    Caption = 'Consolidated Marksheet 2';
                    Image = CompleteLine;

                    RunObject = Report "Final Consolidated Marksheet";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Consolidated Marksheet 3")
                {
                    Caption = 'Consolidated Marksheet 3';
                    RunObject = Report "Consolidated Marksheet 2";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Senate Report")
                {
                    Caption = 'Senate Report';
                    Image = Agreement;

                    RunObject = Report "ACA-Senate Report";
                    ApplicationArea = All;
                }
                action("Senate Summary Report 1")
                {
                    Caption = 'Senate Summary Report 1';
                    Image = Reconcile;

                    RunObject = Report "Results Category Summary";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Senate Summary Report 2")
                {
                    Caption = 'Senate Summary Report 2';
                    Image = Reconcile;

                    RunObject = Report "Results Category Summary 2";
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Attendance_Checklist)
                {
                    Caption = 'Attendance Checklist';
                    RunObject = Report "Exam Attendance Checklist2";
                    ApplicationArea = All;
                }

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

                    RunObject = Report "Provisional College Transcrip3";
                    ApplicationArea = All;
                }
                // action("Provisional Transcript 2")
                // {
                //     Caption = 'Provisional Transcript 2';
                //     Image = FixedAssets;
                //     
                //     RunObject = Report Report77713;
                //     Visible = false;
                // }
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
                    Image = AddAction;
                    RunObject = Report "Lecturer Exam Entry Statistics";
                    ApplicationArea = All;
                }
                action("Check Exam Results")
                {
                    Caption = 'Check Exam Results';
                    Image = Design;

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
                action("Examination Markssheet")
                {
                    ApplicationArea = All;
                    Image = MakeAgreement;
                    RunObject = Report "Individual Marksheet";
                }
            }
            group(GradReports)
            {
                Caption = 'Graduation Reports';
                Image = "Report";
                action("Classification List")
                {
                    Caption = 'Classification List';
                    Image = Completed;

                    RunObject = Report "Final Deans Classification 2";
                    ApplicationArea = All;
                }
                action("Graduation List")
                {
                    Caption = 'Graduation List';
                    Image = CompleteLine;

                    RunObject = Report "Final Deans Graduation List 2";
                    ApplicationArea = All;
                }
                action("Final Consolidated Marksheet")
                {
                    Caption = 'Final Consolidated Marksheet';
                    Image = CompleteLine;

                    RunObject = Report "ACA-Consolidated Marksheet 1";
                    ApplicationArea = All;
                }
                // action("Classification Marksheet")
                // {
                //     Caption = 'Classification Marksheet';
                //     Image = Aging;
                //     
                //     PromotedIsBig = false;
                //     RunObject = Report Report78015;
                //     Visible = false;
                // }
                action("Incomplete List")
                {
                    Caption = 'Incomplete List';
                    Image = ContactFilter;

                    RunObject = Report "Deans Incomplete List";
                    ApplicationArea = All;
                }
                action("Incomplete List (Detailed)")
                {
                    Caption = 'Incomplete List (Detailed)';
                    Image = Continue;

                    RunObject = Report "Reasons for Incomplete";
                    ApplicationArea = All;
                }
                action("Failed Units List")
                {
                    Caption = 'Failed Units List';
                    Image = ContractPayment;

                    RunObject = Report "Cummulative Failed Units";
                    ApplicationArea = All;
                }
                action("Graduation Progress Report")
                {
                    Caption = 'Graduation Progress Report';
                    Image = CreateJobSalesCreditMemo;

                    RunObject = Report "Graduation Progress Report";
                    ApplicationArea = All;
                }
                action(SenateReport)
                {
                    Caption = 'Senate Report';
                    Image = Agreement;

                    RunObject = Report "Exams Final Pass List C 5";
                    ApplicationArea = All;
                }
                action("Cummulative Resit List")
                {
                    Image = BulletList;

                    RunObject = Report "Exams Final Cummulative Resit";
                    ApplicationArea = All;
                }
                action("Cummulative Halt List")
                {
                    Caption = 'Cummulative Halt List';
                    Image = CalcWorkCenterCalendar;

                    RunObject = Report "ACA-Cummulative Halt List";
                    ApplicationArea = All;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                Image = ReopenPeriod;
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
                action(Action5)
                {
                    Caption = 'Students List';
                    Image = UserSetup;
                    RunObject = Page "ACA-Examination Stds List";
                    ApplicationArea = All;
                }
                // action("Export Template")
                // {
                //     Caption = 'Export Template';
                //     Image = Export;
                //     
                //     PromotedCategory = Process;
                //     RunObject = XMLport XMLport39005508;
                // }
                // action(Import_Exam_Results)
                // {
                //     Caption = 'Import Exam Results';
                //     Image = ImportCodes;
                //     
                //     PromotedCategory = Process;
                //     RunObject = XMLport XMLport39005507;
                // }
                // action("Validate Exam Marks")
                // {
                //     Caption = 'Validate Exam Marks';
                //     Image = ValidateEmailLoggingSetup;
                //     
                //     PromotedCategory = Process;
                //     RunObject = Report Report65819;
                // }
                action("Check Marks")
                {
                    Caption = 'Check Marks';
                    Image = CheckList;

                    RunObject = Report "Check Marks";
                    ApplicationArea = All;
                }
                action(Action1000000024)
                {
                    Caption = 'Process Marks';
                    Image = Accounts;
                    RunObject = Report "Process Marks";
                    ApplicationArea = All;
                }
                // action(Timetable)
                // {
                //     Caption = 'Timetable';
                //     Image = Template;
                //     
                //     RunObject = Page "ACA-Timetable Header";
                // }
                // action("Validate Units")
                // {
                //     Caption = 'Validate Units';
                //     RunObject = Report Report65819;
                // }
                action(Examiners)
                {
                    Caption = 'Examiners';
                    Image = HRSetup;
                    ApplicationArea = All;
                    RunObject = Page "ACA-Examiners List";
                }
                action("Tag As Graduated")
                {
                    ApplicationArea = All;
                    Image = NumberGroup;
                    RunObject = Report "Update Status Graduated";
                }
            }
            group("Time Table")
            {
                Caption = 'Time Tabling';
                Image = Statistics;
                action(ClassTimetables)
                {
                    Caption = 'Class Timetable Batches';
                    Image = Timesheet;
                    ApplicationArea = All;
                    RunObject = Page "TT-Timetable Batches";
                }
                action(ExamTimetables)
                {
                    Caption = 'Exam Timetable Batches';
                    Image = Timeline;
                    ApplicationArea = All;
                    RunObject = Page "EXT-Timetable Batches";
                }

                group(Setups1)
                {
                    Caption = 'Exam Setups';
                    Image = Setup;
                    action("Lecturers Units")
                    {
                        Caption = 'Lecturers Units';
                        Image = VendorLedger;

                        RunObject = Page "ACA-Lecturers Units";
                        ApplicationArea = All;
                    }
                    action("Programme List")
                    {
                        Caption = 'Programme List';
                        Image = FixedAssets;
                        RunObject = Page "ACA-Programmes List";
                        ApplicationArea = All;
                    }
                    action("Grading Sources")
                    {
                        Image = SetupLines;
                        RunObject = Page "ACA-Exam Grading Sources";
                        ApplicationArea = All;
                    }
                    action(Action1000000075)
                    {
                        Caption = 'Grading System';
                        Image = Setup;
                        ApplicationArea = All;
                        RunObject = Page "ACA-Grading Sys. Header";
                    }
                    action(Action1000000074)
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
                    action("Rubrics (General)")
                    {
                        Caption = 'Rubrics (General)';
                        Image = Status;
                        RunObject = Page "ACA-Senate Report Lubrics";
                        ApplicationArea = All;
                    }
                    action("Rubrics (Med/Nursing)")
                    {
                        Caption = 'Rubrics (Med/Nursing)';
                        Image = StopPayment;
                        RunObject = Page "ACA-BMED Senate Rubrics";
                        ApplicationArea = All;
                    }
                    action("Classification Rubrics")
                    {
                        Caption = 'Classification Rubrics';
                        Image = AddWatch;

                        RunObject = Page "ACA-Class/Grad. Lubrics";
                        ApplicationArea = All;
                    }
                    action("Supplementary Rubrics")
                    {
                        Caption = 'Supplementary Rubrics';
                        Image = StepInto;
                        RunObject = Page "ACA-Supp. Lubrics List";
                        ApplicationArea = All;
                    }
                }
            }
        }
        area(sections)
        {
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

                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
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
                action("Page FLT Transport Requisition2")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action(Travel_Notices2)
                {
                    Caption = 'Travel Notice';
                    Image = Register;
                    RunObject = Page "FLT-Safari Notices List";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    RunObject = Page "CAT-Meal Booking List";
                }
                action("File Requisitions")
                {
                    Image = Register;
                    ApplicationArea = All;
                    RunObject = Page "REG-File Requisition List";
                }
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }
            }
            group("Student Management Setups")
            {
                Caption = 'Academic Setups';
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
            }
        }
    }
}

profile "Examination Two"
{
    ProfileDescription = 'Examination2';
    RoleCenter = "ACA-Exam Man. Role Centre2";
    Caption = 'Examination Profile2';
}