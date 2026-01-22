report 50527 "Exam Papers Submission"
{
    Caption = 'Exam Papers Submission';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ExamPapersSubmission.rdl';
    dataset
    {
        dataitem(UnitExamPaperSubmission; "Unit Exam Paper Submission")
        {
            CalcFields = "Attachment Exists";
            DataItemTableView = where("Attachment Exists" = const(true));
            column(Pic; CompInfo.Picture)
            {
            }
            column(CompMail; CompInfo."E-Mail" + '/' + CompInfo."Home Page")
            {
            }
            column(CompAddress; CompInfo.Address + ',' + CompInfo."Address 2" + ' ' + CompInfo.City)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(AcademicHours; "Academic Hours")
            {
            }
            column(Allocation; Allocation)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Attachment; Attachment)
            {
            }
            column(AttachmentExists; "Attachment Exists")
            {
            }
            column(Audit; Audit)
            {
            }
            column(Code; "Code")
            {
            }
            column(CombinationCount; "Combination Count")
            {
            }
            column(CommonUnit; "Common Unit")
            {
            }
            column(CoordinatorName; "Coordinator Name")
            {
            }
            column(CoordinatorNo; "Coordinator No.")
            {
            }
            column(CorectedUnitCode; "Corected Unit Code")
            {
            }
            column(CreditHours; "Credit Hours")
            {
            }
            column(DateLastModified; "Date Last Modified")
            {
            }
            column(DayFilter; "Day Filter")
            {
            }
            column(DefaultExamCategory; "Default Exam Category")
            {
            }
            column(Department; Department)
            {
            }
            column(Desription; Desription)
            {
            }
            column(DetailsCount; "Details Count")
            {
            }
            column(EntryNo; "Entry No")
            {
            }
            column(EstimateReg; "Estimate Reg")
            {
            }
            column(ExamCategory; "Exam Category")
            {
            }
            column(ExamFilter; "Exam Filter")
            {
            }
            column(ExamNotAllocated; "Exam Not Allocated")
            {
            }
            column(ExamRemarks; "Exam Remarks")
            {
            }
            column(ExamSlotsVarience; "Exam Slots Varience")
            {
            }
            column(ExamStatus; "Exam Status")
            {
            }
            column(ExamsDone; "Exams Done")
            {
            }
            column(FailedTotalScore; "Failed Total Score")
            {
            }
            column(GLAccount; "G/L Account")
            {
            }
            column(IgnoreinFinalAverage; "Ignore in Final Average")
            {
            }
            column(IssuedCopies; "Issued Copies")
            {
            }
            column(KeyCourse; "Key Course")
            {
            }
            column(LabSlots; "Lab Slots")
            {
            }
            column(LastModifiedby; "Last Modified by")
            {
            }
            column(LectureRoomFilter; "Lecture Room Filter")
            {
            }
            column(LecturerCode; "Lecturer Code")
            {
            }
            column(LecturerLkup; "Lecturer Lkup")
            {
            }
            column(LecturerRoom; "Lecturer Room")
            {
            }
            column(LecturerUnitSet; LecturerUnitSet)
            {
            }
            column(LessonFilter; "Lesson Filter")
            {
            }
            column(MedicalUnit; "Medical Unit")
            {
            }
            column(NewUnit; "New Unit")
            {
            }
            column(NoUnits; "No. Units")
            {
            }
            column(NormalSlots; "Normal Slots")
            {
            }
            column(NotAllocated; "Not Allocated")
            {
            }
            column(OldUnit; "Old Unit")
            {
            }
            column(Prerequisite; Prerequisite)
            {
            }
            column(PrintedCopies; "Printed Copies")
            {
            }
            column(ProgrammeCode; "Programme Code")
            {
            }
            column(ProgrammeCodelkup; "Programme Code lkup")
            {
            }
            column(ProgrammeName; "Programme Name")
            {
            }
            column(ProgrammeOption; "Programme Option")
            {
            }
            column(Project; Project)
            {
            }
            column(ReSit; "Re-Sit")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(RepeatitionCount; "Repeatition Count")
            {
            }
            column(Research; Research)
            {
            }
            column(ReservedRoom; "Reserved Room")
            {
            }
            column(ReturnedCopies; "Returned Copies")
            {
            }
            column(SchoolCode; "School Code")
            {
            }
            column(ScoreBuffer; "Score Buffer")
            {
            }
            column(Semester; Semester)
            {
            }
            column(Show; Show)
            {
            }
            column(SlotsVarience; "Slots Varience")
            {
            }
            column(SpecialProgrammeClass; "Special Programme Class")
            {
            }
            column(StageCode; "Stage Code")
            {
            }
            column(StudentType; "Student Type")
            {
            }
            column(StudentsRegistered; "Students Registered")
            {
            }
            column(SubmissionDate; "Submission Date")
            {
            }
            column(SubmissionTime; "Submission Time")
            {
            }
            column(Submited; Submited)
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
            column(Tested; Tested)
            {
            }
            column(TimeLastModified; "Time Last Modified")
            {
            }
            column(TimeTable; "Time Table")
            {
            }
            column(TimeTableCode; "Time Table Code")
            {
            }
            column(TimeTabledCount; "Time Tabled Count")
            {
            }
            column(TimeTabledUsedCount; "Time Tabled Used Count")
            {
            }
            column(TimetablePriority; "Timetable Priority")
            {
            }
            column(TotalCreditHours; "Total Credit Hours")
            {
            }
            column(TotalIncome; "Total Income")
            {
            }
            column(TotalScore; "Total Score")
            {
            }
            column(UnitClassSize; "Unit Class Size")
            {
            }
            column(UnitRegistered; "Unit Registered")
            {
            }
            column(UnitType; "Unit Type")
            {
            }
            column(UsedCount; "Used Count")
            {
            }
            column(YearofStudy; "Year of Study")
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

    var
        CompInfo: Record "Company Information";
}
