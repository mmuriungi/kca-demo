table 50062 "ACA-SuppSenate Rep. Counts"
{
    Caption = 'ACA-SuppSenate Rep. Counts';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Prog. Code"; Code[10])
        {
            Caption = 'Prog. Code';
            DataClassification = CustomerContent;
        }
        field(2; "StatusCode"; Code[30])
        {
            Caption = 'StatusCode';
            DataClassification = CustomerContent;
        }
        field(4; "YoS"; Integer)
        {
            Caption = 'YoS';
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
            Caption = 'Counted Recs';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Prog. Code", "StatusCode", "Academic Year", "Student No.", "YoS")
        {
            Clustered = true;
        }
    }
}