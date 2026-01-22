table 51264 "Student Leave Ledger"
{
    Caption = 'Student Leave Ledger';
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
        field(15; "Posting Type"; Option)
        {
            Caption = 'Posting Type';
            OptionMembers = Leave,Recall;
        }
        field(5200; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(5201; "No of Days"; Decimal)
        {
            Caption = 'No of Days';
        }
        field(5202; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
    }
    keys
    {
        key(PK; "Leave No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}
