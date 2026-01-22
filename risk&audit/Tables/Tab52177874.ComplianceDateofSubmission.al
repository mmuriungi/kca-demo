table 50138 "Compliance Date of Submission"
{
    Caption = 'Compliance Date of Submission';
    DataClassification = ToBeClassified;
    ObsoleteState = Removed;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Date of Submission"; Date)
        {
            Caption = 'Date of Submission';
            DataClassification = ToBeClassified;
        }
        field(3; "Issue Line No."; Integer)
        {
            Caption = 'Issue Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Requirement Line No."; Integer)
        {
            Caption = 'Requirement Line No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Date of Submission", "Requirement Line No.")
        {
            Clustered = true;
        }
    }

}
