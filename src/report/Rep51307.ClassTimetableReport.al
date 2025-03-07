report 51307 "Class Timetable Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ClassTimetableLayout;

    dataset
    {
        dataitem(TimeTableEntry; "Timetable Entry")
        {
            DataItemTableView = SORTING("Day of Week", "Time Slot Code") WHERE(Type = CONST(Class));
            column(CompanyName; CompInfo.Name)
            { }
            column(CompanyPhone; CompInfo."Phone No.")
            { }
            column(Logo; CompInfo.Picture)
            { }
            column(Monday_AcademicYear; "Academic Year") { }
            column(Monday_Semester; Semester) { }
            column(Monday_TimeSlotCode; "Time Slot Code") { }
            column(Monday_LectureHallCode; "Lecture Hall Code") { }
            column(Monday_UnitCode; "Unit Code") { }
            column(Monday_LecturerCode; "Lecturer Code") { }
            column(Monday_ProgrammeCode; "Programme Code") { }
            column(Monday_StageCode; "Stage Code") { }
            column(Monday_StartTime; "Start Time") { }
            column(Monday_EndTime; "End Time") { }
            column(DayofWeek_TimeTableEntry; "Day of Week")
            {
            }
            column(DurationHours_TimeTableEntry; "Duration (Hours)")
            {
            }
            column(TimeSlotLabel; TimeSlotLabel)
            {

            }
            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                LectureHall.Reset();
                LectureHall.SetRange("Lecture Room Code", "Lecture Hall Code");
                if LectureHall.FindFirst() then
                    VenueName := LectureHall."Lecture Room Name"
                else
                    VenueName := "Lecture Hall Code";

                TimeSlot.Reset();
                TimeSlot.SetRange(Code, "Time Slot Code");
                if TimeSlot.FindFirst() then begin
                    TimeSlotLabel := Format(TimeSlot."Start Time", 0, '<Hours24,2>:<Minutes,2>') + '-' +
                                    Format(TimeSlot."End Time", 0, '<Hours24,2>:<Minutes,2>');
                end else
                    TimeSlotLabel := "Time Slot Code";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {

                }
            }
        }

        trigger OnOpenPage()
        var
            AcademicYear: Record "ACA-Academic Year";
        begin
        end;
    }

    rendering
    {
        layout(ClassTimetableLayout)
        {
            Type = RDLC;
            LayoutFile = './Layouts/ClassTimetableReport.rdlc';
        }
    }

    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Time Slot";
        VenueName: Text[100];
        TimeSlotLabel: Text[30];
        CompInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);
    end;
}
