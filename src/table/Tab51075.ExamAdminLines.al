table 51075 "ExamAdmin Lines"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; Semester; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(4; "Lecturer Hall"; Code[20])
        {
            Caption = 'Lecturer Hall';
        }
        field(5; Department; Code[20])
        {
            Caption = 'Department';
        }
        field(6; Programme; Code[20])
        {
            Caption = 'Programme';
            TableRelation = "ACA-Programme";
        }
        field(7; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "ACA-Units/Subjects".Code where("Programme Code" = field(Programme));
        }
        field(8; "Course Name"; Code[20])
        {
            Caption = 'Course Name';
        }
        field(9; "No of Students"; Integer)
        {
            // CalcFormula = count ("ACA-Student Units"."Student No." where(Unit = field("Course Code")));
            // FieldClass = FlowField;
        }
        field(10; "No of Invigilattors"; Integer)
        {
            Caption = 'No of Invigilattors';
        }
        field(11; "Scheduled Start Time"; Time)
        {
            Caption = 'Scheduled Start Time';
        }
        field(12; "Actual Start Time"; Time)
        {
            Caption = 'Actual Start Time';
        }
        field(13; "Chief Invigillator Staff ID"; Code[20])
        {
            Caption = 'Chief Invigillator Staff ID';
        }
        field(14; "Chief Invigillator's Name"; Text[100])
        {
            Caption = 'Chief Invigillator''s Name';
        }
        field(15; "Remarks "; Text[200])
        {
            Caption = 'Remarks ';
        }
        field(16; "Line No"; Integer)
        {

        }
    }
    keys
    {
        key(PK; "No.", "Date", Semester, "Line No")
        {
            Clustered = true;
        }
    }
}
