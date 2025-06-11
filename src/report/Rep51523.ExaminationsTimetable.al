report 51523 "Examinations Timetable"
{
    ApplicationArea = All;
    Caption = 'Examinations Timetable';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ExaminationsTimetable.rdlc';

    dataset
    {
        dataitem(ExamTimetableEntry; "Exam Timetable Entry")
        {
            DataItemTableView = sorting("Exam Date", "Session Type", "Time Slot", "Programme Code", "Stage Code");
            RequestFilterFields = Semester, "Exam Type", "Programme Code", "Stage Code", "Exam Date";

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
            column(ExamPeriod; ExamPeriod)
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
            column(ExamDate; Format("Exam Date", 0, '<Weekday Text>, <Day,2> <Month Text> <Year4>'))
            {
            }
            column(ExamDateShort; Format("Exam Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DayOfWeek; Format("Exam Date", 0, '<Weekday Text>'))
            {
            }
            column(TimeSlot; "Time Slot")
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
            column(LectureHall; "Lecture Hall")
            {
            }
            column(RoomCapacity; "Room Capacity")
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
            column(StudentCount; "Student Count")
            {
            }
            column(NoofStudents; "No. of Students")
            {
            }
            column(ExamType; Format("Exam Type"))
            {
            }
            column(Status; Format(Status))
            {
            }
            column(SessionType; GetSessionType())
            {
            }
            column(ChiefInvigilator; "Chief Invigilator")
            {
            }
            column(ChiefInvigilatorName; ChiefInvigilatorName)
            {
            }
            column(AdditionalInvigilators; "Additional Invigilators")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(ExamGroup; "Exam Group")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }

            // Matrix format columns for different time sessions
            column(MorningExams; GetSessionExams(ExamTimetableEntry."Session Type"::Morning))
            {
            }
            column(MiddayExams; GetSessionExams(ExamTimetableEntry."Session Type"::Midday))
            {
            }
            column(AfternoonExams; GetSessionExams(ExamTimetableEntry."Session Type"::Afternoon))
            {
            }
            column(DayOfWeekText; Format(ExamTimetableEntry."Exam Date", 0, '<Weekday Text>'))
            {
            }
            column(DateFormatted; Format(ExamTimetableEntry."Exam Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }

            dataitem(ExamInvigilators; "Exam Invigilators")
            {
                DataItemLink = Semester = field(Semester),
                              Date = field("Exam Date"),
                              Unit = field("Unit Code"),
                              Hall = field("Lecture Hall");
                DataItemTableView = sorting(Semester, Date, Unit, Hall, "No.");

                column(InvigilatorNo; "No.")
                {
                }
                column(InvigilatorName; Name)
                {
                }
                column(InvigilatorCategory; Format(Category))
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                GetUnitDetails();
                GetProgrammeDetails();
                GetStageDetails();
                GetChiefInvigilatorName();
            end;

            trigger OnPreDataItem()
            begin
                SetFilters();
                GetReportHeaders();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(GroupByDate; GroupByDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Date';
                        ToolTip = 'Group exams by date in the report';
                    }
                    field(ShowInvigilators; ShowInvigilators)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Invigilators';
                        ToolTip = 'Show invigilator details in the report';
                    }
                    field(ShowVenueCapacity; ShowVenueCapacity)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Venue Capacity';
                        ToolTip = 'Show venue capacity information';
                    }
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
        CompanyInfo: Record "Company Information";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAProgramme: Record "ACA-Programme";
        ACAProgrammeStages: Record "ACA-Programme Stages";
        HRMEmployee: Record "HRM-Employee C";
        Semester: Record "ACA-Semesters";
        ReportTitle: Text[100];
        AcademicYear: Text[50];
        SemesterName: Text[50];
        ExamPeriod: Text[100];
        ProgrammeFilter: Text[250];
        StageFilter: Text[250];
        UnitDescription: Text[100];
        ProgrammeName: Text[100];
        StageName: Text[100];
        ChiefInvigilatorName: Text[100];
        GroupByDate: Boolean;
        ShowInvigilators: Boolean;
        ShowVenueCapacity: Boolean;

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        GroupByDate := true;
        ShowInvigilators := true;
        ShowVenueCapacity := true;
    end;

    local procedure SetFilters()
    begin
        if ExamTimetableEntry.GetFilter("Programme Code") <> '' then
            ProgrammeFilter := 'Programme: ' + ExamTimetableEntry.GetFilter("Programme Code")
        else
            ProgrammeFilter := 'All Programmes';

        if ExamTimetableEntry.GetFilter("Stage Code") <> '' then
            StageFilter := 'Stage: ' + ExamTimetableEntry.GetFilter("Stage Code")
        else
            StageFilter := 'All Stages';
    end;

    local procedure GetReportHeaders()
    begin
        if ExamTimetableEntry.FindFirst() then begin
            if Semester.Get(ExamTimetableEntry.Semester) then begin
                AcademicYear := Semester."Academic Year";
                SemesterName := Semester.Description;

                case ExamTimetableEntry."Exam Type" of
                    ExamTimetableEntry."Exam Type"::Regular:
                        begin
                            ReportTitle := 'FINAL EXAMINATIONS TIMETABLE';
                            ExamPeriod := Format(Semester."Exam Start Date", 0, '<Day,2> <Month Text> <Year4>') +
                                         ' - ' +
                                         Format(Semester."Exam End Date", 0, '<Day,2> <Month Text> <Year4>');
                        end;
                    ExamTimetableEntry."Exam Type"::Supplementary:
                        begin
                            ReportTitle := 'SUPPLEMENTARY EXAMINATIONS TIMETABLE';
                            ExamPeriod := Format(Semester."Supp Start Date", 0, '<Day,2> <Month Text> <Year4>') +
                                         ' - ' +
                                         Format(Semester."Supp End Date", 0, '<Day,2> <Month Text> <Year4>');
                        end;
                    ExamTimetableEntry."Exam Type"::Special:
                        begin
                            ReportTitle := 'SPECIAL EXAMINATIONS TIMETABLE';
                            ExamPeriod := 'Special Examination Period';
                        end;
                end;
            end;
        end;
    end;

    local procedure GetUnitDetails()
    begin
        Clear(UnitDescription);
        if ACAUnitsSubjects.Get(ExamTimetableEntry."Programme Code",
                               ExamTimetableEntry."Stage Code",
                               ExamTimetableEntry."Unit Code") then
            UnitDescription := ACAUnitsSubjects.Desription
        else
            if ACAUnitsSubjects.Get('', '', ExamTimetableEntry."Unit Code") then
                UnitDescription := ACAUnitsSubjects.Desription;
    end;

    local procedure GetProgrammeDetails()
    begin
        Clear(ProgrammeName);
        if ACAProgramme.Get(ExamTimetableEntry."Programme Code") then
            ProgrammeName := ACAProgramme.Description;
    end;

    local procedure GetStageDetails()
    begin
        Clear(StageName);
        if ACAProgrammeStages.Get(ExamTimetableEntry."Programme Code",
                                  ExamTimetableEntry."Stage Code") then
            StageName := ACAProgrammeStages.Description;
    end;

    local procedure GetChiefInvigilatorName()
    begin
        Clear(ChiefInvigilatorName);
        if HRMEmployee.Get(ExamTimetableEntry."Chief Invigilator") then
            ChiefInvigilatorName := HRMEmployee."First Name" + ' ' +
                                   HRMEmployee."Middle Name" + ' ' +
                                   HRMEmployee."Last Name";
    end;

    local procedure GetDuration(): Text[20]
    var
        StartTime: Time;
        EndTime: Time;
        Duration: Duration;
        Hours: Integer;
        Minutes: Integer;
    begin
        StartTime := ExamTimetableEntry."Start Time";
        EndTime := ExamTimetableEntry."End Time";

        if (StartTime = 0T) or (EndTime = 0T) then
            exit('');

        Duration := EndTime - StartTime;
        Hours := Duration div 3600000; // Convert milliseconds to hours
        Minutes := (Duration mod 3600000) div 60000; // Get remaining minutes

        if Minutes > 0 then
            exit(Format(Hours) + 'h ' + Format(Minutes) + 'm')
        else
            exit(Format(Hours) + ' Hours');
    end;

    local procedure GetSessionType(): Text[20]
    begin
        case ExamTimetableEntry."Session Type" of
            ExamTimetableEntry."Session Type"::Morning:
                exit('Morning');
            ExamTimetableEntry."Session Type"::Midday:
                exit('Midday');
            ExamTimetableEntry."Session Type"::Afternoon:
                exit('Afternoon');
            else
                exit('');
        end;
    end;

    local procedure GetSessionExams(SessionType: Option Morning,Midday,Afternoon): Text
    var
        TempExamEntry: Record "Exam Timetable Entry";
        ExamInfo: Text;
        UnitInfo: Text;
        VenueInfo: Text;
        StudentInfo: Text;
        TempUnitDescription: Text;
        LineBreak: Text;
        ExamBlock: Text;
        THelper: Codeunit "Type Helper";
    begin
        LineBreak := THelper.CRLFSeparator(); // Line break for RDLC

        // Get all exams for this date and session type
        TempExamEntry.Reset();
        TempExamEntry.SetRange("Exam Date", ExamTimetableEntry."Exam Date");
        TempExamEntry.SetRange("Session Type", SessionType);
        TempExamEntry.SetRange(Semester, ExamTimetableEntry.Semester);
        TempExamEntry.SetRange("Exam Type", ExamTimetableEntry."Exam Type");

        // Apply same filters as main dataitem
        if ExamTimetableEntry.GetFilter("Programme Code") <> '' then
            TempExamEntry.SetFilter("Programme Code", ExamTimetableEntry.GetFilter("Programme Code"));
        if ExamTimetableEntry.GetFilter("Stage Code") <> '' then
            TempExamEntry.SetFilter("Stage Code", ExamTimetableEntry.GetFilter("Stage Code"));

        if TempExamEntry.FindSet() then begin
            repeat
                // Get unit description
                Clear(TempUnitDescription);
                if ACAUnitsSubjects.Get(TempExamEntry."Programme Code",
                                       TempExamEntry."Stage Code",
                                       TempExamEntry."Unit Code") then
                    TempUnitDescription := ACAUnitsSubjects.Desription
                else
                    if ACAUnitsSubjects.Get('', '', TempExamEntry."Unit Code") then
                        TempUnitDescription := ACAUnitsSubjects.Desription;

                // Format unit info like the sample: UCC 200: Financial Literacy (A102/A105/N104)
                UnitInfo := TempExamEntry."Unit Code";
                if TempUnitDescription <> '' then
                    UnitInfo += ': ' + TempUnitDescription;

                // Add programme/stage info in brackets
                if (TempExamEntry."Programme Code" <> '') or (TempExamEntry."Stage Code" <> '') then
                    UnitInfo += ' (' + TempExamEntry."Programme Code" + '/' + TempExamEntry."Stage Code" + ')';

                // Student count info
                if TempExamEntry."Student Count" > 0 then
                    StudentInfo := Format(TempExamEntry."Student Count")
                else if TempExamEntry."No. of Students" > 0 then
                    StudentInfo := Format(TempExamEntry."No. of Students")
                else
                    StudentInfo := '0';

                // Venue info
                VenueInfo := TempExamEntry."Lecture Hall";

                // Format like sample: Course Code & Title, No. of Students, Venue on separate lines
                ExamBlock := UnitInfo + LineBreak;
                if StudentInfo <> '' then
                    ExamBlock += 'No. of Students: ' + StudentInfo + LineBreak;
                if VenueInfo <> '' then
                    ExamBlock += 'Venue: ' + VenueInfo + LineBreak;

                // Add to main info with separator
                if ExamInfo <> '' then
                    ExamInfo += LineBreak + '---' + LineBreak;

                ExamInfo += ExamBlock;

            until TempExamEntry.Next() = 0;
        end;

        exit(ExamInfo);
    end;
}