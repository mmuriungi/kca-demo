table 51368 "Aca-Final Cons. Summ. Count"
{
    Caption = 'Aca-Final Cons. Summ. Count';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Names"; Code[20])
        {
            Caption = 'User Names';
        }
        field(3; "Graduation Academic Year"; Code[20])
        {
            Caption = 'Graduation Academic Year';
        }
        field(4; "Programme"; Code[20])
        {
            Caption = 'Programme';
        }
        field(6; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(7; "Serial"; Integer)
        {
            Caption = 'Serial';
        }
    }
    keys
    {
        key(PK; "User Names", "Graduation Academic Year", "Programme", "Student No.")
        {
            Clustered = true;
        }
        key(StudentNo; "Student No.")
        {

        }
    }
}
