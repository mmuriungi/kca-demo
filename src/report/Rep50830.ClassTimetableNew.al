report 50830 "Class Timetable New"
{
    ApplicationArea = All;
    Caption = 'Class Timetable';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClassTimetableNew.rdl';

    dataset
    {
        dataitem(TimetableEntry; "Timetable Entry")
        {
            DataItemTableView = sorting("Lecture Hall Code", "Day of Week", "Start Time");
            RequestFilterFields = "Academic Year", Semester, "Programme Code", "Stage Code", "Lecture Hall Code", "Unit Code";

            // Header columns
            column(ReportTitle; ReportTitle)
            {
            }
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(AcademicYear; AcademicYear)
            {
            }
            column(SemesterName; SemesterName)
            {
            }
            column(TimetablePeriod; TimetablePeriod)
            {
            }
            column(ProgrammeFilter; ProgrammeFilter)
            {
            }
            column(StageFilter; StageFilter)
            {
            }
            column(PrintedBy; 'Printed By: ' + UserId)
            {
            }
            column(PrintedDate; 'Date: ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(PrintedTime; 'Time: ' + Format(Time, 0, '<Hours24>:<Minutes,2>'))
            {
            }

            // Detail columns
            column(Date; Date)
            {
            }
            column(ClassDate; Format(Date, 0, '<Weekday Text>, <Day,2> <Month Text> <Year4>'))
            {
            }
            column(ClassDateShort; Format(Date, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DayOfWeek; GetDayOfWeekText())
            {
            }
            column(DayOrder; GetDayOrder())
            {
            }
            column(TimeSlotCode; "Time Slot Code")
            {
            }
            column(StartTime; Format("Start Time", 0, '<Hours24,2>:<Minutes,2>'))
            {
            }
            column(EndTime; Format("End Time", 0, '<Hours24,2>:<Minutes,2>'))
            {
            }
            column(Duration; GetDuration())
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(UnitDescription; UnitDescription)
            {
            }
            column(LectureHallCode; "Lecture Hall Code")
            {
            }
            column(LectureHallName; LectureHallName)
            {
            }
            column(HallCapacity; HallCapacity)
            {
            }
            column(ProgrammeCode; "Programme Code")
            {
            }
            column(ProgrammeName; ProgrammeName)
            {
            }
            column(StageCode; "Stage Code")
            {
            }
            column(StageName; StageName)
            {
            }
            column(LecturerCode; "Lecturer Code")
            {
            }
            column(LecturerName; LecturerName)
            {
            }
            column(ClassType; Format(Type))
            {
            }
            column(SessionType; GetSessionTypeText())
            {
            }
            column(StudentCount; StudentCount)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }

            // Matrix columns - Day and Time combination
            column(DayTimeSlot; GetDayTimeSlot())
            {
            }
            column(ClassDetails; GetClassDetails())
            {
            }
            column(TimeSlotHeader; GetTimeSlotHeader())
            {
            }


            trigger OnAfterGetRecord()
            begin
                // Get related information
                GetUnitDescription();
                GetProgrammeDetails();
                GetStageDetails();
                GetLectureHallDetails();
                GetLecturerDetails();
                CalculateStudentCount();
            end;

            trigger OnPreDataItem()
            begin
                // Initialize report variables
                SetReportFilters();
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
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
                    Caption = 'Options';

                    field(ReportFormat; ReportFormat)
                    {
                        ApplicationArea = All;
                        Caption = 'Report Format';
                        ToolTip = 'Select the format for the timetable report';
                    }

                    field(ShowWeekView; ShowWeekView)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Week View';
                        ToolTip = 'Display timetable in weekly format';
                    }

                    field(ShowTimeSlotView; ShowTimeSlotView)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Time Slot View';
                        ToolTip = 'Group classes by time slots';
                    }

                    field(IncludeLecturerInfo; IncludeLecturerInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Lecturer Information';
                        ToolTip = 'Show lecturer details in the report';
                    }

                    field(IncludeStudentCount; IncludeStudentCount)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Student Count';
                        ToolTip = 'Show student count for each class';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ReportFormat := ReportFormat::Detailed;
            ShowWeekView := true;
            IncludeLecturerInfo := true;
            IncludeStudentCount := true;
        end;
    }

    var
        CompanyInfo: Record "Company Information";
        AcademicYearRec: Record "ACA-Academic Year";
        ProgrammeRec: Record "ACA-Programme";
        StageRec: Record "ACA-Programme Stages";
        UnitRec: Record "ACA-Units/Subjects";
        LectureHallRec: Record "ACA-Lecturer Halls Setup";
        LecturerRec: Record "HRM-Employee C";

        ReportTitle: Text[100];
        AcademicYear: Text[50];
        SemesterName: Text[50];
        TimetablePeriod: Text[100];
        ProgrammeFilter: Text[250];
        StageFilter: Text[250];
        UnitDescription: Text[200];
        ProgrammeName: Text[200];
        StageName: Text[200];
        LectureHallName: Text[200];
        LecturerName: Text[200];
        HallCapacity: Integer;
        StudentCount: Integer;

        ReportFormat: Option Detailed,Summary,Matrix;
        ShowWeekView: Boolean;
        ShowTimeSlotView: Boolean;
        IncludeLecturerInfo: Boolean;
        IncludeStudentCount: Boolean;

    local procedure SetReportFilters()
    var
        Semester: Record "ACA-Semesters";
    begin
        ReportTitle := 'CLASS TIMETABLE';

        // Set Academic Year
        if TimetableEntry.GetFilter("Academic Year") <> '' then
            AcademicYear := TimetableEntry.GetFilter("Academic Year")
        else begin
            Semester.Reset();
            Semester.SetRange(Code, TimetableEntry.Semester);
            if Semester.FindFirst() then
                AcademicYear := Semester."Academic Year";
        end;

        // Set Semester
        if TimetableEntry.GetFilter(Semester) <> '' then
            SemesterName := TimetableEntry.GetFilter(Semester)
        else
            SemesterName := 'All Semesters';

        // Set Programme Filter
        if TimetableEntry.GetFilter("Programme Code") <> '' then
            ProgrammeFilter := 'Programme: ' + TimetableEntry.GetFilter("Programme Code")
        else
            ProgrammeFilter := 'All Programmes';

        // Set Stage Filter
        if TimetableEntry.GetFilter("Stage Code") <> '' then
            StageFilter := 'Stage: ' + TimetableEntry.GetFilter("Stage Code")
        else
            StageFilter := 'All Stages';

        TimetablePeriod := AcademicYear + ' - ' + SemesterName;
    end;

    local procedure GetUnitDescription()
    begin
        UnitDescription := '';
        if UnitRec.Get(TimetableEntry."Unit Code", TimetableEntry."Programme Code") then
            UnitDescription := UnitRec.Desription;
    end;

    local procedure GetProgrammeDetails()
    begin
        ProgrammeName := '';
        if ProgrammeRec.Get(TimetableEntry."Programme Code") then
            ProgrammeName := ProgrammeRec.Description;
    end;

    local procedure GetStageDetails()
    begin
        StageName := '';
        if StageRec.Get(TimetableEntry."Programme Code", TimetableEntry."Stage Code") then
            StageName := StageRec.Description;
    end;

    local procedure GetLectureHallDetails()
    begin
        LectureHallName := '';
        HallCapacity := 0;
        if LectureHallRec.Get(TimetableEntry."Lecture Hall Code", '', '') then begin
            LectureHallName := LectureHallRec."Lecture Room Name";
            HallCapacity := LectureHallRec."Sitting Capacity";
        end;
    end;

    local procedure GetLecturerDetails()
    begin
        LecturerName := '';
        LecturerRec.Reset();
        LecturerRec.SetRange("No.",TimetableEntry."Lecturer Code");
        if LecturerRec.FindFirst() then
            LecturerName := LecturerRec."First Name"+' '+LecturerRec."Middle Name"+' '+LecturerRec."Last Name";;
    end;

    local procedure CalculateStudentCount()
    var
        StudentUnit: Record "ACA-Student Units";
    begin
        StudentCount := 0;
        StudentUnit.Reset();
        StudentUnit.SetRange(Unit, TimetableEntry."Unit Code");
        StudentUnit.SetRange(Programme, TimetableEntry."Programme Code");
        StudentUnit.SetRange(Stage, TimetableEntry."Stage Code");
        StudentUnit.SetRange(Semester, TimetableEntry.Semester);
        StudentCount := StudentUnit.Count();
    end;

    local procedure GetDuration(): Text[20]
    begin
        if (TimetableEntry."Start Time" <> 0T) and (TimetableEntry."End Time" <> 0T) then
            exit(Format(TimetableEntry."End Time" - TimetableEntry."Start Time"))
        else
            exit('');
    end;

    local procedure GetDayOfWeekText(): Text[20]
    begin
        case TimetableEntry."Day of Week" of
            TimetableEntry."Day of Week"::Monday:
                exit('Monday');
            TimetableEntry."Day of Week"::Tuesday:
                exit('Tuesday');
            TimetableEntry."Day of Week"::Wednesday:
                exit('Wednesday');
            TimetableEntry."Day of Week"::Thursday:
                exit('Thursday');
            TimetableEntry."Day of Week"::Friday:
                exit('Friday');
            TimetableEntry."Day of Week"::Saturday:
                exit('Saturday');
            TimetableEntry."Day of Week"::Sunday:
                exit('Sunday');
            else
                exit('');
        end;
    end;

    local procedure GetDayOrder(): Integer
    begin
        case TimetableEntry."Day of Week" of
            TimetableEntry."Day of Week"::Monday:
                exit(1);
            TimetableEntry."Day of Week"::Tuesday:
                exit(2);
            TimetableEntry."Day of Week"::Wednesday:
                exit(3);
            TimetableEntry."Day of Week"::Thursday:
                exit(4);
            TimetableEntry."Day of Week"::Friday:
                exit(5);
            TimetableEntry."Day of Week"::Saturday:
                exit(6);
            TimetableEntry."Day of Week"::Sunday:
                exit(7);
            else
                exit(0);
        end;
    end;

    local procedure GetSessionTypeText(): Text[20]
    begin
        case TimetableEntry."Session Type" of
            TimetableEntry."Session Type"::Regular:
                exit('Regular');
            TimetableEntry."Session Type"::Theory:
                exit('Theory');
            TimetableEntry."Session Type"::Practical:
                exit('Practical');
            TimetableEntry."Session Type"::Online:
                exit('Online');
            else
                exit('');
        end;
    end;

    local procedure GetDayTimeSlot(): Text[50]
    begin
        exit(GetDayOfWeekText() + ' ' + Format(TimetableEntry."Start Time", 0, '<Hours24,2>:<Minutes,2>') + '-' +
             Format(TimetableEntry."End Time", 0, '<Hours24,2>:<Minutes,2>'));
    end;

    local procedure GetClassDetails(): Text[500]
    var
        ClassText: Text[2048];
        lec: Text[500];
        lbr: Text;
        Thelper: Codeunit "Type Helper";
    begin
        lbr:=Thelper.CRLFSeparator();
        ClassText := TimetableEntry."Unit Code";
        if TimetableEntry."Group No" <> '' then
            ClassText += ' ' + '(' + TimetableEntry."Group No" + ') ';
        if TimetableEntry."Programme Code" <> '' then
            ClassText += ' (' + TimetableEntry."Programme Code" + ')';
        if LecturerName <> '' then
            ClassText += lbr + LecturerName;

            ClassText+=lbr+Format(TimetableEntry."Duration (Hours)") +' hrs.';
        exit(ClassText);
    end;

    local procedure GetTimeSlotHeader(): Text[50]
    begin
        exit(Format(TimetableEntry."Start Time", 0, '<Hours24,2>:<Minutes,2>') + '-' +
             Format(TimetableEntry."End Time", 0, '<Hours24,2>:<Minutes,2>'));
    end;

}