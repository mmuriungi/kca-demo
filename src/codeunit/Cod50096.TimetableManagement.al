codeunit 50096 "Timetable Management"
{

    trigger OnRun()
    begin
        GenerateTimetable('2024', 'S1');
    end;

    procedure GenerateExamTimeSlots(TTHeader: Record "Timetable Header")
    var
        Semester: Record "ACA-Semesters";
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
        Window: Dialog;
        SlotGroup: Option Regular,Medical;
        SemesterCode: Code[25];
    begin
        // Validate semester
        SemesterCode := TTHeader.Semester;
        FindSemester(SemesterCode, Semester);
        TTHeader.TestField("Start Date");
        TTHeader.TestField("End Date");

        // Clear existing slots for this semester
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.SetFilter("Valid From Date", '%1..%2', TTHeader."Start Date", TTHeader."End Date");
        ExamTimeSlot.DeleteAll();

        // Generate Regular Exam Slots
        GenerateRegularSlots(Semester, SemesterCode);

        // Generate Medical Exam Slots
        GenerateMedicalSlots(Semester, SemesterCode);

        Message('Time slots generated successfully.');
    end;

    local procedure IsHoliday(CheckDate: Date): Boolean
    var
        TimetableHolidays: Record "Timetable Holidays";
    begin
        TimetableHolidays.Reset();
        TimetableHolidays.SetRange("Date", CheckDate);
        exit(not TimetableHolidays.IsEmpty);
    end;

    procedure GenerateSuppExamTimeSlots(SemesterCode: Code[25])
    var
        Semester: Record "ACA-Semesters";
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
        Window: Dialog;
        SlotGroup: Option Regular,Medical;
    begin
        // Validate semester
        FindSemester(SemesterCode, Semester);
        Semester.TestField("Supp Start Date");
        Semester.TestField("Supp End Date");

        // Clear existing slots for this semester
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.SetFilter("Valid From Date", '%1..%2', Semester."Supp Start Date", Semester."Supp End Date");
        ExamTimeSlot.DeleteAll();

        // Generate Regular Exam Slots
        GenerateRegularSuppSlots(Semester, SemesterCode);

        // Generate Medical Exam Slots
        GenerateMedicalSuppSlots(Semester, SemesterCode);

        Message('Supplementary Time slots generated successfully.');
    end;

    local procedure GenerateRegularSlots(Semester: Record "ACA-Semesters"; SemesterCode: Code[25])
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
    begin
        CurrentDate := Semester."Exam Start Date";
        while CurrentDate <= Semester."Exam End Date" do begin
            // Skip weekends AND holidays
            if (Date2DWY(CurrentDate, 1) <= 5) and (not IsHoliday(CurrentDate)) then begin

                // Morning session (9:00 AM - 11:00 AM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-M');
                CreateExamTimeSlot(
                    SlotCode,
                    'Regular Morning Session',
                    090000T,
                    110000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Morning,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode,
                    0  // Regular
                );

                // Midday session (12:00 PM - 2:00 PM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-N');
                CreateExamTimeSlot(
                    SlotCode,
                    'Regular Noon Session',
                    120000T,
                    140000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Midday,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode,
                    0  // Regular
                );

                // Afternoon session (3:00 PM - 5:00 PM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-A');
                CreateExamTimeSlot(
                    SlotCode,
                    'Regular Afternoon Session',
                    150000T,
                    170000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Afternoon,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode,
                    0  // Regular
                );
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;
    end;

    local procedure GenerateRegularSuppSlots(Semester: Record "ACA-Semesters"; SemesterCode: Code[25])
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
    begin
        CurrentDate := Semester."Supp Start Date";
        while CurrentDate <= Semester."Supp End Date" do begin
            // Skip weekends AND holidays
            if (Date2DWY(CurrentDate, 1) <= 5) and (not IsHoliday(CurrentDate)) then begin

                // Morning session (9:00 AM - 11:00 AM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-M');
                CreateExamTimeSlot(
                    SlotCode,
                    'Regular Morning Session',
                    090000T,
                    110000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Morning,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode,
                    0  // Regular
                );

                // Midday session (12:00 PM - 2:00 PM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-N');
                CreateExamTimeSlot(
                    SlotCode,
                    'Regular Noon Session',
                    120000T,
                    140000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Midday,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode,
                    0  // Regular
                );

                // Afternoon session (3:00 PM - 5:00 PM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-A');
                CreateExamTimeSlot(
                    SlotCode,
                    'Regular Afternoon Session',
                    150000T,
                    170000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Afternoon,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode,
                    0  // Regular
                );
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;
    end;

    local procedure GenerateMedicalSuppSlots(Semester: Record "ACA-Semesters"; SemesterCode: Code[25])
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
        DayCount: Integer;
    begin
        CurrentDate := Semester."Supp Start Date";
        DayCount := 0;

        while CurrentDate <= Semester."Supp End Date" do begin
            // Skip weekends AND holidays
            if (Date2DWY(CurrentDate, 1) <= 5) and (not IsHoliday(CurrentDate)) then begin
                DayCount += 1;

                if DayCount = 1 then begin
                    // First day: Three sessions like regular exams

                    // Morning session (9:00 AM - 11:00 AM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-M');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Morning Session',
                        090000T,
                        110000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Morning,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );

                    // Midday session (12:00 PM - 2:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-N');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Noon Session',
                        120000T,
                        140000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Midday,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );

                    // Afternoon session (3:00 PM - 5:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-A');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Afternoon Session',
                        150000T,
                        170000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Afternoon,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );
                end else begin
                    // Extended morning session (9:00 AM - 12:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-ME');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Extended Morning Session',
                        090000T,
                        120000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Morning,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );

                    // Extended afternoon session (2:00 PM - 5:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-AE');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Extended Afternoon Session',
                        140000T,
                        170000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Afternoon,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );
                end;
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;
    end;

    local procedure GenerateMedicalSlots(Semester: Record "ACA-Semesters"; SemesterCode: Code[25])
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
        DayCount: Integer;
    begin
        CurrentDate := Semester."Exam Start Date";
        DayCount := 0;

        while CurrentDate <= Semester."Exam End Date" do begin
            // Skip weekends AND holidays
            if (Date2DWY(CurrentDate, 1) <= 5) and (not IsHoliday(CurrentDate)) then begin
                DayCount += 1;

                if DayCount = 1 then begin
                    // First day: Three sessions like regular exams

                    // Morning session (9:00 AM - 11:00 AM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-M');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Morning Session',
                        090000T,
                        110000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Morning,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );

                    // Midday session (12:00 PM - 2:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-N');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Noon Session',
                        120000T,
                        140000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Midday,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );

                    // Afternoon session (3:00 PM - 5:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-A');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Afternoon Session',
                        150000T,
                        170000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Afternoon,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );
                end else begin
                    // Extended morning session (9:00 AM - 12:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-ME');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Extended Morning Session',
                        090000T,
                        120000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Morning,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );

                    // Extended afternoon session (2:00 PM - 5:00 PM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-AE');
                    CreateExamTimeSlot(
                        SlotCode,
                        'Medical Extended Afternoon Session',
                        140000T,
                        170000T,
                        Date2DWY(CurrentDate, 1) - 1,
                        ExamTimeSlot."Session Type"::Afternoon,
                        CurrentDate,
                        CurrentDate,
                        SemesterCode,
                        1  // Medical
                    );
                end;
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;
    end;

    local procedure CreateSlotCode(ExamDate: Date; SessionCode: Code[4]): Code[20]
    begin
        exit(Format(ExamDate, 0, '<Year4><Month,2><Day,2>') + '-' + SessionCode);
    end;

    local procedure CreateExamTimeSlot(SlotCode: Code[20]; Description: Text[50];
        StartTime: Time; EndTime: Time; DayOfWeek: Integer; SessionType: Option;
        ValidFrom: Date; ValidTo: Date; SemesterCode: Code[25]; SlotGroup: Option Regular,Medical)
    var
        ExamTimeSlot: Record "Exam Time Slot";
    begin
        ExamTimeSlot.Init();
        ExamTimeSlot.Code := SlotCode;
        ExamTimeSlot.Description := Description;
        ExamTimeSlot."Start Time" := StartTime;
        ExamTimeSlot."End Time" := EndTime;
        ExamTimeSlot."Day of Week" := DayOfWeek;
        ExamTimeSlot."Session Type" := SessionType;
        ExamTimeSlot."Valid From Date" := ValidFrom;
        ExamTimeSlot."Valid To Date" := ValidTo;
        ExamTimeSlot."Semester Code" := SemesterCode;
        ExamTimeSlot."Default Break Time (Minutes)" := 30;
        ExamTimeSlot."Setup Time Required (Minutes)" := 30;
        ExamTimeSlot."Max Continuous Hours" := 3;
        ExamTimeSlot."Slot Group" := SlotGroup;
        ExamTimeSlot.Active := true;
        ExamTimeSlot.Insert();
    end;

    procedure GenerateExamTimetableByGroup(
    TTHeader: Record "Timetable Header";
    SemesterCode: Code[25];
    StartDate: Date;
    EndDate: Date;
    GroupDescription: Text[100];
    YearFilter: Text;
    SchoolFilter: Text;
    ProgrammeFilter: Text;
    ExcludeYears: Boolean;
    ExcludeSchools: Boolean;
    ExcludeProgrammes: Boolean)
    var
        Semester: Record "ACA-Semesters";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        CourseOffering: Record "ACA-Lecturers Units";
        ExamTimeSlot: Record "Exam Time Slot";
        ProgressWindow: Dialog;
        TotalExams, CurrentExam : Integer;
        CoursesPerDay: Dictionary of [Date, Integer];
        DayCounter: Integer;
        Programme: Record "ACA-Programme";
        ShouldInclude: Boolean;
        GroupCode: Code[20];
        Sudo: Boolean;

    begin
        // Clear invigilator cache for optimal performance
        ClearInvigilatorCache();

        FindSemester(SemesterCode, Semester);

        // Validate dates
        if StartDate = 0D then
            StartDate := Semester."Exam Start Date";
        if EndDate = 0D then
            EndDate := Semester."Exam End Date";

        if StartDate > EndDate then
            Error('Start date cannot be after end date');

        // Generate unique group code
        GroupCode := GenerateGroupCode(SemesterCode, GroupDescription);

        // Get active exam time slots for the date range
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.SetRange(Active, true);
        ExamTimeSlot.SetFilter("Valid From Date", '<=%1', EndDate);
        ExamTimeSlot.SetFilter("Valid To Date", '>=%1', StartDate);

        if not ExamTimeSlot.FindSet() then
            Error('No active exam time slots defined for the specified date range');

        // Get courses with filters applied
        CourseOffering.Reset();
        CourseOffering.SetRange(Semester, SemesterCode);
        CourseOffering.SetCurrentKey("Time Table Hours");

        // Apply filters based on criteria
        ApplyGroupFilters(CourseOffering, YearFilter, SchoolFilter, ProgrammeFilter,
                         ExcludeYears, ExcludeSchools, ExcludeProgrammes);

        TotalExams := CourseOffering.Count();

        if TotalExams = 0 then
            Error('No courses found matching the specified criteria');

        ProgressWindow.Open('Scheduling Exams for Group: ' + GroupDescription + '\' +
                          'Total: #1###\' +
                          'Current Unit: #2##################\' +
                          'Current Date: #3##################');

        DayCounter := 0;

        if CourseOffering.FindSet() then begin
            repeat
                // Check if exam already scheduled in another group
                if not IsExamAlreadyScheduled(CourseOffering.Unit, CourseOffering.Stage, SemesterCode, CourseOffering.Programme) then begin
                    CurrentExam += 1;
                    ProgressWindow.Update(1, Format(CurrentExam) + ' of ' + Format(TotalExams));
                    ProgressWindow.Update(2, CourseOffering.Unit);
                    if CurrentExam >= 367 then begin
                        Sudo := true;
                    end;
                    // Schedule the exam within the specified date range
                    if ScheduleExamInDateRange(
                        CourseOffering,
                        Semester,
                        StartDate,
                        EndDate,
                        DayCounter,
                        CoursesPerDay,
                        GroupCode,
                        TTHeader."Document No.") then begin
                        // Successfully scheduled
                    end else
                        LogSchedulingIssueWithGroup(CourseOffering, GroupCode, GroupDescription);
                end;
            until CourseOffering.Next() = 0;
        end;

        // Invigilators are already assigned during exam scheduling

        ProgressWindow.Close();

        // Show distribution statistics with group info
        ShowSessionDistributionMessageForGroup(GroupDescription, CurrentExam);
    end;

    local procedure ApplyGroupFilters(
        var CourseOffering: Record "ACA-Lecturers Units";
        YearFilter: Text;
        SchoolFilter: Text;
        ProgrammeFilter: Text;
        ExcludeYears: Boolean;
        ExcludeSchools: Boolean;
        ExcludeProgrammes: Boolean)
    var
        YearFilterText: Text;
        StageFilterText: Text;
        SchoolFilterText: Text;
        ProgrammeFilterText: Text;
    begin
        // Apply Programme filter
        if ProgrammeFilter <> '' then begin
            ProgrammeFilterText := BuildFilterText(ProgrammeFilter, ExcludeProgrammes);
            CourseOffering.SetFilter(Programme, ProgrammeFilterText);
        end;

        // Apply Year filter (through Stage)
        if YearFilter <> '' then begin
            StageFilterText := BuildStageFilterFromYears(YearFilter, ExcludeYears);
            if StageFilterText <> '' then
                CourseOffering.SetFilter(Stage, StageFilterText);
        end;

        // Apply School filter (through Programme relationship)
        if SchoolFilter <> '' then begin
            CourseOffering.CalcFields("School Code"); // Ensure flowfield is calculated
            SchoolFilterText := BuildFilterText(SchoolFilter, ExcludeSchools);
            CourseOffering.SetFilter("School Code", SchoolFilterText);
        end;
    end;

    local procedure BuildFilterText(FilterValues: Text; Exclude: Boolean): Text
    var
        FilterList: List of [Text];
        FilterItem: Text;
        ResultFilter: Text;
        IsFirst: Boolean;
    begin
        IsFirst := true;
        FilterList := FilterValues.Split(',');

        foreach FilterItem in FilterList do begin
            FilterItem := FilterItem.Trim();
            if FilterItem <> '' then begin
                if Exclude then begin
                    // For exclusions, we need to chain with & operator
                    if not IsFirst then
                        ResultFilter += '&';
                    ResultFilter += '<>' + FilterItem;
                end else begin
                    // For inclusions, we use | operator
                    if not IsFirst then
                        ResultFilter += '|';
                    ResultFilter += FilterItem;
                end;
                IsFirst := false;
            end;
        end;

        exit(ResultFilter);
    end;

    local procedure BuildStageFilterFromYears(YearFilter: Text; ExcludeYears: Boolean): Text
    var
        FilterList: List of [Text];
        FilterValue: Text;
        ResultFilter: Text;
        YearValue: Integer;
        StartYear: Integer;
        EndYear: Integer;
        i: Integer;
        IsFirst: Boolean;
        StageList: List of [Text];
        StageCode: Text;
    begin
        // Parse year filter and build corresponding stage filter
        FilterList := YearFilter.Split(',');

        // First, collect all stage codes based on year filter
        foreach FilterValue in FilterList do begin
            FilterValue := FilterValue.Trim();

            if FilterValue.Contains('-') then begin
                // Handle range (e.g., "2-4")
                if ParseYearRange(FilterValue, StartYear, EndYear) then begin
                    for i := StartYear to EndYear do begin
                        AddYearToStageFilter(i, StageList);
                    end;
                end;
            end else begin
                // Handle single year
                if Evaluate(YearValue, FilterValue) then
                    AddYearToStageFilter(YearValue, StageList);
            end;
        end;

        // Build the filter string
        IsFirst := true;
        foreach StageCode in StageList do begin
            if ExcludeYears then begin
                // For exclusions, chain with & operator
                if not IsFirst then
                    ResultFilter += '&';
                ResultFilter += '<>' + StageCode;
            end else begin
                // For inclusions, use | operator
                if not IsFirst then
                    ResultFilter += '|';
                ResultFilter += StageCode;
            end;
            IsFirst := false;
        end;

        exit(ResultFilter);
    end;

    local procedure ParseYearRange(RangeText: Text; var StartYear: Integer; var EndYear: Integer): Boolean
    var
        Parts: List of [Text];
    begin
        Parts := RangeText.Split('-');

        if Parts.Count = 2 then begin
            if Evaluate(StartYear, Parts.Get(1).Trim()) and
               Evaluate(EndYear, Parts.Get(2).Trim()) then begin
                // Validate range
                if (StartYear > 0) and (EndYear >= StartYear) and (EndYear <= 10) then
                    exit(true);
            end;
        end;

        exit(false);
    end;

    local procedure AddYearToStageFilter(YearValue: Integer; var StageList: List of [Text])
    var
        StageCode: Text;
    begin
        // Add all possible stage codes for this year
        // This handles semester system (S1, S2)
        StageCode := 'Y' + Format(YearValue) + 'S1';
        if not StageList.Contains(StageCode) then
            StageList.Add(StageCode);

        StageCode := 'Y' + Format(YearValue) + 'S2';
        if not StageList.Contains(StageCode) then
            StageList.Add(StageCode);

        // If your institution uses trimester system, add these:
        // StageCode := 'Y' + Format(YearValue) + 'T1';
        // if not StageList.Contains(StageCode) then
        //     StageList.Add(StageCode);
        //     
        // StageCode := 'Y' + Format(YearValue) + 'T2';
        // if not StageList.Contains(StageCode) then
        //     StageList.Add(StageCode);
        //     
        // StageCode := 'Y' + Format(YearValue) + 'T3';
        // if not StageList.Contains(StageCode) then
        //     StageList.Add(StageCode);

        // If you have other stage naming patterns, add them here
        // For example, for medical programs with different patterns:
        // if your medical programs use 'M1S1', 'M1S2' format:
        // StageCode := 'M' + Format(YearValue) + 'S1';
        // if not StageList.Contains(StageCode) then
        //     StageList.Add(StageCode);
    end;

    local procedure IsYearInFilter(YearOfStudy: Integer; YearFilter: Text): Boolean
    var
        FilterList: List of [Text];
        FilterValue: Text;
        YearValue: Integer;
    begin
        // Parse comma-separated years or ranges (e.g., "1,3-5,7")
        FilterList := YearFilter.Split(',');

        foreach FilterValue in FilterList do begin
            if FilterValue.Contains('-') then begin
                // Handle range
                if IsInRange(YearOfStudy, FilterValue) then
                    exit(true);
            end else begin
                // Handle single value
                if Evaluate(YearValue, FilterValue.Trim()) then
                    if YearOfStudy = YearValue then
                        exit(true);
            end;
        end;

        exit(false);
    end;

    local procedure IsInRange(Value: Integer; RangeText: Text): Boolean
    var
        Parts: List of [Text];
        StartValue, EndValue : Integer;
    begin
        Parts := RangeText.Split('-');

        if Parts.Count = 2 then begin
            if Evaluate(StartValue, Parts.Get(1).Trim()) and
               Evaluate(EndValue, Parts.Get(2).Trim()) then
                exit((Value >= StartValue) and (Value <= EndValue));
        end;

        exit(false);
    end;

    local procedure IsTextInFilter(TextValue: Text; Filter: Text): Boolean
    var
        FilterList: List of [Text];
        FilterItem: Text;
    begin
        FilterList := Filter.Split(',');

        foreach FilterItem in FilterList do begin
            if TextValue = FilterItem.Trim() then
                exit(true);
        end;

        exit(false);
    end;

    local procedure ScheduleExamInDateRange(
     var CourseOffering: Record "ACA-Lecturers Units";
     Semester: Record "ACA-Semesters";
     StartDate: Date;
     EndDate: Date;
     var DayCounter: Integer;
     var CoursesPerDay: Dictionary of [Date, Integer];
     GroupCode: Code[20];
     DocumentNo: Code[20]): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        CurrentDate: Date;
        OptimalDate: Date;
        IsMedical: Boolean;
        SlotFound: Boolean;
        MaxDaysToCheck: Integer;
        DaysChecked: Integer;
        AllTimeSlots: Record "Exam Time Slot" temporary;
        TriedCombinations: List of [Text];
        CombinationKey: Text;
        FirstDayUnits: Record "Exam First Day Units";
        IsFirstDayUnit: Boolean;
        DateAttempts: Integer;
        MaxDateAttempts: Integer;
        AvailableDates: List of [Date];
        BestDate: Date;
        LowestLoadDate: Date;
        LowestLoad: Integer;
        CurrentLoad: Integer;
        TempDate: Date;
    begin
        IsMedical := IsMedicalProgramme(CourseOffering.Programme);
        MaxDaysToCheck := (EndDate - StartDate) + 1;
        DaysChecked := 0;
        SlotFound := false;
        MaxDateAttempts := 3; // Try up to 3 different dates for better distribution

        // Check if this is a first day preference unit
        FirstDayUnits.Reset();
        FirstDayUnits.SetRange(Unit, CourseOffering.Unit);
        IsFirstDayUnit := FirstDayUnits.FindFirst();

        // If this is a first day unit, try to schedule on the first day first
        if IsFirstDayUnit then begin
            CurrentDate := StartDate;
            // Skip weekends for start date
            while ((Date2DWY(CurrentDate, 1) > 5) or IsHoliday(CurrentDate)) and (CurrentDate <= EndDate) do
                CurrentDate := CalcDate('1D', CurrentDate);

            if CurrentDate <= EndDate then begin
                if TryScheduleExamOnDate(CourseOffering, CurrentDate, Semester, GroupCode, CoursesPerDay, IsMedical, DocumentNo) then
                    exit(true);
            end;
        end;

        // Build a list of all possible time slots for this period
        BuildAvailableTimeSlots(StartDate, EndDate, IsMedical, AllTimeSlots);

        // Build list of available dates for better distribution
        BuildAvailableDatesList(StartDate, EndDate, AvailableDates);

        // For better distribution, try to find the date with lowest exam load
        DateAttempts := 0;
        repeat
            DateAttempts += 1;

            // Find the date with the lowest exam load for better distribution
            if DateAttempts = 1 then begin
                BestDate := FindLeastLoadedDate(AvailableDates, CoursesPerDay);
            end else begin
                // Calculate date based on day counter for subsequent attempts
                BestDate := CalcDate(StrSubstNo('%1D', DayCounter), StartDate);

                // Cycle through available dates if we go beyond range
                while BestDate > EndDate do begin
                    DayCounter := DayCounter - MaxDaysToCheck;
                    if DayCounter < 0 then DayCounter := 0;
                    BestDate := CalcDate(StrSubstNo('%1D', DayCounter), StartDate);
                end;
            end;

            // Skip weekends and holidays
            while ((Date2DWY(BestDate, 1) > 5) or IsHoliday(BestDate)) and (BestDate <= EndDate) do begin
                BestDate := CalcDate('1D', BestDate);
            end;

            // Break if we've gone beyond the end date after skipping
            if BestDate > EndDate then begin
                DayCounter += 1;
            end else begin
                // Try to schedule on this date
                if TryScheduleExamOnDate(CourseOffering, BestDate, Semester, GroupCode, CoursesPerDay, IsMedical, DocumentNo) then
                    exit(true);
            end;

            // Try the next day
            DayCounter += 1;

        until DateAttempts >= MaxDateAttempts;

        // If specific date attempts failed, try sequential scheduling with better distribution
        DaysChecked := 0;
        repeat
            DaysChecked += 1;

            // Calculate date based on day counter with modulo to ensure distribution
            CurrentDate := CalcDate(StrSubstNo('%1D', (DayCounter mod MaxDaysToCheck)), StartDate);

            // Skip weekends and holidays
            while ((Date2DWY(CurrentDate, 1) > 5) or IsHoliday(CurrentDate)) and (CurrentDate <= EndDate) do begin
                CurrentDate := CalcDate('1D', CurrentDate);
            end;

            // Break if we've gone beyond the end date after skipping
            if CurrentDate > EndDate then begin
                DayCounter += 1;
                if DaysChecked >= MaxDaysToCheck then
                    exit(false);
            end else begin
                // Try to schedule on this date
                if TryScheduleExamOnDate(CourseOffering, CurrentDate, Semester, GroupCode, CoursesPerDay, IsMedical, DocumentNo) then
                    exit(true);
            end;

            // Try the next day
            DayCounter += 1;

        until DaysChecked >= MaxDaysToCheck;

        exit(false);
    end;

    local procedure ScheduleExamWithRoomAllocationGroup(
    CourseOffering: Record "ACA-Lecturers Units";
    ExamDate: Date;
    ExamTimeSlot: Record "Exam Time Slot";
    Semester: Record "ACA-Semesters";
    GroupCode: Code[20];
    DocumentNo: Code[20]): Boolean
    var
        TotalStudents: Integer;
        RemainingStudents: Integer;
        AvailableRooms: array[100] of Record "ACA-Lecturer Halls Setup";
        AvailableCapacities: array[100] of Integer;
        RoomCount: Integer;
        i: Integer;
        StudentsInRoom: Integer;
        MinStudentsPerRoom: Integer;
        ActuallyScheduledStudents: Integer;
    begin
        TotalStudents := CourseOffering."Student Allocation";
        RemainingStudents := TotalStudents;
        ActuallyScheduledStudents := 0;
        MinStudentsPerRoom := 15; // Minimum students to make a room allocation worthwhile

        // Get available exam rooms
        GetAvailableExamRoomsEnhanced(ExamDate, ExamTimeSlot, AvailableRooms, AvailableCapacities, RoomCount);

        if RoomCount = 0 then
            exit(false);

        // Calculate total available capacity
        i := 1;
        while i <= RoomCount do begin
            ActuallyScheduledStudents += AvailableCapacities[i];
            i += 1;
        end;

        // If total available capacity is less than required, don't proceed
        if ActuallyScheduledStudents < (TotalStudents * 0.8) then // Allow 80% minimum
            exit(false);

        // Try to allocate all students to a single room if possible
        for i := 1 to RoomCount do begin
            if AvailableCapacities[i] >= TotalStudents then begin
                // Create exam entry for the entire class
                CreateExamEntryWithGroup(CourseOffering, ExamDate, ExamTimeSlot,
                    AvailableRooms[i]."Lecture Room Code", TotalStudents, Semester.Code, GroupCode, DocumentNo);
                exit(true);
            end;
        end;

        // If we need to split across multiple rooms, ensure we can accommodate at least 80% of students
        ActuallyScheduledStudents := 0;
        i := 1;
        while (RemainingStudents > 0) and (i <= RoomCount) do begin
            if AvailableCapacities[i] >= MinStudentsPerRoom then begin
                StudentsInRoom := MinValue(RemainingStudents, AvailableCapacities[i]);

                // Create exam entry
                CreateExamEntryWithGroup(CourseOffering, ExamDate, ExamTimeSlot,
                    AvailableRooms[i]."Lecture Room Code", StudentsInRoom, Semester.Code, GroupCode, DocumentNo);

                RemainingStudents -= StudentsInRoom;
                ActuallyScheduledStudents += StudentsInRoom;
            end;
            i += 1;
        end;

        // If we couldn't schedule at least 80% of students, rollback
        if ActuallyScheduledStudents < (TotalStudents * 0.8) then begin
            // Delete the entries we just created
            DeleteExamEntries(CourseOffering.Unit, ExamDate, ExamTimeSlot.Code, Semester.Code);
            exit(false);
        end;

        exit(RemainingStudents = 0);
    end;

    local procedure GetAvailableExamRoomsEnhanced(ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        var AvailableRooms: array[100] of Record "ACA-Lecturer Halls Setup";
        var AvailableCapacities: array[100] of Integer;
        var RoomCount: Integer)
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        TotalCapacity: Integer;
        UsedCapacity: Integer;
        BufferPercentage: Decimal;
    begin
        Clear(RoomCount);
        Clear(AvailableRooms);
        Clear(AvailableCapacities);
        BufferPercentage := 0.9; // Use 90% of room capacity for comfort

        LectureHall.Reset();
        LectureHall.SetFilter("Exam Sitting Capacity", '>0');
        LectureHall.SetRange(Status, LectureHall.Status::Active);

        // Include both Normal and Lab rooms if enabled
        if EnableLabsForExam() then
            LectureHall.SetFilter("Hall Category", '%1|%2',
                LectureHall."Hall Category"::Normal,
                LectureHall."Hall Category"::Lab)
        else
            LectureHall.SetRange("Hall Category", LectureHall."Hall Category"::Normal);

        // Sort by capacity descending to prioritize larger rooms
        LectureHall.SetCurrentKey("Exam Sitting Capacity");
        LectureHall.SetAscending("Exam Sitting Capacity", false);

        if LectureHall.FindSet() then
            repeat
                Clear(UsedCapacity);
                TotalCapacity := Round(LectureHall."Exam Sitting Capacity" * BufferPercentage, 1);

                // Check existing bookings for this room at this time
                ExamTimetableEntry.Reset();
                ExamTimetableEntry.SetRange("Exam Date", ExamDate);
                ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);
                ExamTimetableEntry.SetRange("Lecture Hall", LectureHall."Lecture Room Code");

                if ExamTimetableEntry.FindSet() then
                    repeat
                        if ExamTimetableEntry."Student Count" > 0 then
                            UsedCapacity += ExamTimetableEntry."Student Count"
                        else
                            UsedCapacity += GetExamStudentCount(ExamTimetableEntry);
                    until ExamTimetableEntry.Next() = 0;

                // If there's still capacity available
                if TotalCapacity > UsedCapacity then begin
                    RoomCount += 1;
                    if RoomCount <= 100 then begin
                        AvailableRooms[RoomCount] := LectureHall;
                        AvailableCapacities[RoomCount] := TotalCapacity - UsedCapacity;
                    end;
                end;
            until (LectureHall.Next() = 0) or (RoomCount >= 100);
    end;

    // 6. Helper to delete exam entries (for rollback)
    local procedure DeleteExamEntries(UnitCode: Code[25]; ExamDate: Date; TimeSlot: Code[20]; SemesterCode: Code[25])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Unit Code", UnitCode);
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", TimeSlot);
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
        ExamTimetableEntry.DeleteAll();
    end;

    // 7. Add retry mechanism for failed units
    procedure RetryFailedExamScheduling(SemesterCode: Code[25])
    var
        SchedulingIssue: Record "Scheduling Issue";
        CourseOffering: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
        ExamTimeSlot: Record "Exam Time Slot";
        DayCounter: Integer;
        CoursesPerDay: Dictionary of [Date, Integer];
        RetryCount: Integer;
        MaxRetries: Integer;
    begin
        MaxRetries := 3;
        FindSemester(SemesterCode, Semester);

        for RetryCount := 1 to MaxRetries do begin
            SchedulingIssue.Reset();
            if SchedulingIssue.FindSet() then begin
                repeat
                    CourseOffering.Reset();
                    CourseOffering.SetRange(Unit, SchedulingIssue."Course Code");
                    CourseOffering.SetRange(Semester, SemesterCode);
                    CourseOffering.SetRange(Programme, SchedulingIssue."Programme");

                    if CourseOffering.FindFirst() then begin
                        DayCounter := 0;

                        // Try with relaxed constraints
                        if ScheduleExamInDateRangeRelaxed(
                            CourseOffering,
                            Semester,
                            Semester."Exam Start Date",
                            Semester."Exam End Date",
                            DayCounter,
                            CoursesPerDay,
                            '') then begin
                            // Successfully scheduled, remove from issues
                            SchedulingIssue.Delete();
                        end;
                    end;
                until SchedulingIssue.Next() = 0;
            end;
        end;
    end;

    // 8. Relaxed scheduling for retry attempts
    local procedure ScheduleExamInDateRangeRelaxed(
        var CourseOffering: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
        StartDate: Date;
        EndDate: Date;
        var DayCounter: Integer;
        var CoursesPerDay: Dictionary of [Date, Integer];
        GroupCode: Code[20]): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        CurrentDate: Date;
        IsMedical: Boolean;
    begin
        IsMedical := IsMedicalProgramme(CourseOffering.Programme);

        // Try all dates and all time slots without restrictions
        CurrentDate := StartDate;
        while CurrentDate <= EndDate do begin
            if (Date2DWY(CurrentDate, 1) <= 5) and (not IsHoliday(CurrentDate)) then begin
                ExamTimeSlot.Reset();
                ExamTimeSlot.SetRange(Active, true);
                ExamTimeSlot.SetFilter("Valid From Date", '<=%1', CurrentDate);
                ExamTimeSlot.SetFilter("Valid To Date", '>=%1', CurrentDate);
                ExamTimeSlot.SetRange("Day of Week", Date2DWY(CurrentDate, 1) - 1);

                // Try both regular and medical slots if needed
                if ExamTimeSlot.FindSet() then begin
                    repeat
                        if ScheduleExamWithPartialAllocation(
                            CourseOffering,
                            CurrentDate,
                            ExamTimeSlot,
                            Semester,
                            GroupCode) then
                            exit(true);
                    until ExamTimeSlot.Next() = 0;
                end;
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;

        exit(false);
    end;

    // 9. Allow partial allocation as last resort
    local procedure ScheduleExamWithPartialAllocation(
        CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        Semester: Record "ACA-Semesters";
        GroupCode: Code[20]): Boolean
    var
        TotalStudents: Integer;
        AvailableRooms: array[100] of Record "ACA-Lecturer Halls Setup";
        AvailableCapacities: array[100] of Integer;
        RoomCount: Integer;
        i: Integer;
        TotalAvailableCapacity: Integer;
        StudentsToSchedule: Integer;
    begin
        TotalStudents := CourseOffering."Student Allocation";

        // Get available exam rooms
        GetAvailableExamRoomsEnhanced(ExamDate, ExamTimeSlot, AvailableRooms, AvailableCapacities, RoomCount);

        if RoomCount = 0 then
            exit(false);

        // Calculate total available capacity
        TotalAvailableCapacity := 0;
        for i := 1 to RoomCount do
            TotalAvailableCapacity += AvailableCapacities[i];

        // If we can accommodate at least 50% of students, proceed
        if TotalAvailableCapacity >= (TotalStudents * 0.5) then begin
            StudentsToSchedule := MinValue(TotalStudents, TotalAvailableCapacity);

            // Schedule what we can
            i := 1;
            while (StudentsToSchedule > 0) and (i <= RoomCount) do begin
                if AvailableCapacities[i] > 0 then begin
                    CreateExamEntryWithGroup(
                        CourseOffering,
                        ExamDate,
                        ExamTimeSlot,
                        AvailableRooms[i]."Lecture Room Code",
                        MinValue(StudentsToSchedule, AvailableCapacities[i]),
                        Semester.Code,
                        GroupCode,
                        '');

                    StudentsToSchedule -= MinValue(StudentsToSchedule, AvailableCapacities[i]);
                end;
                i += 1;
            end;

            // Log partial allocation
            LogPartialAllocation(CourseOffering, TotalStudents - StudentsToSchedule, TotalStudents);
            exit(true);
        end;

        exit(false);
    end;

    // 10. Log partial allocations
    local procedure LogPartialAllocation(CourseOffering: Record "ACA-Lecturers Units"; ScheduledCount: Integer; TotalCount: Integer)
    var
        SchedulingIssue: Record "Scheduling Issue";
    begin
        SchedulingIssue.Init();
        SchedulingIssue."Course Code" := CourseOffering.Unit;
        SchedulingIssue."Programme" := CourseOffering.Programme;
        SchedulingIssue."Lecturer Code" := CourseOffering.Lecturer;
        SchedulingIssue.Stage := CourseOffering.Stage;
        SchedulingIssue."Issue Description" :=
            StrSubstNo('Partial allocation: %1 of %2 students scheduled', ScheduledCount, TotalCount);
        SchedulingIssue.Insert();
    end;

    local procedure BuildAvailableTimeSlots(StartDate: Date; EndDate: Date; IsMedical: Boolean; var TempTimeSlots: Record "Exam Time Slot" temporary)
    var
        ExamTimeSlot: Record "Exam Time Slot";
    begin
        TempTimeSlots.DeleteAll();

        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange(Active, true);
        ExamTimeSlot.SetFilter("Valid From Date", '<=%1', EndDate);
        ExamTimeSlot.SetFilter("Valid To Date", '>=%1', StartDate);

        if ExamTimeSlot.FindSet() then begin
            repeat
                TempTimeSlots := ExamTimeSlot;
                TempTimeSlots.Insert();
            until ExamTimeSlot.Next() = 0;
        end;
    end;

    // 3. New helper to check if time slot is valid for specific date
    local procedure IsTimeSlotValidForDate(TimeSlot: Record "Exam Time Slot"; ExamDate: Date): Boolean
    begin
        if (TimeSlot."Valid From Date" <= ExamDate) and (TimeSlot."Valid To Date" >= ExamDate) then
            if TimeSlot."Day of Week" = (Date2DWY(ExamDate, 1) - 1) then
                exit(true);

        exit(false);
    end;

    local procedure CreateExamEntryWithGroup(
    CourseOffering: Record "ACA-Lecturers Units";
    ExamDate: Date;
    ExamTimeSlot: Record "Exam Time Slot";
    LectureHall: Code[20];
    StudentCount: Integer;
    SemesterCode: Code[25];
    GroupCode: Code[20];
    DocumentNo: Code[20])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Init();
        ExamTimetableEntry."Unit Code" := CourseOffering.Unit;
        ExamTimetableEntry.Semester := SemesterCode;
        ExamTimetableEntry."Exam Date" := ExamDate;
        ExamTimetableEntry."Time Slot" := ExamTimeSlot.Code;
        ExamTimetableEntry."Start Time" := ExamTimeSlot."Start Time";
        ExamTimetableEntry."End Time" := ExamTimeSlot."End Time";
        ExamTimetableEntry."Lecture Hall" := LectureHall;
        ExamTimetableEntry."Programme Code" := CourseOffering.Programme;
        ExamTimetableEntry."Stage Code" := CourseOffering.Stage;
        ExamTimetableEntry.Status := ExamTimetableEntry.Status::Scheduled;
        ExamTimetableEntry."Student Count" := StudentCount;
        ExamTimetableEntry."Exam Type" := ExamTimetableEntry."Exam Type"::Regular;
        ExamTimetableEntry."Exam Group" := GroupCode;
        ExamTimetableEntry."Document No." := DocumentNo;
        ExamTimetableEntry."Session Type" := ExamTimeSlot."Session Type";
        ExamTimetableEntry.Insert(true);

        // Don't update global counter here - it's already updated in FindTimeSlotForDay
        // UpdateGlobalSessionCounter(ExamTimeSlot."Session Type");

        // Immediately assign invigilators after creating the exam entry
        AssignInvigilatorsToRoomOptimized(
            CourseOffering,
            ExamDate,
            ExamTimeSlot,
            LectureHall,
            StudentCount,
            SemesterCode);

        // Update the exam entry to mark invigilators as assigned
        ExamTimetableEntry."Invigilators Assigned" := true;
        ExamTimetableEntry."Invigilator Assignment Date" := CurrentDateTime;
        ExamTimetableEntry.Modify();
    end;

    local procedure GenerateGroupCode(SemesterCode: Code[25]; Description: Text[100]): Code[20]
    var
        GroupCode: Code[20];
        Counter: Integer;
    begin
        // Generate a unique group code based on semester and description
        GroupCode := CopyStr(SemesterCode + '-G1', 1, 20);
        Counter := 1;

        // Find next available code
        while ExamGroupExists(GroupCode) do begin
            Counter += 1;
            GroupCode := CopyStr(SemesterCode + '-G' + Format(Counter), 1, 20);
        end;

        // Store group information
        CreateExamGroup(GroupCode, Description);

        exit(GroupCode);
    end;

    local procedure ExamGroupExists(GroupCode: Code[20]): Boolean
    var
        ExamGroup: Record "Exam Groups"; // You'll need to create this table
    begin
        exit(ExamGroup.Get(GroupCode));
    end;

    local procedure CreateExamGroup(GroupCode: Code[20]; Description: Text[100])
    var
        ExamGroup: Record "Exam Groups"; // You'll need to create this table
    begin
        ExamGroup.Init();
        ExamGroup.Code := GroupCode;
        ExamGroup.Description := Description;
        ExamGroup."Creation Date" := Today;
        ExamGroup."Created By" := UserId;
        ExamGroup.Insert();
    end;

    local procedure LogSchedulingIssueWithGroup(
        CourseOffering: Record "ACA-Lecturers Units";
        GroupCode: Code[20];
        GroupDescription: Text[100])
    var
        SchedulingIssue: Record "Scheduling Issue";
    begin
        SchedulingIssue.Init();
        SchedulingIssue."Course Code" := CourseOffering.Unit;
        SchedulingIssue."Programme" := CourseOffering.Programme;
        SchedulingIssue."Lecturer Code" := CourseOffering.Lecturer;
        SchedulingIssue."Issue Description" :=
            StrSubstNo('Unable to schedule exam for group: %1 (%2)', GroupCode, GroupDescription);
        SchedulingIssue.Insert();
    end;

    local procedure AssignInvigilatorsToExamsInGroup(SemesterCode: Code[25]; GroupCode: Code[20])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentCount: Integer;
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
        ExamTimetableEntry.SetRange("Exam Group", GroupCode);

        if ExamTimetableEntry.FindSet() then
            repeat
                // Get student count
                if ExamTimetableEntry."Student Count" > 0 then
                    StudentCount := ExamTimetableEntry."Student Count"
                else
                    StudentCount := GetExamStudentCount(ExamTimetableEntry);

                // Assign invigilators based on student count
                AssignInvigilatorsToRoomOptimized(
                    GetCourseOffering(ExamTimetableEntry."Unit Code", SemesterCode),
                    ExamTimetableEntry."Exam Date",
                    GetExamTimeSlot(ExamTimetableEntry."Time Slot", SemesterCode),
                    ExamTimetableEntry."Lecture Hall",
                    StudentCount,
                    SemesterCode);
            until ExamTimetableEntry.Next() = 0;
    end;

    procedure GenerateTimetable(AcademicYear: Code[20]; Semester: Code[20])
    var
        CourseOffering: Record "ACA-Lecturers Units";
        TimetableEntry: Record "Timetable Entry";
        DaysPerWeek: array[5] of Integer;
        ProgressWindow: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
        SchedulingIssue: Record "Scheduling Issue";
        Uscheduled: Integer;
    begin
        // Clear existing timetable
        TimetableEntry.Reset();
        TimetableEntry.SetRange(Semester, Semester);
        TimetableEntry.DeleteAll(true);

        // Sort courses by priority (e.g., core courses first)
        CourseOffering.Reset();
        CourseOffering.SetRange(Semester, Semester);
        CourseOffering.SetCurrentKey("Time Table Hours");
        CourseOffering.SetAscending("Time Table Hours", false);
        if CourseOffering.FindSet() then begin
            TotalRecords := CourseOffering.Count();
            ProgressWindow.Open('Scheduling Classes\' +
                              'Total: #1###\' +
                              'Current: #2###\' +
                              'Remaining: #3###' +
                              'Weekly Hours: #4###');

            repeat
                CurrentRecord += 1;
                ProgressWindow.Update(1, TotalRecords);
                ProgressWindow.Update(2, CurrentRecord);
                ProgressWindow.Update(3, TotalRecords - CurrentRecord);
                ProgressWindow.Update(4, CourseOffering."Time Table Hours");

                if not AssignBalancedTimeAndLocationNew(CourseOffering, DaysPerWeek) then
                    LogSchedulingIssue(CourseOffering);
            until CourseOffering.Next() = 0;
            //Try again to schedule the logged units and clear them from the log

            SchedulingIssue.Reset();
            if SchedulingIssue.FindSet() then
                repeat
                    Uscheduled := SchedulingIssue.Count();
                    CourseOffering.Reset();
                    CourseOffering.SetRange(Semester, Semester);
                    CourseOffering.SetRange("Unit", SchedulingIssue."Course Code");
                    CourseOffering.SetRange(Lecturer, SchedulingIssue."Lecturer Code");
                    CourseOffering.SetRange(Programme, SchedulingIssue."Programme");
                    CourseOffering.SetRange(Stage, SchedulingIssue.Stage);
                    if CourseOffering.FindFirst() then
                        if AssignBalancedTimeAndLocationNew(CourseOffering, DaysPerWeek) then
                            //LogSchedulingIssue(CourseOffering);
                            SchedulingIssue.Delete();
                until SchedulingIssue.Next() = 0;
            ProgressWindow.Close();
        end;
    end;

    procedure GetSemesterAcademicYear(Sem: Code[25]): Code[20]
    var
        Semester: Record "ACA-Semesters";
    begin
        Semester.Reset();
        Semester.SetRange(Code, Sem);
        if Semester.FindFirst() then
            exit(Semester."Academic Year");
    end;

    local procedure AssignTimeAndLocation(var CourseOffering: Record "ACA-Lecturers Units"): Boolean
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Time Slot";
        TimetableEntry: Record "Timetable Entry";
        RemainingHours: Integer;
        Loops: Integer;
        UnhandledConflict: Integer;
    begin
        RemainingHours := CourseOffering."Time Table Hours";
        // Find suitable lecture hall
        LectureHall.Reset();
        //LectureHall.SetAutoCalcFields("Sitting Capacity");
        LectureHall.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Student Allocation");
        LectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

        if LectureHall.FindSet() then
            repeat
                while (RemainingHours > 0) and (UnhandledConflict < 42) do begin
                    Loops += 1;
                    // Find available time slot
                    if FindAvailableTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot, CourseOffering.Semester) then begin
                        // Create timetable entry
                        TimetableEntry.Init();
                        TimetableEntry."Unit Code" := CourseOffering.Unit;
                        TimetableEntry.Semester := CourseOffering.Semester;
                        TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
                        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                        TimetableEntry."Time Slot Code" := TimeSlot.Code;
                        TimetableEntry."Day of Week" := TimeSlot."Day of Week";
                        TimetableEntry."Start Time" := TimeSlot."Start Time";
                        TimetableEntry."End Time" := TimeSlot."End Time";
                        TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";
                        TimetableEntry."Programme Code" := CourseOffering.Programme;
                        TimetableEntry."Stage Code" := CourseOffering.Stage;
                        TimetableEntry.Type := TimetableEntry.Type::Class;
                        // Note: Document No. will need to be added when GenerateTimetable is updated to use header
                        if TimetableEntry.Insert() then
                            exit(true);
                    end
                    else begin
                        // Handle conflict
                        if HandleAllocationConflict(CourseOffering, TimeSlot, LectureHall, CourseOffering.Semester) then begin
                            TimetableEntry.Init();
                            TimetableEntry."Unit Code" := CourseOffering.Unit;
                            TimetableEntry.Semester := CourseOffering.Semester;
                            TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
                            TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                            TimetableEntry."Time Slot Code" := TimeSlot.Code;
                            TimetableEntry."Day of Week" := TimeSlot."Day of Week";
                            TimetableEntry."Start Time" := TimeSlot."Start Time";
                            TimetableEntry."End Time" := TimeSlot."End Time";
                            TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";
                            TimetableEntry."Programme Code" := CourseOffering.Programme;
                            TimetableEntry."Stage Code" := CourseOffering.Stage;
                            TimetableEntry.Type := TimetableEntry.Type::Class;
                            // Note: Document No. will need to be added when GenerateTimetable is updated to use header
                            if TimetableEntry.Insert() then
                                exit(true);
                        end else begin
                            UnhandledConflict += 1;
                        end;
                    end;
                    if RemainingHours <= 0 then
                        exit(true);
                end;
            until LectureHall.Next() = 0;

        exit(false);
    end;

    local procedure FindAvailableTimeSlot(CourseOffering: Record "ACA-Lecturers Units"; LectureHallCode: Code[20]; var AvailableTimeSlot: Record "Time Slot"; Semester: Code[25]): Boolean
    var
        TimeSlot: Record "Time Slot";
        TimetableEntry: Record "Timetable Entry";
        Lecturer: Record "HRM-Employee C";
    begin
        if TimeSlot.FindSet() then
            repeat
                // Check if lecture hall is available
                if not IsRoomBooked(CourseOffering."Academic Year", LectureHallCode, TimeSlot.Code, CourseOffering.Semester, CourseOffering.Stage) then begin
                    // Check if lecturer is available
                    if not IsLecturerBusy(CourseOffering."Lecturer", CourseOffering."Academic Year", TimeSlot.Code, Semester, CourseOffering.Stage) then begin
                        // Check if there's a conflict with the same course in a different programme
                        if not IsCourseConflict(CourseOffering, TimeSlot.Code, Semester, CourseOffering.Stage) then begin
                            AvailableTimeSlot := TimeSlot;
                            exit(true);
                        end;
                    end;
                end;
            until TimeSlot.Next() = 0;

        exit(false);
    end;

    local procedure IsLecturerBusy(LecturerNo: Code[20]; AcademicYear: Code[20]; TimeSlotCode: Code[20]; Semester: Code[25]; Stage: Code[20]): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
        CourseOffering: Record "ACA-Lecturers Units";
    begin
        TimetableEntry.SetRange("Time Slot Code", TimeSlotCode);
        TimetableEntry.SetRange("Stage Code", Stage);
        if TimetableEntry.FindSet() then
            repeat
                if CourseOffering.Get(TimetableEntry."Unit Code") then
                    if CourseOffering.Lecturer = LecturerNo then
                        exit(true);
            until TimetableEntry.Next() = 0;

        exit(false);
    end;

    local procedure IsCourseConflict(CourseOffering: Record "ACA-Lecturers Units"; TimeSlotCode: Code[20]; Semester: Code[25]; Stage: Code[20]): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
        ConflictingCourseOffering: Record "ACA-Lecturers Units";
    begin
        TimetableEntry.SetRange("Time Slot Code", TimeSlotCode);
        TimetableEntry.SetRange(Semester, Semester);
        TimetableEntry.SetRange("Stage Code", Stage);
        if TimetableEntry.FindSet() then
            repeat
                ConflictingCourseOffering.Reset();
                ConflictingCourseOffering.SetRange(Semester, Semester);
                ConflictingCourseOffering.SetRange("Unit", TimetableEntry."Unit Code");
                ConflictingCourseOffering.SetRange("Lecturer", CourseOffering.Lecturer);
                //ConflictingCourseOffering.SetRange("Stage Code", Stage);
                if ConflictingCourseOffering.Find('-') then
                    if (ConflictingCourseOffering.Unit = CourseOffering.Unit) and
                       (ConflictingCourseOffering.Programme <> CourseOffering.Programme) then
                        exit(true);
            until TimetableEntry.Next() = 0;

        exit(false);
    end;

    local procedure HandleAllocationConflict(var CourseOffering: Record "ACA-Lecturers Units"; var TimeSlot: Record "Time Slot"; var LectureHall: Record "ACA-Lecturer Halls Setup"; Semester: Code[25]): Boolean
    var
        NextTimeSlot: Record "Time Slot";
        NextLectureHall: Record "ACA-Lecturer Halls Setup";
        PreviousLectureHall: Record "ACA-Lecturer Halls Setup";
        i: Integer;
    begin
        // Try next time slot
        NextTimeSlot := TimeSlot;
        if NextTimeSlot.Next() <> 0 then begin
            if FindAvailableTimeSlot(CourseOffering, LectureHall."Lecture Room Code", NextTimeSlot, Semester) then begin
                TimeSlot := NextTimeSlot;
                exit(true);
            end;
        end;

        // If not successful, try next lecture hall
        NextLectureHall := LectureHall;
        if NextLectureHall.Next() <> 0 then begin
            LectureHall := NextLectureHall;
            if FindAvailableTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot, Semester) then
                exit(true);
        end;
        PreviousLectureHall := LectureHall;
        //try a previous lecture hall randomly
        PreviousLectureHall.Reset();
        if PreviousLectureHall.FindSet(false, false) then begin
            PreviousLectureHall.Next(Random(PreviousLectureHall.Count));
            LectureHall := PreviousLectureHall;
            if FindAvailableTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot, Semester) then
                exit(true);
        end;
        NextLectureHall := LectureHall;

        // If still not successful, try combination of next time slot and next lecture hall
        NextTimeSlot.FindSet();
        repeat
            if FindAvailableTimeSlot(CourseOffering, NextLectureHall."Lecture Room Code", NextTimeSlot, Semester) then begin
                TimeSlot := NextTimeSlot;
                LectureHall := NextLectureHall;
                exit(true);
            end;
        until NextTimeSlot.Next() = 0;
        //if still not successful, try next lecture hall with a random time slot that is free three times
        for i := 1 to NextTimeSlot.Count do begin
            //get a random time slot
            TimeSlot.Reset();
            TimeSlot.FindSet(false, false);
            TimeSlot.Next(Random(TimeSlot.Count));
            if FindAvailableTimeSlot(CourseOffering, NextLectureHall."Lecture Room Code", TimeSlot, Semester) then begin
                LectureHall := NextLectureHall;
                exit(true);
            end;
        end;

        exit(false);
    end;

    local procedure LogSchedulingIssue(CourseOffering: Record "ACA-Lecturers Units")
    var
        SchedulingIssue: Record "Scheduling Issue";
    begin
        SchedulingIssue.Init();
        SchedulingIssue."Course Code" := CourseOffering.Unit;
        SchedulingIssue."Programme" := CourseOffering.Programme;
        SchedulingIssue."Lecturer Code" := CourseOffering.Lecturer;
        SchedulingIssue."Issue Description" := 'Unable to schedule course offering';
        SchedulingIssue.Insert();
    end;

    local procedure IsRoomBooked(AcademicYear: Code[20]; LectureHallCode: Code[20]; TimeSlotCode: Code[20]; Semester: Code[25]; Stage: Code[20]): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
    begin
        TimetableEntry.Reset();
        TimetableEntry.SetRange("Lecture Hall Code", LectureHallCode);
        TimetableEntry.SetRange("Time Slot Code", TimeSlotCode);
        TimetableEntry.SetRange(Semester, Semester);
        exit(not TimetableEntry.IsEmpty);
    end;

    procedure EnableLabsForExam(): Boolean
    var
        TtSetup: Record "Timetable Setup";
    begin
        TtSetup.Get();
        exit(TtSetup."Enable Labs for Exam");
    end;

    procedure GetMaxStudentsPerClass(var CourseOffering: Record "ACA-Lecturers Units"): Integer
    var
        TtSetup: Record "Timetable Setup";
    begin
        TtSetup.Get();
        CourseOffering.CalcFields("Timetable Category");
        case
            CourseOffering."Timetable Category" of
            courseoffering."Timetable Category"::"Non-STEM":
                exit(TtSetup."Maximum Students (Non-STEM)");
            courseoffering."Timetable Category"::"STEM":
                exit(TtSetup."Maximum Students (STEM)");
        end;
    end;

    local procedure AssignBalancedTimeAndLocationNew(var CourseOffering: Record "ACA-Lecturers Units";
       var DaysPerWeek: array[5] of Integer): Boolean
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        LabLectureHall: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Time Slot";
        LabTimeSlot: Record "Time Slot";
        TimetableEntry: Record "Timetable Entry";
        LeastBusyDay: Integer;
        SecondLeastBusyDay: Integer;
        TimetableSetup: Record "Timetable Setup";
        MaxStudentsPerClass: Integer;
        StudentCount: Integer;
        SecondLectureHall: Record "ACA-Lecturer Halls Setup";
        SecondTimeSlot: Record "Time Slot";
        RequiresSplit: Boolean;
        FirstGroupSize: Integer;
        SecondGroupSize: Integer;
        SplitForPractical: Boolean;
        TheoryHours: Integer;
        PracticalHours: Integer;
        FirstDayBusyLevel: array[5] of Integer;
        IsOnlinePreferredUnit: Boolean;
        YearOfStudy: Integer;
    begin
        TimetableSetup.Get();
        StudentCount := CourseOffering."Student Allocation";
        MaxStudentsPerClass := GetMaxStudentsPerClass(CourseOffering);

        // Check if unit is preferred for online teaching
        YearOfStudy := GetYearOfStudyFromStage(CourseOffering.Stage);
        IsOnlinePreferredUnit := IsUnitInOnlinePreferences(CourseOffering.Unit, YearOfStudy);

        // Check if class needs to be split due to student count
        RequiresSplit := (StudentCount >= (MaxStudentsPerClass + 4));

        // Check if unit hours need to be split into theory and practical
        SplitForPractical := (CourseOffering."Time Table Hours" > 3);  // Using your threshold of 3

        // If we need to split, determine theory and practical hours
        if SplitForPractical then begin
            TheoryHours := 2;  // 2 hours for theory
            PracticalHours := CourseOffering."Time Table Hours" - TheoryHours;  // Remaining for practical
        end;

        if RequiresSplit then begin
            // Calculate group sizes - divide students into two groups
            FirstGroupSize := Round(StudentCount / 2, 1, '<');  // First half (round down)
            SecondGroupSize := StudentCount - FirstGroupSize;   // Second half
        end;

        // Copy the days per week array to track busy level for first day assignment
        CopyArray(FirstDayBusyLevel, DaysPerWeek);

        // Find least busy day for first session
        LeastBusyDay := GetLeastBusyDay(FirstDayBusyLevel);

        // If this is an online preferred unit, assign an online venue
        if IsOnlinePreferredUnit then begin
            // Find a suitable time slot
            if FindBalancedTimeSlot(CourseOffering, '', TimeSlot, CourseOffering.Semester, LeastBusyDay) then begin
                // Create online session timetable entry
                if CreateOnlineSessionEntry(CourseOffering, TimeSlot, LeastBusyDay) then begin
                    DaysPerWeek[LeastBusyDay] += 1;

                    // If this is a practical unit, we still need to schedule a physical practical session
                    if SplitForPractical then begin
                        // Find the second least busy day for practical session
                        DaysPerWeek[LeastBusyDay] := 99999; // Make first day extremely busy to avoid selecting it again
                        SecondLeastBusyDay := GetLeastBusyDay(DaysPerWeek);
                        DaysPerWeek[LeastBusyDay] := FirstDayBusyLevel[LeastBusyDay] + 1; // Restore original value plus one

                        // Find a lab with matching equipment for practical
                        LabLectureHall.Reset();
                        LabLectureHall.SetRange(Status, LabLectureHall.Status::Active);
                        LabLectureHall.SetRange("Hall Category", LabLectureHall."Hall Category"::Lab);  // Explicitly for labs
                        LabLectureHall.SetFilter("Sitting Capacity", '>=%1', StudentCount);
                        LabLectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

                        if LabLectureHall.FindSet() then begin
                            if FindBalancedTimeSlot(CourseOffering, LabLectureHall."Lecture Room Code", LabTimeSlot,
                                CourseOffering.Semester, SecondLeastBusyDay) then begin

                                // Create practical session timetable entry
                                TimetableEntry.Init();
                                TimetableEntry."Unit Code" := CourseOffering.Unit;
                                TimetableEntry.Semester := CourseOffering.Semester;
                                TimetableEntry."Lecture Hall Code" := LabLectureHall."Lecture Room Code";
                                TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                                TimetableEntry."Time Slot Code" := LabTimeSlot.Code;
                                TimetableEntry."Day of Week" := LabTimeSlot."Day of Week";
                                TimetableEntry."Start Time" := LabTimeSlot."Start Time";
                                TimetableEntry."End Time" := LabTimeSlot."End Time";
                                TimetableEntry."Duration (Hours)" := PracticalHours;
                                TimetableEntry."Programme Code" := CourseOffering.Programme;
                                TimetableEntry."Stage Code" := CourseOffering.Stage;
                                TimetableEntry.Type := TimetableEntry.Type::Class;
                                TimetableEntry."Session Type" := TimetableEntry."Session Type"::Practical;

                                if TimetableEntry.Insert() then
                                    DaysPerWeek[SecondLeastBusyDay] += 1;
                            end;
                        end;
                    end;

                    exit(true);
                end;
            end;
        end;

        // Find suitable lecture hall(s) for theory/regular sessions
        // IMPORTANT: Explicitly exclude labs for non-practical sessions and theory sessions
        LectureHall.Reset();
        LectureHall.SetRange(Status, LectureHall.Status::Active);

        // Always exclude lab rooms for theory/regular classes
        LectureHall.SetFilter("Hall Category", '<>%1', LectureHall."Hall Category"::Lab);

        if RequiresSplit then
            LectureHall.SetFilter("Sitting Capacity", '>=%1', FirstGroupSize)
        else
            LectureHall.SetFilter("Sitting Capacity", '>=%1', StudentCount);

        if LectureHall.FindSet() then begin
            repeat
                // Find a time slot on the least busy day
                if FindBalancedTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot,
                    CourseOffering.Semester, LeastBusyDay) then begin

                    // Create timetable entry for first session (or theory if splitting for practical)
                    TimetableEntry.Init();
                    TimetableEntry."Unit Code" := CourseOffering.Unit;
                    TimetableEntry.Semester := CourseOffering.Semester;
                    TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
                    TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                    TimetableEntry."Time Slot Code" := TimeSlot.Code;
                    TimetableEntry."Day of Week" := TimeSlot."Day of Week";
                    TimetableEntry."Start Time" := TimeSlot."Start Time";
                    TimetableEntry."End Time" := TimeSlot."End Time";

                    // Set the duration based on whether this is theory or full course
                    if SplitForPractical then
                        TimetableEntry."Duration (Hours)" := TheoryHours
                    else
                        TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";

                    TimetableEntry."Programme Code" := CourseOffering.Programme;
                    TimetableEntry."Stage Code" := CourseOffering.Stage;
                    TimetableEntry.Type := TimetableEntry.Type::Class;

                    // If splitting due to student count, mark as group 1
                    if RequiresSplit then
                        TimetableEntry."Group No" := 1;

                    // If splitting for practical, mark as theory session
                    if SplitForPractical then
                        TimetableEntry."Session Type" := TimetableEntry."Session Type"::Theory
                    else
                        TimetableEntry."Session Type" := TimetableEntry."Session Type"::Regular;  // Explicitly mark as regular

                    if TimetableEntry.Insert() then begin
                        // Update busy level for this day
                        DaysPerWeek[LeastBusyDay] += 1;

                        // Handle second session based on which type of split we're doing
                        if RequiresSplit and not SplitForPractical then begin
                            // Handle student count split (original logic)
                            if FindSecondTimeSlotAndRoom(CourseOffering, TimeSlot, SecondGroupSize, SecondTimeSlot, SecondLectureHall) then
                                if CreateSecondClassGroup(CourseOffering, SecondTimeSlot, SecondLectureHall, 2) then begin
                                    if (SecondTimeSlot."Day of Week" >= 1) and (SecondTimeSlot."Day of Week" < 5) then
                                        DaysPerWeek[SecondTimeSlot."Day of Week"] += 1;
                                end;
                        end;

                        // If we need to schedule a practical session
                        if SplitForPractical then begin
                            // Find the second least busy day for practical session
                            DaysPerWeek[LeastBusyDay] := 99999; // Make first day extremely busy to avoid selecting it again
                            SecondLeastBusyDay := GetLeastBusyDay(DaysPerWeek);
                            DaysPerWeek[LeastBusyDay] := FirstDayBusyLevel[LeastBusyDay] + 1; // Restore original value plus one

                            // Find a lab with matching equipment for practical
                            LabLectureHall.Reset();
                            LabLectureHall.SetRange(Status, LabLectureHall.Status::Active);
                            LabLectureHall.SetRange("Hall Category", LabLectureHall."Hall Category"::Lab);  // Explicitly for labs
                            LabLectureHall.SetFilter("Sitting Capacity", '>=%1', StudentCount);
                            LabLectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

                            if LabLectureHall.FindSet() then begin
                                if FindBalancedTimeSlot(CourseOffering, LabLectureHall."Lecture Room Code", LabTimeSlot,
                                    CourseOffering.Semester, SecondLeastBusyDay) then begin

                                    // Create practical session timetable entry
                                    TimetableEntry.Init();
                                    TimetableEntry."Unit Code" := CourseOffering.Unit;
                                    TimetableEntry.Semester := CourseOffering.Semester;
                                    TimetableEntry."Lecture Hall Code" := LabLectureHall."Lecture Room Code";
                                    TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                                    TimetableEntry."Time Slot Code" := LabTimeSlot.Code;
                                    TimetableEntry."Day of Week" := LabTimeSlot."Day of Week";
                                    TimetableEntry."Start Time" := LabTimeSlot."Start Time";
                                    TimetableEntry."End Time" := LabTimeSlot."End Time";
                                    TimetableEntry."Duration (Hours)" := PracticalHours;
                                    TimetableEntry."Programme Code" := CourseOffering.Programme;
                                    TimetableEntry."Stage Code" := CourseOffering.Stage;
                                    TimetableEntry.Type := TimetableEntry.Type::Class;
                                    TimetableEntry."Session Type" := TimetableEntry."Session Type"::Practical;  // Explicitly mark as practical

                                    if TimetableEntry.Insert() then
                                        DaysPerWeek[SecondLeastBusyDay] += 1;
                                end;
                            end;
                        end;

                        exit(true);
                    end;
                end;
            until LectureHall.Next() = 0;
        end;

        exit(false);
    end;

    // Helper function to copy an array (already in your code)
    local procedure CopyArray(var Target: array[5] of Integer; Source: array[5] of Integer)
    var
        i: Integer;
    begin
        for i := 1 to 5 do
            Target[i] := Source[i];
    end;

    // NEW: Helper function to check if a unit is in online preferences
    local procedure IsUnitInOnlinePreferences(UnitCode: Code[20]; YearOfStudy: Integer): Boolean
    var
        OnlineClassPreference: Record "Online Class Preference";
    begin
        OnlineClassPreference.Reset();
        OnlineClassPreference.SetRange("Unit Code", UnitCode);
        OnlineClassPreference.SetRange("Year of Study", YearOfStudy);
        exit(not OnlineClassPreference.IsEmpty);
    end;

    // NEW: Helper function to extract year of study from stage code
    local procedure GetYearOfStudyFromStage(StageCode: Code[20]): Integer
    var
        YearStr: Text;
        YearValue: Integer;
    begin
        // Extract number after 'Y' and before 'S'
        // For format like 'Y1S1', this will extract '1'
        if StageCode = '' then
            exit(0);

        if StrPos(StageCode, 'Y') = 0 then
            exit(0);

        if StrPos(StageCode, 'S') = 0 then
            exit(0);

        YearStr := CopyStr(StageCode, 2, StrPos(StageCode, 'S') - 2);

        if Evaluate(YearValue, YearStr) then
            exit(YearValue);

        exit(0);
    end;

    // NEW: Create an online session timetable entry
    local procedure CreateOnlineSessionEntry(CourseOffering: Record "ACA-Lecturers Units";
        TimeSlot: Record "Time Slot"; DayOfWeek: Integer): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
        VirtualRoom: Record "ACA-Lecturer Halls Setup";
    begin
        // Find a virtual room
        VirtualRoom.Reset();
        VirtualRoom.SetRange("Hall Category", VirtualRoom."Hall Category"::Online);  // Using Hall Category for consistency
        VirtualRoom.SetRange(Status, VirtualRoom.Status::Active);

        if not VirtualRoom.FindFirst() then begin
            // If no specific virtual room exists, use a default online room code
            TimetableEntry.Init();
            TimetableEntry."Unit Code" := CourseOffering.Unit;
            TimetableEntry.Semester := CourseOffering.Semester;
            TimetableEntry."Lecture Hall Code" := 'ONLINE'; // Default online venue
            TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
            TimetableEntry."Time Slot Code" := TimeSlot.Code;
            TimetableEntry."Day of Week" := TimeSlot."Day of Week";
            TimetableEntry."Start Time" := TimeSlot."Start Time";
            TimetableEntry."End Time" := TimeSlot."End Time";
            TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";
            TimetableEntry."Programme Code" := CourseOffering.Programme;
            TimetableEntry."Stage Code" := CourseOffering.Stage;
            TimetableEntry.Type := TimetableEntry.Type::Class;
            TimetableEntry."Session Type" := TimetableEntry."Session Type"::Online;
            exit(TimetableEntry.Insert());
        end else begin
            // Use the found virtual room
            TimetableEntry.Init();
            TimetableEntry."Unit Code" := CourseOffering.Unit;
            TimetableEntry.Semester := CourseOffering.Semester;
            TimetableEntry."Lecture Hall Code" := VirtualRoom."Lecture Room Code";
            TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
            TimetableEntry."Time Slot Code" := TimeSlot.Code;
            TimetableEntry."Day of Week" := TimeSlot."Day of Week";
            TimetableEntry."Start Time" := TimeSlot."Start Time";
            TimetableEntry."End Time" := TimeSlot."End Time";
            TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";
            TimetableEntry."Programme Code" := CourseOffering.Programme;
            TimetableEntry."Stage Code" := CourseOffering.Stage;
            TimetableEntry.Type := TimetableEntry.Type::Class;
            TimetableEntry."Session Type" := TimetableEntry."Session Type"::Online;
            exit(TimetableEntry.Insert());
        end;
    end;

    local procedure AssignBalancedTimeAndLocation(var CourseOffering: Record "ACA-Lecturers Units";
       var DaysPerWeek: array[5] of Integer): Boolean
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        LabRoom: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Time Slot";
        PracticalTimeSlot: Record "Time Slot";
        TimetableEntry: Record "Timetable Entry";
        LeastBusyDay: Integer;
        SecondLeastBusyDay: Integer;
        TimetableSetup: Record "Timetable Setup";
        MaxStudentsPerClass: Integer;
        StudentCount: Integer;
        SecondLectureHall: Record "ACA-Lecturer Halls Setup";
        SecondTimeSlot: Record "Time Slot";
        RequiresSplit: Boolean;
        FirstGroupSize: Integer;
        SecondGroupSize: Integer;
        RequiresPractical: Boolean;
    begin
        TimetableSetup.Get();
        StudentCount := CourseOffering."Student Allocation";
        MaxStudentsPerClass := GetMaxStudentsPerClass(CourseOffering);

        // Check if class needs to be split by student count
        RequiresSplit := (StudentCount >= (MaxStudentsPerClass + 4));

        // Check if unit requires theory and practical split (more than 5 hours)
        RequiresPractical := (CourseOffering."Time Table Hours" > 3);

        if RequiresSplit then begin
            // Calculate group sizes - divide students into two groups
            FirstGroupSize := Round(StudentCount / 2, 1, '<');  // First half (round down)
            SecondGroupSize := StudentCount - FirstGroupSize;   // Second half
        end;

        // Find suitable lecture hall(s)
        LectureHall.Reset();
        LectureHall.SetRange(Status, LectureHall.Status::Active);
        if RequiresSplit then
            LectureHall.SetFilter("Sitting Capacity", '>=%1', FirstGroupSize)
        else
            LectureHall.SetFilter("Sitting Capacity", '>=%1', StudentCount);
        if not RequiresPractical then
            LectureHall.SetFilter("Hall Category", '<>%1', LectureHall."Hall Category"::Lab);

        //LectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

        if RequiresPractical then begin
            exit(HandleTheoryPracticalUnit(CourseOffering, DaysPerWeek, RequiresSplit, FirstGroupSize, SecondGroupSize));
        end;

        if LectureHall.FindSet() then
            repeat
                // Find least busy day
                LeastBusyDay := GetLeastBusyDay(DaysPerWeek);

                if FindBalancedTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot,
                    CourseOffering.Semester, LeastBusyDay) then begin

                    // Create timetable entry for first group
                    TimetableEntry.Init();
                    TimetableEntry."Unit Code" := CourseOffering.Unit;
                    TimetableEntry.Semester := CourseOffering.Semester;
                    TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
                    TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                    TimetableEntry."Time Slot Code" := TimeSlot.Code;
                    TimetableEntry."Day of Week" := TimeSlot."Day of Week";
                    TimetableEntry."Start Time" := TimeSlot."Start Time";
                    TimetableEntry."End Time" := TimeSlot."End Time";
                    TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";
                    TimetableEntry."Programme Code" := CourseOffering.Programme;
                    TimetableEntry."Stage Code" := CourseOffering.Stage;
                    TimetableEntry.Type := TimetableEntry.Type::Class;
                    if RequiresSplit then
                        TimetableEntry."Group No" := 1;
                    if TimetableEntry.Insert() then begin
                        DaysPerWeek[LeastBusyDay] += 1;
                        // If we need to split the class, create a second entry with a different timeslot
                        if RequiresSplit then
                            if FindSecondTimeSlotAndRoom(CourseOffering, TimeSlot, SecondGroupSize, SecondTimeSlot, SecondLectureHall) then
                                if CreateSecondClassGroup(CourseOffering, SecondTimeSlot, SecondLectureHall, 2) then begin
                                    // Only update DaysPerWeek if the day is within valid range (1-5)
                                    if (SecondTimeSlot."Day of Week" >= 1) and (SecondTimeSlot."Day of Week" <= 5) then
                                        DaysPerWeek[SecondTimeSlot."Day of Week"] += 1;
                                end;

                        exit(true);
                    end;
                end;
            until LectureHall.Next() = 0;

        exit(false);
    end;


    // New procedure to handle units with theory and practical components
    local procedure HandleTheoryPracticalUnit(
        var CourseOffering: Record "ACA-Lecturers Units";
        var DaysPerWeek: array[5] of Integer;
        RequiresSplit: Boolean;
        FirstGroupSize: Integer;
        SecondGroupSize: Integer): Boolean
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        LabRoom: Record "ACA-Lecturer Halls Setup";
        TheoryTimeSlot: Record "Time Slot";
        PracticalTimeSlot: Record "Time Slot";
        TimetableEntry: Record "Timetable Entry";
        LeastBusyDay: Integer;
        SecondLeastBusyDay: Integer;
        DaysUsage: array[5] of Integer;
        i: Integer;
        SlotInt: Integer;
    begin
        // Copy the current days usage
        for i := 1 to 5 do begin
            DaysUsage[i] := DaysPerWeek[i];
            i += 1;
        end;


        // Find suitable lecture hall for theory
        LectureHall.Reset();
        LectureHall.SetRange(Status, LectureHall.Status::Active);
        LectureHall.SetRange("Hall Category", LectureHall."Hall Category"::Normal);
        if RequiresSplit then
            LectureHall.SetFilter("Sitting Capacity", '>=%1', FirstGroupSize)
        else
            LectureHall.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Student Allocation");

        // Find suitable lab for practical with required equipment
        LabRoom.Reset();
        LabRoom.SetRange(Status, LabRoom.Status::Active);
        if RequiresSplit then
            LabRoom.SetFilter("Sitting Capacity", '>=%1', FirstGroupSize)
        else
            LabRoom.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Student Allocation");

        // Make sure lab has the required equipment
        LabRoom.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');
        LabRoom.SetRange("Hall Category", LabRoom."Hall Category"::Lab);

        if not (LectureHall.FindSet() and LabRoom.FindSet()) then
            exit(false);  // No suitable lecture hall or lab found

        // Find least busy day for theory session
        LeastBusyDay := GetLeastBusyDay(DaysUsage);

        // Try to find available time slot for theory session
        if not FindBalancedTimeSlot(CourseOffering, LectureHall."Lecture Room Code",
                TheoryTimeSlot, CourseOffering.Semester, LeastBusyDay) then
            exit(false);

        // Create timetable entry for theory session
        TimetableEntry.Init();
        TimetableEntry."Unit Code" := CourseOffering.Unit;
        TimetableEntry.Semester := CourseOffering.Semester;
        TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
        TimetableEntry."Time Slot Code" := TheoryTimeSlot.Code;
        TimetableEntry."Day of Week" := TheoryTimeSlot."Day of Week";
        TimetableEntry."Start Time" := TheoryTimeSlot."Start Time";
        TimetableEntry."End Time" := TheoryTimeSlot."End Time";
        TimetableEntry."Duration (Hours)" := 2; // 2 hours for theory
        TimetableEntry."Programme Code" := CourseOffering.Programme;
        TimetableEntry."Stage Code" := CourseOffering.Stage;
        TimetableEntry.Type := TimetableEntry.Type::Theory;
        if RequiresSplit then
            TimetableEntry."Group No" := 1;
        if not TimetableEntry.Insert() then
            exit(false);

        // Update the days usage
        if (TheoryTimeSlot."Day of Week".AsInteger() >= 0) and (TheoryTimeSlot."Day of Week".AsInteger() < 5) then
            DaysUsage[TheoryTimeSlot."Day of Week".AsInteger() + 1] += 1;
        SlotInt := TheoryTimeSlot."Day of Week".AsInteger() + 1;

        // Mark the theory day as very busy to avoid selecting it again for practical
        DaysUsage[SlotInt] := 99999;

        // Find least busy day for practical session (different from theory day)
        SecondLeastBusyDay := GetLeastBusyDay(DaysUsage);

        // Try to find available time slot for practical session
        if not FindBalancedTimeSlot(CourseOffering, LabRoom."Lecture Room Code",
                PracticalTimeSlot, CourseOffering.Semester, SecondLeastBusyDay) then
            exit(false);

        // Create timetable entry for practical session
        TimetableEntry.Init();
        TimetableEntry."Unit Code" := CourseOffering.Unit;
        TimetableEntry.Semester := CourseOffering.Semester;
        TimetableEntry."Lecture Hall Code" := LabRoom."Lecture Room Code";
        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
        TimetableEntry."Time Slot Code" := PracticalTimeSlot.Code;
        TimetableEntry."Day of Week" := PracticalTimeSlot."Day of Week";
        TimetableEntry."Start Time" := PracticalTimeSlot."Start Time";
        TimetableEntry."End Time" := PracticalTimeSlot."End Time";
        TimetableEntry."Duration (Hours)" := 3; // 3 hours for practical
        TimetableEntry."Programme Code" := CourseOffering.Programme;
        TimetableEntry."Stage Code" := CourseOffering.Stage;
        TimetableEntry.Type := TimetableEntry.Type::Practical;
        if RequiresSplit then
            TimetableEntry."Group No" := 1;
        if not TimetableEntry.Insert() then
            exit(false);

        // Update the real days usage for both sessions
        if (TheoryTimeSlot."Day of Week" >= 1) and (TheoryTimeSlot."Day of Week" < 5) then
            DaysPerWeek[TheoryTimeSlot."Day of Week"] += 1;
        if (PracticalTimeSlot."Day of Week" >= 1) and (PracticalTimeSlot."Day of Week" < 5) then
            DaysPerWeek[PracticalTimeSlot."Day of Week"] += 1;

        // If we need to split the class by student count, handle second group
        if RequiresSplit then
            HandleSecondGroupTheoryPractical(CourseOffering, DaysPerWeek,
                TheoryTimeSlot, PracticalTimeSlot, LectureHall, LabRoom, SecondGroupSize);

        exit(true);
    end;

    // Handle split classes for theory/practical units
    local procedure HandleSecondGroupTheoryPractical(
        var CourseOffering: Record "ACA-Lecturers Units";
        var DaysPerWeek: array[5] of Integer;
        TheoryTimeSlot: Record "Time Slot";
        PracticalTimeSlot: Record "Time Slot";
        TheoryRoom: Record "ACA-Lecturer Halls Setup";
        PracticalRoom: Record "ACA-Lecturer Halls Setup";
        SecondGroupSize: Integer): Boolean
    var
        SecondTheoryTimeSlot: Record "Time Slot";
        SecondPracticalTimeSlot: Record "Time Slot";
        SecondTheoryRoom: Record "ACA-Lecturer Halls Setup";
        SecondPracticalRoom: Record "ACA-Lecturer Halls Setup";
        TimetableEntry: Record "Timetable Entry";
    begin
        // Find alternative time slots and rooms for second group
        if not FindSecondTimeSlotAndRoom(CourseOffering, TheoryTimeSlot, SecondGroupSize,
                SecondTheoryTimeSlot, SecondTheoryRoom) then
            exit(false);

        if not FindSecondTimeSlotAndRoom(CourseOffering, PracticalTimeSlot, SecondGroupSize,
                SecondPracticalTimeSlot, SecondPracticalRoom) then
            exit(false);

        // Create theory entry for second group
        TimetableEntry.Init();
        TimetableEntry."Unit Code" := CourseOffering.Unit;
        TimetableEntry.Semester := CourseOffering.Semester;
        TimetableEntry."Lecture Hall Code" := SecondTheoryRoom."Lecture Room Code";
        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
        TimetableEntry."Time Slot Code" := SecondTheoryTimeSlot.Code;
        TimetableEntry."Day of Week" := SecondTheoryTimeSlot."Day of Week";
        TimetableEntry."Start Time" := SecondTheoryTimeSlot."Start Time";
        TimetableEntry."End Time" := SecondTheoryTimeSlot."End Time";
        TimetableEntry."Duration (Hours)" := 2; // 2 hours for theory
        TimetableEntry."Programme Code" := CourseOffering.Programme;
        TimetableEntry."Stage Code" := CourseOffering.Stage;
        TimetableEntry.Type := TimetableEntry.Type::Theory;
        TimetableEntry."Group No" := 2;
        if not TimetableEntry.Insert() then
            exit(false);

        // Create practical entry for second group
        TimetableEntry.Init();
        TimetableEntry."Unit Code" := CourseOffering.Unit;
        TimetableEntry.Semester := CourseOffering.Semester;
        TimetableEntry."Lecture Hall Code" := SecondPracticalRoom."Lecture Room Code";
        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
        TimetableEntry."Time Slot Code" := SecondPracticalTimeSlot.Code;
        TimetableEntry."Day of Week" := SecondPracticalTimeSlot."Day of Week";
        TimetableEntry."Start Time" := SecondPracticalTimeSlot."Start Time";
        TimetableEntry."End Time" := SecondPracticalTimeSlot."End Time";
        TimetableEntry."Duration (Hours)" := 3; // 3 hours for practical
        TimetableEntry."Programme Code" := CourseOffering.Programme;
        TimetableEntry."Stage Code" := CourseOffering.Stage;
        TimetableEntry.Type := TimetableEntry.Type::Practical;
        TimetableEntry."Group No" := 2;
        if not TimetableEntry.Insert() then
            exit(false);

        // Update days usage for both sessions
        if (SecondTheoryTimeSlot."Day of Week" >= 1) and (SecondTheoryTimeSlot."Day of Week" <= 5) then
            DaysPerWeek[SecondTheoryTimeSlot."Day of Week"] += 1;
        if (SecondPracticalTimeSlot."Day of Week" >= 1) and (SecondPracticalTimeSlot."Day of Week" <= 5) then
            DaysPerWeek[SecondPracticalTimeSlot."Day of Week"] += 1;

        exit(true);
    end;

    local procedure GetLeastBusyDay(DaysPerWeek: array[5] of Integer): Integer
    var
        i: Integer;
        MinValue: Integer;
        LeastBusyDay: Integer;
    begin
        MinValue := 99999;
        for i := 1 to 5 do
            if DaysPerWeek[i] < MinValue then begin
                MinValue := DaysPerWeek[i];
                LeastBusyDay := i;
            end;
        exit(LeastBusyDay);
    end;

    local procedure FindSecondTimeSlotAndRoom(
        CourseOffering: Record "ACA-Lecturers Units";
        FirstTimeSlot: Record "Time Slot";
        RequiredCapacity: Integer;
        var FoundTimeSlot: Record "Time Slot";
        var FoundLectureHall: Record "ACA-Lecturer Halls Setup"): Boolean
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Time Slot";
        SecondLeastBusyDay: Integer;
        DaysPerWeek: array[5] of Integer;
        TimetableEntry: Record "Timetable Entry";
        i: Integer;
        PreferredDay: Integer;
        DayOfWeek: Integer;
    begin
        // Calculate the days usage for balancing
        TimetableEntry.Reset();
        TimetableEntry.SetRange("Lecturer Code", CourseOffering.Lecturer);
        TimetableEntry.SetRange(Semester, CourseOffering.Semester);
        if TimetableEntry.FindSet() then
            repeat
                DayOfWeek := TimetableEntry."Day of Week";
                // Make sure we only access array elements within range 1-5
                if (DayOfWeek >= 1) and (DayOfWeek < 5) then
                    DaysPerWeek[DayOfWeek] += 1;
            until TimetableEntry.Next() = 0;

        // Find least busy day excluding the day of the first time slot
        PreferredDay := FirstTimeSlot."Day of Week";

        // Make sure preferred day is within valid range (1-5)
        if (PreferredDay < 1) or (PreferredDay > 5) then
            PreferredDay := 1;  // Default to Monday if out of range

        // Mark the day of the first slot as very busy to avoid selecting it
        DaysPerWeek[PreferredDay] := 99999;

        // Find the next least busy day
        SecondLeastBusyDay := GetLeastBusyDay(DaysPerWeek);

        // First try to find a room and timeslot on a different day
        LectureHall.Reset();
        LectureHall.SetFilter("Sitting Capacity", '>=%1', RequiredCapacity);
        LectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

        if LectureHall.FindSet() then begin
            repeat
                // Try to find a timeslot for this lecture hall on the second least busy day
                if FindBalancedTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot,
                    CourseOffering.Semester, SecondLeastBusyDay) then begin
                    // Make sure this is not the same timeslot as the first group
                    if TimeSlot.Code <> FirstTimeSlot.Code then begin
                        // Make sure lecturer is not busy at this time
                        if not IsLecturerBusy(CourseOffering.Lecturer, CourseOffering."Academic Year",
                            TimeSlot.Code, CourseOffering.Semester, CourseOffering.Stage) then begin
                            FoundTimeSlot := TimeSlot;
                            FoundLectureHall := LectureHall;
                            exit(true);
                        end;
                    end;
                end;
            until LectureHall.Next() = 0;

            // If we couldn't find a suitable slot on the preferred day, try other days
            for i := 1 to 5 do begin
                if i <> PreferredDay then begin
                    LectureHall.Reset();
                    LectureHall.SetFilter("Sitting Capacity", '>=%1', RequiredCapacity);
                    LectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');
                    if LectureHall.FindSet() then begin
                        repeat
                            if FindBalancedTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot,
                                CourseOffering.Semester, i) then begin
                                // Make sure lecturer is not busy at this time
                                if not IsLecturerBusy(CourseOffering.Lecturer, CourseOffering."Academic Year",
                                    TimeSlot.Code, CourseOffering.Semester, CourseOffering.Stage) then begin
                                    FoundTimeSlot := TimeSlot;
                                    FoundLectureHall := LectureHall;
                                    exit(true);
                                end;
                            end;
                        until LectureHall.Next() = 0;
                    end;
                end;
            end;
        end;

        exit(false);
    end;

    local procedure CreateSecondClassGroup(
        CourseOffering: Record "ACA-Lecturers Units";
        TimeSlot: Record "Time Slot";
        LectureHall: Record "ACA-Lecturer Halls Setup";
        GroupNo: Integer): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
    begin
        // Create timetable entry for second group
        TimetableEntry.Init();
        TimetableEntry."Unit Code" := CourseOffering.Unit;
        TimetableEntry.Semester := CourseOffering.Semester;
        TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
        TimetableEntry."Time Slot Code" := TimeSlot.Code;
        TimetableEntry."Day of Week" := TimeSlot."Day of Week";
        TimetableEntry."Start Time" := TimeSlot."Start Time";
        TimetableEntry."End Time" := TimeSlot."End Time";
        TimetableEntry."Duration (Hours)" := TimeSlot."Duration (Hours)";
        TimetableEntry."Programme Code" := CourseOffering.Programme;
        TimetableEntry."Stage Code" := CourseOffering.Stage;
        TimetableEntry.Type := TimetableEntry.Type::Class;
        TimetableEntry."Group No" := GroupNo;

        exit(TimetableEntry.Insert());
    end;

    local procedure FindBalancedTimeSlot(CourseOffering: Record "ACA-Lecturers Units";
            LectureHallCode: Code[20]; var AvailableTimeSlot: Record "Time Slot";
            Semester: Code[25]; PreferredDay: Integer): Boolean
    var
        TimeSlot: Record "Time Slot";
        HasAllowConstraints: Boolean;
        HasExemptConstraints: Boolean;
        IsExemptDay: Boolean;
        DayOfWeek: Integer;
    begin
        // Check if the lecturer has any constraints
        HasLecturerConstraints(CourseOffering.Lecturer, Semester, HasAllowConstraints, HasExemptConstraints);

        // If lecturer has "Allow" constraints, check those day preferences first
        if HasAllowConstraints then begin
            // Try to find time slots on allowed days first
            TimeSlot.Reset();
            if TimeSlot.FindSet() then
                repeat
                    DayOfWeek := TimeSlot."Day of Week";
                    if IsAllowedDay(CourseOffering.Lecturer, Semester, DayOfWeek) then
                        if IsTimeSlotAvailable(CourseOffering, LectureHallCode, TimeSlot, Semester) then begin
                            AvailableTimeSlot := TimeSlot;
                            exit(true);
                        end;
                until TimeSlot.Next() = 0;
        end;

        // If no "Allow" constraints or no match found, try preferred day
        TimeSlot.Reset();
        TimeSlot.SetRange("Day of Week", PreferredDay);

        if TimeSlot.FindSet() then
            repeat
                // Skip if day is exempt for this lecturer
                IsExemptDay := false;
                if HasExemptConstraints then
                    IsExemptDay := IsExemptDay(CourseOffering.Lecturer, Semester, TimeSlot."Day of Week");

                if not IsExemptDay then
                    if IsTimeSlotAvailable(CourseOffering, LectureHallCode, TimeSlot, Semester) then begin
                        AvailableTimeSlot := TimeSlot;
                        exit(true);
                    end;
            until TimeSlot.Next() = 0;

        // If no slot found on preferred day, try other non-exempt days
        TimeSlot.Reset();
        if TimeSlot.FindSet() then
            repeat
                if TimeSlot."Day of Week" <> PreferredDay then begin  // Skip the day we already checked
                    // Skip if day is exempt for this lecturer
                    IsExemptDay := false;
                    if HasExemptConstraints then
                        IsExemptDay := IsExemptDay(CourseOffering.Lecturer, Semester, TimeSlot."Day of Week");

                    if not IsExemptDay then
                        if IsTimeSlotAvailable(CourseOffering, LectureHallCode, TimeSlot, Semester) then begin
                            AvailableTimeSlot := TimeSlot;
                            exit(true);
                        end;
                end;
            until TimeSlot.Next() = 0;

        // If still no slot found and we have exempt constraints, try the exempt days as last resort
        if HasExemptConstraints then begin
            TimeSlot.Reset();
            if TimeSlot.FindSet() then
                repeat
                    if IsExemptDay(CourseOffering.Lecturer, Semester, TimeSlot."Day of Week") then
                        if IsTimeSlotAvailable(CourseOffering, LectureHallCode, TimeSlot, Semester) then begin
                            AvailableTimeSlot := TimeSlot;
                            exit(true);
                        end;
                until TimeSlot.Next() = 0;
        end;

        exit(false);
    end;

    local procedure HasLecturerConstraints(LecturerNo: Code[25]; Semester: Code[25];
            var HasAllowConstraints: Boolean; var HasExemptConstraints: Boolean): Boolean
    var
        LecturerConstraints: Record "Lecturer Timetable Constraints";
    begin
        Clear(HasAllowConstraints);
        Clear(HasExemptConstraints);

        // Check for Allow constraints
        LecturerConstraints.Reset();
        LecturerConstraints.SetRange(Semester, Semester);
        LecturerConstraints.SetRange("Lecturer No.", LecturerNo);
        LecturerConstraints.SetRange("Constraint Type", LecturerConstraints."Constraint Type"::Allow);
        HasAllowConstraints := not LecturerConstraints.IsEmpty;

        // Check for Exempt constraints
        LecturerConstraints.Reset();
        LecturerConstraints.SetRange(Semester, Semester);
        LecturerConstraints.SetRange("Lecturer No.", LecturerNo);
        LecturerConstraints.SetRange("Constraint Type", LecturerConstraints."Constraint Type"::Exempt);
        HasExemptConstraints := not LecturerConstraints.IsEmpty;

        exit(HasAllowConstraints or HasExemptConstraints);
    end;

    local procedure IsAllowedDay(LecturerNo: Code[25]; Semester: Code[25]; DayOfWeek: Integer): Boolean
    var
        LecturerConstraints: Record "Lecturer Timetable Constraints";
    begin
        LecturerConstraints.Reset();
        LecturerConstraints.SetRange(Semester, Semester);
        LecturerConstraints.SetRange("Lecturer No.", LecturerNo);
        LecturerConstraints.SetRange("Constraint Type", LecturerConstraints."Constraint Type"::Allow);
        LecturerConstraints.SetRange("Day of The week", DayOfWeek);
        exit(not LecturerConstraints.IsEmpty);
    end;

    local procedure IsExemptDay(LecturerNo: Code[25]; Semester: Code[25]; DayOfWeek: Integer): Boolean
    var
        LecturerConstraints: Record "Lecturer Timetable Constraints";
    begin
        LecturerConstraints.Reset();
        LecturerConstraints.SetRange(Semester, Semester);
        LecturerConstraints.SetRange("Lecturer No.", LecturerNo);
        LecturerConstraints.SetRange("Constraint Type", LecturerConstraints."Constraint Type"::Exempt);
        LecturerConstraints.SetRange("Day of The week", DayOfWeek);
        exit(not LecturerConstraints.IsEmpty);
    end;

    local procedure IsTimeSlotAvailable(CourseOffering: Record "ACA-Lecturers Units";
        LectureHallCode: Code[20]; TimeSlot: Record "Time Slot"; Semester: Code[25]): Boolean
    begin
        if IsRoomBooked(CourseOffering."Academic Year", LectureHallCode, TimeSlot.Code, Semester, CourseOffering.Stage) then
            exit(false);

        if IsLecturerBusy(CourseOffering.Lecturer, CourseOffering."Academic Year", TimeSlot.Code, Semester, CourseOffering.Stage) then
            exit(false);

        if IsCourseConflict(CourseOffering, TimeSlot.Code, Semester, CourseOffering.Stage) then
            exit(false);

        exit(true);
    end;

    #region Exam Timetable Generation
    procedure GenerateExamTimetable(SemesterCode: Code[25])
    var
        Semester: Record "ACA-Semesters";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        CourseOffering: Record "ACA-Lecturers Units";
        ExamTimeSlot: Record "Exam Time Slot";
        FirstDayUnits: Record "Exam First Day Units";
        ExamDate: Date;
        ProgressWindow: Dialog;
        TotalExams, CurrentExam : Integer;
        DayOfWeek: Integer;
        CoursesPerDay: Dictionary of [Date, Integer];
        DayCounter: Integer;
        MaxAttempts: Integer;
        AttemptCounter: Integer;
        SlotFound: Boolean;
    begin
        // Clear invigilator cache for optimal performance
        ClearInvigilatorCache();

        FindSemester(SemesterCode, Semester);
        Semester.TestField("Exam Start Date");
        Semester.TestField("Exam End Date");

        // Clear existing exam timetable
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
        ExamTimetableEntry.SetRange("Exam Type", ExamTimetableEntry."Exam Type"::Regular);
        ExamTimetableEntry.DeleteAll(true);

        // Get active exam time slots for the semester
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.SetRange(Active, true);
        if not ExamTimeSlot.FindSet() then
            Error('No active exam time slots defined for semester %1', SemesterCode);

        // Get courses with exams
        CourseOffering.Reset();
        CourseOffering.SetRange(Semester, SemesterCode);
        CourseOffering.SetCurrentKey("Time Table Hours");  // Prioritize core units
        TotalExams := CourseOffering.Count();

        ProgressWindow.Open('Scheduling Exams #1### of #2###\' +
                          'Current Unit: #3##################\' +
                          'Current Date: #4##################\' +
                          'Day: #5###');

        // STEP 1: First schedule all units that must be on the first day (priority)
        FirstDayUnits.Reset();
        if FirstDayUnits.FindSet() then begin
            repeat
                CourseOffering.Reset();
                CourseOffering.SetRange(Semester, SemesterCode);
                CourseOffering.SetRange(Unit, FirstDayUnits.Unit);

                if CourseOffering.FindSet() then begin
                    repeat
                        CurrentExam += 1;
                        ProgressWindow.Update(1, CurrentExam);
                        ProgressWindow.Update(2, TotalExams);
                        ProgressWindow.Update(3, CourseOffering.Unit);
                        ProgressWindow.Update(4, Semester."Exam Start Date");
                        ProgressWindow.Update(5, 1);

                        // Find appropriate slot on first day based on programme type (medical vs regular)
                        if ScheduleExamOnFirstDay(CourseOffering, Semester, ExamTimeSlot) then begin
                            // Mark as scheduled
                        end else
                            LogSchedulingIssue(CourseOffering);
                    until CourseOffering.Next() = 0;
                end;
            until FirstDayUnits.Next() = 0;
        end;

        // STEP 2: Schedule remaining units
        DayCounter := 1; // Start from day 2

        CourseOffering.Reset();
        CourseOffering.SetRange(Semester, SemesterCode);
        CourseOffering.SetCurrentKey("Time Table Hours");  // Prioritize core units

        if CourseOffering.FindSet() then begin
            repeat
                // Skip units that have already been scheduled
                if not IsExamAlreadyScheduled(CourseOffering.Unit, CourseOffering.Stage, SemesterCode, CourseOffering.Programme) then begin
                    CurrentExam += 1;
                    Clear(ExamDate);

                    ProgressWindow.Update(1, CurrentExam);
                    ProgressWindow.Update(2, TotalExams);
                    ProgressWindow.Update(3, CourseOffering.Unit);

                    // Find optimal exam date and slot based on programme type
                    // Try to find a slot and room allocation for up to MaxAttempts days
                    MaxAttempts := 10; // Try up to 10 different days
                    AttemptCounter := 0;
                    SlotFound := false;

                    repeat
                        AttemptCounter += 1;

                        if FindOptimalExamSlot(CourseOffering, Semester, ExamTimeSlot, ExamDate, CoursesPerDay, DayCounter) then begin
                            ProgressWindow.Update(4, ExamDate);
                            ProgressWindow.Update(5, DayCounter + 1);

                            // Try to schedule with room allocation
                            if ScheduleExamWithRoomAllocation(
                                CourseOffering,
                                ExamDate,
                                ExamTimeSlot,
                                Semester) then begin
                                // Successfully scheduled
                                SlotFound := true;
                                break;
                            end else begin
                                // Room allocation failed, try next day
                                DayCounter += 1;
                            end;
                        end else begin
                            // No more slots available
                            break;
                        end;
                    until (AttemptCounter >= MaxAttempts) or SlotFound;

                    if not SlotFound then
                        LogSchedulingIssue(CourseOffering);
                end;

            until CourseOffering.Next() = 0;
        end;

        ProgressWindow.Close();

        // Show distribution statistics
        ShowSessionDistributionMessage();
    end;

    local procedure ScheduleExamOnFirstDay(CourseOffering: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
        var ExamTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamDate: Date;
        SelectedTimeSlot: Record "Exam Time Slot";
    begin
        ExamDate := Semester."Exam Start Date";

        // Find appropriate time slot based on programme type
        if FindTimeSlotForProgrammeType(CourseOffering, ExamDate, SelectedTimeSlot) then begin
            // Schedule the exam with room allocation
            ScheduleExamWithRoomAllocation(
                CourseOffering,
                ExamDate,
                SelectedTimeSlot,
                Semester);
            exit(true);
        end;

        exit(false);
    end;

    local procedure ScheduleExamOnFirstDaySupp(SuppUnits: Record "Supp. Exam Units";
        Semester: Record "ACA-Semesters";
        var ExamTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamDate: Date;
        SelectedTimeSlot: Record "Exam Time Slot";
    begin
        ExamDate := Semester."Exam Start Date";

        // Find appropriate time slot based on programme type
        if FindTimeSlotForProgrammeTypeSupp(SuppUnits, ExamDate, SelectedTimeSlot) then begin
            // Schedule the exam with room allocation
            ScheduleExamWithRoomAllocationSupp(
                SuppUnits,
                ExamDate,
                SelectedTimeSlot,
                Semester);
            exit(true);
        end;

        exit(false);
    end;

    local procedure FindTimeSlotForProgrammeType(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        var SelectedTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        IsMedical: Boolean;
    begin
        // Determine if this is a medical programme
        IsMedical := IsMedicalProgramme(CourseOffering.Programme);

        // Find appropriate slot based on programme type
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Valid From Date", ExamDate);
        ExamTimeSlot.SetRange("Valid To Date", ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);

        if IsMedical then
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
        else
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

        if ExamTimeSlot.FindFirst() then begin
            SelectedTimeSlot := ExamTimeSlot;
            exit(true);
        end;

        // Fallback to any available slot if specific group not found
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Valid From Date", ExamDate);
        ExamTimeSlot.SetRange("Valid To Date", ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);

        if ExamTimeSlot.FindFirst() then begin
            SelectedTimeSlot := ExamTimeSlot;
            exit(true);
        end;

        exit(false);
    end;

    local procedure FindTimeSlotForProgrammeTypeSupp(SuppUnits: Record "Supp. Exam Units";
    ExamDate: Date;
    var SelectedTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        IsMedical: Boolean;
    begin
        // Determine if this is a medical programme
        IsMedical := IsMedicalProgramme(SuppUnits.Programme);

        // Find appropriate slot based on programme type
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Valid From Date", ExamDate);
        ExamTimeSlot.SetRange("Valid To Date", ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);

        if IsMedical then
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
        else
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

        if ExamTimeSlot.FindFirst() then begin
            SelectedTimeSlot := ExamTimeSlot;
            exit(true);
        end;

        // Fallback to any available slot if specific group not found
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Valid From Date", ExamDate);
        ExamTimeSlot.SetRange("Valid To Date", ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);

        if ExamTimeSlot.FindFirst() then begin
            SelectedTimeSlot := ExamTimeSlot;
            exit(true);
        end;

        exit(false);
    end;

    local procedure IsMedicalProgramme(ProgrammeCode: Code[25]): Boolean
    var
        Programme: Record "ACA-Programme";
    begin
        Programme.Reset();
        Programme.SetRange(Code, ProgrammeCode);

        if Programme.FindFirst() then
            case
             Programme."Special Programme Class" of
                Programme."Special Programme Class"::"Medicine & Nursing":
                    exit(true);
                else
                    exit(false);
            end;

        exit(false);
    end;


    local procedure IsExamAlreadyScheduledSupp(UnitCode: Code[25]; StageCode: Code[25]; SemesterCode: Code[25]; ProgrammeCode: Code[25]): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Unit Code", UnitCode);
        ExamTimetableEntry.SetRange("Stage Code", StageCode);  // Added stage check
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
        ExamTimetableEntry.SetRange("Programme Code", ProgrammeCode);
        exit(not ExamTimetableEntry.IsEmpty);
    end;


    local procedure FindOptimalExamSlot(CourseOffering: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
        var ExamTimeSlot: Record "Exam Time Slot";
        var OptimalDate: Date;
        var CoursesPerDay: Dictionary of [Date, Integer];
        DayCounter: Integer): Boolean
    var
        IsMedical: Boolean;
        CurrentDate: Date;
        SlotFound: Boolean;
        InitialDayCounter: Integer;
    begin
        // Store initial day counter for looping
        InitialDayCounter := DayCounter;

        // Determine if this is a medical programme
        IsMedical := IsMedicalProgramme(CourseOffering.Programme);

        // Loop through all possible days until the exam end date
        repeat
            // Calculate date based on day counter
            CurrentDate := CalcDate(StrSubstNo('%1D', DayCounter), Semester."Exam Start Date");

            // Break the loop if we've gone beyond exam end date
            if CurrentDate > Semester."Exam End Date" then
                break;

            // Skip weekends AND holidays
            while ((Date2DWY(CurrentDate, 1) > 5) or IsHoliday(CurrentDate)) and (CurrentDate <= Semester."Exam End Date") do begin
                CurrentDate := CalcDate('1D', CurrentDate);
                DayCounter += 1;
            end;

            // Break the loop if we've gone beyond exam end date after skipping weekends and holidays
            if CurrentDate > Semester."Exam End Date" then
                break;

            // Try to find a time slot on this date based on programme type
            SlotFound := FindTimeSlotForDay(CourseOffering, CurrentDate, ExamTimeSlot, IsMedical);

            if SlotFound then begin
                OptimalDate := CurrentDate;

                // Update courses per day counter
                if not CoursesPerDay.ContainsKey(CurrentDate) then
                    CoursesPerDay.Add(CurrentDate, 1)
                else
                    CoursesPerDay.Set(CurrentDate, CoursesPerDay.Get(CurrentDate) + 1);

                exit(true);
            end;

            // Try the next day
            DayCounter += 1;
        until CurrentDate >= Semester."Exam End Date";

        // If we've checked all days and found no slots, return false
        exit(false);
    end;

    local procedure IsExamAlreadyScheduled(UnitCode: Code[25]; StageCode: Code[25]; SemesterCode: Code[25]; ProgrammeCode: Code[25]): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Unit Code", UnitCode);
        ExamTimetableEntry.SetRange("Stage Code", StageCode);
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
        ExamTimetableEntry.SetRange("Programme Code", ProgrammeCode);
        exit(not ExamTimetableEntry.IsEmpty);
    end;

    local procedure FindOptimalExamSlotSupp(SuppUnits: Record "Supp. Exam Units";
         Semester: Record "ACA-Semesters";
         var ExamTimeSlot: Record "Exam Time Slot";
         var OptimalDate: Date;
         var CoursesPerDay: Dictionary of [Date, Integer];
         DayCounter: Integer): Boolean
    var
        IsMedical: Boolean;
        CurrentDate: Date;
        SlotFound: Boolean;
    begin
        // Determine if this is a medical programme
        IsMedical := IsMedicalProgramme(SuppUnits.Programme);

        // Calculate date based on day counter
        CurrentDate := CalcDate(StrSubstNo('%1D', DayCounter), Semester."supp Start Date");

        // Ensure we don't go beyond exam end date
        if CurrentDate > Semester."supp End Date" then
            exit(false);

        // Skip weekends AND holidays
        while ((Date2DWY(CurrentDate, 1) > 5) or IsHoliday(CurrentDate)) and (CurrentDate <= Semester."supp End Date") do begin
            CurrentDate := CalcDate('1D', CurrentDate);
            DayCounter += 1;
        end;

        // If we've gone beyond the exam period, return false
        if CurrentDate > Semester."supp End Date" then
            exit(false);

        // Try to find a time slot on this date based on programme type
        SlotFound := FindTimeSlotForDaySupp(SuppUnits, CurrentDate, ExamTimeSlot, IsMedical);

        if SlotFound then begin
            OptimalDate := CurrentDate;

            // Update courses per day counter
            if not CoursesPerDay.ContainsKey(CurrentDate) then
                CoursesPerDay.Add(CurrentDate, 1)
            else
                CoursesPerDay.Set(CurrentDate, CoursesPerDay.Get(CurrentDate) + 1);

            exit(true);
        end;

        // Try the next day
        DayCounter += 1;
        exit(FindOptimalExamSlotSupp(SuppUnits, Semester, ExamTimeSlot, OptimalDate, CoursesPerDay, DayCounter));
    end;

    local procedure FindTimeSlotForDay(CourseOffering: Record "ACA-Lecturers Units";
    ExamDate: Date;
    var SelectedTimeSlot: Record "Exam Time Slot";
    IsMedical: Boolean): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SessionTypesToTry: array[3] of Integer;
        i: Integer;
        SessionTypeCount: array[3] of Integer;
        TotalScheduled: Integer;
        NextSessionType: Integer;
    begin
        // Count available session types for this date
        Clear(SessionTypeCount);
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
        ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
        if IsMedical then
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
        else
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

        if ExamTimeSlot.FindSet() then
            repeat
                case ExamTimeSlot."Session Type" of
                    0:
                        SessionTypeCount[1] += 1; // Morning
                    1:
                        SessionTypeCount[2] += 1; // Midday
                    2:
                        SessionTypeCount[3] += 1; // Afternoon
                end;
            until ExamTimeSlot.Next() = 0;

        // Simple round-robin: cycle through 0, 1, 2, 0, 1, 2...
        TotalScheduled := GlobalMorningCount + GlobalMiddayCount + GlobalAfternoonCount;
        NextSessionType := TotalScheduled mod 3; // This gives us 0, 1, 2 in sequence

        // Set priority order starting from the next session in rotation
        SessionTypesToTry[1] := NextSessionType;
        SessionTypesToTry[2] := (NextSessionType + 1) mod 3;
        SessionTypesToTry[3] := (NextSessionType + 2) mod 3;

        // Try each session type in rotation order
        for i := 1 to 3 do begin
            // Only try if this session type is available
            if ((SessionTypesToTry[i] = 0) and (SessionTypeCount[1] > 0)) or
               ((SessionTypesToTry[i] = 1) and (SessionTypeCount[2] > 0)) or
               ((SessionTypesToTry[i] = 2) and (SessionTypeCount[3] > 0)) then begin

                ExamTimeSlot.Reset();
                ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
                ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
                ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
                ExamTimeSlot.SetRange("Session Type", SessionTypesToTry[i]);

                if IsMedical then
                    ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
                else
                    ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

                if ExamTimeSlot.FindSet() then begin
                    repeat
                        // Check if this slot would have conflicts
                        if not HasSchedulingConflicts(CourseOffering, ExamDate, ExamTimeSlot) then begin
                            // Check invigilator availability for this slot
                            if HasSufficientInvigilatorsForSlot(ExamDate, ExamTimeSlot, CourseOffering) then begin
                                SelectedTimeSlot := ExamTimeSlot;

                                // Update global counters immediately
                                UpdateGlobalSessionCounter(SessionTypesToTry[i]);

                                exit(true);
                            end;
                        end;
                    until ExamTimeSlot.Next() = 0;
                end;
            end;
        end;

        exit(false);
    end;


    local procedure FindTimeSlotForDaySupp(SuppUnits: Record "Supp. Exam Units";
           ExamDate: Date;
           var SelectedTimeSlot: Record "Exam Time Slot";
           IsMedical: Boolean): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        PreferredSessionType: Integer;
        SessionTypesToTry: array[3] of Integer;
        i: Integer;
        Found: Boolean;
    begin
        // STEP 1: Determine preferred session type using strict rotation
        PreferredSessionType := GetNextSessionTypeInRotation();

        // STEP 2: Setup session types to try in order
        case PreferredSessionType of
            0: // Morning preferred
                begin
                    SessionTypesToTry[1] := 0; // Morning
                    SessionTypesToTry[2] := 1; // Midday  
                    SessionTypesToTry[3] := 2; // Afternoon
                end;
            1: // Midday preferred
                begin
                    SessionTypesToTry[1] := 1; // Midday
                    SessionTypesToTry[2] := 2; // Afternoon
                    SessionTypesToTry[3] := 0; // Morning
                end;
            2: // Afternoon preferred
                begin
                    SessionTypesToTry[1] := 2; // Afternoon
                    SessionTypesToTry[2] := 0; // Morning
                    SessionTypesToTry[3] := 1; // Midday
                end;
        end;

        // STEP 3: Try each session type in order
        Found := false;
        for i := 1 to 3 do begin
            ExamTimeSlot.Reset();
            ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
            ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
            ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
            ExamTimeSlot.SetRange("Session Type", SessionTypesToTry[i]);

            if IsMedical then
                ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
            else
                ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

            if ExamTimeSlot.FindSet() then begin
                repeat
                    // Check if this slot would have conflicts
                    if not HasSchedulingConflictsSupp(SuppUnits, ExamDate, ExamTimeSlot) then begin
                        // Check invigilator availability for this slot
                        if HasSufficientInvigilatorsForSlotSupp(ExamDate, ExamTimeSlot, SuppUnits) then begin
                            SelectedTimeSlot := ExamTimeSlot;

                            // Update global counters
                            UpdateGlobalSessionCounter(SessionTypesToTry[i]);

                            exit(true);
                        end;
                    end;
                until ExamTimeSlot.Next() = 0;
            end;
        end;

        exit(false);
    end;

    local procedure ScheduleExamWithRoomAllocation(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        Semester: Record "ACA-Semesters"): Boolean
    var
        TotalStudents: Integer;
        RemainingStudents: Integer;
        AvailableRooms: array[100] of Record "ACA-Lecturer Halls Setup";
        AvailableCapacities: array[100] of Integer;
        RoomCount: Integer;
        i: Integer;
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentsInRoom: Integer;
        CurrentFloor: Integer;
        SameFloorRooms: List of [Integer];
        RoomIndex: Integer;
    begin
        TotalStudents := CourseOffering."Student Allocation";
        RemainingStudents := TotalStudents;

        // Get available exam rooms
        GetAvailableExamRooms(ExamDate, ExamTimeSlot, AvailableRooms, AvailableCapacities, RoomCount);

        if RoomCount = 0 then begin
            // Return false to indicate no rooms available
            exit(false);
        end;

        // Try to allocate all students to a single room if possible
        for i := 1 to RoomCount do begin
            if AvailableCapacities[i] >= TotalStudents then begin
                // Create exam entry for the entire class
                CreateExamEntry(CourseOffering, ExamDate, ExamTimeSlot,
                    AvailableRooms[i]."Lecture Room Code", TotalStudents, Semester.Code);

                // Assign invigilators for this room
                AssignInvigilatorsToRoomOptimized(CourseOffering, ExamDate, ExamTimeSlot,
                    AvailableRooms[i]."Lecture Room Code", TotalStudents, Semester.Code);

                exit(true);
            end;
        end;

        // If we get here, we need to split the students across multiple rooms
        // First try rooms on the same floor for best continuity

        // Sort rooms by floor and capacity for better allocation
        SortRoomsByFloorAndCapacity(AvailableRooms, AvailableCapacities, RoomCount);

        i := 1;
        while (RemainingStudents > 0) and (i <= RoomCount) do begin
            // Get current floor
            CurrentFloor := GetRoomFloor(AvailableRooms[i]."Lecture Room Code");

            // Find all rooms on the same floor
            Clear(SameFloorRooms);
            for RoomIndex := i to RoomCount do begin
                if GetRoomFloor(AvailableRooms[RoomIndex]."Lecture Room Code") = CurrentFloor then
                    SameFloorRooms.Add(RoomIndex);
            end;

            // Allocate students to rooms on the same floor first
            if SameFloorRooms.Count > 0 then begin
                foreach RoomIndex in SameFloorRooms do begin
                    if RemainingStudents <= 0 then
                        break;

                    if AvailableCapacities[RoomIndex] > 0 then begin
                        StudentsInRoom := MinValue(RemainingStudents, AvailableCapacities[RoomIndex]);

                        // Create exam entry
                        CreateExamEntry(CourseOffering, ExamDate, ExamTimeSlot,
                            AvailableRooms[RoomIndex]."Lecture Room Code", StudentsInRoom, Semester.Code);

                        // Assign invigilators
                        AssignInvigilatorsToRoomOptimized(CourseOffering, ExamDate, ExamTimeSlot,
                            AvailableRooms[RoomIndex]."Lecture Room Code", StudentsInRoom, Semester.Code);

                        RemainingStudents -= StudentsInRoom;
                        AvailableCapacities[RoomIndex] := 0; // Mark as used
                    end;
                end;
            end;

            // Skip to the next floor
            i += SameFloorRooms.Count;
            if SameFloorRooms.Count = 0 then
                i += 1;
        end;

        // If we still have students without a room, use any remaining capacity
        if RemainingStudents > 0 then begin
            for i := 1 to RoomCount do begin
                if AvailableCapacities[i] > 0 then begin
                    StudentsInRoom := MinValue(RemainingStudents, AvailableCapacities[i]);

                    // Create exam entry
                    CreateExamEntry(CourseOffering, ExamDate, ExamTimeSlot,
                        AvailableRooms[i]."Lecture Room Code", StudentsInRoom, Semester.Code);

                    // Assign invigilators
                    AssignInvigilatorsToRoomOptimized(CourseOffering, ExamDate, ExamTimeSlot,
                        AvailableRooms[i]."Lecture Room Code", StudentsInRoom, Semester.Code);

                    RemainingStudents -= StudentsInRoom;

                    if RemainingStudents <= 0 then
                        break;
                end;
            end;
        end;

        // Log issue if we couldn't accommodate all students
        if RemainingStudents > 0 then begin
            LogSchedulingIssue(CourseOffering);
            exit(false);
        end;

        exit(true);
    end;

    local procedure ScheduleExamWithRoomAllocationSupp(SuppUnits: Record "Supp. Exam Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        Semester: Record "ACA-Semesters")
    var
        TotalStudents: Integer;
        RemainingStudents: Integer;
        AvailableRooms: array[100] of Record "ACA-Lecturer Halls Setup";
        AvailableCapacities: array[100] of Integer;
        RoomCount: Integer;
        i: Integer;
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentsInRoom: Integer;
        CurrentFloor: Integer;
        SameFloorRooms: List of [Integer];
        RoomIndex: Integer;
    begin
        TotalStudents := SuppUnits."Student Allocation";
        RemainingStudents := TotalStudents;

        // Get available exam rooms
        GetAvailableExamRooms(ExamDate, ExamTimeSlot, AvailableRooms, AvailableCapacities, RoomCount);

        if RoomCount = 0 then begin
            //   LogSchedulingIssue( CourseOffering);
            exit;
        end;

        // Try to allocate all students to a single room if possible
        for i := 1 to RoomCount do begin
            if AvailableCapacities[i] >= TotalStudents then begin
                // Create exam entry for the entire class
                CreateExamEntrySupp(SuppUnits, ExamDate, ExamTimeSlot,
                    AvailableRooms[i]."Lecture Room Code", TotalStudents, Semester.Code);

                exit;
            end;
        end;

        // If we get here, we need to split the students across multiple rooms
        // First try rooms on the same floor for best continuity

        // Sort rooms by floor and capacity for better allocation
        SortRoomsByFloorAndCapacity(AvailableRooms, AvailableCapacities, RoomCount);

        i := 1;
        while (RemainingStudents > 0) and (i <= RoomCount) do begin
            // Get current floor
            CurrentFloor := GetRoomFloor(AvailableRooms[i]."Lecture Room Code");

            // Find all rooms on the same floor
            Clear(SameFloorRooms);
            for RoomIndex := i to RoomCount do begin
                if GetRoomFloor(AvailableRooms[RoomIndex]."Lecture Room Code") = CurrentFloor then
                    SameFloorRooms.Add(RoomIndex);
            end;

            // Allocate students to rooms on the same floor first
            if SameFloorRooms.Count > 0 then begin
                foreach RoomIndex in SameFloorRooms do begin
                    if RemainingStudents <= 0 then
                        break;

                    if AvailableCapacities[RoomIndex] > 0 then begin
                        StudentsInRoom := MinValue(RemainingStudents, AvailableCapacities[RoomIndex]);

                        // Create exam entry
                        CreateExamEntrySupp(SuppUnits, ExamDate, ExamTimeSlot,
                            AvailableRooms[RoomIndex]."Lecture Room Code", StudentsInRoom, Semester.Code);

                        RemainingStudents -= StudentsInRoom;
                        AvailableCapacities[RoomIndex] := 0; // Mark as used
                    end;
                end;
            end;

            // Skip to the next floor
            i += SameFloorRooms.Count;
            if SameFloorRooms.Count = 0 then
                i += 1;
        end;

        // If we still have students without a room, use any remaining capacity
        if RemainingStudents > 0 then begin
            for i := 1 to RoomCount do begin
                if AvailableCapacities[i] > 0 then begin
                    StudentsInRoom := MinValue(RemainingStudents, AvailableCapacities[i]);

                    // Create exam entry
                    CreateExamEntrySupp(SuppUnits, ExamDate, ExamTimeSlot,
                        AvailableRooms[i]."Lecture Room Code", StudentsInRoom, Semester.Code);

                    RemainingStudents -= StudentsInRoom;

                    if RemainingStudents <= 0 then
                        break;
                end;
            end;
        end;

        // Log issue if we couldn't accommodate all students
        // if RemainingStudents > 0 then
        //     LogSchedulingIssue(CourseOffering);
    end;

    local procedure CreateExamEntry(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        LectureHall: Code[20];
        StudentCount: Integer;
        SemesterCode: Code[25])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Init();
        ExamTimetableEntry."Unit Code" := CourseOffering.Unit;
        ExamTimetableEntry.Semester := SemesterCode;
        ExamTimetableEntry."Exam Date" := ExamDate;
        ExamTimetableEntry."Time Slot" := ExamTimeSlot.Code;
        ExamTimetableEntry."Start Time" := ExamTimeSlot."Start Time";
        ExamTimetableEntry."End Time" := ExamTimeSlot."End Time";
        ExamTimetableEntry."Lecture Hall" := LectureHall;
        ExamTimetableEntry."Programme Code" := CourseOffering.Programme;
        ExamTimetableEntry."Stage Code" := CourseOffering.Stage;
        ExamTimetableEntry.Status := ExamTimetableEntry.Status::Scheduled;
        ExamTimetableEntry."Student Count" := StudentCount;
        ExamTimetableEntry."Exam Type" := ExamTimetableEntry."Exam Type"::Regular;
        ExamTimetableEntry.Insert(true);
    end;

    local procedure CreateExamEntrySupp(SuppUnits: Record "Supp. Exam Units";
    ExamDate: Date;
    ExamTimeSlot: Record "Exam Time Slot";
    LectureHall: Code[20];
    StudentCount: Integer;
    SemesterCode: Code[25])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Init();
        ExamTimetableEntry."Unit Code" := SuppUnits."Unit Code";
        ExamTimetableEntry.Semester := SemesterCode;
        ExamTimetableEntry."Exam Date" := ExamDate;
        ExamTimetableEntry."Time Slot" := ExamTimeSlot.Code;
        ExamTimetableEntry."Start Time" := ExamTimeSlot."Start Time";
        ExamTimetableEntry."End Time" := ExamTimeSlot."End Time";
        ExamTimetableEntry."Lecture Hall" := LectureHall;
        ExamTimetableEntry."Programme Code" := SuppUnits.Programme;
        ExamTimetableEntry."Stage Code" := SuppUnits."Stage Code";
        ExamTimetableEntry.Status := ExamTimetableEntry.Status::Scheduled;
        ExamTimetableEntry."Student Count" := StudentCount;
        ExamTimetableEntry."Exam Type" := ExamTimetableEntry."Exam Type"::Supplementary;
        ExamTimetableEntry.Insert(true);

        // Immediately assign invigilators after creating the supplementary exam entry
        AssignInvigilatorsToRoomSupp(
            SuppUnits,
            ExamDate,
            ExamTimeSlot,
            LectureHall,
            StudentCount,
            SemesterCode);

        // Update the exam entry to mark invigilators as assigned
        ExamTimetableEntry."Invigilators Assigned" := true;
        ExamTimetableEntry."Invigilator Assignment Date" := CurrentDateTime;
        ExamTimetableEntry.Modify();
    end;

    local procedure GetAvailableExamRooms(ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        var AvailableRooms: array[100] of Record "ACA-Lecturer Halls Setup";
        var AvailableCapacities: array[100] of Integer;
        var RoomCount: Integer)
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        TotalCapacity: Integer;
        UsedCapacity: Integer;
        i: Integer;
    begin
        Clear(RoomCount);
        Clear(AvailableRooms);
        Clear(AvailableCapacities);

        LectureHall.Reset();
        LectureHall.SetFilter("Exam Sitting Capacity", '>0');
        LectureHall.SetRange(Status, LectureHall.Status::Active);
        if not EnableLabsForExam() then
            LectureHall.SetFilter("Hall Category", '%1', LectureHall."Hall Category"::Normal)
        else
            LectureHall.SetFilter("Hall Category", '%1|%2', LectureHall."Hall Category"::Normal, LectureHall."Hall Category"::Lab);
        if LectureHall.FindSet() then
            repeat
                Clear(UsedCapacity);
                TotalCapacity := LectureHall."Exam Sitting Capacity";

                // Check existing bookings for this room at this time
                ExamTimetableEntry.Reset();
                ExamTimetableEntry.SetRange("Exam Date", ExamDate);
                ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);
                ExamTimetableEntry.SetRange("Lecture Hall", LectureHall."Lecture Room Code");

                if ExamTimetableEntry.FindSet() then
                    repeat
                        // Calculate used capacity
                        if ExamTimetableEntry."Student Count" > 0 then
                            UsedCapacity += ExamTimetableEntry."Student Count"
                        else
                            UsedCapacity += GetExamStudentCount(ExamTimetableEntry);
                    until ExamTimetableEntry.Next() = 0;

                // If there's still capacity available
                if TotalCapacity > UsedCapacity then begin
                    RoomCount += 1;
                    AvailableRooms[RoomCount] := LectureHall;
                    AvailableCapacities[RoomCount] := TotalCapacity - UsedCapacity;
                end;
            until LectureHall.Next() = 0;
    end;

    local procedure SortRoomsByFloorAndCapacity(var Rooms: array[100] of Record "ACA-Lecturer Halls Setup";
        var Capacities: array[100] of Integer;
        RoomCount: Integer)
    var
        i, j : Integer;
        TempRoom: Record "ACA-Lecturer Halls Setup";
        TempCapacity: Integer;
        Floor1, Floor2 : integer;
    begin
        // Simple bubble sort by floor then by capacity
        for i := 1 to RoomCount - 1 do
            for j := i + 1 to RoomCount do begin
                Floor1 := GetRoomFloor(Rooms[i]."Lecture Room Code");
                Floor2 := GetRoomFloor(Rooms[j]."Lecture Room Code");

                if (Floor1 > Floor2) or
                   ((Floor1 = Floor2) and (Capacities[i] < Capacities[j])) then begin
                    // Swap rooms
                    TempRoom := Rooms[i];
                    Rooms[i] := Rooms[j];
                    Rooms[j] := TempRoom;

                    // Swap capacities
                    TempCapacity := Capacities[i];
                    Capacities[i] := Capacities[j];
                    Capacities[j] := TempCapacity;
                end;
            end;
    end;

    local procedure GetRoomFloor(RoomCode: Code[20]): Integer
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
    begin
        LectureHall.Reset();
        LectureHall.SetRange("Lecture Room Code", RoomCode);
        if LectureHall.FindFirst() then
            exit(LectureHall.Floor);
    end;

    local procedure AssignInvigilatorsToExams(SemesterCode: Code[25])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentCount: Integer;
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange(Semester, SemesterCode);

        if ExamTimetableEntry.FindSet() then
            repeat
                // Get student count
                if ExamTimetableEntry."Student Count" > 0 then
                    StudentCount := ExamTimetableEntry."Student Count"
                else
                    StudentCount := GetExamStudentCount(ExamTimetableEntry);

                // Assign invigilators based on student count
                AssignInvigilatorsToRoomOptimized(
                    GetCourseOffering(ExamTimetableEntry."Unit Code", SemesterCode),
                    ExamTimetableEntry."Exam Date",
                    GetExamTimeSlot(ExamTimetableEntry."Time Slot", SemesterCode),
                    ExamTimetableEntry."Lecture Hall",
                    StudentCount,
                    SemesterCode);
            until ExamTimetableEntry.Next() = 0;
    end;

    local procedure AssignInvigilatorsToRoomOptimized(
        CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        LectureHall: Code[20];
        StudentCount: Integer;
        SemesterCode: Code[25])
    var
        InvigilatorSetup: Record "Invigilator Setup";
        InvigilatorCount: Integer;
        Department: Code[20];
        AvailableInvigilators: List of [Code[20]];
        SelectedInvigilators: List of [Code[20]];
        InvigilatorNo: Code[20];
        ExamInvigilator: Record "Exam Invigilators";
        Employee: Record "HRM-Employee C";
        MinimumRequired: Integer;
        MaxAllowed: Integer;
    begin
        // Get invigilator setup
        if not InvigilatorSetup.Get() then begin
            // Use defaults if no setup
            InvigilatorCount := 2;
        end else begin
            // Calculate based on student count
            InvigilatorCount := CalculateRequiredInvigilators(StudentCount, InvigilatorSetup);
        end;

        // Get department from course offering
        CourseOffering.CalcFields("Department Code");
        Department := CourseOffering."Department Code";

        // Get available invigilators using optimized method
        GetAvailableInvigilatorsFromLecturersOptimized(
            Department,
            ExamDate,
            ExamTimeSlot,
            CourseOffering.Lecturer,
            AvailableInvigilators);

        // Select required number of invigilators
        SelectInvigilatorsWithWorkloadBalance(
            AvailableInvigilators,
            InvigilatorCount,
            SelectedInvigilators,
            ExamDate,
            SemesterCode);

        // Batch insert the invigilator assignments
        foreach InvigilatorNo in SelectedInvigilators do begin
            if Employee.Get(InvigilatorNo) then begin
                ExamInvigilator.Init();
                ExamInvigilator.Semester := SemesterCode;
                ExamInvigilator.Date := ExamDate;
                ExamInvigilator.Unit := CourseOffering.Unit;
                ExamInvigilator.Hall := LectureHall;
                ExamInvigilator."Start Time" := ExamTimeSlot."Start Time";
                ExamInvigilator."End Time" := ExamTimeSlot."End Time";
                ExamInvigilator."No." := InvigilatorNo;
                ExamInvigilator.Name := Employee."First Name" + ' ' + Employee."Last Name";
                ExamInvigilator.Category := GetEmployeeCategoryFromLecturer(InvigilatorNo);
                ExamInvigilator.Insert();
            end;
        end;
    end;

    local procedure GetEmployeeCategoryFromLecturer(LecturerNo: Code[20]): Option "Full-Timer","Part-Timer"
    var
        Employee: Record "HRM-Employee C";
    begin
        if Employee.Get(LecturerNo) then begin
            if (Employee."Full / Part Time" = Employee."Full / Part Time"::"Full Time") or
               (Employee."Full / Part Time" = Employee."Full / Part Time"::Contract) then
                exit(0) // Full-Timer
            else
                exit(1); // Part-Timer
        end;

        // Default to Full-Timer if employee record not found
        exit(0);
    end;

    local procedure AssignInvigilatorsToRoomSupp(SuppUnits: Record "Supp. Exam Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        LectureHall: Code[20];
        StudentCount: Integer;
        SemesterCode: Code[25])
    var
        InvigilatorSetup: Record "Invigilator Setup";
        InvigilatorCount: Integer;
        FirstInvigilators: Integer;
        AdditionalInvigilators: Integer;
        Department: Code[20];
        AvailableInvigilators: List of [Code[20]];
        SelectedInvigilators: List of [Code[20]];
        InvigilatorNo: Code[20];
        ExamInvigilator: Record "Exam Invigilators";
        Employee: Record "HRM-Employee C";
    begin
        // Get invigilator setup
        if not InvigilatorSetup.FindFirst() then
            exit;

        // Calculate number of invigilators needed
        FirstInvigilators := InvigilatorSetup."First 100";

        if StudentCount <= 100 then
            InvigilatorCount := FirstInvigilators
        else begin
            AdditionalInvigilators := ROUND((StudentCount - 100) / 50, 1, '>') * InvigilatorSetup."Next 50";
            InvigilatorCount := FirstInvigilators + AdditionalInvigilators;
        end;

        // Get department from course offering
        Department := GetCourseDepartmentSupp(SuppUnits);

        // Get available invigilators from lecturer units, starting with unit lecturer
        GetAvailableInvigilatorsFromLecturersOptimized(Department, ExamDate, ExamTimeSlot, SuppUnits."Lecturer Code", AvailableInvigilators);

        // Select required number of invigilators, prioritizing full-timers
        SelectInvigilatorsWithWorkloadBalance(AvailableInvigilators, InvigilatorCount, SelectedInvigilators, ExamDate, SemesterCode);

        // Assign the selected invigilators
        foreach InvigilatorNo in SelectedInvigilators do begin
            if Employee.Get(InvigilatorNo) then begin
                ExamInvigilator.Init();
                ExamInvigilator.Semester := SemesterCode;
                ExamInvigilator.Date := ExamDate;
                ExamInvigilator.Unit := SuppUnits."Unit Code";
                ExamInvigilator.Hall := LectureHall;
                ExamInvigilator."Start Time" := ExamTimeSlot."Start Time";
                ExamInvigilator."End Time" := ExamTimeSlot."End Time";
                ExamInvigilator."No." := InvigilatorNo;
                ExamInvigilator.Name := Employee."First Name" + ' ' + Employee."Last Name";
                ExamInvigilator.Category := GetEmployeeCategoryFromLecturer(InvigilatorNo);
                ExamInvigilator.Insert();
            end;
        end;
    end;

    local procedure GetAvailableInvigilatorsFromLecturersOptimized(
        Department: Code[20];
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        UnitLecturer: Code[20];
        var AvailableInvigilators: List of [Code[20]])
    var
        Employee: Record "HRM-Employee C";
        ExamInvigilator: Record "Exam Invigilators";
        BusyInvigilators: List of [Code[20]];
        ProcessedLecturers: List of [Code[20]];
        InvigilatorNo: Code[20];
        SessionKey: Text[100];
        CachedBusyList: List of [Code[20]];
    begin
        Clear(AvailableInvigilators);
        Clear(ProcessedLecturers);
        Clear(BusyInvigilators);

        // Create session key for caching busy invigilators
        SessionKey := StrSubstNo('%1-%2-%3', ExamDate, ExamTimeSlot."Start Time", ExamTimeSlot."End Time");

        // STEP 1: Try to use cached busy invigilators for this session
        if TryGetCachedBusyInvigilators(SessionKey, BusyInvigilators) then begin
            // Use cached data
        end else begin
            // Build fresh list and cache it
            ExamInvigilator.Reset();
            ExamInvigilator.SetRange(Date, ExamDate);
            ExamInvigilator.SetFilter("Start Time", '<=%1', ExamTimeSlot."End Time");
            ExamInvigilator.SetFilter("End Time", '>=%1', ExamTimeSlot."Start Time");

            if ExamInvigilator.FindSet() then
                repeat
                    if not BusyInvigilators.Contains(ExamInvigilator."No.") then
                        BusyInvigilators.Add(ExamInvigilator."No.");
                until ExamInvigilator.Next() = 0;

            // Cache the busy list for reuse
            CacheBusyInvigilators(SessionKey, BusyInvigilators);
        end;

        // STEP 2: Check unit lecturer first if available
        if (UnitLecturer <> '') and (not BusyInvigilators.Contains(UnitLecturer)) then begin
            if IsLecturerActive(UnitLecturer) then begin
                AvailableInvigilators.Add(UnitLecturer);
                ProcessedLecturers.Add(UnitLecturer);
            end;
        end;

        // STEP 3: Get department lecturers using cached approach
        CollectDepartmentLecturersOptimized(Department, BusyInvigilators, ProcessedLecturers, AvailableInvigilators);

        // STEP 4: If not enough, get from other departments (only if needed)
        if AvailableInvigilators.Count < 2 then
            CollectLecturersFromOtherDepartmentsOptimized(Department, BusyInvigilators, ProcessedLecturers, AvailableInvigilators);

        // STEP 5: Final fallback - get from all lecturers if still not enough
        if AvailableInvigilators.Count < 2 then
            CollectAllRemainingLecturersOptimized(BusyInvigilators, ProcessedLecturers, AvailableInvigilators);
    end;

    // Helper to collect department lecturers from lecturer units
    local procedure CollectDepartmentLecturersFromUnits(
        Department: Code[20];
        BusyInvigilators: List of [Code[20]];
        var ProcessedLecturers: List of [Code[20]];
        var AvailableInvigilators: List of [Code[20]])
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        Employee: Record "HRM-Employee C";
        TempLecturers: List of [Code[20]];
    begin
        // Get unique lecturers from the department via Lecturer Units
        LecturerUnits.Reset();
        LecturerUnits.SetCurrentKey(Lecturer);

        // Use a query-like approach to get distinct lecturers
        if LecturerUnits.FindSet() then
            repeat
                // Calculate department only once per unique lecturer
                if (LecturerUnits.Lecturer <> '') and
                   (not TempLecturers.Contains(LecturerUnits.Lecturer)) then begin

                    LecturerUnits.CalcFields("Department Code");

                    if LecturerUnits."Department Code" = Department then begin
                        TempLecturers.Add(LecturerUnits.Lecturer);

                        // Check if lecturer is available
                        if not ProcessedLecturers.Contains(LecturerUnits.Lecturer) and
                           not BusyInvigilators.Contains(LecturerUnits.Lecturer) then begin

                            if Employee.Get(LecturerUnits.Lecturer) then
                                if (Employee.Status = Employee.Status::Active) and
                                   (Employee.Lecturer = true) then begin
                                    AvailableInvigilators.Add(LecturerUnits.Lecturer);
                                    ProcessedLecturers.Add(LecturerUnits.Lecturer);
                                end;
                        end;
                    end;
                end;
            until LecturerUnits.Next() = 0;
    end;

    // Helper to collect lecturers from other departments
    local procedure CollectLecturersFromOtherDepartments(
        ExcludeDepartment: Code[20];
        BusyInvigilators: List of [Code[20]];
        var ProcessedLecturers: List of [Code[20]];
        var AvailableInvigilators: List of [Code[20]])
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        Employee: Record "HRM-Employee C";
        TempLecturers: List of [Code[20]];
        RequiredCount: Integer;
    begin
        RequiredCount := 2; // Minimum required

        // Get unique lecturers from other departments via Lecturer Units
        LecturerUnits.Reset();
        LecturerUnits.SetCurrentKey(Lecturer);

        if LecturerUnits.FindSet() then
            repeat
                if AvailableInvigilators.Count >= RequiredCount then
                    break;

                // Process only unique lecturers
                if (LecturerUnits.Lecturer <> '') and
                   (not TempLecturers.Contains(LecturerUnits.Lecturer)) and
                   (not ProcessedLecturers.Contains(LecturerUnits.Lecturer)) then begin

                    LecturerUnits.CalcFields("Department Code");
                    TempLecturers.Add(LecturerUnits.Lecturer);

                    // Check if from different department and not empty
                    if (LecturerUnits."Department Code" <> ExcludeDepartment) and
                       (LecturerUnits."Department Code" <> '') then begin

                        // Check if available
                        if not BusyInvigilators.Contains(LecturerUnits.Lecturer) then begin
                            if Employee.Get(LecturerUnits.Lecturer) then
                                if (Employee.Status = Employee.Status::Active) and
                                   (Employee.Lecturer = true) then begin
                                    AvailableInvigilators.Add(LecturerUnits.Lecturer);
                                    ProcessedLecturers.Add(LecturerUnits.Lecturer);
                                end;
                        end;
                    end;
                end;
            until LecturerUnits.Next() = 0;
    end;

    // Final fallback to get any available lecturers
    local procedure CollectAllRemainingLecturers(
        BusyInvigilators: List of [Code[20]];
        ProcessedLecturers: List of [Code[20]];
        var AvailableInvigilators: List of [Code[20]])
    var
        Employee: Record "HRM-Employee C";
        RequiredCount: Integer;
    begin
        RequiredCount := 2; // Minimum required

        Employee.Reset();
        Employee.SetRange(Lecturer, true);
        Employee.SetRange(Status, Employee.Status::Active);

        if Employee.FindSet() then
            repeat
                if AvailableInvigilators.Count >= RequiredCount then
                    break;

                if not ProcessedLecturers.Contains(Employee."No.") and
                   not BusyInvigilators.Contains(Employee."No.") then begin
                    AvailableInvigilators.Add(Employee."No.");
                    ProcessedLecturers.Add(Employee."No.");
                end;
            until Employee.Next() = 0;
    end;

    // Helper to calculate required invigilators
    local procedure CalculateRequiredInvigilators(
        StudentCount: Integer;
        InvigilatorSetup: Record "Invigilator Setup"): Integer
    var
        InvigilatorCount: Integer;
        FirstInvigilators: Integer;
        AdditionalInvigilators: Integer;
        MinimumRequired: Integer;
        MaxAllowed: Integer;
    begin
        FirstInvigilators := InvigilatorSetup."First 100";
        MinimumRequired := 1;
        MaxAllowed := 6;

        if StudentCount <= 100 then begin
            InvigilatorCount := FirstInvigilators;
            if InvigilatorCount < MinimumRequired then
                InvigilatorCount := MinimumRequired;
        end else begin
            AdditionalInvigilators := ROUND((StudentCount - 100) / 50, 1, '>') * InvigilatorSetup."Next 50";
            InvigilatorCount := FirstInvigilators + AdditionalInvigilators;

            if InvigilatorCount > MaxAllowed then
                InvigilatorCount := MaxAllowed;
        end;

        if InvigilatorCount < MinimumRequired then
            InvigilatorCount := MinimumRequired;

        exit(InvigilatorCount);
    end;

    // Simple workload-based sorting
    local procedure SortInvigilatorsByWorkload(
        AvailableList: List of [Code[20]];
        WorkloadDict: Dictionary of [Code[20], Integer];
        var SortedList: List of [Code[20]])
    var
        TempList: List of [Code[20]];
        InvigilatorNo: Code[20];
        LowestWorkload: Integer;
        LowestInvigilator: Code[20];
        CurrentWorkload: Integer;
        i: Integer;
    begin
        Clear(SortedList);

        // Copy to temp list
        foreach InvigilatorNo in AvailableList do
            TempList.Add(InvigilatorNo);

        // Simple selection sort
        while TempList.Count > 0 do begin
            LowestWorkload := 999999;
            LowestInvigilator := '';

            foreach InvigilatorNo in TempList do begin
                if WorkloadDict.ContainsKey(InvigilatorNo) then
                    CurrentWorkload := WorkloadDict.Get(InvigilatorNo)
                else
                    CurrentWorkload := 0;

                if CurrentWorkload < LowestWorkload then begin
                    LowestWorkload := CurrentWorkload;
                    LowestInvigilator := InvigilatorNo;
                end;
            end;

            if LowestInvigilator <> '' then begin
                SortedList.Add(LowestInvigilator);
                TempList.Remove(LowestInvigilator);
            end;
        end;
    end;

    local procedure GetCourseDepartment(CourseOffering: Record "ACA-Lecturers Units"): Code[20]
    begin
        // Get department from unit setup
        CourseOffering.CalcFields("Department Code");
        exit(CourseOffering."Department Code");
    end;

    local procedure GetCourseDepartmentSupp(SuppUnits: Record "Supp. Exam Units"): Code[20]
    begin
        // Get department from unit setup
        SuppUnits.CalcFields("Department Code");
        exit(SuppUnits."Department Code");
    end;

    local procedure GetAvailableInvigilators(Department: Code[20];
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        var AvailableInvigilators: List of [Code[20]])
    var
        Employee: Record "HRM-Employee C";
        ExamInvigilator: Record "Exam Invigilators";
        IsAvailable: Boolean;
    begin
        Clear(AvailableInvigilators);

        // Get all lecturers from the department
        Employee.Reset();
        Employee.SetRange(Lecturer, true);
        Employee.SetRange("Department Code", Department);
        Employee.SetRange(Status, Employee.Status::Active);

        if Employee.FindSet() then
            repeat
                // Check if the lecturer is available at this time
                IsAvailable := true;

                ExamInvigilator.Reset();
                ExamInvigilator.SetRange(Date, ExamDate);
                ExamInvigilator.SetRange("No.", Employee."No.");

                if ExamInvigilator.FindSet() then
                    repeat
                        // Check for time overlap
                        if (ExamInvigilator."Start Time" <= ExamTimeSlot."End Time") and
                           (ExamInvigilator."End Time" >= ExamTimeSlot."Start Time") then
                            IsAvailable := false;
                    until (ExamInvigilator.Next() = 0) or not IsAvailable;

                if IsAvailable then
                    AvailableInvigilators.Add(Employee."No.");

            until Employee.Next() = 0;

        // If not enough invigilators from department, get from other departments
        if AvailableInvigilators.Count < 2 then begin
            Employee.Reset();
            Employee.SetRange(Lecturer, true);
            Employee.SetFilter("Department Code", '<>%1', Department);
            Employee.SetRange(Status, Employee.Status::Active);

            if Employee.FindSet() then
                repeat
                    // Check if the lecturer is available at this time
                    IsAvailable := true;

                    ExamInvigilator.Reset();
                    ExamInvigilator.SetRange(Date, ExamDate);
                    ExamInvigilator.SetRange("No.", Employee."No.");

                    if ExamInvigilator.FindSet() then
                        repeat
                            // Check for time overlap
                            if (ExamInvigilator."Start Time" <= ExamTimeSlot."End Time") and
                               (ExamInvigilator."End Time" >= ExamTimeSlot."Start Time") then
                                IsAvailable := false;
                        until (ExamInvigilator.Next() = 0) or not IsAvailable;

                    if IsAvailable then
                        AvailableInvigilators.Add(Employee."No.");
                until Employee.Next() = 0;
        end;
    end;

    local procedure SelectInvigilatorsWithWorkloadBalance(
        AvailableInvigilators: List of [Code[20]];
        RequiredCount: Integer;
        var SelectedInvigilators: List of [Code[20]];
        ExamDate: Date;
        SemesterCode: Code[25])
    var
        InvigilatorWorkload: Dictionary of [Code[20], Integer];
        InvigilatorNo: Code[20];
        ExamInvigilator: Record "Exam Invigilators";
        WorkloadCount: Integer;
        SortedByWorkload: List of [Code[20]];
        i: Integer;
    begin
        Clear(SelectedInvigilators);
        Clear(InvigilatorWorkload);

        // Build workload dictionary in one pass
        ExamInvigilator.Reset();
        ExamInvigilator.SetRange(Date, ExamDate);
        ExamInvigilator.SetRange(Semester, SemesterCode);

        if ExamInvigilator.FindSet() then
            repeat
                if InvigilatorWorkload.ContainsKey(ExamInvigilator."No.") then
                    InvigilatorWorkload.Set(ExamInvigilator."No.",
                        InvigilatorWorkload.Get(ExamInvigilator."No.") + 1)
                else
                    InvigilatorWorkload.Add(ExamInvigilator."No.", 1);
            until ExamInvigilator.Next() = 0;

        // Add workload for available invigilators not yet assigned today
        foreach InvigilatorNo in AvailableInvigilators do begin
            if not InvigilatorWorkload.ContainsKey(InvigilatorNo) then
                InvigilatorWorkload.Add(InvigilatorNo, 0);
        end;

        // Sort by workload (simple implementation)
        SortInvigilatorsByWorkload(AvailableInvigilators, InvigilatorWorkload, SortedByWorkload);

        // Select the required number with lowest workload
        i := 0;
        foreach InvigilatorNo in SortedByWorkload do begin
            if i >= RequiredCount then
                break;
            SelectedInvigilators.Add(InvigilatorNo);
            i += 1;
        end;
    end;

    local procedure GetEmployeeCategory(Employee: Record "HRM-Employee C"): Option "Full-Timer","Part-Timer"
    begin
        if (Employee."Full / Part Time" = Employee."Full / Part Time"::"Full Time") or (Employee."Full / Part Time" = Employee."Full / Part Time"::Contract) then
            exit(0) // Full-Timer
        else
            exit(1); // Part-Timer
    end;

    local procedure GetCourseOffering(UnitCode: Code[25]; SemesterCode: Code[25]): Record "ACA-Lecturers Units"
    var
        CourseOffering: Record "ACA-Lecturers Units";
    begin
        CourseOffering.Reset();
        CourseOffering.SetRange(Unit, UnitCode);
        CourseOffering.SetRange(Semester, SemesterCode);

        if CourseOffering.FindFirst() then
            exit(CourseOffering);

        Clear(CourseOffering);
        exit(CourseOffering);
    end;

    local procedure GetExamTimeSlot(SlotCode: Code[20]; SemesterCode: Code[25]): Record "Exam Time Slot"
    var
        ExamTimeSlot: Record "Exam Time Slot";
    begin
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange(Code, SlotCode);
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);

        if ExamTimeSlot.FindFirst() then
            exit(ExamTimeSlot);

        Clear(ExamTimeSlot);
        exit(ExamTimeSlot);
    end;

    local procedure HasSchedulingConflicts(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentUnits: Record "ACA-Student Units";
        ProgramUnits: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
    begin
        // Get semester code
        FindSemester(CourseOffering.Semester, Semester);

        // Check for program conflicts - same program/stage at same time
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);
        ExamTimetableEntry.SetRange("Programme Code", CourseOffering.Programme);
        ExamTimetableEntry.SetRange("Stage Code", CourseOffering.Stage);
        if not ExamTimetableEntry.IsEmpty then
            exit(true);

        // Check for lecturer conflicts - same lecturer at same time
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);

        if ExamTimetableEntry.FindSet() then begin
            repeat
                ProgramUnits.Reset();
                ProgramUnits.SetRange(Unit, ExamTimetableEntry."Unit Code");
                ProgramUnits.SetRange(Semester, ExamTimetableEntry.Semester);

                if ProgramUnits.FindFirst() then
                    if ProgramUnits.Lecturer = CourseOffering.Lecturer then
                        exit(true);
            until ExamTimetableEntry.Next() = 0;
        end;

        // Check for student conflicts - students taking both exams
        StudentUnits.Reset();
        StudentUnits.SetRange(Unit, CourseOffering.Unit);
        StudentUnits.SetRange(Programme, CourseOffering.Programme);
        StudentUnits.SetRange(Stage, CourseOffering.Stage);
        StudentUnits.SetRange(Semester, Semester.Code);

        if StudentUnits.FindSet() then
            repeat
                if HasStudentExamConflict(
                    StudentUnits."Student No.",
                    ExamDate,
                    ExamTimeSlot.Code,
                    Semester.Code) then
                    exit(true);
            until StudentUnits.Next() = 0;

        exit(false);
    end;

    local procedure HasSchedulingConflictsSupp(SuppUnits: Record "Supp. Exam Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentUnits: Record "ACA-Student Units";
        ProgramUnits: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
    begin
        // Get semester code
        FindSemester(SuppUnits.Semester, Semester);

        // Check for program conflicts - same program/stage at same time
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);
        ExamTimetableEntry.SetRange("Programme Code", SuppUnits.Programme);
        ExamTimetableEntry.SetRange("Stage Code", SuppUnits."Stage Code");
        if not ExamTimetableEntry.IsEmpty then
            exit(true);

        // Check for lecturer conflicts - same lecturer at same time
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);

        if ExamTimetableEntry.FindSet() then begin
            repeat
                ProgramUnits.Reset();
                ProgramUnits.SetRange(Unit, ExamTimetableEntry."Unit Code");
                ProgramUnits.SetRange(Semester, ExamTimetableEntry.Semester);

                if ProgramUnits.FindFirst() then
                    if ProgramUnits.Lecturer = SuppUnits."Lecturer Code" then
                        exit(true);
            until ExamTimetableEntry.Next() = 0;
        end;

        // Check for student conflicts - students taking both exams
        StudentUnits.Reset();
        StudentUnits.SetRange(Unit, SuppUnits."Unit Code");
        StudentUnits.SetRange(Semester, Semester.Code);

        if StudentUnits.FindSet() then
            repeat
                if HasStudentExamConflict(
                    StudentUnits."Student No.",
                    ExamDate,
                    ExamTimeSlot.Code,
                    Semester.Code) then
                    exit(true);
            until StudentUnits.Next() = 0;

        exit(false);
    end;

    local procedure HasStudentExamConflict(StudentNo: Code[20];
        ExamDate: Date;
        TimeSlot: Code[20];
        SemesterCode: Code[25]): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentUnits: Record "ACA-Student Units";
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", TimeSlot);

        if ExamTimetableEntry.FindSet() then
            repeat
                StudentUnits.Reset();
                StudentUnits.SetRange("Student No.", StudentNo);
                StudentUnits.SetRange(Unit, ExamTimetableEntry."Unit Code");
                StudentUnits.SetRange(Semester, SemesterCode);

                if not StudentUnits.IsEmpty then
                    exit(true);
            until ExamTimetableEntry.Next() = 0;

        exit(false);
    end;

    local procedure MinValue(Value1: Integer; Value2: Integer): Integer
    begin
        if Value1 < Value2 then
            exit(Value1)
        else
            exit(Value2);
    end;

    local procedure GetExamStudentCount(ExamEntry: Record "Exam Timetable Entry"): Integer
    var
        StudentUnits: Record "ACA-Student Units";
    begin
        // If student count field exists and has a value, use it
        if ExamEntry."Student Count" > 0 then
            exit(ExamEntry."Student Count");

        // Otherwise calculate from student units
        StudentUnits.Reset();
        StudentUnits.SetRange(Unit, ExamEntry."Unit Code");
        StudentUnits.SetRange(Semester, ExamEntry.Semester);
        exit(StudentUnits.Count);
    end;
    #endregion
    local procedure FindOptimalExamSlot(CourseOffering: Record "ACA-Lecturers Units";
        Semester: Record "ACA-Semesters";
        var ExamTimeSlot: Record "Exam Time Slot";
        var OptimalDate: Date;
        var CoursesPerDay: Dictionary of [Date, Integer]): Boolean
    begin
        // Use DistributeExamsEvenly to find the optimal date
        if DistributeExamsEvenly(CourseOffering, OptimalDate, Semester) then
            exit(FindAvailableSlotForDate(CourseOffering, OptimalDate, ExamTimeSlot, Semester));

        exit(false);
    end;

    local procedure FindAvailableSlotForDate(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        var AvailableSlot: Record "Exam Time Slot";
        Semester: Record "ACA-Semesters"): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        LectureHall: Record "ACA-Lecturer Halls Setup";
    begin
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", Semester.Code);
        ExamTimeSlot.SetRange(Active, true);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
        ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
        ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);

        if ExamTimeSlot.FindSet() then
            repeat
                // Find suitable lecture hall
                if FindAvailableExamRoom(CourseOffering, ExamDate, ExamTimeSlot, LectureHall) then begin
                    if not HasSchedulingConflicts(CourseOffering, ExamDate, ExamTimeSlot, Semester) then begin
                        AvailableSlot := ExamTimeSlot;
                        exit(true);
                    end;
                end;
            until ExamTimeSlot.Next() = 0;

        exit(false);
    end;

    local procedure FindAvailableExamRoom(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        var AvailableRoom: Record "ACA-Lecturer Halls Setup"): Boolean
    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        TotalStudents: Integer;
        RoomCapacityUsed: Integer;
        TimetableSetup: Record "Timetable Setup";
    begin
        TotalStudents := CourseOffering."Student Allocation";

        LectureHall.Reset();
        LectureHall.SetFilter("Exam Sitting Capacity", '>=%1', TotalStudents);
        LectureHall.SetRange("Hall Category", LectureHall."Hall Category"::Normal);

        if LectureHall.FindSet() then
            repeat
                Clear(RoomCapacityUsed);

                // Check existing bookings
                ExamTimetableEntry.Reset();
                ExamTimetableEntry.SetRange("Exam Date", ExamDate);
                ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);
                ExamTimetableEntry.SetRange("Lecture Hall", LectureHall."Lecture Room Code");
                if ExamTimetableEntry.FindSet() then
                    repeat
                        RoomCapacityUsed += GetExamStudentCount(ExamTimetableEntry);
                    until ExamTimetableEntry.Next() = 0;

                if (LectureHall."Exam Sitting Capacity" - RoomCapacityUsed) >= TotalStudents then begin
                    AvailableRoom := LectureHall;
                    exit(true);
                end;
            until LectureHall.Next() = 0;

        exit(false);
    end;

    local procedure HasSchedulingConflicts(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        Semester: Record "ACA-Semesters"): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        StudentUnits: Record "ACA-Student Units";
        ExistingStudentUnits: Record "ACA-Student Units";
        ProgramUnits: Record "ACA-Lecturers Units";
    begin
        // Check for program conflicts
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Time Slot", ExamTimeSlot.Code);
        ExamTimetableEntry.SetRange("Programme Code", CourseOffering.Programme);
        ExamTimetableEntry.SetRange("Stage Code", CourseOffering.Stage);
        if not ExamTimetableEntry.IsEmpty then
            exit(true);

        // Check for student conflicts
        StudentUnits.Reset();
        StudentUnits.SetRange(Unit, CourseOffering.Unit);
        StudentUnits.SetRange(Semester, Semester.Code);

        if StudentUnits.FindSet() then
            repeat
                if HasStudentExamConflict(
                    StudentUnits."Student No.",
                    ExamDate,
                    ExamTimeSlot.Code,
                    Semester.Code) then
                    exit(true);
            until StudentUnits.Next() = 0;

        exit(false);
    end;

    local procedure CreateExamTimetableEntry(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        Semester: Record "ACA-Semesters")
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        LectureHall: Record "ACA-Lecturer Halls Setup";
    begin
        if FindAvailableExamRoom(CourseOffering, ExamDate, ExamTimeSlot, LectureHall) then begin
            ExamTimetableEntry.Init();
            ExamTimetableEntry."Unit Code" := CourseOffering.Unit;
            ExamTimetableEntry.Semester := Semester.Code;
            ExamTimetableEntry."Exam Date" := ExamDate;
            ExamTimetableEntry."Time Slot" := ExamTimeSlot.Code;
            ExamTimetableEntry."Start Time" := ExamTimeSlot."Start Time";
            ExamTimetableEntry."End Time" := ExamTimeSlot."End Time";
            ExamTimetableEntry."Lecture Hall" := LectureHall."Lecture Room Code";
            ExamTimetableEntry."Programme Code" := CourseOffering.Programme;
            ExamTimetableEntry."Stage Code" := CourseOffering.Stage;
            ExamTimetableEntry.Status := ExamTimetableEntry.Status::Scheduled;
            ExamTimetableEntry.Insert(true);
        end;
    end;

    local procedure DistributeExamsEvenly(var CourseOffering: Record "ACA-Lecturers Units";
        var ExamDate: Date; Semester: Record "ACA-Semesters"): Boolean
    var
        ExamsPerDay: Dictionary of [Date, Integer];
        CurrentDate: Date;
        MinExams: Integer;
        SelectedDate: Date;
    begin
        CurrentDate := Semester."Exam Start Date";

        while CurrentDate <= Semester."Exam End Date" do begin
            // Check weekdays that are not holidays
            if (Date2DWY(CurrentDate, 1) <= 5) and (not IsHoliday(CurrentDate)) then begin
                if not ExamsPerDay.ContainsKey(CurrentDate) then
                    ExamsPerDay.Add(CurrentDate, 0);

                if (ExamsPerDay.Get(CurrentDate) < 3) and  // Max 3 exams per day
                   (not HasProgramConflict(CourseOffering, CurrentDate)) then begin
                    MinExams := 999;
                    if ExamsPerDay.Get(CurrentDate) < MinExams then begin
                        MinExams := ExamsPerDay.Get(CurrentDate);
                        SelectedDate := CurrentDate;
                    end;
                end;
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;

        if SelectedDate <> 0D then begin
            ExamDate := SelectedDate;
            ExamsPerDay.Set(SelectedDate, ExamsPerDay.Get(SelectedDate) + 1);
            exit(true);
        end;

        exit(false);
    end;

    local procedure HasProgramConflict(CourseOffering: Record "ACA-Lecturers Units"; ExamDate: Date): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        ProgramUnits: Record "ACA-Lecturers Units";
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        ExamTimetableEntry.SetRange("Programme Code", CourseOffering.Programme);
        ExamTimetableEntry.SetRange("Stage Code", CourseOffering.Stage);

        if ExamTimetableEntry.FindSet() then begin
            repeat
                ProgramUnits.Reset();
                ProgramUnits.SetRange(Programme, CourseOffering.Programme);
                ProgramUnits.SetRange(Stage, CourseOffering.Stage);
                ProgramUnits.SetRange(Unit, ExamTimetableEntry."Unit Code");

                if not ProgramUnits.IsEmpty then
                    exit(true);

            until ExamTimetableEntry.Next() = 0;
        end;

        exit(false);
    end;

    procedure FindSemester(SemesterCode: Code[25]; var Sems: Record "ACA-Semesters")
    begin
        Sems.Reset();
        Sems.SetRange(Code, SemesterCode);
        Sems.FindFirst();
    end;

    //Generate Supplementary timetable
    procedure GenerateSuppTimetable(SemesterCode: Code[25])
    var
        Semester: Record "ACA-Semesters";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        CourseOffering: Record "ACA-Lecturers Units";
        ExamTimeSlot: Record "Exam Time Slot";
        FirstDayUnits: Record "Exam First Day Units";
        ExamDate: Date;
        ProgressWindow: Dialog;
        TotalExams, CurrentExam : Integer;
        DayOfWeek: Integer;
        CoursesPerDay: Dictionary of [Date, Integer];
        DayCounter: Integer;
        SuppUnits: Record "Supp. Exam Units";
    begin
        // Clear invigilator cache for optimal performance
        ClearInvigilatorCache();

        FindSemester(SemesterCode, Semester);
        Semester.TestField("Supp Start Date");
        Semester.TestField("Supp End Date");

        // Clear existing exam timetable
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
        ExamTimetableEntry.SetRange("Exam Type", ExamTimetableEntry."Exam Type"::Supplementary);
        ExamTimetableEntry.DeleteAll(true);

        // Get active exam time slots for the semester
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.SetRange(Active, true);
        ExamTimeSlot.SetRange("Valid From Date", Semester."Supp Start Date");
        if not ExamTimeSlot.FindSet() then
            Error('No active Supp exam time slots defined for semester %1', SemesterCode);

        // Get courses with exams
        SuppUnits.Reset();
        SuppUnits.SetRange(Semester, SemesterCode);
        TotalExams := SuppUnits.Count();

        ProgressWindow.Open('Scheduling Supplementary Exams #1### of #2###\' +
                          'Current Unit: #3##################\' +
                          'Current Date: #4##################\' +
                          'Day: #5###');

        // STEP 1: First schedule all units that must be on the first day (priority)
        FirstDayUnits.Reset();
        if FirstDayUnits.FindSet() then begin
            repeat
                SuppUnits.Reset();
                SuppUnits.SetRange(Semester, SemesterCode);
                SuppUnits.SetRange("Unit Code", FirstDayUnits.Unit);

                if SuppUnits.FindSet() then begin
                    repeat
                        CurrentExam += 1;
                        ProgressWindow.Update(1, CurrentExam);
                        ProgressWindow.Update(2, TotalExams);
                        ProgressWindow.Update(3, SuppUnits."Unit Code");
                        ProgressWindow.Update(4, Semester."Exam Start Date");
                        ProgressWindow.Update(5, 1);

                        // Find appropriate slot on first day based on programme type (medical vs regular)
                        if ScheduleExamOnFirstDaySupp(SuppUnits, Semester, ExamTimeSlot) then begin
                            // Mark as scheduled
                        end;
                    until SuppUnits.Next() = 0;
                end;
            until FirstDayUnits.Next() = 0;
        end;

        // STEP 2: Schedule remaining units
        DayCounter := 1; // Start from day 2

        SuppUnits.Reset();
        SuppUnits.SetRange(Semester, SemesterCode);

        if SuppUnits.FindSet() then begin
            repeat
                // Skip units that have already been scheduled
                if not IsExamAlreadyScheduled(SuppUnits."Unit Code", SuppUnits."Stage Code", SemesterCode, SuppUnits.Programme) then begin
                    CurrentExam += 1;
                    Clear(ExamDate);

                    ProgressWindow.Update(1, CurrentExam);
                    ProgressWindow.Update(2, TotalExams);
                    ProgressWindow.Update(3, SuppUnits."Unit Code");

                    // Find optimal exam date and slot based on programme type
                    if FindOptimalExamSlotSupp(SuppUnits, Semester, ExamTimeSlot, ExamDate, CoursesPerDay, DayCounter) then begin
                        ProgressWindow.Update(4, ExamDate);
                        ProgressWindow.Update(5, DayCounter + 1);

                        // Create exam timetable entry with appropriate room assignment
                        // and student distribution if needed
                        ScheduleExamWithRoomAllocationSupp(
                            SuppUnits,
                            ExamDate,
                            ExamTimeSlot,
                            Semester);
                    end;
                end;

            until SuppUnits.Next() = 0;
        end;

        // STEP 3: Assign invigilators to all scheduled exams
        AssignInvigilatorsToExams(SemesterCode);

        ProgressWindow.Close();

        // Show distribution statistics
        ShowSessionDistributionMessage();
    end;

    local procedure TryScheduleExamOnDate(
        CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        Semester: Record "ACA-Semesters";
        GroupCode: Code[20];
        var CoursesPerDay: Dictionary of [Date, Integer];
        IsMedical: Boolean;
        DocumentNo: Code[20]): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotFound: Boolean;
    begin
        // Use FindTimeSlotForDay which now implements simple round-robin
        SlotFound := FindTimeSlotForDay(CourseOffering, ExamDate, ExamTimeSlot, IsMedical);

        if SlotFound then begin
            // Try to schedule with room allocation
            if ScheduleExamWithRoomAllocationGroup(
                CourseOffering,
                ExamDate,
                ExamTimeSlot,
                Semester,
                GroupCode,
                DocumentNo) then begin

                // Update courses per day counter
                if not CoursesPerDay.ContainsKey(ExamDate) then
                    CoursesPerDay.Add(ExamDate, 1)
                else
                    CoursesPerDay.Set(ExamDate, CoursesPerDay.Get(ExamDate) + 1);

                exit(true);
            end else begin
                // If room allocation failed, decrement the global counter
                case ExamTimeSlot."Session Type" of
                    0:
                        GlobalMorningCount -= 1;
                    1:
                        GlobalMiddayCount -= 1;
                    2:
                        GlobalAfternoonCount -= 1;
                end;
            end;
        end;

        exit(false);
    end;

    local procedure BuildAvailableDatesList(StartDate: Date; EndDate: Date; var AvailableDates: List of [Date])
    var
        CurrentDate: Date;
    begin
        AvailableDates.RemoveRange(1, AvailableDates.Count);
        CurrentDate := StartDate;

        while CurrentDate <= EndDate do begin
            // Skip weekends and holidays
            if (Date2DWY(CurrentDate, 1) <= 5) and not IsHoliday(CurrentDate) then
                AvailableDates.Add(CurrentDate);
            CurrentDate := CalcDate('1D', CurrentDate);
        end;
    end;

    local procedure FindLeastLoadedDate(AvailableDates: List of [Date]; CoursesPerDay: Dictionary of [Date, Integer]): Date
    var
        BestDate: Date;
        CurrentDate: Date;
        LowestLoad: Integer;
        CurrentLoad: Integer;
        IsFirst: Boolean;
    begin
        IsFirst := true;
        LowestLoad := 99999;

        foreach CurrentDate in AvailableDates do begin
            if CoursesPerDay.ContainsKey(CurrentDate) then
                CurrentLoad := CoursesPerDay.Get(CurrentDate)
            else
                CurrentLoad := 0;

            if IsFirst or (CurrentLoad < LowestLoad) then begin
                LowestLoad := CurrentLoad;
                BestDate := CurrentDate;
                IsFirst := false;
            end;
        end;

        exit(BestDate);
    end;

    local procedure FindLeastLoadedTimeSlot(
 var AvailableTimeSlots: Record "Exam Time Slot" temporary;
 ExamDate: Date;
 GroupCode: Code[20];
 var BestTimeSlot: Record "Exam Time Slot"): Boolean
    var
        CurrentSlot: Record "Exam Time Slot" temporary;
        SlotFound: Boolean;
        SlotsAvailable: array[3] of Boolean;
        SlotRecords: array[3] of Record "Exam Time Slot" temporary;
        RotationIndex: Integer;
        SessionTypeToUse: Integer;
        NextSessionType: Integer;
        i: Integer;
        SessionOrder: array[3] of Integer;
    begin
        SlotFound := false;
        Clear(SlotsAvailable);
        Clear(SlotRecords);

        // Categorize available time slots by session type
        AvailableTimeSlots.Reset();
        if AvailableTimeSlots.FindSet() then begin
            repeat
                CurrentSlot := AvailableTimeSlots;

                case CurrentSlot."Session Type" of
                    CurrentSlot."Session Type"::Morning:
                        begin
                            SlotsAvailable[1] := true;
                            SlotRecords[1] := CurrentSlot;
                        end;
                    CurrentSlot."Session Type"::Midday:
                        begin
                            SlotsAvailable[2] := true;
                            SlotRecords[2] := CurrentSlot;
                        end;
                    CurrentSlot."Session Type"::Afternoon:
                        begin
                            SlotsAvailable[3] := true;
                            SlotRecords[3] := CurrentSlot;
                        end;
                end;
            until AvailableTimeSlots.Next() = 0;
        end;

        // Determine which session type has been used least
        // This ensures true load balancing
        if GlobalMorningCount <= GlobalMiddayCount then begin
            if GlobalMorningCount <= GlobalAfternoonCount then
                SessionTypeToUse := 1 // Morning is least used
            else
                SessionTypeToUse := 3; // Afternoon is least used
        end else begin
            if GlobalMiddayCount <= GlobalAfternoonCount then
                SessionTypeToUse := 2 // Midday is least used
            else
                SessionTypeToUse := 3; // Afternoon is least used
        end;

        // Build rotation order starting from least used
        SessionOrder[1] := SessionTypeToUse;
        SessionOrder[2] := SessionTypeToUse mod 3 + 1; // Next in rotation
        SessionOrder[3] := (SessionTypeToUse + 1) mod 3 + 1; // Last in rotation

        // Try sessions in order of least used to most used
        for i := 1 to 3 do begin
            if SlotsAvailable[SessionOrder[i]] then begin
                BestTimeSlot := SlotRecords[SessionOrder[i]];
                exit(true);
            end;
        end;

        exit(false);
    end;

    local procedure GetNextRoundRobinSlotImproved(GroupExamCount: Integer; SlotsAvailable: array[3] of Boolean): Integer
    var
        AvailableSlotCount: Integer;
        SlotIndex: Integer;
        TargetSlot: Integer;
        i: Integer;
    begin
        // Count available slots
        AvailableSlotCount := 0;
        for i := 1 to 3 do begin
            if SlotsAvailable[i] then
                AvailableSlotCount += 1;
        end;

        if AvailableSlotCount = 0 then
            exit(0);

        // For pure round-robin, use modulo to cycle through slots
        // This ensures each slot gets used in turn
        SlotIndex := GroupExamCount mod 3; // 0, 1, 2, 0, 1, 2...

        // Map to 1-based index
        TargetSlot := SlotIndex + 1; // 1, 2, 3, 1, 2, 3...

        // If target slot is available, use it
        if SlotsAvailable[TargetSlot] then
            exit(TargetSlot);

        // Otherwise, find next available slot in sequence
        for i := 1 to 3 do begin
            TargetSlot += 1;
            if TargetSlot > 3 then
                TargetSlot := 1;

            if SlotsAvailable[TargetSlot] then
                exit(TargetSlot);
        end;

        // Fallback: return first available
        for i := 1 to 3 do begin
            if SlotsAvailable[i] then
                exit(i);
        end;

        exit(0);
    end;

    local procedure GetNextRoundRobinSlot(GroupCode: Code[20]; SlotsAvailable: array[3] of Boolean): Integer
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        LastUsedSlot: Integer;
        NextSlot: Integer;
        AttemptsCount: Integer;
        MorningTime: Time;
        MiddayTime: Time;
        AfternoonTime: Time;
    begin
        // Initialize time constants
        MorningTime := 090000T;
        MiddayTime := 120000T;
        AfternoonTime := 150000T;

        // Get the last used slot for this group from the most recent entry
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Group", GroupCode);
        if ExamTimetableEntry.FindLast() then begin
            // Determine what type of slot was used last
            if ExamTimetableEntry."Start Time" = MorningTime then
                LastUsedSlot := 1 // Morning
            else if ExamTimetableEntry."Start Time" = MiddayTime then
                LastUsedSlot := 2 // Midday  
            else if ExamTimetableEntry."Start Time" = AfternoonTime then
                LastUsedSlot := 3 // Afternoon
            else
                LastUsedSlot := 1; // Default to morning
        end else
            LastUsedSlot := 0; // No previous entries, start with first available

        // Find next available slot in round-robin fashion
        NextSlot := LastUsedSlot + 1;
        AttemptsCount := 0;

        while AttemptsCount < 3 do begin
            if NextSlot > 3 then
                NextSlot := 1; // Wrap around

            if SlotsAvailable[NextSlot] then
                exit(NextSlot);

            NextSlot += 1;
            AttemptsCount += 1;
        end;

        // Fallback: return first available slot
        if SlotsAvailable[1] then exit(1);
        if SlotsAvailable[2] then exit(2);
        if SlotsAvailable[3] then exit(3);

        exit(0); // No slots available
    end;

    local procedure BuildAvailableTimeSlotsForDate(ExamDate: Date; IsMedical: Boolean; var AllTimeSlots: Record "Exam Time Slot" temporary)
    var
        ExamTimeSlot: Record "Exam Time Slot";
    begin
        AllTimeSlots.Reset();
        AllTimeSlots.DeleteAll();

        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange(Active, true);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
        if IsMedical then
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
        else
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

        // Order time slots by start time to ensure proper distribution
        ExamTimeSlot.SetCurrentKey("Start Time");
        ExamTimeSlot.SetAscending("Start Time", true);

        if ExamTimeSlot.FindSet() then begin
            repeat
                AllTimeSlots := ExamTimeSlot;
                AllTimeSlots.Insert();
            until ExamTimeSlot.Next() = 0;
        end;
    end;

    local procedure SelectInvigilatorsOptimized(
        AvailableInvigilators: List of [Code[20]];
        RequiredCount: Integer;
        var SelectedInvigilators: List of [Code[20]];
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot")
    var
        InvigilatorNo: Code[20];
        Employee: Record "HRM-Employee C";
        InvigilatorWorkload: Record "Exam Invigilators";
        CurrentWorkload: Integer;
        WorkloadDict: Dictionary of [Code[20], Integer];
        SortedInvigilators: List of [Code[20]];
        Count: Integer;
    begin
        SelectedInvigilators.RemoveRange(1, SelectedInvigilators.Count);

        // Calculate current workload for each available invigilator
        foreach InvigilatorNo in AvailableInvigilators do begin
            InvigilatorWorkload.Reset();
            InvigilatorWorkload.SetRange("No.", InvigilatorNo);
            InvigilatorWorkload.SetRange(Date, ExamDate);
            CurrentWorkload := InvigilatorWorkload.Count();
            WorkloadDict.Add(InvigilatorNo, CurrentWorkload);
        end;

        // Sort invigilators by workload (ascending) and employment type (full-time first)
        SortInvigilatorsByWorkloadAndType(AvailableInvigilators, WorkloadDict, SortedInvigilators);

        // Select the required number
        Count := 0;
        foreach InvigilatorNo in SortedInvigilators do begin
            if Count >= RequiredCount then
                break;
            SelectedInvigilators.Add(InvigilatorNo);
            Count += 1;
        end;
    end;

    local procedure SortInvigilatorsByWorkloadAndType(
        AvailableInvigilators: List of [Code[20]];
        WorkloadDict: Dictionary of [Code[20], Integer];
        var SortedInvigilators: List of [Code[20]])
    var
        InvigilatorNo: Code[20];
        Employee: Record "HRM-Employee C";
        FullTimeInvigilators: List of [Code[20]];
        PartTimeInvigilators: List of [Code[20]];
        TempInvigilator: Code[20];
        TempWorkload: Integer;
        i, j : Integer;
    begin
        SortedInvigilators.RemoveRange(1, SortedInvigilators.Count);

        // Add all invigilators to full-time list (prioritize all equally for now)
        // TODO: Implement employment type check when field is available
        foreach InvigilatorNo in AvailableInvigilators do begin
            FullTimeInvigilators.Add(InvigilatorNo);
        end;

        // Sort full-time by workload first
        SortByWorkload(FullTimeInvigilators, WorkloadDict);
        SortByWorkload(PartTimeInvigilators, WorkloadDict);

        // Add to sorted list (full-time first)
        foreach InvigilatorNo in FullTimeInvigilators do
            SortedInvigilators.Add(InvigilatorNo);
        foreach InvigilatorNo in PartTimeInvigilators do
            SortedInvigilators.Add(InvigilatorNo);
    end;

    local procedure SortByWorkload(var InvigilatorList: List of [Code[20]]; WorkloadDict: Dictionary of [Code[20], Integer])
    var
        i, j : Integer;
        TempInvigilator: Code[20];
        Swapped: Boolean;
        InvigilatorArray: array[100] of Code[20];
        Count: Integer;
    begin
        // Convert list to array for sorting
        Count := InvigilatorList.Count;
        for i := 1 to Count do begin
            InvigilatorArray[i] := InvigilatorList.Get(i);
        end;

        // Bubble sort by workload
        repeat
            Swapped := false;
            for i := 1 to Count - 1 do begin
                if WorkloadDict.Get(InvigilatorArray[i]) > WorkloadDict.Get(InvigilatorArray[i + 1]) then begin
                    TempInvigilator := InvigilatorArray[i];
                    InvigilatorArray[i] := InvigilatorArray[i + 1];
                    InvigilatorArray[i + 1] := TempInvigilator;
                    Swapped := true;
                end;
            end;
        until not Swapped;

        // Convert back to list
        InvigilatorList.RemoveRange(1, InvigilatorList.Count);
        for i := 1 to Count do begin
            InvigilatorList.Add(InvigilatorArray[i]);
        end;
    end;

    // Global variables for caching
    var
        CachedBusyInvigilators: Dictionary of [Text[100], List of [Code[20]]];
        CachedLecturersByDept: Dictionary of [Code[20], List of [Code[20]]];
        CacheInitialized: Boolean;
        GlobalSessionCounter: array[3] of Integer; // Track total exams per session type
        LastUsedSessionType: Integer; // For round-robin distribution

    // Cache management for busy invigilators
    local procedure TryGetCachedBusyInvigilators(SessionKey: Text[100]; var BusyInvigilators: List of [Code[20]]): Boolean
    begin
        if CachedBusyInvigilators.ContainsKey(SessionKey) then begin
            BusyInvigilators := CachedBusyInvigilators.Get(SessionKey);
            exit(true);
        end;
        exit(false);
    end;

    local procedure CacheBusyInvigilators(SessionKey: Text[100]; BusyInvigilators: List of [Code[20]])
    begin
        if not CachedBusyInvigilators.ContainsKey(SessionKey) then
            CachedBusyInvigilators.Add(SessionKey, BusyInvigilators)
        else
            CachedBusyInvigilators.Set(SessionKey, BusyInvigilators);
    end;

    // Clear cache when starting new timetable generation
    local procedure ClearInvigilatorCache()
    var
        i: Integer;
    begin
        Clear(CachedBusyInvigilators);
        Clear(CachedLecturersByDept);
        CacheInitialized := false;

        // Reset global session counters
        GlobalMorningCount := 0;
        GlobalMiddayCount := 0;
        GlobalAfternoonCount := 0;
    end;

    local procedure GetNextSessionTypeInRotation(): Integer
    var
        TotalAssigned: Integer;
        RotationPosition: Integer;
    begin
        // Calculate total sessions assigned so far
        TotalAssigned := GlobalMorningCount + GlobalMiddayCount + GlobalAfternoonCount;

        // Use strict rotation: 0=Morning, 1=Midday, 2=Afternoon
        RotationPosition := TotalAssigned mod 3;

        // Return session type (0=Morning, 1=Midday, 2=Afternoon)
        exit(RotationPosition);
    end;

    local procedure UpdateGlobalSessionCounter(SessionType: Option Morning,Midday,Afternoon)
    begin
        case SessionType of
            SessionType::Morning:
                GlobalMorningCount += 1;
            SessionType::Midday:
                GlobalMiddayCount += 1;
            SessionType::Afternoon:
                GlobalAfternoonCount += 1;
        end;
    end;

    // Optimized lecturer checking with caching
    local procedure IsLecturerActive(LecturerNo: Code[20]): Boolean
    var
        Employee: Record "HRM-Employee C";
    begin
        if Employee.Get(LecturerNo) then
            exit((Employee.Status = Employee.Status::Active) and (Employee.Lecturer = true));
        exit(false);
    end;

    // Initialize department lecturer cache
    local procedure InitializeDepartmentCache()
    var
        LecturerUnits: Record "ACA-Lecturers Units";
        DeptLecturers: List of [Code[20]];
        CurrentDept: Code[20];
        TempLecturers: Dictionary of [Code[20], Boolean];
    begin
        if CacheInitialized then
            exit;

        Clear(CachedLecturersByDept);
        Clear(TempLecturers);

        LecturerUnits.Reset();
        LecturerUnits.SetCurrentKey(Lecturer);
        if LecturerUnits.FindSet() then
            repeat
                if LecturerUnits.Lecturer <> '' then begin
                    LecturerUnits.CalcFields("Department Code");
                    CurrentDept := LecturerUnits."Department Code";

                    if CurrentDept <> '' then begin
                        // Get or create department list
                        if CachedLecturersByDept.ContainsKey(CurrentDept) then
                            DeptLecturers := CachedLecturersByDept.Get(CurrentDept)
                        else
                            Clear(DeptLecturers);

                        // Add lecturer if not already in department list
                        if not DeptLecturers.Contains(LecturerUnits.Lecturer) then begin
                            if IsLecturerActive(LecturerUnits.Lecturer) then begin
                                DeptLecturers.Add(LecturerUnits.Lecturer);
                                CachedLecturersByDept.Set(CurrentDept, DeptLecturers);
                            end;
                        end;
                    end;
                end;
            until LecturerUnits.Next() = 0;

        CacheInitialized := true;
    end;

    // Optimized collection methods using cache
    local procedure CollectDepartmentLecturersOptimized(
        Department: Code[20];
        BusyInvigilators: List of [Code[20]];
        var ProcessedLecturers: List of [Code[20]];
        var AvailableInvigilators: List of [Code[20]])
    var
        DeptLecturers: List of [Code[20]];
        LecturerNo: Code[20];
        RequiredCount: Integer;
    begin
        RequiredCount := 5; // Get up to 5 from department
        InitializeDepartmentCache();

        if CachedLecturersByDept.ContainsKey(Department) then begin
            DeptLecturers := CachedLecturersByDept.Get(Department);

            foreach LecturerNo in DeptLecturers do begin
                if AvailableInvigilators.Count >= RequiredCount then
                    break;

                if not ProcessedLecturers.Contains(LecturerNo) and
                   not BusyInvigilators.Contains(LecturerNo) then begin
                    AvailableInvigilators.Add(LecturerNo);
                    ProcessedLecturers.Add(LecturerNo);
                end;
            end;
        end;
    end;

    local procedure CollectLecturersFromOtherDepartmentsOptimized(
        ExcludeDepartment: Code[20];
        BusyInvigilators: List of [Code[20]];
        var ProcessedLecturers: List of [Code[20]];
        var AvailableInvigilators: List of [Code[20]])
    var
        DeptCode: Code[20];
        DeptLecturers: List of [Code[20]];
        LecturerNo: Code[20];
        RequiredCount: Integer;
        DeptKeys: List of [Code[20]];
    begin
        RequiredCount := 3; // Maximum from other departments
        InitializeDepartmentCache();

        // Get all department keys
        foreach DeptCode in CachedLecturersByDept.Keys do begin
            if DeptCode <> ExcludeDepartment then
                DeptKeys.Add(DeptCode);
        end;

        // Collect from other departments
        foreach DeptCode in DeptKeys do begin
            if AvailableInvigilators.Count >= RequiredCount then
                break;

            DeptLecturers := CachedLecturersByDept.Get(DeptCode);
            foreach LecturerNo in DeptLecturers do begin
                if AvailableInvigilators.Count >= RequiredCount then
                    break;

                if not ProcessedLecturers.Contains(LecturerNo) and
                   not BusyInvigilators.Contains(LecturerNo) then begin
                    AvailableInvigilators.Add(LecturerNo);
                    ProcessedLecturers.Add(LecturerNo);
                end;
            end;
        end;
    end;

    local procedure CollectAllRemainingLecturersOptimized(
        BusyInvigilators: List of [Code[20]];
        ProcessedLecturers: List of [Code[20]];
        var AvailableInvigilators: List of [Code[20]])
    var
        Employee: Record "HRM-Employee C";
        RequiredCount: Integer;
    begin
        RequiredCount := 2; // Minimum required

        Employee.Reset();
        Employee.SetRange(Lecturer, true);
        Employee.SetRange(Status, Employee.Status::Active);

        if Employee.FindSet() then
            repeat
                if AvailableInvigilators.Count >= RequiredCount then
                    break;

                if not ProcessedLecturers.Contains(Employee."No.") and
                   not BusyInvigilators.Contains(Employee."No.") then begin
                    AvailableInvigilators.Add(Employee."No.");
                    ProcessedLecturers.Add(Employee."No.");
                end;
            until Employee.Next() = 0;
    end;

    // Session load balancing functions
    local procedure CalculateSessionLoadsForDate(ExamDate: Date; var SessionLoad: Dictionary of [Integer, Integer])
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        ExamTimeSlot: Record "Exam Time Slot";
        SessionType: Integer;
        CurrentLoad: Integer;
    begin
        // Initialize session loads
        Clear(SessionLoad);
        SessionLoad.Add(0, 0); // Morning
        SessionLoad.Add(1, 0); // Midday
        SessionLoad.Add(2, 0); // Afternoon

        // Count existing exams for each session type on this date
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Exam Date", ExamDate);
        if ExamTimetableEntry.FindSet() then
            repeat
                if ExamTimeSlot.Get(ExamTimetableEntry."Time Slot") then begin
                    SessionType := ExamTimeSlot."Session Type";
                    if SessionLoad.ContainsKey(SessionType) then begin
                        CurrentLoad := SessionLoad.Get(SessionType);
                        SessionLoad.Set(SessionType, CurrentLoad + 1);
                    end;
                end;
            until ExamTimetableEntry.Next() = 0;
    end;

    local procedure FindLeastLoadedSessionType(SessionLoad: Dictionary of [Integer, Integer]): Integer
    var
        BestSessionType: Integer;
        LowestLoad: Integer;
        CurrentLoad: Integer;
        SessionType: Integer;
        IsFirst: Boolean;
    begin
        BestSessionType := 0; // Default to Morning
        LowestLoad := 99999;
        IsFirst := true;

        // Find session type with lowest load
        foreach SessionType in SessionLoad.Keys do begin
            CurrentLoad := SessionLoad.Get(SessionType);
            if IsFirst or (CurrentLoad < LowestLoad) then begin
                LowestLoad := CurrentLoad;
                BestSessionType := SessionType;
                IsFirst := false;
            end;
        end;

        exit(BestSessionType);
    end;

    local procedure TryAlternativeSessionTypes(
        CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        IsMedical: Boolean;
        SessionLoad: Dictionary of [Integer, Integer];
        ExcludeSessionType: Integer;
        var SelectedTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SessionTypeList: List of [Integer];
        SessionType: Integer;
        CurrentLoad: Integer;
        TempLoad: Dictionary of [Integer, Integer];
    begin
        // Create sorted list of session types by load (excluding the already tried one)
        foreach SessionType in SessionLoad.Keys do begin
            if SessionType <> ExcludeSessionType then begin
                CurrentLoad := SessionLoad.Get(SessionType);
                TempLoad.Add(SessionType, CurrentLoad);
            end;
        end;

        // Sort by load and try each session type
        SessionTypeList := SortSessionTypesByLoad(TempLoad);

        foreach SessionType in SessionTypeList do begin
            ExamTimeSlot.Reset();
            ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
            ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
            ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
            ExamTimeSlot.SetRange("Session Type", SessionType);

            if IsMedical then
                ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
            else
                ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

            if ExamTimeSlot.FindSet() then begin
                repeat
                    if not HasSchedulingConflicts(CourseOffering, ExamDate, ExamTimeSlot) then begin
                        if HasSufficientInvigilatorsForSlot(ExamDate, ExamTimeSlot, CourseOffering) then begin
                            SelectedTimeSlot := ExamTimeSlot;
                            exit(true);
                        end;
                    end;
                until ExamTimeSlot.Next() = 0;
            end;
        end;

        exit(false);
    end;

    local procedure SortSessionTypesByLoad(SessionLoad: Dictionary of [Integer, Integer]): List of [Integer]
    var
        SessionTypeList: List of [Integer];
        SessionArray: array[10] of Integer;
        LoadArray: array[10] of Integer;
        Count: Integer;
        i, j : Integer;
        TempSession, TempLoad : Integer;
        SessionType: Integer;
        Swapped: Boolean;
    begin
        // Convert to arrays for sorting
        Count := 0;
        foreach SessionType in SessionLoad.Keys do begin
            Count += 1;
            SessionArray[Count] := SessionType;
            LoadArray[Count] := SessionLoad.Get(SessionType);
        end;

        // Bubble sort by load (ascending)
        repeat
            Swapped := false;
            for i := 1 to Count - 1 do begin
                if LoadArray[i] > LoadArray[i + 1] then begin
                    // Swap loads
                    TempLoad := LoadArray[i];
                    LoadArray[i] := LoadArray[i + 1];
                    LoadArray[i + 1] := TempLoad;

                    // Swap session types
                    TempSession := SessionArray[i];
                    SessionArray[i] := SessionArray[i + 1];
                    SessionArray[i + 1] := TempSession;

                    Swapped := true;
                end;
            end;
        until not Swapped;

        // Convert back to list
        Clear(SessionTypeList);
        for i := 1 to Count do begin
            SessionTypeList.Add(SessionArray[i]);
        end;

        exit(SessionTypeList);
    end;

    local procedure HasSufficientInvigilatorsForSlot(
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        CourseOffering: Record "ACA-Lecturers Units"): Boolean
    var
        AvailableInvigilators: List of [Code[20]];
        RequiredInvigilators: Integer;
        InvigilatorSetup: Record "Invigilator Setup";
    begin
        // Calculate required invigilators for this course
        if InvigilatorSetup.FindFirst() then
            RequiredInvigilators := CalculateRequiredInvigilators(CourseOffering."Student Allocation", InvigilatorSetup)
        else
            RequiredInvigilators := 2; // Default minimum

        // Get available invigilators for this slot
        CourseOffering.CalcFields("Department Code");
        GetAvailableInvigilatorsFromLecturersOptimized(
            CourseOffering."Department Code",
            ExamDate,
            ExamTimeSlot,
            CourseOffering.Lecturer,
            AvailableInvigilators);

        // Check if we have enough invigilators
        exit(AvailableInvigilators.Count >= RequiredInvigilators);
    end;

    // Supplementary exam helper functions
    local procedure HasSufficientInvigilatorsForSlotSupp(
        ExamDate: Date;
        ExamTimeSlot: Record "Exam Time Slot";
        SuppUnits: Record "Supp. Exam Units"): Boolean
    var
        AvailableInvigilators: List of [Code[20]];
        RequiredInvigilators: Integer;
        InvigilatorSetup: Record "Invigilator Setup";
        Department: Code[20];
    begin
        // Calculate required invigilators for this supplementary exam
        if InvigilatorSetup.FindFirst() then
            RequiredInvigilators := CalculateRequiredInvigilators(SuppUnits."Student Allocation", InvigilatorSetup)
        else
            RequiredInvigilators := 2; // Default minimum

        // Get department from supplementary units
        Department := GetCourseDepartmentSupp(SuppUnits);

        // Get available invigilators for this slot
        GetAvailableInvigilatorsFromLecturersOptimized(
            Department,
            ExamDate,
            ExamTimeSlot,
            SuppUnits."Lecturer Code",
            AvailableInvigilators);

        // Check if we have enough invigilators
        exit(AvailableInvigilators.Count >= RequiredInvigilators);
    end;

    local procedure TryAlternativeSessionTypesSupp(
        SuppUnits: Record "Supp. Exam Units";
        ExamDate: Date;
        IsMedical: Boolean;
        SessionLoad: Dictionary of [Integer, Integer];
        ExcludeSessionType: Integer;
        var SelectedTimeSlot: Record "Exam Time Slot"): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SessionTypeList: List of [Integer];
        SessionType: Integer;
        CurrentLoad: Integer;
        TempLoad: Dictionary of [Integer, Integer];
    begin
        // Create sorted list of session types by load (excluding the already tried one)
        foreach SessionType in SessionLoad.Keys do begin
            if SessionType <> ExcludeSessionType then begin
                CurrentLoad := SessionLoad.Get(SessionType);
                TempLoad.Add(SessionType, CurrentLoad);
            end;
        end;

        // Sort by load and try each session type
        SessionTypeList := SortSessionTypesByLoad(TempLoad);

        foreach SessionType in SessionTypeList do begin
            ExamTimeSlot.Reset();
            ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
            ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
            ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);
            ExamTimeSlot.SetRange("Session Type", SessionType);

            if IsMedical then
                ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
            else
                ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

            if ExamTimeSlot.FindSet() then begin
                repeat
                    if not HasSchedulingConflictsSupp(SuppUnits, ExamDate, ExamTimeSlot) then begin
                        if HasSufficientInvigilatorsForSlotSupp(ExamDate, ExamTimeSlot, SuppUnits) then begin
                            SelectedTimeSlot := ExamTimeSlot;
                            exit(true);
                        end;
                    end;
                until ExamTimeSlot.Next() = 0;
            end;
        end;

        exit(false);
    end;

    local procedure ShowSessionDistributionMessage()
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        MorningCount: Integer;
        MiddayCount: Integer;
        AfternoonCount: Integer;
        DistributionText: Text;
    begin
        // Count actual sessions by session type
        ExamTimetableEntry.Reset();
        if ExamTimetableEntry.FindSet() then
            repeat
                case ExamTimetableEntry."Session Type" of
                    ExamTimetableEntry."Session Type"::Morning:
                        MorningCount += 1;
                    ExamTimetableEntry."Session Type"::Midday:
                        MiddayCount += 1;
                    ExamTimetableEntry."Session Type"::Afternoon:
                        AfternoonCount += 1;
                end;
            until ExamTimetableEntry.Next() = 0;

        DistributionText := StrSubstNo('Session Distribution: Morning: %1, Midday: %2, Afternoon: %3',
                                      MorningCount, MiddayCount, AfternoonCount);
        Message(DistributionText);
    end;

    local procedure ShowSessionDistributionMessageForGroup(GroupDescription: Text[100]; CurrentExam: Integer)
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
        MorningCount: Integer;
        MiddayCount: Integer;
        AfternoonCount: Integer;
        TotalCount: Integer;
        MorningPct: Decimal;
        MiddayPct: Decimal;
        AfternoonPct: Decimal;
        DebugMessage: Text;
    begin
        // Count actual sessions by session type
        ExamTimetableEntry.Reset();
        if ExamTimetableEntry.FindSet() then
            repeat
                case ExamTimetableEntry."Session Type" of
                    ExamTimetableEntry."Session Type"::Morning:
                        MorningCount += 1;
                    ExamTimetableEntry."Session Type"::Midday:
                        MiddayCount += 1;
                    ExamTimetableEntry."Session Type"::Afternoon:
                        AfternoonCount += 1;
                end;
            until ExamTimetableEntry.Next() = 0;

        TotalCount := MorningCount + MiddayCount + AfternoonCount;

        // Debug information about global counters
        DebugMessage := StrSubstNo('Debug - Global Counters: Morning=%1, Midday=%2, Afternoon=%3',
                                  GlobalMorningCount, GlobalMiddayCount, GlobalAfternoonCount);

        if TotalCount > 0 then begin
            MorningPct := Round((MorningCount * 100.0) / TotalCount, 0.01);
            MiddayPct := Round((MiddayCount * 100.0) / TotalCount, 0.01);
            AfternoonPct := Round((AfternoonCount * 100.0) / TotalCount, 0.01);

            Message('Exam timetable generation completed for group: %1\' +
                    'Total exams scheduled: %2\' +
                    '\' +
                    'Session Distribution:\' +
                    'Morning: %3 exams (%4%%)\' +
                    'Midday: %5 exams (%6%%)\' +
                    'Afternoon: %7 exams (%8%%)\' +
                    '\' +
                    '%9',
                    GroupDescription, CurrentExam,
                    MorningCount, MorningPct,
                    MiddayCount, MiddayPct,
                    AfternoonCount, AfternoonPct,
                    DebugMessage);
        end else begin
            Message('Exam timetable generation completed for group: %1\' +
                    'No exams were scheduled.', GroupDescription);
        end;
    end;

    // Global session counters for strict rotation
    var
        GlobalMorningCount: Integer;
        GlobalMiddayCount: Integer;
        GlobalAfternoonCount: Integer;

}