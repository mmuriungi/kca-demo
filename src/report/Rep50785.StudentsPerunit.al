report 50785 "Students Per unit"
{
    ApplicationArea = All;
    Caption = 'Students Per unit';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StudentsPerUnit.rdlc';
    dataset
    {
        dataitem(ACAStudentUnits; "ACA-Student Units")
        {
            RequestFilterFields="Academic Year",Semester,Unit,"Student No.";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompPic; CompanyInformation.Picture)
            {
            }
            column(AcademicYear; "Academic Year")
            {
            }
            column(AcademicYearFlow; "Academic Year (Flow)")
            {
            }
            column(ActualFees; "Actual Fees")
            {
            }
            column(AllowSupplementary; "Allow Supplementary")
            {
            }
            column(AssTotalMarks; "Ass Total Marks")
            {
            }
            column(AttachmentUnit; "Attachment Unit")
            {
            }
            column(Attendance; Attendance)
            {
            }
            column(Audit; Audit)
            {
            }
            column(BalanceDue; "Balance Due")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(CATTotalMarks; "CAT Total Marks")
            {
            }
            column(CAT1; "CAT-1")
            {
            }
            column(CAT2; "CAT-2")
            {
            }
            column(CATsMarks; "CATs Marks")
            {
            }
            column(CATsMarksExists; "CATs Marks Exists")
            {
            }
            column(CFScore; "CF Score")
            {
            }
            column(CampusCode; "Campus Code")
            {
            }
            column(CancelledScore; "Cancelled Score")
            {
            }
            column(CategoryCode; "Category Code")
            {
            }
            column(ConsolidatedMarkIdentifier; "Consolidated Mark Identifier")
            {
            }
            column(ConsolidatedMarkPref; "Consolidated Mark Pref.")
            {
            }
            column(CourseEvaluated; "Course Evaluated")
            {
            }
            column(CourseRegistrationCancelled; "Course Registration Cancelled")
            {
            }
            column(CourseType; "Course Type")
            {
            }
            column(CoursesEvaluated; "Courses Evaluated")
            {
            }
            column(Createdby; "Created by")
            {
            }
            column(CreditHours; "Credit Hours")
            {
            }
            column(CreditedHours; "Credited Hours")
            {
            }
            column(CustExist; "Cust Exist")
            {
            }
            column(DateEdited; "Date Edited")
            {
            }
            column(Datecreated; "Date created")
            {
            }
            column(DefenceOutCome; "Defence OutCome")
            {
            }
            column(Defense; Defense)
            {
            }
            column(Description; Description)
            {
            }
            column(DetailsCount; "Details Count")
            {
            }
            column(ENo; ENo)
            {
            }
            column(EXAMsMarks; "EXAMs Marks")
            {
            }
            column(EXAMsMarksExists; "EXAMs Marks Exists")
            {
            }
            column(EditedBy; "Edited By")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(Evaluated; Evaluated)
            {
            }
            column(EvaluatedDate; "Evaluated Date")
            {
            }
            column(Evaluatedsemester; "Evaluated semester")
            {
            }
            column(ExamCategory; "Exam Category")
            {
            }
            column(ExamMarks; "Exam Marks")
            {
            }
            column(ExamPeriod; "Exam Period")
            {
            }
            column(ExamStatus; "Exam Status")
            {
            }
            column(Examiner1; Examiner1)
            {
            }
            column(Examiner2; Examiner2)
            {
            }
            column(Examiner3; Examiner3)
            {
            }
            column(Examiner4; Examiner4)
            {
            }
            column(Examiners; Examiners)
            {
            }
            column(Exempted; Exempted)
            {
            }
            column(ExemptedinEvaluation; "Exempted in Evaluation")
            {
            }
            column(ExistsFinalStage; "Exists Final Stage")
            {
            }
            column(Failed; Failed)
            {
            }
            column(FailedUnitsCount; "Failed Units Count")
            {
            }
            column(FinalScore; "Final Score")
            {
            }
            column(FinalStage; "Final Stage")
            {
            }
            column(FinalAcademicYear; "Final. Academic Year")
            {
            }
            column(FinalConsMarkIdentifier; "Final. Cons. Mark Identifier")
            {
            }
            column(FinalConsMarkPref; "Final. Cons. Mark Pref.")
            {
            }
            column(FinalExamMarks; "Final. Exam Marks")
            {
            }
            column(FinalExamPeriod; "Final. Exam Period")
            {
            }
            column(FinalFinalScore; "Final. Final Score")
            {
            }
            column(FinalGrade; "Final. Grade")
            {
            }
            column(FinalTotalMarks; "Final. Total Marks")
            {
            }
            column(FinalTotalScore; "Final. Total Score")
            {
            }
            column(FinalWeightedUnits; "Final. Weighted Units")
            {
            }
            column(Grade; Grade)
            {
            }
            column(GradeFlow; "Grade Flow")
            {
            }
            column(HasSupplementary; "Has Supplementary")
            {
            }
            column(IgnoreinCummAverage; "Ignore in Cumm  Average")
            {
            }
            column(IgnoreinFinalAverage; "Ignore in Final Average")
            {
            }
            column(IncludeinGraduation; "Include in Graduation")
            {
            }
            column(IntakeCode; "Intake Code")
            {
            }
            column(Lecturer; Lecturer)
            {
            }
            column(MainProgramme; "Main Programme")
            {
            }
            column(MarksExists; "Marks Exists")
            {
            }
            column(MarksStatus; "Marks Status")
            {
            }
            column(ModeOfStudy; ModeOfStudy)
            {
            }
            column(Multiple; Multiple)
            {
            }
            column(NoofSupplementaries; "No of Supplementaries")
            {
            }
            column(NoOfUnits; "No. Of Units")
            {
            }
            column(Occurances; Occurances)
            {
            }
            column(OldUnit; "Old Unit")
            {
            }
            column(OldUnitLk; "Old Unit Lk")
            {
            }
            column(PassExists; "Pass Exists")
            {
            }
            column(Passed; Passed)
            {
            }
            column(PassedUnit; "Passed Unit")
            {
            }
            column(ProcessedMarks; "Processed Marks")
            {
            }
            column(ProgCategory; "Prog. Category")
            {
            }
            column(ProgramOptionFlow; "Program Option (Flow)")
            {
            }
            column(Programme; Programme)
            {
            }
            column(ProgressDate; "Progress Date")
            {
            }
            column(ProgressReport; "Progress Report")
            {
            }
            column(ProjectStatus; "Project Status")
            {
            }
            column(ProposalDate; "Proposal Date")
            {
            }
            column(ProposalStatus; "Proposal Status")
            {
            }
            column(ReTake; "Re-Take")
            {
            }
            column(ReasonforSpecialExamSusp; "Reason for Special Exam/Susp.")
            {
            }
            column(RegOption; "Reg Option")
            {
            }
            column(Reg_Reversed; "Reg Reversed")
            {
            }
            column(RegResultsStatus; "Reg. Results Status")
            {
            }
            column(RegReversed; "Reg. Reversed")
            {
            }
            column(RegTransactonID; "Reg. Transacton ID")
            {
            }
            column(Registerfor; "Register for")
            {
            }
            column(Registered; Registered)
            {
            }
            column(RegisteredPrograme; "Registered Programe")
            {
            }
            column(RegistrationStatus; "Registration Status")
            {
            }
            column(ReleasedResults; "Released Results")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(RepeatMarks; "Repeat Marks")
            {
            }
            column(RepeatUnit; "Repeat Unit")
            {
            }
            column(Research; Research)
            {
            }
            column(ResultStatus; "Result Status")
            {
            }
            column(ResultsCancelled; "Results Cancelled")
            {
            }
            column(ResultsExistsStatus; "Results Exists Status")
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(SatSupplementary; "Sat Supplementary")
            {
            }
            column(SchoolCode; "School Code")
            {
            }
            column(Semester; Semester)
            {
            }
            column(SemesterRegistered; "Semester Registered")
            {
            }
            column(SenateProposal; "Senate-Proposal")
            {
            }
            column(SenateResearch; "Senate-Research")
            {
            }
            column(SessionCode; "Session Code")
            {
            }
            column(SettlementType; "Settlement Type")
            {
            }
            column(Show; Show)
            {
            }
            column(SpecialExam; "Special Exam")
            {
            }
            column(SpecialProgrammeClass; "Special Programme Class")
            {
            }
            column(Stage; Stage)
            {
            }
            column(Status; Status)
            {
            }
            column(Stream; Stream)
            {
            }
            column(StudentClass; "Student Class")
            {
            }
            column(StudentCode; "Student Code")
            {
            }
            column(StudentName; "Student Name")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(StudentType; "Student Type")
            {
            }
            column(Supervisor; Supervisor)
            {
            }
            column(SuppTaken; "Supp Taken")
            {
            }
            column(SuppAcademicYear; "Supp. Academic Year")
            {
            }
            column(SuppConsMarkIdentifier; "Supp. Cons. Mark Identifier")
            {
            }
            column(SuppConsMarkPref; "Supp. Cons. Mark Pref.")
            {
            }
            column(SuppExamMarks; "Supp. Exam Marks")
            {
            }
            column(SuppExamPeriod; "Supp. Exam Period")
            {
            }
            column(SuppExamScore; "Supp. Exam Score")
            {
            }
            column(SuppFailed; "Supp. Failed")
            {
            }
            column(SuppFinalScore; "Supp. Final Score")
            {
            }
            column(SuppGrade; "Supp. Grade")
            {
            }
            column(SuppRegisteredPassed; "Supp. Registered & Passed")
            {
            }
            column(SuppTotalMarks; "Supp. Total Marks")
            {
            }
            column(SuppTotalScore; "Supp. Total Score")
            {
            }
            column(SuppWeightedUnits; "Supp. Weighted Units")
            {
            }
            column(SystemCreated; "System Created")
            {
            }
            column(SystemTaken; "System Taken")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(Taken; Taken)
            {
            }
            column(TotalMarks; "Total Marks")
            {
            }
            column(TotalScore; "Total Score")
            {
            }
            column(Unit; Unit)
            {
            }
            column(UnitDescription; "Unit Description")
            {
            }
            column(UnitFees; "Unit Fees")
            {
            }
            column(UnitName; "Unit Name")
            {
            }
            column(UnitPoints; "Unit Points")
            {
            }
            column(UnitRegCount; "Unit Reg Count")
            {
            }
            column(UnitStage; "Unit Stage")
            {
            }
            column(UnitType; "Unit Type")
            {
            }
            column(UnitTypeFlow; "Unit Type (Flow)")
            {
            }
            column(UnitYearofStudy; "Unit Year of Study")
            {
            }
            column(UnitnotinCatalogue; "Unit not in Catalogue")
            {
            }
            column(UnitCount; UnitCount)
            {
            }
            column(Units; Units)
            {
            }
            column(UnitsRegStatus; "Units Reg. Status")
            {
            }
            column(WeightedUnits; "Weighted Units")
            {
            }
            column(YearOfStudy; "Year Of Study")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        ClassAtt: Record "Class Attendance Details";
        GenSetup: Record "ACA-General Set-Up";
        MinPerce: Decimal;
        CurrPerce: Decimal;
        TotalClasses: Integer;
        AttendedClasses: Integer;
        CompanyInformation: Record "Company Information";
}
