table 51309 "Scheduling Issue"
{
    Caption = 'Scheduling Issue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[25])
        {
            Caption = 'Academic Year';
        }
        field(2; "Course Code"; Code[25])
        {
            Caption = 'Course Code';
        }
        field(3; Semester; Code[25])
        {
            Caption = 'Semester';
        }
        field(4; Programme; Code[25])
        {
            Caption = 'Programme';
        }
        field(5; "Lecturer Code"; Code[25])
        {
            Caption = 'Lecturer Code';
        }
        field(6; "Issue Description"; Text[1000])
        {
            Caption = 'Issue Description';
        }
        field(7; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            autoincrement = true;
        }
        field(8; "Stage"; Code[20])
        {
            Caption = 'Stage';
        }
    }
    keys
    {
        key(PK; "Academic Year", Semester, Programme, "Course Code", "Lecturer Code", "Entry No")
        {
            Clustered = true;
        }
    }
}
