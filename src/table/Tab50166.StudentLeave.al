table 50166 "Student Leave"
{
    Caption = 'Student Leave';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Leave No."; Code[20])
        {
            Caption = 'Leave No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = customer where("Customer Type" = CONST(Student));
        }
        field(3; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            OptionMembers = Regular,Compassionate;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; Reason; Text[250])
        {
            Caption = 'Reason';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,PendingHOD,PendingDean,Approved,Rejected;
        }
        field(8; "Approved By"; Code[20])
        {
            Caption = 'Approved By';
            TableRelation = Employee;
        }
        field(9; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
    }

    keys
    {
        key(PK; "Leave No.")
        {
            Clustered = true;
        }
    }
}