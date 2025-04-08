table 52177876 "Compliance Dates of Submission"
{
    Caption = 'Compliance Date of Submission';
    DataClassification = ToBeClassified;

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
        field(5; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.", "Issue Line No.", "Requirement Line No.", "Date of Submission")
        {
            Clustered = true;
        }
    }

}
