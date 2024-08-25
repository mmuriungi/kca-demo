table 50167 "Club/Society Activity"
{
    Caption = 'Club/Society Activity';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Club/Society Code"; Code[20])
        {
            Caption = 'Club/Society Code';
            TableRelation = Club;
        }
        field(3; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Planned,Completed,Cancelled;
        }
        field(6; Attendance; Integer)
        {
            Caption = 'Attendance';
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
