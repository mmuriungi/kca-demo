report 50521 "Exam Timetable Report"
{
    ApplicationArea = All;
    Caption = 'Exam Timetable Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ExamTimetableReportNew.rdlc';
    dataset
    {
        dataitem(ExamTimetableEntry; "Exam Timetable Entry")
        {
            column(AdditionalInvigilators; "Additional Invigilators")
            {
            }
            column(ChiefInvigilator; "Chief Invigilator")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(EndTime; "End Time")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(ExamDate; "Exam Date")
            {
            }
            column(ExamGroup; "Exam Group")
            {
            }
            column(ExamType; "Exam Type")
            {
            }
            column(LastModifiedBy; "Last Modified By")
            {
            }
            column(LastModifiedDate; "Last Modified Date")
            {
            }
            column(LectureHall; "Lecture Hall")
            {
            }
            column(NoofStudents; "No. of Students")
            {
            }
            column(ProgrammeCode; "Programme Code")
            {
            }
            column(RoomCapacity; "Room Capacity")
            {
            }
            column(Semester; Semester)
            {
            }
            column(StageCode; "Stage Code")
            {
            }
            column(StartTime; "Start Time")
            {
            }
            column(Status; Status)
            {
            }
            column(StudentCount; "Student Count")
            {
            }
            column(TimeSlot; format("Session Type"))
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(Day;'')
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
}
