table 50063 "ACA-Graduation Reports Buff"
{
    Caption = 'ACA-Graduation Reports Buff';
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
        field(3; "Counts"; Integer)
        {
            Caption = 'Counts';
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
        field(7; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(8; "Exists in Counts"; Boolean)
        {
            Caption = 'Exists in Counts';
            CalcFormula = Exist("ACA-Grad. Report Counts" WHERE(
                "Prog. Code" = FIELD("Prog. Code"),
                "Academic Year" = FIELD("Academic Year"),
                "Student No." = FIELD("Student No."),
                "User ID" = FIELD("User ID")
            ));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Prog. Code", StatusCode, YoS, "Academic Year", "Student No.")
        {
            Clustered = true;
        }
    }
}