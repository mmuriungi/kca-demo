/// <summary>
/// Codeunit Time Table (ID 50120).
/// </summary>
codeunit 52401 "Time Table"
{

    trigger OnRun()
    begin
    end;

    var
        GenSetup: Record "ACA-General Set-Up";
        TimeTable: Record "ACA-Time Table Header";
        ClassRec: Record "ACA-Class Setups";
        CV: Integer;
        TRec: Record "ACA-Time Table";
        TRec2: Record "ACA-Time Table";
        TRec3: Record "ACA-Time Table";
        TRec4: Record "ACA-Time Table";
        TRec5: Record "ACA-Time Table";


    /// <summary>
    /// InsertTimeTable.
    /// </summary>
    /// <param name="Unit">Code[20].</param>
    /// <param name="Lesson">Code[20].</param>
    procedure InsertTimeTable(Unit: Code[20]; Lesson: Code[20])
    var
        TT: Record "ACA-Time Table";
    begin
        GenSetup.GET();
        IF TimeTable.GET(GenSetup."Current TT Code") THEN BEGIN
            CheckConflict(Unit, Lesson);
            TT.INIT;
            TT.Programme := TimeTable.Programme;
            TT.Stage := TimeTable.Stage;
            TT.Unit := Unit;
            TT.Semester := TimeTable.Semester;
            TT.Period := Lesson;
            TT."Day of Week" := TimeTable.Day;
            TT."Lecture Room" := TimeTable."Lecturer Room";
            TT.Lecturer := TimeTable.Lecturer;
            TT."Campus Code" := TimeTable.Campus;
            TT.INSERT;
        END;
    end;


    /// <summary>
    /// CheckConflict.
    /// </summary>
    /// <param name="Unit">Code[20].</param>
    /// <param name="Lesson">Code[20].</param>
    procedure CheckConflict(Unit: Code[20]; Lesson: Code[20])
    var
        TTable2: Record "ACA-Time Table";
    begin
        GenSetup.GET();
        IF TimeTable.GET(GenSetup."Current TT Code") THEN BEGIN

            TTable2.RESET;
            TTable2.SETRANGE(TTable2.Released, FALSE);
            TTable2.SETRANGE(TTable2.Programme, TimeTable.Programme);
            TTable2.SETRANGE(TTable2.Stage, TimeTable.Stage);
            TTable2.SETRANGE(TTable2.Semester, TimeTable.Semester);
            TTable2.SETRANGE(TTable2."Day of Week", TimeTable.Day);
            TTable2.SETRANGE(TTable2.Period, Lesson);
            TTable2.SETRANGE(TTable2.Unit, Unit);
            //TTable2.SETRANGE(TTable2.Session,GETFILTER("Session Filter"));

            IF TTable2.FIND('-') THEN
                ERROR('Class already allocated a class at this time.');



            TTable2.RESET;
            TTable2.SETRANGE(TTable2.Released, FALSE);
            TTable2.SETRANGE(TTable2.Semester, TimeTable.Semester);
            TTable2.SETRANGE(TTable2.Period, Lesson);
            TTable2.SETRANGE(TTable2."Day of Week", TimeTable.Day);
            TTable2.SETRANGE(TTable2."Lecture Room", TimeTable."Lecturer Room");
            IF TTable2.FIND('-') THEN BEGIN
                IF CONFIRM('Lecture room occupied at the specified period/lesson. Do you wish to create a combined lesson?') = FALSE THEN
                    EXIT;
                //ERROR('Lecture room occupied at the specified period/lesson.');
            END;


            TTable2.RESET;
            TTable2.SETRANGE(TTable2.Released, FALSE);
            TTable2.SETRANGE(TTable2.Programme, TimeTable.Programme);
            TTable2.SETRANGE(TTable2.Semester, TimeTable.Semester);
            TTable2.SETRANGE(TTable2.Period, Lesson);
            TTable2.SETRANGE(TTable2."Day of Week", TimeTable.Day);
            //TTable2.SETRANGE(TTable2.Class,GETFILTER("Class Filter"));
            TTable2.SETRANGE(TTable2.Lecturer, TimeTable.Lecturer);
            IF TTable2.FIND('-') THEN BEGIN
                ERROR('Lecturer occupied at the specified period/lesson.');
            END;

        END;
    end;


    /// <summary>
    /// Randomization.
    /// </summary>
    /// <param name="SemCode">Code[20].</param>
    /// <param name="CampusCode">Code[20].</param>
    procedure Randomization(SemCode: Code[20]; CampusCode: Code[20])
    var
        DayRec: Record "ACA-Day Of Week";
        LessonRec: Record "ACA-Lessons";
        ProgStage: Record "ACA-Programme Stages";
        UnitsRec: Record "ACA-Units/Subjects";
        TT: Record "ACA-Time Table";
        ConflictOk: Boolean;
        RoomCode: Code[20];
        LecturerCode: Code[20];
        RoomOk: Boolean;
        RoomRec: Record "ACA-Lecture Room";
        ProgStage1: Record "ACA-Programme Stages";
        "StageUnits TT Count": Integer;
        "StageUnits Count": Integer;
        LessonCode: Code[20];
        DayCode: Code[20];
    begin

        ProgStage.RESET;
        ProgStage.SETRANGE(ProgStage."Include in Time Table", TRUE);
        ProgStage.ASCENDING := FALSE;
        IF ProgStage.FIND('-') THEN BEGIN
            REPEAT //CLASS

                UnitsRec.RESET;
                UnitsRec.SETRANGE(UnitsRec."Programme Code", ProgStage."Programme Code");
                UnitsRec.SETRANGE(UnitsRec."Stage Code", ProgStage.Code);
                // UnitsRec.SETCURRENTKEY(UnitsRec.Code,UnitsRec."Time Tabled Count");
                IF UnitsRec.FIND('-') THEN BEGIN
                    ConflictOk := TRUE;
                    REPEAT
                        LessonCode := GetLesson;
                        DayCode := GetDay;
                        TT.RESET;
                        TT.SETRANGE(TT.Programme, ProgStage."Programme Code");
                        TT.SETFILTER(TT."Stage Filter", ProgStage.Code);
                        TT.SETFILTER(TT."Semester Filter", SemCode);
                        TT.SETFILTER(TT."Lesson Filter", LessonRec.Code);
                        TT.SETFILTER(TT."Day Filter", DayRec.Day);
                        TT.SETFILTER(TT.Unit, UnitsRec.Code);
                        IF TT.FIND('-') THEN BEGIN
                            TT.CALCFIELDS(TT."Unit Count");
                            TT.CALCFIELDS(TT."Unit Week Count");
                            IF TT."Unit Count" > 0 THEN ConflictOk := FALSE;
                        END;
                        RoomRec.RESET;
                        RoomRec.FIND('-');
                        RoomOk := FALSE;
                        REPEAT
                            // RoomCode:=GetRoom;
                            TT.RESET;
                            TT.SETRANGE(TT.Semester, SemCode);
                            TT.SETRANGE(TT.Period, LessonCode);
                            TT.SETRANGE(TT."Day of Week", DayCode);
                            TT.SETRANGE(TT."Lecture Room", RoomCode);
                            IF TT.FIND('-') THEN
                                RoomCode := GetRoom(RoomCode)
                            ELSE
                                RoomOk := TRUE;
                        UNTIL (RoomOk = TRUE) OR (RoomRec.NEXT = 0);

                        IF ConflictOk = TRUE THEN BEGIN
                            LecturerCode := GetLecturer(CampusCode, SemCode, UnitsRec.Code);
                            IF TT."Unit Count" = 0 THEN
                                // InsertRandom(UnitsRec.Code,UnitsRec."Programme Code",UnitsRec."Stage Code",SemCode,DayCode,LessonCode,RoomCode,LecturerCode,
                                //CampusCode);
                                UpdateUnit(UnitsRec."Programme Code", UnitsRec.Code);
                            UpdateLesson(LessonCode);
                            UpdateDay(DayCode);

                        END;
                    UNTIL UnitsRec.NEXT = 0;
                END;

            UNTIL ProgStage.NEXT = 0;
        END;

        MESSAGE('Done');
    end;


    /// <summary>
    /// InsertRandom.
    /// </summary>
    /// <param name="UnitCode">Code[20].</param>
    /// <param name="SemCode">Code[20].</param>
    /// <param name="DayCode">Code[20].</param>
    /// <param name="LessonCode">Code[20].</param>
    /// <param name="RoomCode">Code[20].</param>
    /// <param name="LecturerCode">Code[20].</param>
    /// <param name="ClassName">Code[50].</param>
    /// <param name="ProgCode">Code[20].</param>
    /// <param name="StageCode">Code[20].</param>
    /// <param name="UnitClass">Code[20].</param>
    procedure InsertRandom(UnitCode: Code[20]; SemCode: Code[20]; DayCode: Code[20]; LessonCode: Code[20]; RoomCode: Code[20]; LecturerCode: Code[20]; ClassName: Code[50]; ProgCode: Code[20]; StageCode: Code[20]; UnitClass: Code[20])
    var
        TT: Record "ACA-Time Table";
    begin
        TT.INIT;
        TT.Programme := ProgCode;
        TT.Stage := StageCode;
        TT.Unit := UnitCode;
        TT.Semester := SemCode;
        TT.Period := LessonCode;
        TT."Day of Week" := DayCode;
        TT."Lecture Room" := RoomCode;
        TT.Lecturer := LecturerCode;
        TT.Class := ClassName;
        TT."Unit Class" := UnitClass;
        //TT."Campus Code":=CampusCode;
        TT.Auto := TRUE;
        TT.INSERT;
    end;


    /// <summary>
    /// UpdateUnit.
    /// </summary>
    /// <param name="ProgCode">Code[20].</param>
    /// <param name="UnitCode">Code[20].</param>
    procedure UpdateUnit(ProgCode: Code[20]; UnitCode: Code[20])
    var
        UnitsRec: Record "ACA-Units/Subjects";
    begin
        UnitsRec.RESET;
        UnitsRec.SETRANGE(UnitsRec."Programme Code", ProgCode);
        UnitsRec.SETRANGE(UnitsRec.Code, UnitCode);
        IF UnitsRec.FIND('-') THEN BEGIN
            UnitsRec."Time Tabled Count" := UnitsRec."Time Tabled Count" + 1;
            UnitsRec.MODIFY;
        END;
    end;


    /// <summary>
    /// GetRoom.
    /// </summary>
    /// <param name="badRoom">Code[20].</param>
    /// <returns>Return variable Room of type Code[20].</returns>
    procedure GetRoom(badRoom: Code[20]) Room: Code[20]
    var
        LecRoom: Record "ACA-Lecture Rooms";
    begin
        UpdateRoom(badRoom);
        LecRoom.RESET;
        LecRoom.SETFILTER(LecRoom.Code, '<>%1', badRoom);
        // LecRoom.SETFILTER(LecRoom."Time Table Count",'<%1',100);
        LecRoom.SETCURRENTKEY("Time Table Count");
        LecRoom.ASCENDING := FALSE;
        IF LecRoom.FIND('+') THEN
            Room := LecRoom.Code;
        UpdateRoom(Room);
    end;


    procedure ClearCurrentTimeTable(SemCode: Code[20]; CompusCode: Code[20])
    var
        TT: Record "ACA-Time Table";
        RoomRec: Record "ACA-Lecture Rooms";
        UnitsRec: Record "ACA-Units/Subjects";
        LessonRec: Record "ACA-Lessons";
        DayRec: Record "ACA-Day Of Week";
    begin
        TT.RESET;
        TT.SETRANGE(TT.Semester, SemCode);
        TT.SETRANGE(TT."Campus Code", CompusCode);
        TT.SETRANGE(TT.Auto, TRUE);
        IF TT.FIND('-') THEN BEGIN
            REPEAT
                TT.DELETE;
            UNTIL TT.NEXT = 0;
        END;

        UnitsRec.RESET;
        IF UnitsRec.FIND('-') THEN BEGIN
            REPEAT
                UnitsRec."Time Tabled Count" := 0;
                UnitsRec.MODIFY;
            UNTIL UnitsRec.NEXT = 0;
        END;

        RoomRec.RESET;
        IF RoomRec.FIND('-') THEN BEGIN
            REPEAT
                RoomRec."Time Table Count" := 0;
                RoomRec.MODIFY;
            UNTIL RoomRec.NEXT = 0;
        END;

        LessonRec.RESET;
        IF LessonRec.FIND('-') THEN BEGIN
            REPEAT
                LessonRec."Used Count" := 0;
                LessonRec.MODIFY;
            UNTIL LessonRec.NEXT = 0;
        END;

        DayRec.RESET;
        IF DayRec.FIND('-') THEN BEGIN
            REPEAT
                // DayRec."Used Count":=0;
                DayRec.MODIFY;
            UNTIL DayRec.NEXT = 0;
        END;


        MESSAGE('The Time Table has been cleared Successfuly');
    end;


    /// <summary>
    /// UpdateRoom.
    /// </summary>
    /// <param name="RoomCode">Code[20].</param>
    procedure UpdateRoom(RoomCode: Code[20])
    var
        RoomRec: Record "ACA-Lecture Rooms";
    begin
        RoomRec.RESET;
        RoomRec.SETRANGE(RoomRec.Code, RoomCode);
        IF RoomRec.FIND('-') THEN BEGIN
            RoomRec."Time Table Count" := RoomRec."Time Table Count" + 1;
            RoomRec.MODIFY;
        END;
    end;


    /// <summary>
    /// GetLecturer.
    /// </summary>
    /// <param name="CompusCode">Code[20].</param>
    /// <param name="SemCode">Code[20].</param>
    /// <param name="UnitCode">Code[20].</param>
    /// <returns>Return variable LectCode of type Code[20].</returns>
    procedure GetLecturer(CompusCode: Code[20]; SemCode: Code[20]; UnitCode: Code[20]) LectCode: Code[20]
    var
        LecUnits: Record "ACA-Lecturers Units - Old";
    begin
        LecUnits.RESET;
        LecUnits.SETRANGE(LecUnits.Semester, SemCode);
        LecUnits.SETRANGE(LecUnits."Campus Code", CompusCode);
        LecUnits.SETRANGE(LecUnits.Unit, UnitCode);
        IF LecUnits.FIND('-') THEN
            LectCode := LecUnits.Lecturer;
    end;


    /// <summary>
    /// UpdateLesson.
    /// </summary>
    /// <param name="LessonCode">Code[20].</param>
    procedure UpdateLesson(LessonCode: Code[20])
    var
        LessonRec: Record "ACA-Lessons";
    begin
        LessonRec.RESET;
        LessonRec.SETRANGE(LessonRec.Code, LessonCode);
        IF LessonRec.FIND('-') THEN BEGIN
            LessonRec."Used Count" := LessonRec."Used Count" + 1;
            LessonRec.MODIFY;
        END;
    end;


    /// <summary>
    /// UpdateDay.
    /// </summary>
    /// <param name="DayCode">Code[20].</param>
    procedure UpdateDay(DayCode: Code[20])
    var
        DayRec: Record "ACA-Day Of Week";
    begin
        DayRec.RESET;
        DayRec.SETRANGE(DayRec.Day, DayCode);
        IF DayRec.FIND('-') THEN BEGIN
            //DayRec."Used Count":=DayRec."Used Count"+1;
            DayRec.MODIFY;
        END;
    end;


    /// <summary>
    /// GetDay.
    /// </summary>
    /// <returns>Return variable DayCode of type Code[20].</returns>
    procedure GetDay() DayCode: Code[20]
    var
        DayRec: Record "ACA-Day Of Week";
    begin
        DayRec.RESET;
        //DayRec.SETCURRENTKEY(DayRec."Used Count");
        DayRec.ASCENDING := FALSE;
        IF DayRec.FIND('+') THEN BEGIN
            DayCode := DayRec.Day;
        END;
    end;


    /// <summary>
    /// GetLesson.
    /// </summary>
    /// <returns>Return variable LessonCode of type Code[20].</returns>
    procedure GetLesson() LessonCode: Code[20]
    var
        LessonRec: Record "ACA-Lessons";
    begin
        LessonRec.RESET;
        LessonRec.SETCURRENTKEY(LessonRec."Used Count");
        LessonRec.ASCENDING := FALSE;
        IF LessonRec.FIND('+') THEN BEGIN
            LessonCode := LessonRec.Code;
        END;
    end;


    /// <summary>
    /// GenerateClass.
    /// </summary>
    /// <param name="CapSem">Code[20].</param>
    /// <param name="ClassMax">Integer.</param>
    procedure GenerateClass(CapSem: Code[20]; ClassMax: Integer)
    var
        ProgStages: Record "ACA-Programme Stages";
        UnitsRec: Record "ACA-Units/Subjects";
        Classes: Integer;
        i: Integer;
        HrEmp: Record "HRM-Employee C";
    begin
        ClassRec.DELETEALL;

        ProgStages.RESET;
        ProgStages.SETRANGE(ProgStages."Include in Time Table", TRUE);
        IF ProgStages.FIND('-') THEN BEGIN
            REPEAT
                UnitsRec.RESET;
                UnitsRec.SETRANGE(UnitsRec."Programme Code", ProgStages."Programme Code");
                UnitsRec.SETRANGE(UnitsRec."Stage Code", ProgStages.Code);
                UnitsRec.SETFILTER(UnitsRec."Semester Filter", CapSem);
                IF UnitsRec.FIND('-') THEN BEGIN
                    REPEAT
                        UnitsRec.CALCFIELDS(UnitsRec."Unit Class Size");
                        UnitsRec.CALCFIELDS(UnitsRec."Lecturer Lkup");
                        IF UnitsRec."Unit Class Size" > ClassMax THEN
                            Classes := ABS(UnitsRec."Unit Class Size" / ClassMax);
                        IF Classes < 1 THEN Classes := 1;
                        FOR i := 1 TO Classes DO BEGIN
                            IF NOT ClassRec.GET(UnitsRec.Code + '$' + FORMAT(i)) THEN BEGIN
                                ClassRec.INIT;
                                ClassRec."Class Code" := UnitsRec.Code + '$' + FORMAT(i);
                                ClassRec."Unit Code" := UnitsRec.Code;
                                IF HrEmp.GET(UnitsRec."Lecturer Lkup") THEN
                                    ClassRec.Lecturer := HrEmp."First Name";
                                IF UnitsRec."Unit Class Size" > ClassMax THEN
                                    ClassRec."Class Size" := ClassMax
                                ELSE
                                    ClassRec."Class Size" := UnitsRec."Unit Class Size";
                                ClassRec.INSERT;
                            END;
                        END;
                    UNTIL UnitsRec.NEXT = 0;
                END;
            UNTIL ProgStages.NEXT = 0;
        END;
    end;


    /// <summary>
    /// GenerateTT.
    /// </summary>
    /// <param name="MaxClassWk">Integer.</param>
    /// <param name="SemCode">Code[20].</param>
    procedure GenerateTT(MaxClassWk: Integer; SemCode: Code[20])
    var
        DayRec: Record "ACA-Day Of Week";
        LessonRec: Record "ACA-Lessons";
        LecRooms: Record "ACA-Lecture Rooms";
    begin

        DayRec.RESET;
        IF DayRec.FIND('-') THEN BEGIN
            REPEAT
                LessonRec.RESET;
                IF LessonRec.FIND('-') THEN BEGIN
                    REPEAT
                        LecRooms.RESET;
                        LecRooms.SETFILTER(LecRooms."Day Filter", DayRec.Day);
                        LecRooms.SETFILTER(LecRooms."Lesson Filter", LessonRec.Code);
                        IF LecRooms.FIND('-') THEN BEGIN
                            REPEAT

                                LecRooms.CALCFIELDS(LecRooms."Used Count");
                                IF LecRooms."Used Count" < 2 THEN BEGIN

                                    ClassRec.RESET;
                                    ClassRec.SETFILTER(ClassRec."Day Filter", DayRec.Day);
                                    ClassRec.SETFILTER(ClassRec."Lesson Filter", LessonRec.Code);
                                    IF ClassRec.FIND('-') THEN BEGIN
                                        REPEAT
                                            ClassRec.CALCFIELDS(ClassRec."Day Count");
                                            ClassRec.CALCFIELDS(ClassRec."Lesson Count");
                                            ClassRec.CALCFIELDS(ClassRec."Used Count");
                                            ClassRec.CALCFIELDS(ClassRec."Unit Programme");
                                            ClassRec.CALCFIELDS(ClassRec."Unit Stage");
                                            IF ClassRec."Class Size" < LecRooms."Maximum Capacity" THEN BEGIN
                                                TRec.RESET;
                                                TRec.SETRANGE(TRec.Unit, ClassRec."Unit Code");
                                                TRec.SETRANGE(TRec."Day of Week", DayRec.Day);
                                                IF TRec.COUNT < 1 THEN BEGIN    // Check Unit per day
                                                    TRec2.RESET;
                                                    TRec2.SETRANGE(TRec2."Day of Week", DayRec.Day);
                                                    TRec2.SETRANGE(TRec2."Lecture Room", LecRooms.Code);
                                                    TRec2.SETRANGE(TRec2.Period, LessonRec.Code);
                                                    IF TRec2.COUNT < 1 THEN BEGIN   // Check room confict
                                                        TRec3.RESET;
                                                        TRec3.SETRANGE(TRec3."Unit Class", ClassRec."Class Code");
                                                        IF TRec3.COUNT < MaxClassWk THEN BEGIN  // Check max class weekly
                                                            TRec4.RESET;
                                                            TRec4.SETRANGE(TRec4.Lecturer, ClassRec.Lecturer);
                                                            TRec4.SETRANGE(TRec4.Period, LessonRec.Code);
                                                            TRec4.SETRANGE(TRec4."Day of Week", DayRec.Day);
                                                            IF TRec4.COUNT < 1 THEN BEGIN  // Check the lecturer conflict
                                                                TRec5.RESET;
                                                                TRec5.SETRANGE(TRec5.Programme, ClassRec."Unit Programme");
                                                                TRec5.SETRANGE(TRec5.Stage, ClassRec."Unit Stage");
                                                                TRec5.SETRANGE(TRec5.Period, LessonRec.Code);
                                                                TRec5.SETRANGE(TRec5."Day of Week", DayRec.Day);
                                                                IF TRec5.COUNT < 1 THEN BEGIN  // Check the class conflict
                                                                    InsertRandom(ClassRec."Unit Code", SemCode, DayRec.Day, LessonRec.Code, LecRooms.Code, ClassRec.Lecturer, ClassRec."Unit Code"
                                                                    + '[' + FORMAT(ClassRec."Class Size") + '] ' + ClassRec.Lecturer + ' ' + LecRooms.Code, ClassRec."Unit Programme", ClassRec."Unit Stage",
                                                                    ClassRec."Class Code");
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        UNTIL ClassRec.NEXT = 0;
                                    END;
                                END;
                            UNTIL LecRooms.NEXT = 0;
                        END;
                    UNTIL LessonRec.NEXT = 0;
                END;

            UNTIL DayRec.NEXT = 0;
        END;
    end;
}

