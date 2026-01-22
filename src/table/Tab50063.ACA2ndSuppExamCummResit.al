table 66687 "ACA-2ndSuppExam Cumm. Resit"
{
    fields
    {
        field(1; "Student Number"; Code[20])
        {
        }
        field(2; "Student Name"; Text[150])
        {
        }
        field(3; "Programme"; Code[20])
        {
        }
        field(4; "Department"; Code[20])
        {
        }
        field(5; "School Code"; Code[20])
        {
        }
        field(6; "Department Name"; Text[150])
        {
        }
        field(7; "School Name"; Text[150])
        {
        }
        field(8; "Unit Code"; Code[20])
        {
        }
        field(9; "Unit Description"; Text[150])
        {
        }
        field(10; "Score"; Decimal)
        {
        }
        field(11; "Grade"; Code[10])
        {
        }
        field(12; "Credit Hours"; Decimal)
        {
        }
        field(13; "Academic Year"; Code[20])
        {
        }
        field(14; "Serial"; Integer)
        {
        }
        field(15; "Unit Type"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Student Number", "Unit Code", "Academic Year", "Serial")
        {
            Clustered = true;
        }
    }
}