table 50066 "Exam Timetable Entry"
{
    Caption = 'Exam Timetable Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            // TableRelation = "ACA-Units";
        }
        field(3; Semester; Code[25])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(4; "Exam Date"; Date)
        {
            Caption = 'Exam Date';

            trigger OnValidate()
            begin
                ValidateExamDate();
            end;
        }
        field(5; "Time Slot"; Code[20])
        {
            Caption = 'Time Slot';
            TableRelation = "Exam Time Slot";
        }
        field(6; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(7; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(8; "Lecture Hall"; Code[20])
        {
            Caption = 'Lecture Hall';
            TableRelation = "ACA-Lecturer Halls Setup";
        }
        field(9; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
            TableRelation = "ACA-Programme";
        }
        field(10; "Stage Code"; Code[20])
        {
            Caption = 'Stage Code';
        }
        field(11; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(12; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }
        field(14; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            Editable = false;
        }
        field(15; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            OptionMembers = Regular,Supplementary,Special;
            OptionCaption = 'Regular,Supplementary,Special';
        }
        field(16; "No. of Students"; Integer)
        {
            Caption = 'No. of Students';
            FieldClass = FlowField;
            CalcFormula = sum("ACA-Lecturers Units"."Student Allocation" where(unit = field("Unit Code"),
                                                         Semester = field(Semester),
                                                         Programme = field("Programme Code")));
            Editable = false;
        }
        field(17; "Room Capacity"; Integer)
        {
            Caption = 'Room Capacity';
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Lecturer Halls Setup"."Exam Sitting Capacity"
                                where("Lecture Room Code" = field("Lecture Hall")));
            Editable = false;
        }
        field(18; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Scheduled,InProgress,Completed,Cancelled;
            OptionCaption = 'Scheduled,In Progress,Completed,Cancelled';
        }
        field(19; "Chief Invigilator"; Code[20])
        {
            Caption = 'Chief Invigilator';
            TableRelation = "HRM-Employee C";
        }
        field(20; "Additional Invigilators"; Text[250])
        {
            Caption = 'Additional Invigilators';
        }
        //"Student Count"
        field(21; "Student Count"; Integer)
        {
            Caption = 'Student Count';
        }
        field(22; "Exam Group"; Code[20])
        {
            Caption = 'Exam Group';
            TableRelation = "Exam Groups";
        }
        //session type
        field(23; "Session Type"; Option)
        {
            Caption = 'Session Type';
            OptionMembers = Morning,Midday,Afternoon;
            OptionCaption = 'Morning,Midday,Afternoon';
            FieldClass = FlowField;
            CalcFormula = lookup("Exam Time Slot"."Session Type" where("Code" = field("Time Slot")));
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "Exam Date", "Time Slot", "Lecture Hall")
        {
        }
        key(Key2; "Unit Code", Semester)
        {
        }
        key(Key3; "Programme Code", "Stage Code", "Exam Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Creation Date" := CurrentDateTime;
        "Last Modified By" := UserId;
        "Last Modified Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified Date" := CurrentDateTime;
    end;

    var
        Sem: Record "ACA-Semesters";

    local procedure ValidateExamDate()
    begin
        if "Exam Date" = 0D then
            exit;

        if Sem.Get(Semester) then begin
            if ("Exam Date" < Sem."Exam Start Date") or
               ("Exam Date" > Sem."Exam End Date") then
                Error('Exam date must be within the Sem exam period (%1 to %2).',
                      Sem."Exam Start Date",
                      Sem."Exam End Date");

            if Date2DWY("Exam Date", 1) > 5 then  // Weekend check
                Error('Exams cannot be scheduled on weekends.');
        end;
    end;
}