/// <summary>
/// Page ACA-Exam Man. Role Centre (ID 52043).
/// </summary>
page 51978 "ACA-Exam Man. Role Centre2"
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
                part(Control1904484608; "ACA-Programmes Part")
                {
                    Caption = 'Programmes List';
                }
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
            }
            action("<Page ACA-Std Card List>")
            {
                Caption = 'Students Card';
                Image = Registered;

                RunObject = Page "ACA-Std Card List";
            }
            action("Programmes List")
            {
                Caption = 'Programmes List';
                Image = FixedAssets;
                RunObject = Page "ACA-Programmes List";
            }
            action("Grading System")
            {
                Caption = 'Grading System';
                Image = SetupColumns;
                Applicationarea = All;
                RunObject = Page "ACA-Grading Sys. Header";
            }
            action("Results Status List")
            {
                Caption = 'Results Status List';
                Image = Status;
                Applicationarea = All;
                RunObject = Page "ACA-Senate Report Lubrics";
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
                }
                action("Process Marks")
                {
                    Caption = 'Process Marks';
                    Image = AdjustEntries;

                    RunObject = Page "Process Exams Central Gen.";
                }
                action("Process Graduation")
                {
                    Caption = 'Process Graduation';
                    Image = AddAction;

                    RunObject = Page "Process Exams Central";
                }
                action("Senate Preview")
                {
                    Caption = 'Senate Preview';
                    Image = PreviewChecks;

                    RunObject = Page "ACA-Exam. Senate Review";
                }
                action("Graduation Review")
                {
                    Caption = 'Graduation Review';
                    Image = AddToHome;

                    RunObject = Page "Graduation Overview";
                }
                action("Student List")
                {
                    Caption = 'Student List';
                    Image = CalculateConsumption;

                    RunObject = Page "Deans Student List";
                }
                action("Examination Module Guide")
                {
                    Caption = 'Examination Module Guide';
                    Image = GLRegisters;

                    RunObject = Report "Examination Module Guide";
                }
                action("Import Results")
                {
                    Caption = 'Import Results';
                    Image = UserSetup;

                    RunObject = Page "ACA-Exam Results Buffer 2";
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
                    Applicationarea = All;
                    RunObject = Report "ACA-Consolidated Marksheet 1";
                }
                action("Consolidated Marksheet")
                {
                    Caption = 'Consolidated Marksheet';
                    Image = Completed;
                    Applicationarea = All;
                    RunObject = Report "Supp. Final Cons. Marksheet";
                    Visible = false;
                }
                action("Consolidated Marksheet 2")
                {
                    Caption = 'Consolidated Marksheet 2';
                    Image = CompleteLine;
                    Applicationarea = All;
                    RunObject = Report "Final Consolidated Marksheet";
                    Visible = false;
                }
                action("Consolidated Marksheet 3")
                {
                    Caption = 'Consolidated Marksheet 3';
                    RunObject = Report "Consolidated Marksheet 2";
                    Visible = false;
                }
                action("Senate Report")
                {
                    Caption = 'Senate Report';
                    Image = Agreement;
                    Applicationarea = All;
                    RunObject = Report "ACA-Senate Report";
                }
                action("Senate Summary Report 1")
                {
                    Caption = 'Senate Summary Report 1';
                    Image = Reconcile;

                    RunObject = Report "Results Category Summary";
                    Visible = false;
                }
                action("Senate Summary Report 2")
                {
                    Caption = 'Senate Summary Report 2';
                    Image = Reconcile;

                    RunObject = Report "Results Category Summary 2";
                    Visible = false;
                }
                action(Attendance_Checklist)
                {
                    Caption = 'Attendance Checklist';
                    RunObject = Report "Exam Attendance Checklist2";
                }
                // action("Class Grade Sheet")
                // {
                //     Caption = 'Class Grade Sheet';
                //     Image = CheckDuplicates;
                //     Applicationarea=All;
                //     RunObject = Report "ACA-Class Roster Grade Sheet";
                //     Visible = false;
                // }
                action("Consolidated Gradesheet")
                {
                    Caption = 'Consolidated Gradesheet';
                    Image = CheckDuplicates;
                    Applicationarea = All;
                    RunObject = Report "ACA-Consolidated Gradesheet";
                    Visible = false;
                }
                action("Provisional Transcript")
                {
                    Caption = 'Provisional Transcript';
                    Image = FixedAssets;
                    Applicationarea = All;
                    RunObject = Report "Provisional College Transcrip3";
                }
                // action("Provisional Transcript 2")
                // {
                //     Caption = 'Provisional Transcript 2';
                //     Image = FixedAssets;
                //     Applicationarea=All;
                //     RunObject = Report Report77713;
                //     Visible = false;
                // }
                action("Official Transcript")
                {
                    Caption = 'Official Transcript';
                    Image = Split;
                    Applicationarea = All;
                    RunObject = Report "Official College Transcrip2";
                }
                action("Marks Entry Statistics")
                {
                    Caption = 'Marks Entry Statistics';
                    Image = AddAction;
                    RunObject = Report "Lecturer Exam Entry Statistics";
                }
                action("Check Exam Results")
                {
                    Caption = 'Check Exam Results';
                    Image = Design;

                    RunObject = Report "Check Marks";
                }
                action("Student Progress Report")
                {
                    Caption = 'Student Progress Report';
                    Image = Agreement;
                    RunObject = Report "Student Progress Report";
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
                    Applicationarea = All;
                    RunObject = Report "Final Deans Classification 2";
                }
                action("Graduation List")
                {
                    Caption = 'Graduation List';
                    Image = CompleteLine;

                    RunObject = Report "Final Deans Graduation List 2";
                }
                action("Final Consolidated Marksheet")
                {
                    Caption = 'Final Consolidated Marksheet';
                    Image = CompleteLine;
                    Applicationarea = All;
                    RunObject = Report "ACA-Consolidated Marksheet 1";
                }
                // action("Classification Marksheet")
                // {
                //     Caption = 'Classification Marksheet';
                //     Image = Aging;
                //     Applicationarea=All;
                //     PromotedIsBig = false;
                //     RunObject = Report Report78015;
                //     Visible = false;
                // }
                action("Incomplete List")
                {
                    Caption = 'Incomplete List';
                    Image = ContactFilter;
                    Applicationarea = All;
                    RunObject = Report "Deans Incomplete List";
                }
                action("Incomplete List (Detailed)")
                {
                    Caption = 'Incomplete List (Detailed)';
                    Image = Continue;
                    Applicationarea = All;
                    RunObject = Report "Reasons for Incomplete";
                }
                action("Failed Units List")
                {
                    Caption = 'Failed Units List';
                    Image = ContractPayment;
                    Applicationarea = All;
                    RunObject = Report "Cummulative Failed Units";
                }
                action("Graduation Progress Report")
                {
                    Caption = 'Graduation Progress Report';
                    Image = CreateJobSalesCreditMemo;

                    RunObject = Report "Graduation Progress Report";
                }
                action(SenateReport)
                {
                    Caption = 'Senate Report';
                    Image = Agreement;
                    Applicationarea = All;
                    RunObject = Report "Exams Final Pass List C 5";
                }
                action("Cummulative Resit List")
                {
                    Image = BulletList;
                    Applicationarea = All;
                    RunObject = Report "Exams Final Cummulative Resit";
                }
                action("Cummulative Halt List")
                {
                    Caption = 'Cummulative Halt List';
                    Image = CalcWorkCenterCalendar;
                    Applicationarea = All;
                    RunObject = Report "ACA-Cummulative Halt List";
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
                    Applicationarea = All;
                    RunObject = Page "ACA-Exam Results Raw Buffer";
                }
                action("Exam Results Buffer")
                {
                    Caption = 'Exam Results Buffer';
                    Image = UserSetup;
                    RunObject = Page "ACA-Exam Results Buffer 2";
                }
                action(Action5)
                {
                    Caption = 'Students List';
                    Image = UserSetup;
                    RunObject = Page "ACA-Examination Stds List";
                }
                // action("Export Template")
                // {
                //     Caption = 'Export Template';
                //     Image = Export;
                //     Applicationarea=All;
                //     Applicationarea=All;
                //     RunObject = XMLport XMLport39005508;
                // }
                // action(Import_Exam_Results)
                // {
                //     Caption = 'Import Exam Results';
                //     Image = ImportCodes;
                //     Applicationarea=All;
                //     Applicationarea=All;
                //     RunObject = XMLport XMLport39005507;
                // }
                // action("Validate Exam Marks")
                // {
                //     Caption = 'Validate Exam Marks';
                //     Image = ValidateEmailLoggingSetup;
                //     Applicationarea=All;
                //     Applicationarea=All;
                //     RunObject = Report Report65819;
                // }
                action("Check Marks")
                {
                    Caption = 'Check Marks';
                    Image = CheckList;
                    Applicationarea = All;
                    RunObject = Report "Check Marks";
                }
                action(Action1000000024)
                {
                    Caption = 'Process Marks';
                    Image = Accounts;
                    RunObject = Report "Process Marks";
                }
                // action(Timetable)
                // {
                //     Caption = 'Timetable';
                //     Image = Template;
                //     Applicationarea=All;
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
                    Applicationarea = All;
                    RunObject = Page "ACA-Examiners List";
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
                    Applicationarea = All;

                    RunObject = Page "TT-Timetable Batches";
                }
                action(ExamTimetables)
                {
                    Caption = 'Exam Timetable Batches';
                    Image = Timeline;
                    Applicationarea = All;

                    RunObject = Page "EXT-Timetable Batches";
                }
                // action("Automatic Timetable")
                // {
                //     Caption = 'Automatic Timetable';
                //     Image = ListPage;
                //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //     //
                //     RunObject = Page "ACA-Auto_Time Table";
                // }
                // action("Manual Timetable")
                // {
                //     Caption = 'Manual Timetable';
                //     Image = ListPage;
                //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //     //
                //     RunObject = Page "ACA-Manual Time Table";
                // }
                // action("Semi Auto Time Table")
                // {
                //     Caption = 'Semi Auto Time Table';
                //     Image = ListPage;
                //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //     //
                //     RunObject = Page "ACA-Time Table Header";
                // }
            }
            // group("Time Table Reports")
            // {
            //     Caption = 'Time Table Reports';
            //     Image = Statistics;
            //     action(Master)
            //     {
            //         Caption = 'Master';
            //         Image = Report2;
            //         //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //         //
            //         RunObject = Report "Time Table";
            //     }
            //     // action(Individual)
            //     // {
            //     //     Caption = 'Individual';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Individual Time Table-General";
            //     // }
            //     action(TT)
            //     {
            //         Caption = 'TT';
            //         Image = Addresses;
            //         RunObject = Report "Time table2";
            //     }
            //     // action(Stage)
            //     // {
            //     //     Caption = 'Stage';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Time Table - By Stage";
            //     // }
            //     // action("Lecturer Room")
            //     // {
            //     //     Caption = 'Lecturer Room';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Time Table - By Lecturer Room";
            //     // }
            //     // action(Lecturer)
            //     // {
            //     //     Caption = 'Lecturer';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Time Table - By Lecturer";
            //     // }
            //     // action(Exam)
            //     // {
            //     //     Caption = 'Exam';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Time Table - By Exam";
            //     // }
            //     // action(Course)
            //     // {
            //     //     Caption = 'Course';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Time Table - By Courses";
            //     // }
            //     // action("Course 2")
            //     // {
            //     //     Caption = 'Course 2';
            //     //     Image = Report2;
            //     //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //     //
            //     //     RunObject = Report "Time Table - By Courses 2";
            //     // }

            // }
            group(Setups1)
            {
                Caption = 'Exam Setups';
                Image = Setup;
                action("Lecturers Units")
                {
                    Caption = 'Lecturers Units';
                    Image = VendorLedger;
                    Applicationarea = All;
                    RunObject = Page "ACA-Lecturers Units";
                }
                action("Programme List")
                {
                    Caption = 'Programme List';
                    Image = FixedAssets;
                    RunObject = Page "ACA-Programmes List";
                }
                // action("Exam Setups")
                // {
                //     Caption = 'Exam Setups';
                //     Image = SetupLines;
                //     Applicationarea=All;
                //     RunObject = Page "ACA-Exam Setups";
                // }
                action(Action1000000075)
                {
                    Caption = 'Grading System';
                    Image = Setup;
                    Applicationarea = All;

                    RunObject = Page "ACA-Grading Sys. Header";
                }
                action(Action1000000074)
                {
                    Caption = 'Lecturers Units';
                    Image = VendorLedger;
                    Applicationarea = All;
                    RunObject = Page "ACA-Lecturers Units";
                }
                action("General Setup")
                {
                    Caption = 'General Setup';
                    Image = GeneralPostingSetup;
                    Applicationarea = All;
                    RunObject = Page "ACA-General Set-Up";
                }
                action("Academic Year")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;
                    Applicationarea = All;
                    RunObject = Page "ACA-Academic Year Card";
                }
                action("Rubrics (General)")
                {
                    Caption = 'Rubrics (General)';
                    Image = Status;
                    RunObject = Page "ACA-Senate Report Lubrics";
                }
                action("Rubrics (Med/Nursing)")
                {
                    Caption = 'Rubrics (Med/Nursing)';
                    Image = StopPayment;
                    RunObject = Page "ACA-BMED Senate Rubrics";
                }
                action("Classification Rubrics")
                {
                    Caption = 'Classification Rubrics';
                    Image = AddWatch;

                    RunObject = Page "ACA-Class/Grad. Lubrics";
                }
                action("Supplementary Rubrics")
                {
                    Caption = 'Supplementary Rubrics';
                    Image = StepInto;
                    RunObject = Page "ACA-Supp. Lubrics List";
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
                    Applicationarea = All;
                    RunObject = Page "Lect Load Batch List";
                }
                action(LoadApp)
                {
                    Caption = 'Loading Approvals';
                    Image = Registered;
                    Applicationarea = All;
                    RunObject = Page "Lect Load Approvals";
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
                    Applicationarea = All;
                    RunObject = Page "Lecturer Load Pending Dept. Ap";
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
                    Applicationarea = All;
                    RunObject = Page "Lect Load Central Setup";
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
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page "ACA-Clearance Approval Entries";
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
                }
                // action("Imprest Requisitions")
                // {
                //     Caption = 'Imprest Requisitions';
                //     RunObject = Page "FIN-Imprest List UP";
                // }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                }
            }
            group("Student Management Setups")
            {
                Caption = 'Academic Setups';
                action("program List")
                {
                    Caption = 'program List';
                    Image = FixedAssets;
                    Applicationarea = All;

                    RunObject = Page "ACA-Programmes List";
                }
                action("Semester Setup")
                {
                    Caption = 'Semester Setup';
                    Image = FixedAssetLedger;
                    Applicationarea = All;
                    RunObject = Page "ACA-Semesters List";
                }
                action("Academic Year Manager")
                {
                    Caption = 'Academic Year Manager';
                    Image = Calendar;
                    Applicationarea = All;
                    RunObject = Page "ACA-Academic Year List";
                }
            }
        }
    }
}

profile "Examination2"
{
    ProfileDescription = 'Examination2';
    RoleCenter = "ACA-Exam Man. Role Centre2";
    Caption = 'Examination Profile2';
}

