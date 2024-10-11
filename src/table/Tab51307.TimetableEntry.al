table 51307 "Timetable Entry"
{
    Caption = 'Timetable Entry';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year";
        }
        field(3; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            // TableRelation = "ACA-Lecturers Units";
        }
        field(4; "Lecture Hall Code"; Code[20])
        {
            Caption = 'Lecture Hall Code';
            TableRelation = "ACA-Lecturer Halls Setup";
        }
        field(5; "Time Slot Code"; Code[20])
        {
            Caption = 'Time Slot Code';
            TableRelation = "Time Slot";
        }
        field(6; "Lecturer Code"; Code[20])
        {
            Caption = 'Lecturer Code';
        }
        //semester
        field(7; Semester; Code[20])
        {
            Caption = 'Semester';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Academic Year", "Unit Code", "Time Slot Code", Semester)
        {
            Clustered = true;
        }
    }
}