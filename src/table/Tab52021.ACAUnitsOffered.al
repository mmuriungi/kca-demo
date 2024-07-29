table 52021 "ACA-Units Offered"
{
    Caption = 'ACA-UnitsonOffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Programs; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
            trigger OnValidate()
            begin
                prog.Reset();
                prog.SetRange(Code, Programs);
                if prog.Find('-') then begin
                    "Program Name" := prog.Description;
                end;

            end;

        }
        field(2; "Program Name"; text[200])
        {

        }
        field(3; "Unit Base Code"; Code[20])
        {
            //TableRelation = "ACA-Units/Subjects".Code where("Programme Code" = field(Programs));
            trigger OnValidate()
            begin
                units.Reset();
                units.SetRange("Unit Base Code", Rec."Unit Base Code");
                units.SetRange(ModeofStudy, Rec.ModeofStudy);
                units.SetRange(Semester, Rec.Semester);
                units.SetRange(Campus, Rec.Campus);
                units.SetRange(Stage, Rec.Stage);

                //generate stream
                IF units.Find('-') then begin
                    if units.Count = 1
                    then
                        Rec.Stream := 'Stream B' else
                        if units.Count = 2
                        then
                            Rec.Stream := 'Stream C' else
                            if units.Count = 3
                            then
                                Rec.Stream := 'Stream D' else
                                if units.Count = 4
                                then
                                    Rec.Stream := 'Stream E' else
                                    if units.Count = 5
                                    then
                                        Rec.Stream := 'Stream F';
                end else begin
                    Rec.Stream := 'Stream A'
                end;
                // unitAss.Reset();
                // unitAss.SetRange("Associated Unit", Rec."Unit Base Code");
                // if not unitAss.Find('-') then begin
                //     units.Reset();
                //     units.SetRange("Unit Base Code", Rec."Unit Base Code");
                //     units.SetRange(Day, Rec.Day);
                //     units.SetRange(TimeSlot, Rec.TimeSlot);
                //     units.SetRange(ModeofStudy, Rec.ModeofStudy);
                //     units.SetRange(Semester, GetCurrentSemester());
                //     units.SetRange(Stream, Rec.Stream);
                //     if units.Find('-') then begin
                //         Error('Unit Has Already Been Allocated On this Time Slot');
                //     end;
                // end;



            end;

        }
        field(4; Department; code[20])
        {

        }
        field(5; Day; Code[20])
        {
            TableRelation = "TT-Days"."Day Code";

        }
        field(6; TimeSlot; code[20])
        {
            TableRelation = "TT-Daily Lessons"."Lesson Code";
        }
        field(7; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(8; "Lecture Hall"; code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";

        }
        field(9; "Sitting Capacity"; Integer)
        {
            CalcFormula = lookup("ACA-Lecturer Halls Setup"."Sitting Capacity" where("Lecture Room Code" = field("Lecture Hall")));
            FieldClass = FlowField;
        }
        field(10; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(11; Lecturer; code[20])
        {
            TableRelation = "HRM-Employee C"."No." where(Lecturer = filter(true));
            trigger OnValidate()
            begin
                lecturers.Reset;
                lecturers.SetRange(Lecturer, Rec.lecturer);
                lecturers.SetRange(Semester, GetCurrentSemester());
                lecturers.SetRange(Day, day);
                lecturers.SetRange(TimeSlot, timeslot);
                if lecturers.Find('-') then begin
                    Error('The selected Lecturer already has a lesson in the selected timeslot!')
                end;
                // lecturers.Reset();
                // lecturers.SetRange(Lecturer, Rec.Lecturer);
                // lecturers.SetRange(Semester, Rec.Semester);
                // lecturers.SetRange(Unit, Rec."Unit Base Code");
                // lecturers.SetRange(ModeOfStudy, Rec.ModeofStudy);
                // lecturers.SetRange(Stream, Rec.Stream);
                // if lecturers.Find('-') then begin
                //     Error('The selected Lecturer already has a lesson in the selected timeslot!');
                // end;
            end;

        }
        field(12; ModeofStudy; code[20])
        {
            TableRelation = "ACA-Student Types";
        }
        field(13; Stream; Text[100])
        {

        }
        field(14; "Registered Students"; Integer)
        {
            CalcFormula = count("ACA-Student Units" where(Unit = field("Unit Base Code"), Semester = field(Semester), Stream = field(Stream), "Campus Code" = field(Campus), ModeOfStudy = field(ModeofStudy)));
            FieldClass = FlowField;
        }
        field(15; Campus; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(16; LectureAllocated; Boolean)
        {

        }
        field(17; "Final Exam Date"; Date)
        {

        }
        field(18; "final exam day"; code[20])
        {
            TableRelation = "TT-Days"."Day Code";

        }
        field(19; "final Exam Time"; code[20])
        {
            TableRelation = "EXT-Daily Periods"."Period Code";
        }
        field(20; "Final Exam Room"; code[20])
        {
            TableRelation = "ACA-Lecturer Halls Setup"."Lecture Room Code";
        }
        field(21; "Invigilator 1"; code[20])
        {

        }
        field(22; "Invigilator 2"; code[20])
        {

        }
        field(23; "Invigilator 3"; code[20])
        {

        }
        field(24; uniqueRecord; Boolean)
        {
            CalcFormula = exist("ACA-Units Offered" where("Unit Base Code" = field("Unit Base Code"), Semester = field(Semester), ModeofStudy = field(ModeofStudy), Day = field(Day), Stream = field(Stream)));
            FieldClass = FlowField;
        }
        field(25; Stage; code[20])
        {

        }

    }
    keys
    {
        key(Key1; "Unit Base Code", Programs, Day, TimeSlot, ModeofStudy, Stream, Campus, Semester, Stage)
        {
            Clustered = true;
        }
    }
    var
        prog: Record "ACA-Programme";
        units: Record "ACA-Units Offered";
        Halls: Record "ACA-Lecturer Halls Setup";
        lecturers: Record "ACA-Lecturers Units";
        CurrentSem: Record "ACA-Semester";
        unitsOff: Record "ACA-Units Offered";
        ass1: Code[20];
        ass2: code[20];
        ass3: Code[20];
        ass4: code[20];

    trigger OnModify()
    begin
        if UserId <> 'frankie' then Error('You are mot Allowed to Modify!!');
    end;

    trigger OnDelete()
    begin
        if UserId <> 'frankie' then Error('You are mot Allowed to Modify!!');
    end;

    trigger OnRename()
    begin
        if UserId <> 'frankie' then Error('You are mot Allowed to Modify!!');
    end;

    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;
}
