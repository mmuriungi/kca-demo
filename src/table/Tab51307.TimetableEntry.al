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
        field(7; Semester; Code[20])
        {
            Caption = 'Semester';
        }
        field(8; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
        }
        //Day
        field(9; "Day of Week"; Option)
        {
            Caption = 'Day of Week';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(10; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(11; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(12; "Duration (Hours)"; Decimal)
        {
            Caption = 'Duration (Hours)';
        }
        //stage
        field(13; "Stage Code"; Code[20])
        {
            Caption = 'Stage Code';
        }
        //Type
        field(14; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Class,Exam,Theory,Practical,Online;
        }
        //Date
        field(15; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(16; "Group No"; Integer)
        {
            Caption = 'Group No';
        }
        field(17; "Session Type"; Enum "Session Type")
        {
            Caption = 'Session Type';
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