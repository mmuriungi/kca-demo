table 50123 "Exam Invigilators"
{
    Caption = 'Exam Invigilators';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Semester; Code[25])
        {
            Caption = 'Semester';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; Unit; Code[25])
        {
            Caption = 'Unit';
        }
        field(4; Hall; Code[50])
        {
            Caption = 'Hall';
        }
        field(5; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(6; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(7; "No."; Code[25])
        {
            Caption = 'No.';
            TableRelation = "HRM-Employee C" where(Lecturer = const(true));
        }
        field(8; Name; Text[150])
        {
            Caption = 'Name';
        }
        field(9; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = "Full-Timer","Part-Timer";
        }
        field(10; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; Semester, Unit, "No.", Date, Hall, "Entry No")
        {
            Clustered = true;
        }
    }
}
