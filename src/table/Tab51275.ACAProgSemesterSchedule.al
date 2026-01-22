table 51275 "ACA-Prog. Semester Schedule"
{
    Caption = 'ACA-Prog. Semester Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[250])
        {
            Caption = 'Code';
        }
        field(2; "Programme Code"; Code[50])
        {
            Caption = 'Programme Code';
        }
        field(3; "Programme Name"; Text[250])
        {
            Caption = 'Programme Name';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; "Current Semester"; Boolean)
        {
            Caption = 'Current Semester';
        }
        field(7; "Academic Year"; Text[9])
        {
            Caption = 'Academic Year';
        }
        field(8; "SMS Results Semester"; Boolean)
        {
            Caption = 'SMS Results Semester';
        }
        field(9; "Lock Exam Editing"; Boolean)
        {
            Caption = 'Lock Exam Editing';
        }
        field(10; "Lock CAT Editing"; Boolean)
        {
            Caption = 'Lock CAT Editing';
        }
        field(12; "Released Results"; Boolean)
        {
            Caption = 'Released Results';
        }
        field(13; "Lock Lecturer Editing"; Boolean)
        {
            Caption = 'Lock Lecturer Editing';
        }
        field(14; "Mark Entry Deadline"; Date)
        {
            Caption = 'Mark Entry Deadline';
        }
        field(15; "Registration Deadline"; Date)
        {
            Caption = 'Registration Deadline';
        }
        field(16; "Ignore Editing Rule"; Boolean)
        {
            Caption = 'Ignore Editing Rule';
        }
        field(17; "BackLog Marks"; Boolean)
        {
            Caption = 'BackLog Marks';
        }
        field(18; "Allow Dean Editing"; Boolean)
        {
            Caption = 'Allow Dean Editing';
        }
        field(19; "Marks Changeable"; Boolean)
        {
            Caption = 'Marks Changeable';
        }
        field(20; "Evaluate Lecture"; Boolean)
        {
            Caption = 'Evaluate Lecture';
        }
        field(21; "Special Entry Deadline"; Date)
        {
            Caption = 'Special Entry Deadline';
        }
        field(23; "Remarks"; Text[150])
        {
            Caption = 'Remarks';
        }
        field(24; "Scheduled Program Stages"; Integer)
        {
            Caption = 'Scheduled Program Stages';
        }
        field(25; "Supplementary Entry Deadline"; Date)
        {
            Caption = 'Supplementary Entry Deadline';
        }
        field(26; "Buffer Results"; Boolean)
        {
            Caption = 'Buffer Results';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        CReg: Record "ACA-Course Registration";
        progs: Record "ACA-Programme";
        ProgSems: Record "ACA-Programme Semesters";
        ACAProgrammeStageSemesters: Record "ACA-Programme Stage Semesters";

    procedure UpdateSchedules(DateOption: Option " ",SemesterRegistration,SpecialDeadline,SuppDeadline,UnitRegistration,RegularMarksEntry; Semester: Code[25]): Boolean
    var
        ACAProgrammeStageSemesters: Record "ACA-Programme Stage Semesters";
        ACAProgramme: Record "ACA-Programme";
        ACAProgrammeStages: Record "ACA-Programme Stages";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAProgSemesterSchedule: Record "ACA-Prog. Semester Schedule";
        ACAProgStageSemSchedule: Record "ACA-Prog/Stage Sem. Schedule";
        ACAProgStageUnitSemSche: Record "ACA-Prog/Stage/Unit Sem. Sche.";
        LectLoadBatchLines: Record "ACA-Lecturers Units";
        ACASemesters: Record "ACA-Semesters";
        prog: Dialog;
        CountedProgs: Integer;
        RemainingProgs: Integer;
        CountedProgUnits: Integer;
        RemainingUnits: Integer;
        CountedStages: Integer;
        RemainingStages: Integer;
        ACALectureMarksPermissions: Record "ACA-Lecture Marks Permissions";
        Selected: Integer;
        AcaProgramStages: Record "ACA-Programme Stages";
        PgAcaPgroStages: Page "ACA-Programme Stages";
        SelectionMgmt: Codeunit SelectionFilterManagement;
        StageFilters: Text;
        Instruction: Label 'Select the option to execute', Locked = true;
        Optionstxt: Label 'Exit,All Stages,Select Stage', Locked = true;
    begin
        IF NOT CONFIRM('Do you want to update ' + FORMAT(DateOption) + ' date') THEN EXIT;

        Selected := STRMENU(OptionsTxt, 1, Instruction);


        CASE
        Selected OF
            1:
                BEGIN
                    EXIT;
                END;
            2:
                BEGIN
                    CLEAR(CountedProgs);
                    CLEAR(RemainingProgs);
                    CLEAR(CountedProgUnits);
                    CLEAR(RemainingUnits);
                    CLEAR(CountedStages);
                    CLEAR(RemainingStages);
                    prog.OPEN('#1######################################\' +
                    '#2######################################\' +
                    '#3######################################\' +
                    '#4######################################\' +
                    '#5######################################\' +
                    '#6######################################\');
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE(Code, Rec.Code);
                    IF ACASemesters.FIND('-') THEN;
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, Rec."Programme Code");
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        CountedProgs := ACAProgramme.COUNT;
                        RemainingProgs := ACAProgramme.COUNT;
                        prog.UPDATE(1, 'Programs: ' + FORMAT(CountedProgs));
                        REPEAT
                        BEGIN
                            prog.UPDATE(2, 'Remaining Programs: ' + FORMAT(RemainingProgs));
                            RemainingProgs := RemainingProgs - 1;
                            //            // Update Program Schedule here
                            ACAProgrammeStages.RESET;
                            ACAProgrammeStages.SETRANGE("Programme Code", ACAProgramme.Code);
                            IF ACAProgrammeStages.FIND('-') THEN BEGIN
                                CountedStages := ACAProgrammeStages.COUNT;
                                RemainingStages := ACAProgrammeStages.COUNT;
                                prog.UPDATE(3, 'Stages: ' + FORMAT(CountedStages));
                                REPEAT
                                BEGIN
                                    prog.UPDATE(4, 'Remaining Stages: ' + FORMAT(RemainingStages));
                                    RemainingStages := RemainingStages - 1;
                                    ACAProgStageSemSchedule.RESET;
                                    ACAProgStageSemSchedule.SETRANGE(Code, Rec.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAProgStageSemSchedule.FIND('-') THEN BEGIN
                                        CASE
                                        DateOption OF
                                            DateOption::SemesterRegistration:
                                                ACAProgStageSemSchedule."Registration Deadline" := "Registration Deadline";
                                            DateOption::SpecialDeadline:
                                                ACAProgStageSemSchedule."Special Entry Deadline" := "Special Entry Deadline";
                                            DateOption::SuppDeadline:
                                                ACAProgStageSemSchedule."Supplementary Entry Deadline" := "Supplementary Entry Deadline";
                                            DateOption::RegularMarksEntry:
                                                ACAProgStageSemSchedule."Mark entry Dealine" := "Mark Entry Deadline";
                                        END;
                                        ACAProgStageSemSchedule.MODIFY;
                                    END;
                                    ACAUnitsSubjects.RESET;
                                    ACAUnitsSubjects.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAUnitsSubjects.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                        CountedProgUnits := ACAUnitsSubjects.COUNT;
                                        RemainingUnits := ACAUnitsSubjects.COUNT;
                                        prog.UPDATE(5, 'Units: ' + FORMAT(RemainingUnits));
                                        REPEAT
                                        BEGIN
                                            prog.UPDATE(6, 'Remaining Units: ' + FORMAT(RemainingUnits));
                                            RemainingUnits := RemainingUnits - 1;
                                            ACAProgStageUnitSemSche.RESET;
                                            ACAProgStageUnitSemSche.SETRANGE(Code, Rec.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Programme Code", ACAProgramme.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Unit Code", ACAUnitsSubjects.Code);
                                            IF ACAProgStageUnitSemSche.FIND('-') THEN BEGIN
                                                CASE
                                                DateOption OF
                                                    DateOption::SemesterRegistration:
                                                        ACAProgStageUnitSemSche."Registration Deadline" := "Registration Deadline";
                                                    DateOption::SpecialDeadline:
                                                        ACAProgStageUnitSemSche."Special Entry Deadline" := "Special Entry Deadline";
                                                    DateOption::SuppDeadline:
                                                        ACAProgStageUnitSemSche."Supplementary Entry Deadline" := "Supplementary Entry Deadline";
                                                    DateOption::RegularMarksEntry:
                                                        ACAProgStageUnitSemSche."Mark entry Dealine" := "Mark Entry Deadline";
                                                END;
                                                ACAProgStageUnitSemSche.MODIFY;
                                            END;
                                        END;
                                        UNTIL ACAUnitsSubjects.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACAProgrammeStages.NEXT = 0;
                            END;
                        END;
                        UNTIL ACAProgramme.NEXT = 0;
                    END;
                    prog.CLOSE;
                    MESSAGE('Updated!');
                END;
            3:
                BEGIN
                    COMMIT();
                    CLEAR(PgAcaPgroStages);
                    AcaProgramStages.RESET;
                    PgAcaPgroStages.SETTABLEVIEW(AcaProgramStages);
                    PgAcaPgroStages.LOOKUPMODE(TRUE);
                    IF PgAcaPgroStages.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        StageFilters := PgAcaPgroStages.GetSelectionFilter();

                    END;
                    CLEAR(CountedProgs);
                    CLEAR(RemainingProgs);
                    CLEAR(CountedProgUnits);
                    CLEAR(RemainingUnits);
                    CLEAR(CountedStages);
                    CLEAR(RemainingStages);
                    prog.OPEN('#1######################################\' +
                    '#2######################################\' +
                    '#3######################################\' +
                    '#4######################################\' +
                    '#5######################################\' +
                    '#6######################################\');
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE(Code, Rec.Code);
                    IF ACASemesters.FIND('-') THEN;
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, "Programme Code");
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        CountedProgs := ACAProgramme.COUNT;
                        RemainingProgs := ACAProgramme.COUNT;
                        prog.UPDATE(1, 'Programs: ' + FORMAT(CountedProgs));
                        REPEAT
                        BEGIN
                            prog.UPDATE(2, 'Remaining Programs: ' + FORMAT(RemainingProgs));
                            RemainingProgs := RemainingProgs - 1;
                            // Update Program Schedule here
                            //        ACAProgSemesterSchedule.RESET;
                            //        ACAProgSemesterSchedule.SETRANGE(Code,Rec.Code);
                            //        ACAProgSemesterSchedule.SETRANGE("Programme Code",ACAProgramme.Code);
                            //        IF ACAProgSemesterSchedule.FIND('-') THEN BEGIN
                            //          CASE
                            //          DateOption OF 
                            //            DateOption::SemesterRegistration:
                            //              ACAProgSemesterSchedule."Registration Deadline":="Registration Deadline";
                            //            DateOption::SpecialDeadline:
                            //              ACAProgSemesterSchedule."Special  Entry Deadline":="Special  Entry Deadline";
                            //            DateOption::SuppDeadline:
                            //              ACAProgSemesterSchedule."Supplementary Entry Deadline":="Supp Registration Deadline";
                            //            END;
                            //            ACAProgSemesterSchedule.MODIFY();
                            //          END;
                            ACAProgrammeStages.RESET;
                            ACAProgrammeStages.SETRANGE("Programme Code", ACAProgramme.Code);
                            ACAProgrammeStages.SETFILTER(Code, StageFilters);
                            IF ACAProgrammeStages.FIND('-') THEN BEGIN
                                CountedStages := ACAProgrammeStages.COUNT;
                                RemainingStages := ACAProgrammeStages.COUNT;
                                prog.UPDATE(3, 'Stages: ' + FORMAT(CountedStages));
                                REPEAT
                                BEGIN
                                    prog.UPDATE(4, 'Remaining Stages: ' + FORMAT(RemainingStages));
                                    RemainingStages := RemainingStages - 1;
                                    ACAProgStageSemSchedule.RESET;
                                    ACAProgStageSemSchedule.SETRANGE(Code, Rec.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAProgStageSemSchedule.FIND('-') THEN BEGIN
                                        CASE
                                        DateOption OF
                                            DateOption::SemesterRegistration:
                                                ACAProgStageSemSchedule."Registration Deadline" := "Registration Deadline";
                                            DateOption::SpecialDeadline:
                                                ACAProgStageSemSchedule."Special Entry Deadline" := "Special Entry Deadline";
                                            DateOption::SuppDeadline:
                                                ACAProgStageSemSchedule."Supplementary Entry Deadline" := "Supplementary Entry Deadline";
                                            DateOption::RegularMarksEntry:
                                                ACAProgStageSemSchedule."Mark entry Dealine" := "Mark Entry Deadline";
                                        END;
                                        ACAProgStageSemSchedule.MODIFY;
                                    END;
                                    ACAUnitsSubjects.RESET;
                                    ACAUnitsSubjects.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAUnitsSubjects.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                        CountedProgUnits := ACAUnitsSubjects.COUNT;
                                        RemainingUnits := ACAUnitsSubjects.COUNT;
                                        prog.UPDATE(5, 'Units: ' + FORMAT(RemainingUnits));
                                        REPEAT
                                        BEGIN
                                            prog.UPDATE(6, 'Remaining Units: ' + FORMAT(RemainingUnits));
                                            RemainingUnits := RemainingUnits - 1;
                                            ACAProgStageUnitSemSche.RESET;
                                            ACAProgStageUnitSemSche.SETRANGE(Code, Rec.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Programme Code", ACAProgramme.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Unit Code", ACAUnitsSubjects.Code);
                                            IF ACAProgStageUnitSemSche.FIND('-') THEN BEGIN
                                                CASE
                                                DateOption OF
                                                    DateOption::SemesterRegistration:
                                                        ACAProgStageUnitSemSche."Registration Deadline" := "Registration Deadline";
                                                    DateOption::SpecialDeadline:
                                                        ACAProgStageUnitSemSche."Special Entry Deadline" := "Special Entry Deadline";
                                                    DateOption::SuppDeadline:
                                                        ACAProgStageUnitSemSche."Supplementary Entry Deadline" := "Supplementary Entry Deadline";
                                                    DateOption::RegularMarksEntry:
                                                        ACAProgStageUnitSemSche."Mark entry Dealine" := "Mark entry Deadline";
                                                END;
                                                ACAProgStageUnitSemSche.MODIFY;
                                            END;
                                        END;
                                        UNTIL ACAUnitsSubjects.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACAProgrammeStages.NEXT = 0;
                            END;
                        END;
                        UNTIL ACAProgramme.NEXT = 0;
                    END;
                    prog.CLOSE;
                    MESSAGE('Updated!');
                END;
        END;
    end;

    procedure UpdateSchedulesBooleans(BoolOption: Option " ",CurrentSemester,LocExam,LockCAT,LectureEvaluation,IgnoreEditing,ReleaseResults,BufferResults,LockLecturer; Semester: Code[25]): Boolean
    var
        ACAProgramme: Record "ACA-Programme";
        ACAProgrammeStages: Record "ACA-Programme Stages";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAProgSemesterSchedule: Record "ACA-Prog. Semester Schedule";
        ACAProgStageSemSchedule: Record "ACA-Prog/Stage Sem. Schedule";
        ACAProgStageUnitSemSche: Record "ACA-Prog/Stage/Unit Sem. Sche.";
        LectLoadBatchLines: Record "ACA-Lecturers Units";
        ACASemesters: Record "ACA-Semesters";
        prog: Dialog;
        CountedProgs: Integer;
        RemainingProgs: Integer;
        CountedProgUnits: Integer;
        RemainingUnits: Integer;
        CountedStages: Integer;
        RemainingStages: Integer;
        ACALectureMarksPermissions: Record "ACA-Lecture Marks Permissions";
        Selected: Integer;
        AcaProgramStages: Record "ACA-Programme Stages";
        PgAcaPgroStages: Page "ACA-Programme Stages";
        SelectionMgmt: Codeunit SelectionFilterManagement;
        Instruction: Label 'Select the option to execute', Locked = true;
        Optionstxt: Label 'Exit,All Stages,Select Stage', Locked = true;
        StageFilters: Text;
    begin
        IF NOT CONFIRM('Do you want to update ' + FORMAT(BoolOption) + ' date') THEN EXIT;

        Selected := STRMENU(OptionsTxt, 1, Instruction);

        CASE
        Selected OF
            1:
                BEGIN
                    EXIT;
                END;
            2:
                BEGIN
                    CLEAR(CountedProgs);
                    CLEAR(RemainingProgs);
                    CLEAR(CountedProgUnits);
                    CLEAR(RemainingUnits);
                    CLEAR(CountedStages);
                    CLEAR(RemainingStages);
                    prog.OPEN('#1######################################\' +
                    '#2######################################\' +
                    '#3######################################\' +
                    '#4######################################\' +
                    '#5######################################\' +
                    '#6######################################\');
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE(Code, Rec.Code);
                    IF ACASemesters.FIND('-') THEN;
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, Rec."Programme Code");
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        CountedProgs := ACAProgramme.COUNT;
                        RemainingProgs := ACAProgramme.COUNT;
                        prog.UPDATE(1, 'Programs: ' + FORMAT(CountedProgs));
                        REPEAT
                        BEGIN
                            prog.UPDATE(2, 'Remaining Programs: ' + FORMAT(RemainingProgs));
                            RemainingProgs := RemainingProgs - 1;
                            // Update Program Schedule here

                            ACAProgrammeStages.RESET;
                            ACAProgrammeStages.SETRANGE("Programme Code", ACAProgramme.Code);
                            IF ACAProgrammeStages.FIND('-') THEN BEGIN
                                CountedStages := ACAProgrammeStages.COUNT;
                                RemainingStages := ACAProgrammeStages.COUNT;
                                prog.UPDATE(3, 'Stages: ' + FORMAT(CountedStages));
                                REPEAT
                                BEGIN
                                    prog.UPDATE(4, 'Remaining Stages: ' + FORMAT(RemainingStages));
                                    RemainingStages := RemainingStages - 1;
                                    ACAProgStageSemSchedule.RESET;
                                    ACAProgStageSemSchedule.SETRANGE(Code, Rec.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAProgStageSemSchedule.FIND('-') THEN BEGIN
                                        CASE
                                        BoolOption OF
                                            BoolOption::CurrentSemester:
                                                ACAProgStageSemSchedule."Current Semester" := "Current Semester";
                                            BoolOption::LocExam:
                                                ACAProgStageSemSchedule."Lock Exam Editting" := "Lock Exam Editing";
                                            BoolOption::LockCAT:
                                                ACAProgStageSemSchedule."Lock CAT Editting" := "Lock CAT Editing";
                                            BoolOption::LectureEvaluation:
                                                ACAProgStageSemSchedule."Evaluate Lecture" := "Evaluate Lecture";
                                            BoolOption::LockLecturer:
                                                ACAProgStageSemSchedule."Lock Lecturer Editing" := "Lock Lecturer Editing";
                                            BoolOption::IgnoreEditing:
                                                ACAProgStageSemSchedule."Ignore Editing Rule" := "Ignore Editing Rule";
                                            BoolOption::ReleaseResults:
                                                ACAProgStageSemSchedule."Released Results" := "Released Results";
                                            BoolOption::BufferResults:
                                                ACAProgStageSemSchedule."Buffer Results" := Rec."Buffer Results";
                                        END;
                                        ACAProgStageSemSchedule.MODIFY;
                                    END;
                                    ACAUnitsSubjects.RESET;
                                    ACAUnitsSubjects.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAUnitsSubjects.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                        CountedProgUnits := ACAUnitsSubjects.COUNT;
                                        RemainingUnits := ACAUnitsSubjects.COUNT;
                                        prog.UPDATE(5, 'Units: ' + FORMAT(RemainingUnits));
                                        REPEAT
                                        BEGIN
                                            prog.UPDATE(6, 'Remaining Units: ' + FORMAT(RemainingUnits));
                                            RemainingUnits := RemainingUnits - 1;
                                            ACAProgStageUnitSemSche.RESET;
                                            ACAProgStageUnitSemSche.SETRANGE(Code, Rec.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Programme Code", ACAProgramme.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Unit Code", ACAUnitsSubjects.Code);
                                            IF ACAProgStageUnitSemSche.FIND('-') THEN BEGIN
                                                CASE
                                                BoolOption OF
                                                    BoolOption::CurrentSemester:
                                                        ACAProgStageUnitSemSche."Current Semester" := "Current Semester";
                                                    BoolOption::LocExam:
                                                        ACAProgStageUnitSemSche."Lock Exam Editting" := "Lock Exam Editing";
                                                    BoolOption::LockCAT:
                                                        ACAProgStageUnitSemSche."Lock CAT Editting" := "Lock CAT Editing";
                                                    BoolOption::LectureEvaluation:
                                                        ACAProgStageUnitSemSche."Evaluate Lecture" := "Evaluate Lecture";
                                                    BoolOption::LockLecturer:
                                                        ACAProgStageUnitSemSche."Lock Lecturer Editing" := "Lock Lecturer Editing";
                                                    BoolOption::IgnoreEditing:
                                                        ACAProgStageUnitSemSche."Ignore Editing Rule" := "Ignore Editing Rule";
                                                    BoolOption::ReleaseResults:
                                                        ACAProgStageUnitSemSche."Released Results" := "Released Results";
                                                    BoolOption::BufferResults:
                                                        ACAProgStageUnitSemSche."Buffer Results" := Rec."Buffer Results";
                                                END;
                                                ACAProgStageUnitSemSche.MODIFY;
                                            END;
                                        END;
                                        UNTIL ACAUnitsSubjects.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACAProgrammeStages.NEXT = 0;
                            END;
                        END;
                        UNTIL ACAProgramme.NEXT = 0;
                    END;
                    prog.CLOSE;
                    MESSAGE('Updated!');
                END;
            3:
                BEGIN
                    COMMIT();
                    CLEAR(PgAcaPgroStages);
                    AcaProgramStages.RESET;
                    PgAcaPgroStages.SETTABLEVIEW(AcaProgramStages);
                    PgAcaPgroStages.LOOKUPMODE(TRUE);
                    IF PgAcaPgroStages.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        StageFilters := PgAcaPgroStages.GetSelectionFilter();

                    END;
                    CLEAR(CountedProgs);
                    CLEAR(RemainingProgs);
                    CLEAR(CountedProgUnits);
                    CLEAR(RemainingUnits);
                    CLEAR(CountedStages);
                    CLEAR(RemainingStages);
                    prog.OPEN('#1######################################\' +
                    '#2######################################\' +
                    '#3######################################\' +
                    '#4######################################\' +
                    '#5######################################\' +
                    '#6######################################\');
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE(Code, Rec.Code);
                    IF ACASemesters.FIND('-') THEN;
                    ACAProgramme.RESET;
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        CountedProgs := ACAProgramme.COUNT;
                        RemainingProgs := ACAProgramme.COUNT;
                        prog.UPDATE(1, 'Programs: ' + FORMAT(CountedProgs));
                        REPEAT
                        BEGIN
                            prog.UPDATE(2, 'Remaining Programs: ' + FORMAT(RemainingProgs));
                            RemainingProgs := RemainingProgs - 1;
                            // Update Program Schedule here

                            ACAProgrammeStages.RESET;
                            ACAProgrammeStages.SETRANGE("Programme Code", ACAProgramme.Code);
                            ACAProgrammeStages.SETFILTER(Code, StageFilters);
                            IF ACAProgrammeStages.FIND('-') THEN BEGIN
                                CountedStages := ACAProgrammeStages.COUNT;
                                RemainingStages := ACAProgrammeStages.COUNT;
                                prog.UPDATE(3, 'Stages: ' + FORMAT(CountedStages));
                                REPEAT
                                BEGIN
                                    prog.UPDATE(4, 'Remaining Stages: ' + FORMAT(RemainingStages));
                                    RemainingStages := RemainingStages - 1;
                                    ACAProgStageSemSchedule.RESET;
                                    ACAProgStageSemSchedule.SETRANGE(Code, Rec.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAProgStageSemSchedule.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAProgStageSemSchedule.FIND('-') THEN BEGIN
                                        CASE
                                        BoolOption OF
                                            BoolOption::CurrentSemester:
                                                ACAProgStageSemSchedule."Current Semester" := "Current Semester";
                                            BoolOption::LocExam:
                                                ACAProgStageSemSchedule."Lock Exam Editting" := "Lock Exam Editing";
                                            BoolOption::LockCAT:
                                                ACAProgStageSemSchedule."Lock CAT Editting" := "Lock CAT Editing";
                                            BoolOption::LectureEvaluation:
                                                ACAProgStageSemSchedule."Evaluate Lecture" := "Evaluate Lecture";
                                            BoolOption::LockLecturer:
                                                ACAProgStageSemSchedule."Lock Lecturer Editing" := "Lock Lecturer Editing";
                                            BoolOption::IgnoreEditing:
                                                ACAProgStageSemSchedule."Ignore Editing Rule" := "Ignore Editing Rule";
                                            BoolOption::ReleaseResults:
                                                ACAProgStageSemSchedule."Released Results" := "Released Results";
                                            BoolOption::BufferResults:
                                                ACAProgStageSemSchedule."Buffer Results" := Rec."Buffer Results";
                                        END;
                                        ACAProgStageSemSchedule.MODIFY;
                                    END;
                                    ACAUnitsSubjects.RESET;
                                    ACAUnitsSubjects.SETRANGE("Programme Code", ACAProgramme.Code);
                                    ACAUnitsSubjects.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                        CountedProgUnits := ACAUnitsSubjects.COUNT;
                                        RemainingUnits := ACAUnitsSubjects.COUNT;
                                        prog.UPDATE(5, 'Units: ' + FORMAT(RemainingUnits));
                                        REPEAT
                                        BEGIN
                                            prog.UPDATE(6, 'Remaining Units: ' + FORMAT(RemainingUnits));
                                            RemainingUnits := RemainingUnits - 1;
                                            ACAProgStageUnitSemSche.RESET;
                                            ACAProgStageUnitSemSche.SETRANGE(Code, Rec.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Programme Code", ACAProgramme.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Stage Code", ACAProgrammeStages.Code);
                                            ACAProgStageUnitSemSche.SETRANGE("Unit Code", ACAUnitsSubjects.Code);
                                            IF ACAProgStageUnitSemSche.FIND('-') THEN BEGIN
                                                CASE
                                                BoolOption OF
                                                    BoolOption::CurrentSemester:
                                                        ACAProgStageUnitSemSche."Current Semester" := "Current Semester";
                                                    BoolOption::LocExam:
                                                        ACAProgStageUnitSemSche."Lock Exam Editting" := "Lock Exam Editing";
                                                    BoolOption::LockCAT:
                                                        ACAProgStageUnitSemSche."Lock CAT Editting" := "Lock CAT Editing";
                                                    BoolOption::LectureEvaluation:
                                                        ACAProgStageUnitSemSche."Evaluate Lecture" := "Evaluate Lecture";
                                                    BoolOption::LockLecturer:
                                                        ACAProgStageUnitSemSche."Lock Lecturer Editing" := "Lock Lecturer Editing";
                                                    BoolOption::IgnoreEditing:
                                                        ACAProgStageUnitSemSche."Ignore Editing Rule" := "Ignore Editing Rule";
                                                    BoolOption::ReleaseResults:
                                                        ACAProgStageUnitSemSche."Released Results" := "Released Results";
                                                    BoolOption::BufferResults:
                                                        ACAProgStageUnitSemSche."Buffer Results" := Rec."Buffer Results";
                                                END;
                                                ACAProgStageUnitSemSche.MODIFY;
                                            END;
                                        END;
                                        UNTIL ACAUnitsSubjects.NEXT = 0;
                                    END;
                                END;
                                UNTIL ACAProgrammeStages.NEXT = 0;
                            END;
                        END;
                        UNTIL ACAProgramme.NEXT = 0;
                    END;
                    prog.CLOSE;
                    MESSAGE('Updated!');
                END;
        END;
    end;
}