table 51291 "Postgrad Messages"
{
    Caption = 'Postgrad Messages';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = customer where("Customer Type" = CONST(Student));
        }
        field(3; "Supervisor Code"; Code[20])
        {
            Caption = 'Supervisor Code';
            TableRelation = "HRM-Employee C" where(Lecturer = Const(true));
        }
        field(4; "Communication Date"; DateTime)
        {
            Caption = 'Communication Date';
        }
        field(5; "Message"; Text[2048])
        {
            Caption = 'Message';
        }
        field(6; "Sender Type"; Option)
        {
            Caption = 'Sender Type';
            OptionMembers = Student,Supervisor;
        }
        field(7; "Student Name"; Text[150])
        {
            Caption = 'Student Name';
        }
        field(8; "Supervisor Name"; Text[150])
        {
            Caption = 'Supervisor Name';
        }
        field(9; "Time"; Time)
        {
            Caption = 'Time';
        }

    }
    keys
    {
        key(PK; "Entry No.", "student No.", "Supervisor Code")
        {
            Clustered = true;
        }
    }
}
