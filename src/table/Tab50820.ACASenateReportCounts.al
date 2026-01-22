table 50820 "ACA-Grad. Report Counts"
{
    Caption = 'ACA-Grad. Report Counts';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Prog. Code"; Code[10])
        {
            Caption = 'Prog. Code';
            DataClassification = CustomerContent;
        }
        field(2; "StatusCode"; Code[100])
        {
            Caption = 'Status Code';
            DataClassification = CustomerContent;
        }
        field(4; "YoS"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(6; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(9; "Transition Code"; Code[20])
        {
            Caption = 'Transition Code';
            DataClassification = CustomerContent;
        }
        field(11; "IS Pass Status"; Boolean)
        {
            Caption = 'IS Pass Status';
            DataClassification = CustomerContent;
        }
        field(12; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(13; "Counted Recs"; Integer)
        {
            Caption = 'Counted Records';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Prog. Code", StatusCode, YoS, "Academic Year", "Student No.", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

