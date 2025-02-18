codeunit 50096 "Timetable Management"
{
    trigger OnRun()
    begin
        GenerateTimetable('2024', 'S1');
    end;

    procedure GenerateTimetable(AcademicYear: Code[20]; Semester: code[20])
    var
        CourseOffering: Record "ACA-Lecturers Units";
        TimetableEntry: Record "Timetable Entry";
        TotalRecords: Integer;
        CurrentRecord: Integer;
        ProgressWindow: Dialog;
    begin
        CourseOffering.Reset();
        CourseOffering.SetRange(Semester, Semester);
        if CourseOffering.FindSet() then begin
            TotalRecords := CourseOffering.Count();
            ProgressWindow.Open('Generating Timetable...\\@1@@@@@@@@@@@@', CurrentRecord, TotalRecords);
            repeat
                CurrentRecord += 1;
                ProgressWindow.Update(1, CurrentRecord);
                if not AssignTimeAndLocation(CourseOffering) then
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
                while RemainingHours > 0 do begin
                    // Find available time slot
                    if FindAvailableTimeSlot(CourseOffering, LectureHall."Lecture Room Code", TimeSlot, CourseOffering.Semester) then begin
                        // Create timetable entry
                        TimetableEntry.Init();
                        TimetableEntry."Unit Code" := CourseOffering.Unit;
                        TimetableEntry.Semester := CourseOffering.Semester;
                        TimetableEntry."Lecture Hall Code" := LectureHall."Lecture Room Code";
                        TimetableEntry."Lecturer Code" := CourseOffering.Lecturer;
                        TimetableEntry."Time Slot Code" := TimeSlot.Code;
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
                            if TimetableEntry.Insert() then
                                exit(true);
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
                if not IsRoomBooked(CourseOffering."Academic Year", LectureHallCode, TimeSlot.Code, CourseOffering.Semester) then begin
                    // Check if lecturer is available
                    if not IsLecturerBusy(CourseOffering."Lecturer", CourseOffering."Academic Year", TimeSlot.Code, Semester) then begin
                        // Check if there's a conflict with the same course in a different programme
                        if not IsCourseConflict(CourseOffering, TimeSlot.Code, Semester) then begin
                            AvailableTimeSlot := TimeSlot;
                            exit(true);
                        end;
                    end;
                end;
            until TimeSlot.Next() = 0;

        exit(false);
    end;

    local procedure IsLecturerBusy(LecturerNo: Code[20]; AcademicYear: Code[20]; TimeSlotCode: Code[20]; Semester: Code[25]): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
        CourseOffering: Record "ACA-Lecturers Units";
    begin
        TimetableEntry.SetRange("Time Slot Code", TimeSlotCode);
        if TimetableEntry.FindSet() then
            repeat
                if CourseOffering.Get(TimetableEntry."Unit Code") then
                    if CourseOffering.Lecturer = LecturerNo then
                        exit(true);
            until TimetableEntry.Next() = 0;

        exit(false);
    end;

    local procedure IsCourseConflict(CourseOffering: Record "ACA-Lecturers Units"; TimeSlotCode: Code[20]; Semester: Code[25]): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
        ConflictingCourseOffering: Record "ACA-Lecturers Units";
    begin
        TimetableEntry.SetRange("Time Slot Code", TimeSlotCode);
        TimetableEntry.SetRange(Semester, Semester);
        if TimetableEntry.FindSet() then
            repeat
                ConflictingCourseOffering.Reset();
                ConflictingCourseOffering.SetRange(Semester, Semester);
                ConflictingCourseOffering.SetRange("Unit", TimetableEntry."Unit Code");
                ConflictingCourseOffering.SetRange("Lecturer", CourseOffering.Lecturer);
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

        // If still not successful, try combination of next time slot and next lecture hall
        NextTimeSlot.FindSet();
        repeat
            if FindAvailableTimeSlot(CourseOffering, NextLectureHall."Lecture Room Code", NextTimeSlot, Semester) then begin
                TimeSlot := NextTimeSlot;
                LectureHall := NextLectureHall;
                exit(true);
            end;
        until NextTimeSlot.Next() = 0;

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

    local procedure IsRoomBooked(AcademicYear: Code[20]; LectureHallCode: Code[20]; TimeSlotCode: Code[20]; Semester: Code[25]): Boolean
    var
        TimetableEntry: Record "Timetable Entry";
    begin
        TimetableEntry.Reset();
        TimetableEntry.SetRange("Lecture Hall Code", LectureHallCode);
        TimetableEntry.SetRange("Time Slot Code", TimeSlotCode);
        TimetableEntry.SetRange(Semester, Semester);
        exit(not TimetableEntry.IsEmpty);
    end;
}