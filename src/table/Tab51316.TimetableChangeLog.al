table 51386 "Timetable Change Log"
{
    Caption = 'Timetable Change Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Timetable Document No."; Code[20])
        {
            Caption = 'Timetable Document No.';
            TableRelation = "Timetable Header"."Document No.";
        }
        field(3; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
            TableRelation = "Timetable Header"."Document No.";
        }
        field(4; "Change Type"; Option)
        {
            Caption = 'Change Type';
            OptionMembers = "Lecturer Change","Room Change","Time Change","Unit Addition","Unit Removal","Lecturer Unavailability","Room Unavailability","Student Conflict Resolution","Other";
            OptionCaption = 'Lecturer Change,Room Change,Time Change,Unit Addition,Unit Removal,Lecturer Unavailability,Room Unavailability,Student Conflict Resolution,Other';
        }
        field(5; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
            TableRelation = "ACA-Programme";
        }
        field(6; "Stage Code"; Code[20])
        {
            Caption = 'Stage Code';
        }
        field(7; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
        }
        field(8; "Stream"; Code[100])
        {
            Caption = 'Stream';
        }
        field(9; "Change Description"; Text[250])
        {
            Caption = 'Change Description';
        }
        field(10; "Old Value"; Text[100])
        {
            Caption = 'Old Value';
        }
        field(11; "New Value"; Text[100])
        {
            Caption = 'New Value';
        }
        field(12; "Old Lecturer Code"; Code[20])
        {
            Caption = 'Old Lecturer Code';
            TableRelation = "HRM-Employee C";
        }
        field(13; "New Lecturer Code"; Code[20])
        {
            Caption = 'New Lecturer Code';
            TableRelation = "HRM-Employee C";
        }
        field(14; "Old Room Code"; Code[20])
        {
            Caption = 'Old Room Code';
            TableRelation = "ACA-Lecturer Halls Setup";
        }
        field(15; "New Room Code"; Code[20])
        {
            Caption = 'New Room Code';
            TableRelation = "ACA-Lecturer Halls Setup";
        }
        field(16; "Old Time Slot"; Code[20])
        {
            Caption = 'Old Time Slot';
            TableRelation = "Time Slot";
        }
        field(17; "New Time Slot"; Code[20])
        {
            Caption = 'New Time Slot';
            TableRelation = "Time Slot";
        }
        field(18; "Old Day"; Option)
        {
            Caption = 'Old Day';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(19; "New Day"; Option)
        {
            Caption = 'New Day';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(20; "Old Start Time"; Time)
        {
            Caption = 'Old Start Time';
        }
        field(21; "New Start Time"; Time)
        {
            Caption = 'New Start Time';
        }
        field(22; "Old End Time"; Time)
        {
            Caption = 'Old End Time';
        }
        field(23; "New End Time"; Time)
        {
            Caption = 'New End Time';
        }
        field(24; "Change Reason"; Text[250])
        {
            Caption = 'Change Reason';
        }
        field(25; "Changed By"; Code[50])
        {
            Caption = 'Changed By';
            Editable = false;
        }
        field(26; "Change Date"; Date)
        {
            Caption = 'Change Date';
            Editable = false;
        }
        field(27; "Change Time"; Time)
        {
            Caption = 'Change Time';
            Editable = false;
        }
        field(28; "Original Entry No."; Integer)
        {
            Caption = 'Original Entry No.';
        }
        field(29; Semester; Code[25])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters";
        }
        field(30; "Academic Year"; Code[25])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year";
        }
    }

    keys
    {
        key(PK; "Entry No.", "Timetable Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Timetable Document No.", "Change Type")
        {
        }
        key(Key3; "Source Document No.", "Programme Code", "Unit Code")
        {
        }
    }

    trigger OnInsert()
    begin
        "Changed By" := UserId;
        "Change Date" := Today;
        "Change Time" := Time;
    end;
}