table 50059 "Aca-Final Supp. Sen.. Count"
{
    Caption = 'Aca-Final Supp. Sen.. Count';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User Names"; Code[20])
        {
            Caption = 'User Names';
            DataClassification = CustomerContent;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(3; "Graduation Academic Year"; Code[20])
        {
            Caption = 'Graduation Academic Year';
            DataClassification = CustomerContent;
        }
        field(4; "Programme"; Code[20])
        {
            Caption = 'Programme';
            DataClassification = CustomerContent;
        }
        field(5; "Program Option"; Code[20])
        {
            Caption = 'Program Option';
            DataClassification = CustomerContent;
        }
        field(6; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(7; "Serial"; Integer)
        {
            Caption = 'Serial';
            DataClassification = CustomerContent;
        }
        field(8; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "User Names", "Academic Year", "Programme", "Student No.", "Year of Study")
        {
            Clustered = true;
        }
    }
}