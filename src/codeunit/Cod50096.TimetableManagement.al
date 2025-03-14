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
        DayCounter: Integer;
        CurrentDate: Date;
        Window: Dialog;
    begin
        // Validate semester
        FindSemester(SemesterCode, Semester);
        Semester.TestField("Exam Start Date");
        Semester.TestField("Exam End Date");

        Window.Open('Generating Time Slots...\' +
                   'Date: #1################\' +
                   'Slot: #2################');

        // Clear existing slots for this semester
        ExamTimeSlot.Reset();
        ExamTimeSlot.SetRange("Semester Code", SemesterCode);
        ExamTimeSlot.DeleteAll();

        // Generate slots for each day in the exam period
        CurrentDate := Semester."Exam Start Date";
        while CurrentDate <= Semester."Exam End Date" do begin
            // Skip weekends
            if Date2DWY(CurrentDate, 1) <= 5 then begin
                Window.Update(1, Format(CurrentDate));

                // Morning session (8:30 AM - 11:30 AM)
                SlotCode := CreateSlotCode(CurrentDate, 'AM1');
                Window.Update(2, SlotCode);
                CreateExamTimeSlot(
                    SlotCode,
                    'Morning Session',
                    083000T,
                    113000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Morning,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode);

                // Afternoon session (2:00 PM - 5:00 PM)
                SlotCode := CreateSlotCode(CurrentDate, 'PM1');
                Window.Update(2, SlotCode);
                CreateExamTimeSlot(
                    SlotCode,
                    'Afternoon Session',
                    140000T,
                    170000T,
                    Date2DWY(CurrentDate, 1) - 1,
                    ExamTimeSlot."Session Type"::Afternoon,
                    CurrentDate,
                    CurrentDate,
                    SemesterCode);
            end;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;

        Window.Close();
        Message('Time slots generated successfully.');
    end;

    local procedure CreateSlotCode(ExamDate: Date; SessionCode: Code[3]): Code[20]
    begin
        exit(Format(ExamDate, 0, '<Year4><Month,2><Day,2>') + '-' + SessionCode);
    end;

    local procedure CreateExamTimeSlot(SlotCode: Code[20]; Description: Text[50];
        StartTime: Time; EndTime: Time; DayOfWeek: Integer; SessionType: Option;
        ValidFrom: Date; ValidTo: Date; SemesterCode: Code[25])
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
    begin
        // Clear existing timetable
        TimetableEntry.Reset();
        TimetableEntry.SetRange(Semester, Semester);
        TimetableEntry.DeleteAll(true);

        // Sort courses by priority (e.g., core courses first)
        CourseOffering.Reset();
        CourseOffering.SetRange(Semester, Semester);
        CourseOffering.SetCurrentKey("Time Table Hours");

        if CourseOffering.FindSet() then begin
            TotalRecords := CourseOffering.Count();
            ProgressWindow.Open('Scheduling Classes\' +
                              'Total: #1###\' +
                              'Current: #2###\' +
                              'Remaining: #3###');

            repeat
                CurrentRecord += 1;
                ProgressWindow.Update(1, TotalRecords);
                ProgressWindow.Update(2, CurrentRecord);
                ProgressWindow.Update(3, TotalRecords - CurrentRecord);

                if not AssignBalancedTimeAndLocation(CourseOffering, DaysPerWeek) then
                    LogSchedulingIssue(CourseOffering);

            until CourseOffering.Next() = 0;

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
        RequiresPractical := (CourseOffering."Time Table Hours" >= 5);

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

        LectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

        if RequiresPractical then begin
            // For units with theory and practical components, handle differently
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
    begin
        // Copy the current days usage
        for i := 1 to 5 do begin
            DaysUsage[i] := DaysPerWeek[i];
            i += 1;
        end;


        // Find suitable lecture hall for theory
        LectureHall.Reset();
        LectureHall.SetRange(Status, LectureHall.Status::Active);
        if RequiresSplit then
            LectureHall.SetFilter("Sitting Capacity", '>=%1', FirstGroupSize)
        else
            LectureHall.SetFilter("Sitting Capacity", '>=%1', CourseOffering."Unit Students Count");

        LectureHall.SetFilter("Available Equipment", '@*' + CourseOffering."Required Equipment" + '*');

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
        if (TheoryTimeSlot."Day of Week" >= 1) and (TheoryTimeSlot."Day of Week" <= 5) then
            DaysUsage[TheoryTimeSlot."Day of Week"] += 1;

        // Mark the theory day as very busy to avoid selecting it again for practical
        DaysUsage[TheoryTimeSlot."Day of Week"] := 99999;

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
        if (TheoryTimeSlot."Day of Week" >= 1) and (TheoryTimeSlot."Day of Week" <= 5) then
            DaysPerWeek[TheoryTimeSlot."Day of Week"] += 1;
        if (PracticalTimeSlot."Day of Week" >= 1) and (PracticalTimeSlot."Day of Week" <= 5) then
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

    procedure GenerateExamTimetable(SemesterCode: Code[25])
    var
        Semester: Record "ACA-Semesters";
        ExamTimetableEntry: Record "Exam Timetable Entry";
        CourseOffering: Record "ACA-Lecturers Units";
        ExamTimeSlot: Record "Exam Time Slot";
        ExamDate: Date;
        ProgressWindow: Dialog;
        TotalExams, CurrentExam : Integer;
        DayOfWeek: Integer;
        CoursesPerDay: Dictionary of [Date, Integer];
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
                          'Current Date: #4##################');

        if CourseOffering.FindSet() then
            repeat
                CurrentExam += 1;
                Clear(ExamDate);

                ProgressWindow.Update(1, CurrentExam);
                ProgressWindow.Update(2, TotalExams);
                ProgressWindow.Update(3, CourseOffering.Unit);

                // Find optimal exam date and slot
                if FindOptimalExamSlot(CourseOffering, Semester, ExamTimeSlot, ExamDate, CoursesPerDay) then begin
                    ProgressWindow.Update(4, ExamDate);

                    // Create exam timetable entry
                    CreateExamTimetableEntry(
                        CourseOffering,
                        ExamDate,
                        ExamTimeSlot,
                        Semester);
                end else
                    LogSchedulingIssue(CourseOffering);

            until CourseOffering.Next() = 0;

        ProgressWindow.Close();
    end;

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
        if ExamTimeSlot."Room Type Required" <> '' then
            LectureHall.SetFilter("Room Type", ExamTimeSlot."Room Type Required");

        LectureHall.SetFilter("Exam Sitting Capacity", '>=%1', TotalStudents);

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

    local procedure GetExamStudentCount(ExamEntry: Record "Exam Timetable Entry"): Integer
    var
        StudentUnits: Record "ACA-Student Units";
    begin
        StudentUnits.Reset();
        StudentUnits.SetRange(Unit, ExamEntry."Unit Code");
        StudentUnits.SetRange(Semester, ExamEntry.Semester);
        exit(StudentUnits.Count);
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