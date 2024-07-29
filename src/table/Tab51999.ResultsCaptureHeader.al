table 51999 "Results Capture Header"
{
    Caption = 'TBL Exam Capture Header';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Semester Code"; Code[20])
        {
            Caption = 'Semester Code';
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters"."Code";

            trigger onvalidate()
            var
                myInt: Integer;
                Sems: Record "ACA-Semesters";
                emps: Record "HRM-Employee C";
                LectUnits: Record "ACA-Lecturers Units";
                TBLMyLecturerPrograms: Record TBLMyLecturerPrograms;
                TBLMyLecturerUnits: Record TBLMyLecturerUnits;
                UserSets: Record "User Setup";
            begin
                UserSets.Reset();
                UserSets.SetRange("User ID", UserId);
                if UserSets.find('-') then
                    UserSets.TestField("Staff No");
                Rec."Lecturer User ID" := UserId;
                Rec."Lecturer PF No." := UserSets."Staff No";
                Sems.Reset();
                Sems.setrange("Code", Rec."Semester Code");
                if Sems.find('-') then;
                Rec."Academic Year" := Sems."Academic Year";
                if emps.Get(Rec."Lecturer PF No.") then begin
                    Rec."Lecturer Name" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                    //message(emps.Password);
                end else
                    Error('Invalid Staff No.');
                TBLMyLecturerPrograms.Reset();
                TBLMyLecturerPrograms.setrange(StaffNo, emps."No.");
                if TBLMyLecturerPrograms.Find('-') then TBLMyLecturerPrograms.DeleteAll(true);

                TBLMyLecturerUnits.Reset();
                TBLMyLecturerUnits.setrange(StaffNo, emps."No.");
                if TBLMyLecturerUnits.Find('-') then TBLMyLecturerUnits.DeleteAll(true);

                LectUnits.Reset();
                LectUnits.SetRange(Semester, Rec."Semester Code");
                LectUnits.SetRange(Lecturer, Rec."Lecturer PF No.");
                //   LectUnits.SetRange(Unit, Rec."Unit Code");
                if LectUnits.find('-') then begin
                    repeat
                    begin
                        // Insert My programs
                        TBLMyLecturerPrograms.Init();
                        TBLMyLecturerPrograms.ProgrammeCode := LectUnits.Programme;
                        TBLMyLecturerPrograms.Semester := Rec."Semester Code";
                        TBLMyLecturerPrograms.StaffNo := Rec."Lecturer PF No.";
                        TBLMyLecturerPrograms.UserCode := UserId;
                        if TBLMyLecturerPrograms.Insert(true) then;
                        //Insert Units
                        TBLMyLecturerUnits.Init();
                        TBLMyLecturerUnits.ProgrammeCode := LectUnits.Programme;
                        TBLMyLecturerUnits.Semester := Rec."Semester Code";
                        TBLMyLecturerUnits.StaffNo := Rec."Lecturer PF No.";
                        TBLMyLecturerUnits.UserCode := UserId;
                        TBLMyLecturerUnits.UnitCode := LectUnits.Unit;
                        if TBLMyLecturerUnits.Insert(true) then;
                    end;
                    until LectUnits.next = 0;
                end else
                    Error('No units Allocation in the specified Semester');
            end;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = ToBeClassified;
        }
        field(3; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
            DataClassification = ToBeClassified;
            TableRelation = TBLMyLecturerPrograms.ProgrammeCode where(UserCode = field("Lecturer User ID"),
            Semester = field("Semester Code"));
            trigger onvalidate()
            var
                myInt: Integer;
                progs: Record "ACA-Programme";
            begin
                progs.Reset();
                progs.setrange("Code", Rec."Programme Code");
                if progs.find('-') then;
                Rec."Program Name" := progs.Description;
            end;
        }
        field(4; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            DataClassification = ToBeClassified;
            TableRelation = TBLMyLecturerUnits.UnitCode
            where(UserCode = field("Lecturer User ID"),
            Semester = field("Semester Code"), ProgrammeCode = field("Programme Code")
            );
            trigger onvalidate()
            var
                myInt: Integer;
                ProgUnits: record "ACA-Units/Subjects";
            begin
                ProgUnits.Reset();
                ProgUnits.setrange("Programme Code", Rec."Programme Code");
                ProgUnits.setrange("Code", Rec."Unit Code");
                if ProgUnits.find('-') then;
                Rec."Unit Name" := ProgUnits.Desription;
            end;
        }
        field(5; "Program Name"; Text[150])
        {
            Caption = 'Program Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Unit Name"; Text[150])
        {
            Caption = 'Unit Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Lecturer User ID"; Code[20])
        {
            Caption = 'Lecturer User ID';
            DataClassification = ToBeClassified;
        }
        field(8; "Lecturer PF No."; Code[20])
        {
            Caption = 'Lecturer PF No.';
            DataClassification = ToBeClassified;

        }
        field(9; "Lecturer Name"; Text[150])
        {
            Caption = 'Lecturer Name';
            DataClassification = ToBeClassified;
        }
        field(10; Password; Text[150])
        {
            Caption = 'Password';
            DataClassification = ToBeClassified;
        }
        field(11; "No. of Students"; Integer)
        {
            Caption = 'No. of Students';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("TBL Exam Results Buff." where
             ("Programme Code" = field("Programme Code"),
             "Unit Code" = field("Unit Code"), "Semester Code" = field("Semester Code"),
             "Academic Year" = field("Academic Year")));
        }

    }
    keys
    {
        key(PK; "Semester Code", "Academic Year", "Programme Code", "Unit Code", "Lecturer User ID")
        {
            Clustered = true;
        }
    }
    trigger oninsert()
    var
        myInt: Integer;
    begin
    end;
}
