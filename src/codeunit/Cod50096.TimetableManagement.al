codeunit 50096 "Timetable Management"
{

    trigger OnRun()
    begin
        GenerateTimetable('2024', 'S1');
    end;

    procedure GenerateExamTimeSlots(SemesterCode: Code[25])
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
        Semester.TestField("Exam Start Date");
        Semester.TestField("Exam End Date");

        Window.Open('Generating Time Slots...\' +
                   'Group: #1################\' +
                   'Date: #2################\' +
                   'Slot: #3################');

        // Clear existing slots for this semester
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.DeleteAll();

        // Generate Regular Exam Slots
        Window.Update(1, 'Regular');
        GenerateRegularSlots(Semester, SemesterCode);

        // Generate Medical Exam Slots
        Window.Update(1, 'Medical');
        GenerateMedicalSlots(Semester, SemesterCode);

        Window.Close();
        Message('Time slots generated successfully.');
    end;

    local procedure GenerateRegularSlots(Semester: Record "ACA-Semesters"; SemesterCode: Code[25])
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
        Window: Dialog;
    begin
        CurrentDate := Semester."Exam Start Date";

        while CurrentDate <= Semester."Exam End Date" do begin
            // Skip weekends
            if Date2DWY(CurrentDate, 1) <= 5 then begin
                Window.Update(2, Format(CurrentDate));

                // Morning session (9:00 AM - 11:00 AM)
                SlotCode := CreateSlotCode(CurrentDate, 'R-M');
                Window.Update(3, SlotCode);
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
                Window.Update(3, SlotCode);
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
                Window.Update(3, SlotCode);
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

    local procedure GenerateMedicalSlots(Semester: Record "ACA-Semesters"; SemesterCode: Code[25])
    var
        ExamTimeSlot: Record "Exam Time Slot";
        SlotCode: Code[20];
        CurrentDate: Date;
        DayCount: Integer;
        Window: Dialog;
    begin
        CurrentDate := Semester."Exam Start Date";
        DayCount := 0;

        while CurrentDate <= Semester."Exam End Date" do begin
            // Skip weekends
            if Date2DWY(CurrentDate, 1) <= 5 then begin
                Window.Update(2, Format(CurrentDate));
                DayCount += 1;

                if DayCount = 1 then begin
                    // First day: Three sessions like regular exams

                    // Morning session (9:00 AM - 11:00 AM)
                    SlotCode := CreateSlotCode(CurrentDate, 'M-M');
                    Window.Update(3, SlotCode);
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
                    Window.Update(3, SlotCode);
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
                    Window.Update(3, SlotCode);
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
                    Window.Update(3, SlotCode);
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
                    Window.Update(3, SlotCode);
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

    local procedure CreateSlotCode(ExamDate: Date; SessionCode: Code[3]): Code[20]
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
        CourseOffering.CalcFields("Unit Students Count");
        // Find suitable lecture hall
        LectureHall.Reset();
        //LectureHall.SetAutoCalcFields("Sitting Capacity");
        LectureHall.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Unit Students Count");
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
        CourseOffering.CalcFields("Unit Students Count");
        StudentCount := CourseOffering."Unit Students Count";
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
        CourseOffering.CalcFields("Unit Students Count");
        StudentCount := CourseOffering."Unit Students Count";
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
            LectureHall.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Unit Students Count");

        // Find suitable lab for practical with required equipment
        LabRoom.Reset();
        LabRoom.SetRange(Status, LabRoom.Status::Active);
        if RequiresSplit then
            LabRoom.SetFilter("Sitting Capacity", '>=%1', FirstGroupSize)
        else
            LabRoom.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Unit Students Count");

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
    begin
        FindSemester(SemesterCode, Semester);
        Semester.TestField("Exam Start Date");
        Semester.TestField("Exam End Date");

        // Clear existing exam timetable
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
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
                if not IsExamAlreadyScheduled(CourseOffering.Unit, SemesterCode) then begin
                    CurrentExam += 1;
                    Clear(ExamDate);

                    ProgressWindow.Update(1, CurrentExam);
                    ProgressWindow.Update(2, TotalExams);
                    ProgressWindow.Update(3, CourseOffering.Unit);

                    // Find optimal exam date and slot based on programme type
                    if FindOptimalExamSlot(CourseOffering, Semester, ExamTimeSlot, ExamDate, CoursesPerDay, DayCounter) then begin
                        ProgressWindow.Update(4, ExamDate);
                        ProgressWindow.Update(5, DayCounter + 1);

                        // Create exam timetable entry with appropriate room assignment
                        // and student distribution if needed
                        ScheduleExamWithRoomAllocation(
                            CourseOffering,
                            ExamDate,
                            ExamTimeSlot,
                            Semester);
                    end else
                        LogSchedulingIssue(CourseOffering);
                end;

            until CourseOffering.Next() = 0;
        end;

        // STEP 3: Assign invigilators to all scheduled exams
        AssignInvigilatorsToExams(SemesterCode);

        ProgressWindow.Close();
        Message('Exam timetable generation completed successfully.');
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

    local procedure IsExamAlreadyScheduled(UnitCode: Code[25]; SemesterCode: Code[25]): Boolean
    var
        ExamTimetableEntry: Record "Exam Timetable Entry";
    begin
        ExamTimetableEntry.Reset();
        ExamTimetableEntry.SetRange("Unit Code", UnitCode);
        ExamTimetableEntry.SetRange(Semester, SemesterCode);
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
    begin
        // Determine if this is a medical programme
        IsMedical := IsMedicalProgramme(CourseOffering.Programme);

        // Calculate date based on day counter
        CurrentDate := CalcDate(StrSubstNo('%1D', DayCounter), Semester."Exam Start Date");

        // Ensure we don't go beyond exam end date
        if CurrentDate > Semester."Exam End Date" then
            exit(false);

        // Skip weekends
        while (Date2DWY(CurrentDate, 1) > 5) and (CurrentDate <= Semester."Exam End Date") do begin
            CurrentDate := CalcDate('1D', CurrentDate);
            DayCounter += 1;
        end;

        // If we've gone beyond the exam period, return false
        if CurrentDate > Semester."Exam End Date" then
            exit(false);

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
        exit(FindOptimalExamSlot(CourseOffering, Semester, ExamTimeSlot, OptimalDate, CoursesPerDay, DayCounter));
    end;

    local procedure FindTimeSlotForDay(CourseOffering: Record "ACA-Lecturers Units";
        ExamDate: Date;
        var SelectedTimeSlot: Record "Exam Time Slot";
        IsMedical: Boolean): Boolean
    var
        ExamTimeSlot: Record "Exam Time Slot";
    begin
        // Find appropriate slot based on programme type
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
        ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);

        if IsMedical then
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Medical)
        else
            ExamTimeSlot.SetRange("Slot Group", ExamTimeSlot."Slot Group"::Regular);

        if ExamTimeSlot.FindSet() then begin
            repeat
                // Check if this slot would have conflicts
                if not HasSchedulingConflicts(CourseOffering, ExamDate, ExamTimeSlot) then begin
                    SelectedTimeSlot := ExamTimeSlot;
                    exit(true);
                end;
            until ExamTimeSlot.Next() = 0;
        end;

        // Fallback to any available slot if specific group not found
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetFilter("Valid From Date", '<=%1', ExamDate);
        ExamTimeSlot.SetFilter("Valid To Date", '>=%1', ExamDate);
        ExamTimeSlot.SetRange("Day of Week", Date2DWY(ExamDate, 1) - 1);

        if ExamTimeSlot.FindSet() then begin
            repeat
                if not HasSchedulingConflicts(CourseOffering, ExamDate, ExamTimeSlot) then begin
                    SelectedTimeSlot := ExamTimeSlot;
                    exit(true);
                end;
            until ExamTimeSlot.Next() = 0;
        end;

        exit(false);
    end;

    local procedure ScheduleExamWithRoomAllocation(CourseOffering: Record "ACA-Lecturers Units";
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
        CurrentFloor: Text;
        SameFloorRooms: List of [Integer];
        RoomIndex: Integer;
    begin
        CourseOffering.CalcFields("Unit Students Count");
        TotalStudents := CourseOffering."Unit Students Count";
        RemainingStudents := TotalStudents;

        // Get available exam rooms
        GetAvailableExamRooms(ExamDate, ExamTimeSlot, AvailableRooms, AvailableCapacities, RoomCount);

        if RoomCount = 0 then begin
            LogSchedulingIssue(CourseOffering);
            exit;
        end;

        // Try to allocate all students to a single room if possible
        for i := 1 to RoomCount do begin
            if AvailableCapacities[i] >= TotalStudents then begin
                // Create exam entry for the entire class
                CreateExamEntry(CourseOffering, ExamDate, ExamTimeSlot,
                    AvailableRooms[i]."Lecture Room Code", TotalStudents, Semester.Code);

                // Assign invigilators for this room
                AssignInvigilatorsToRoom(CourseOffering, ExamDate, ExamTimeSlot,
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
                        CreateExamEntry(CourseOffering, ExamDate, ExamTimeSlot,
                            AvailableRooms[RoomIndex]."Lecture Room Code", StudentsInRoom, Semester.Code);

                        // Assign invigilators
                        AssignInvigilatorsToRoom(CourseOffering, ExamDate, ExamTimeSlot,
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
                    AssignInvigilatorsToRoom(CourseOffering, ExamDate, ExamTimeSlot,
                        AvailableRooms[i]."Lecture Room Code", StudentsInRoom, Semester.Code);

                    RemainingStudents -= StudentsInRoom;

                    if RemainingStudents <= 0 then
                        break;
                end;
            end;
        end;

        // Log issue if we couldn't accommodate all students
        if RemainingStudents > 0 then
            LogSchedulingIssue(CourseOffering);
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
        ExamTimetableEntry.Insert(true);
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
        Floor1, Floor2 : Text;
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

    local procedure GetRoomFloor(RoomCode: Code[20]): Text
    var
        FloorPart: Text;
        i: Integer;
    begin
        // Extract floor from room code - customize based on your naming convention
        // Example: If room code is "F2-R204", this would return "F2"
        // This is a placeholder - update with your actual logic

        i := StrPos(RoomCode, '-');
        if i > 0 then
            exit(CopyStr(RoomCode, 1, i - 1));

        // Default fallback
        exit('');
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
                AssignInvigilatorsToRoom(
                    GetCourseOffering(ExamTimetableEntry."Unit Code", SemesterCode),
                    ExamTimetableEntry."Exam Date",
                    GetExamTimeSlot(ExamTimetableEntry."Time Slot", SemesterCode),
                    ExamTimetableEntry."Lecture Hall",
                    StudentCount,
                    SemesterCode);
            until ExamTimetableEntry.Next() = 0;
    end;

    local procedure AssignInvigilatorsToRoom(CourseOffering: Record "ACA-Lecturers Units";
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
        Department := GetCourseDepartment(CourseOffering);

        // Get available invigilators from department
        GetAvailableInvigilators(Department, ExamDate, ExamTimeSlot, AvailableInvigilators);

        // Select required number of invigilators, prioritizing full-timers
        SelectInvigilators(AvailableInvigilators, InvigilatorCount, SelectedInvigilators);

        // Assign the selected invigilators
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
                ExamInvigilator.Category := GetEmployeeCategory(Employee);
                ExamInvigilator.Insert();
            end;
        end;
    end;

    local procedure GetCourseDepartment(CourseOffering: Record "ACA-Lecturers Units"): Code[20]
    begin
        // Get department from unit setup
        CourseOffering.CalcFields("Department Code");
        exit(CourseOffering."Department Code");
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

    local procedure SelectInvigilators(var AvailableInvigilators: List of [Code[20]];
    RequiredCount: Integer;
    var SelectedInvigilators: List of [Code[20]])
    var
        Employee: Record "HRM-Employee C";
        FullTimers: List of [Code[20]];
        PartTimers: List of [Code[20]];
        InvigilatorNo: Code[20];
        i: Integer;
        ShouldSkip: Boolean;
    begin
        Clear(SelectedInvigilators);
        Clear(FullTimers);
        Clear(PartTimers);

        // Separate full-timers and part-timers
        foreach InvigilatorNo in AvailableInvigilators do begin
            if Employee.Get(InvigilatorNo) then begin
                if (Employee."Full / Part Time" = Employee."Full / Part Time"::"Full Time") or
                   (Employee."Full / Part Time" = Employee."Full / Part Time"::Contract) then
                    FullTimers.Add(InvigilatorNo)
                else
                    PartTimers.Add(InvigilatorNo);
            end;
        end;

        // First select full-timers
        i := 0;
        foreach InvigilatorNo in FullTimers do begin
            if i >= RequiredCount then
                break;

            SelectedInvigilators.Add(InvigilatorNo);
            i += 1;
        end;

        // If we need more, add part-timers
        if i < RequiredCount then
            foreach InvigilatorNo in PartTimers do begin
                if i >= RequiredCount then
                    break;

                SelectedInvigilators.Add(InvigilatorNo);
                i += 1;
            end;

        // If we still don't have enough, go back to available invigilators
        if i < RequiredCount then
            foreach InvigilatorNo in AvailableInvigilators do begin
                ShouldSkip := false;
                if i >= RequiredCount then
                    ShouldSkip := true;

                if SelectedInvigilators.Contains(InvigilatorNo) then
                    ShouldSkip := true;

                if not ShouldSkip then begin
                    SelectedInvigilators.Add(InvigilatorNo);
                    i += 1;
                end;
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
        CourseOffering.CalcFields("Unit Students Count");
        TotalStudents := CourseOffering."Unit Students Count";

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
            if Date2DWY(CurrentDate, 1) <= 5 then begin  // Monday to Friday
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

}