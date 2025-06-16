/// <summary>
/// Page DVC-Academics Role Center (ID 52100).
/// </summary>
page 52122 "DVC-Academics Role Center"
{
    Caption = 'Deputy Vice Chancellor Academics';
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
                part("Academic Overview"; "ACA-Std Card List")
                {
                    ApplicationArea = All;
                    Caption = 'Student Overview';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Academic Governance")
            {
                Caption = 'Academic Governance';
                Image = ExecuteBatch;
                
                action("Academic Senate")
                {
                    Caption = 'Academic Senate';
                    Image = Committee;
                    RunObject = Report "ACA-Senate Report";
                    ApplicationArea = All;
                }
                action("Schools and Faculties")
                {
                    Caption = 'Schools/Faculties';
                    Image = Departments;
                    RunObject = Page "ACA-Schools/Faculties";
                    ApplicationArea = All;
                }
                action("Academic Year Setup")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;
                    RunObject = Page "ACA-Academic Year List";
                    ApplicationArea = All;
                }
                action("Academic Calendar")
                {
                    Caption = 'Academic Calendar';
                    Image = Period;
                    RunObject = Page "ACA-Semesters List";
                    ApplicationArea = All;
                }
                action("General Academic Setup")
                {
                    Caption = 'General Academic Setup';
                    Image = SetupLines;
                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = All;
                }
            }
            group("Programme Management")
            {
                Caption = 'Programme Management';
                Image = FixedAssets;
                
                action("All Programmes")
                {
                    Caption = 'Academic Programmes';
                    Image = List;
                    RunObject = Page "ACA-Programmes List";
                    ApplicationArea = All;
                }
                action("Program Units")
                {
                    Caption = 'Program Units';
                    Image = ItemGroup;
                    RunObject = Page "ACA-Units Master";
                    ApplicationArea = All;
                }
                action("Program Intake Setup")
                {
                    Caption = 'Program Intake Setup';
                    Image = Setup;
                    RunObject = Page "ACA-Intake List";
                    ApplicationArea = All;
                }
                action("Program Schedule")
                {
                    Caption = 'Program/Stage Schedule';
                    Image = Planning;
                    RunObject = Page "ACA-Prog/Stage Sem. Schedule";
                    ApplicationArea = All;
                }
            }
            group("Faculty Management")
            {
                Caption = 'Faculty Management';
                Image = HumanResources;
                
                action("Academic Staff List")
                {
                    Caption = 'Academic Staff';
                    Image = Employee;
                    RunObject = Page "ACA-Lecturer List";
                    ApplicationArea = All;
                }
                action("Lecturer Halls")
                {
                    Caption = 'Lecture Halls';
                    Image = FixedAssets;
                    RunObject = Page "ACA-LectureHalls Setup";
                    ApplicationArea = All;
                }
                action("Part Timer Rates")
                {
                    Caption = 'Part Timer Rates';
                    Image = Resource;
                    RunObject = Page "Part timer Rates";
                    ApplicationArea = All;
                }
                action("Lecturer Loading")
                {
                    Caption = 'Lecturer Loading';
                    Image = Allocations;
                    RunObject = Page "Lect Load Batch List";
                    ApplicationArea = All;
                }
            }
            group("Examinations & Results")
            {
                Caption = 'Examinations & Results';
                Image = TestReport;
                
                action("Examination Management")
                {
                    Caption = 'Examination Management';
                    Image = TestReport;
                    RunObject = Page "Examination Role Center";
                    ApplicationArea = All;
                }
                action("Exam Setup")
                {
                    Caption = 'Exam Setup';
                    Image = SetupColumns;
                    RunObject = Page "ACA-Exams Setup Headers";
                    ApplicationArea = All;
                }
                action("Grading System")
                {
                    Caption = 'Grading System';
                    Image = Setup;
                    RunObject = Page "ACA-Grading Sys. Header";
                    ApplicationArea = All;
                }
                action("Senate Rubrics")
                {
                    Caption = 'Senate Rubrics';
                    Image = ViewComments;
                    RunObject = Page "ACA-Senate Report Lubrics";
                    ApplicationArea = All;
                }
            }
            group("Quality Assurance")
            {
                Caption = 'Quality Assurance';
                Image = QualificationOverview;
                
                action("DAQA Management")
                {
                    Caption = 'Quality Assurance';
                    Image = QualificationOverview;
                    RunObject = Page "DAQA Role Center";
                    ApplicationArea = All;
                }
                action("Lecturer Evaluation")
                {
                    Caption = 'Lecturer Evaluation';
                    Image = Questionnaire;
                    RunObject = Page "ACA-Evaluation Semesters List";
                    ApplicationArea = All;
                }
                action("Evaluation Results")
                {
                    Caption = 'Evaluation Results';
                    Image = Statistics;
                    RunObject = Page "Evaluation Results";
                    ApplicationArea = All;
                }
                action("Quality Setup")
                {
                    Caption = 'Quality Setup';
                    Image = Setup;
                    RunObject = Page "Quality Assurance Setup";
                    ApplicationArea = All;
                }
            }
            group("Research & Innovation")
            {
                Caption = 'Research & Innovation';
                Image = Innovation;
                
                action("Research Management")
                {
                    Caption = 'Research & Extensions';
                    Image = Job;
                    RunObject = Page "Rsearch and Extensions";
                    ApplicationArea = All;
                }
                action("Postgraduate Management")
                {
                    Caption = 'Postgraduate Management';
                    Image = Certificate;
                    RunObject = Page "Post Graduate Management";
                    ApplicationArea = All;
                }
                action("Research Projects")
                {
                    Caption = 'Research Projects';
                    Image = ProjectManagement;
                    RunObject = Page "Research Project List";
                    ApplicationArea = All;
                }
            }
            group("Student Affairs")
            {
                Caption = 'Student Affairs';
                Image = CustomerGroup;
                
                action("Student Affairs Center")
                {
                    Caption = 'Student Affairs';
                    Image = CustomerGroup;
                    RunObject = Page "Student Affairs Role Center";
                    ApplicationArea = All;
                }
                action("Student Registration")
                {
                    Caption = 'Student Registration';
                    Image = Register;
                    RunObject = Page "ACA-Std Registration List";
                    ApplicationArea = All;
                }
                action("Student Cards")
                {
                    Caption = 'Student Cards';
                    Image = Registered;
                    RunObject = Page "ACA-Std Card List";
                    ApplicationArea = All;
                }
                action("Student Clearance")
                {
                    Caption = 'Student Clearance';
                    Image = Intrastat;
                    RunObject = Page "ACA-Student Clearance (Open)";
                    ApplicationArea = All;
                }
                action("Alumni Management")
                {
                    Caption = 'Alumni';
                    Image = History;
                    RunObject = Page "ACA-Student Aluminae List";
                    ApplicationArea = All;
                }
            }
            group("Timetabling")
            {
                Caption = 'Timetabling';
                Image = Calendar;
                
                action("Timetable Management")
                {
                    Caption = 'Timetable Management';
                    Image = Calendar;
                    RunObject = Page "Timetable Role Center";
                    ApplicationArea = All;
                }
                action("Teaching Timetable")
                {
                    Caption = 'Teaching Timetable';
                    Image = CalendarMachine;
                    RunObject = Page "Timetable Header List";
                    RunPageView = where("Type" = const(Class));
                    ApplicationArea = All;
                }
                action("Exam Timetable")
                {
                    Caption = 'Exam Timetable';
                    Image = TestReport;
                    RunObject = Page "Timetable Header List";
                    RunPageView = where("Type" = const(Exam));
                    ApplicationArea = All;
                }
                action("Time Slots Setup")
                {
                    Caption = 'Time Slots';
                    Image = Setup;
                    RunObject = Page "Time Slots";
                    ApplicationArea = All;
                }
            }
        }
        area(embedding)
        {
            action("Programme List")
            {
                Caption = 'Academic Programmes';
                Image = FixedAssets;
                RunObject = Page "ACA-Programmes List";
                ApplicationArea = All;
            }
            action("Lecturer List")
            {
                Caption = 'Academic Staff';
                Image = Employee;
                RunObject = Page "ACA-Lecturer List";
                ApplicationArea = All;
            }
            action("Students")
            {
                Caption = 'Students';
                Image = Customer;
                RunObject = Page "ACA-Std Card List";
                ApplicationArea = All;
            }
            action("Schools and Faculties Management")
            {
                Caption = 'Schools/Faculties';
                Image = Departments;
                RunObject = Page "ACA-Schools/Faculties";
                ApplicationArea = All;
            }
            action("Academic Year List")
            {
                Caption = 'Academic Year';
                Image = Calendar;
                RunObject = Page "ACA-Academic Year List";
                ApplicationArea = All;
            }
            action("Semesters")
            {
                Caption = 'Semesters';
                Image = Period;
                RunObject = Page "ACA-Semesters List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Strategic Oversight")
            {
                Caption = 'Strategic Oversight';
                Image = ExecuteBatch;
                
                action("Academic Dashboard")
                {
                    Caption = 'Academic Dashboard';
                    RunObject = Page "Management Role Center";
                    ApplicationArea = All;
                }
                action("Senate Meetings")
                {
                    Caption = 'Senate Report';
                    RunObject = Report "ACA-Senate Report";
                    ApplicationArea = All;
                }
                action("Academic Policies")
                {
                    Caption = 'Academic Policies';
                    RunObject = Page "ACA-General Set-Up";
                    ApplicationArea = All;
                }
            }
            group("Admissions Oversight")
            {
                Caption = 'Admissions Oversight';
                Image = RegisteredDocs;
                
                action("Admission Applications")
                {
                    Caption = 'Applications';
                    RunObject = Page "ACA-Application Form Header a";
                    ApplicationArea = All;
                }
                action("Approved Applications")
                {
                    Caption = 'Approved Applications';
                    RunObject = Page "ACA-Approved Applications List";
                    ApplicationArea = All;
                }
                action("Admitted Students")
                {
                    Caption = 'Admitted Students';
                    RunObject = Page "ACA-Admitted Applicants List";
                    ApplicationArea = All;
                }
                action("KUCCPS Admissions")
                {
                    Caption = 'KUCCPS Admissions';
                    RunObject = Page "KUCCPS Imports";
                    ApplicationArea = All;
                }
            }
            group("Academic Performance")
            {
                Caption = 'Academic Performance';
                Image = Statistics;
                
                action("Enrollment Statistics")
                {
                    Caption = 'Enrollment Statistics';
                    RunObject = Report "Students Enrolment";
                    ApplicationArea = All;
                }
                action("Program Performance")
                {
                    Caption = 'Program Performance';
                    RunObject = Report "Population By Programme";
                    ApplicationArea = All;
                }
                action("Faculty Performance")
                {
                    Caption = 'Faculty Performance';
                    RunObject = Report "Population By Faculty";
                    ApplicationArea = All;
                }
                action("Graduation Statistics")
                {
                    Caption = 'Graduation Statistics';
                    RunObject = Report "Senate Summary of Graduation";
                    ApplicationArea = All;
                }
            }
            group("Financial Performance")
            {
                Caption = 'Financial Performance';
                Image = Statistics;
                
                action("Student Revenue")
                {
                    Caption = 'Student Revenue';
                    RunObject = Report "Students Revenue Summary";
                    ApplicationArea = All;
                }
                action("Fee Structure")
                {
                    Caption = 'Fee Structure';
                    RunObject = Report "Fee Structure Summary Report";
                    ApplicationArea = All;
                }
                action("Program Revenue")
                {
                    Caption = 'Program Revenue';
                    RunObject = Report "Summary Enrollment - Programme";
                    ApplicationArea = All;
                }
            }
            group("Quality & Compliance")
            {
                Caption = 'Quality & Compliance';
                Image = QualificationOverview;
                
                action("CUE Reporting")
                {
                    Caption = 'CUE Report';
                    RunObject = Report "CUE Report";
                    ApplicationArea = All;
                }
                action("KNBS Enrollment")
                {
                    Caption = 'KNBS Enrollment';
                    RunObject = Report "KNBS Enrollment Data";
                    ApplicationArea = All;
                }
                action("Quality Reviews")
                {
                    Caption = 'Quality Reviews';
                    RunObject = Page "Evaluation Results";
                    ApplicationArea = All;
                }
            }
            group("Approvals")
            {
                Caption = 'Approvals';
                Image = Alerts;
                
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("My Approval Requests")
                {
                    Caption = 'My Approval Requests';
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
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                
                action("Store Requisitions")
                {
                    Caption = 'Store Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                    ApplicationArea = All;
                }
                action("Purchase Requisitions")
                {
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ApplicationArea = All;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                    ApplicationArea = All;
                }
                action("Transport Requisitions")
                {
                    Caption = 'Transport Requisitions';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
                }
            }
        }
        area(reporting)
        {
            group("Executive Reports")
            {
                Caption = 'Executive Reports';
                Image = Report;
                
                action("Senate Summary Report")
                {
                    Caption = 'Senate Summary Report';
                    Image = Report;
                    RunObject = Report "ACA-Senate Report";
                    ApplicationArea = All;
                }
                action("Academic Performance Summary")
                {
                    Caption = 'Academic Performance';
                    Image = Report;
                    RunObject = Report "Students Enrolment";
                    ApplicationArea = All;
                }
                action("Financial Performance Report")
                {
                    Caption = 'Financial Performance';
                    Image = Report;
                    RunObject = Report "Students Revenue Summary";
                    ApplicationArea = All;
                }
                action("Faculty Workload Report")
                {
                    Caption = 'Faculty Workload';
                    Image = Report;
                    RunObject = Report "Lecturer Course Loading";
                    ApplicationArea = All;
                }
            }
            group("Compliance Reports")
            {
                Caption = 'Compliance Reports';
                Image = FileContract;
                
                action("CUE Compliance Report")
                {
                    Caption = 'CUE Compliance';
                    Image = Report;
                    RunObject = Report "CUE Report";
                    ApplicationArea = All;
                }
                action("KNBS Enrollment Report")
                {
                    Caption = 'KNBS Enrollment';
                    Image = Report;
                    RunObject = Report "KNBS Enrollment Data";
                    ApplicationArea = All;
                }
                action("Quality Assurance Report")
                {
                    Caption = 'Quality Assurance';
                    Image = Report;
                    RunObject = Report "ACA-Lecturer Evaluation Summar";
                    ApplicationArea = All;
                }
            }
            group("Academic Analytics")
            {
                Caption = 'Academic Analytics';
                Image = Statistics;
                
                action("Enrollment Trends")
                {
                    Caption = 'Enrollment Trends';
                    Image = Report;
                    RunObject = Report "Enrollment by Stage";
                    ApplicationArea = All;
                }
                action("Program Analytics")
                {
                    Caption = 'Program Analytics';
                    Image = Report;
                    RunObject = Report "Population By Prog. Category";
                    ApplicationArea = All;
                }
                action("Graduate Outcomes")
                {
                    Caption = 'Graduate Outcomes';
                    Image = Report;
                    RunObject = Report "Senate Summary of Graduation";
                    ApplicationArea = All;
                }
                action("Research Output")
                {
                    Caption = 'Research Output';
                    Image = Report;
                    RunObject = Report "Research Publications";
                    ApplicationArea = All;
                }
            }
            group("Strategic Reports")
            {
                Caption = 'Strategic Reports';
                Image = Planning;
                
                action("Population by Faculty Report")
                {
                    Caption = 'Population by Faculty';
                    Image = Report;
                    RunObject = Report "Population By Faculty";
                    ApplicationArea = All;
                }
                action("Population by Programme Report")
                {
                    Caption = 'Population by Programme';
                    Image = Report;
                    RunObject = Report "Population By Programme";
                    ApplicationArea = All;
                }
                action("Classification by Campus")
                {
                    Caption = 'Classification by Campus';
                    Image = Report;
                    RunObject = Report "Population Class By Campus";
                    ApplicationArea = All;
                }
                action("Fee Structure Report")
                {
                    Caption = 'Fee Structure Report';
                    Image = Report;
                    RunObject = Report "Fee Structure Summary Report";
                    ApplicationArea = All;
                }
            }
        }
    }
}