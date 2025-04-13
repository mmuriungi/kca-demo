table 50143 "Survey Header"
{
    Caption = 'Survey Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Survey Code"; Code[20])
        {
            Caption = 'Survey Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(5; Status; Enum "Survey Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(6; "Survey Type"; Enum "Survey Type")
        {
            Caption = 'Survey Type';
        }
        //Project No.
        field(7; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            TableRelation = Job;
        }
    }

    keys
    {
        key(PK; "Survey Code", "Project No.")
        {
            Clustered = true;
        }
    }
}