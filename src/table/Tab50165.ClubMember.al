table 50165 "Club Member"
{
    Caption = 'Club Member';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Club Code"; Code[20])
        {
            Caption = 'Club Code';
            TableRelation = Club;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer where("Customer Type" = CONST(Student));
        }
        field(3; "Join Date"; Date)
        {
            Caption = 'Join Date';
        }
        field(4; "Membership Status"; Option)
        {
            Caption = 'Membership Status';
            OptionMembers = Active,Inactive,Suspended;
        }
        field(5; "Position"; Text[50])
        {
            Caption = 'Position';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
        }
    }

    keys
    {
        key(PK; "Club Code", "Student No.")
        {
            Clustered = true;
        }
    }
}