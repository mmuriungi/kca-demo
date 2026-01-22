table 51359 "Quality Assurance Setup"
{
    Caption = 'Quality Assurance Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Survey Nos."; Code[20])
        {
            Caption = 'Survey Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Evaluation Nos."; Code[20])
        {
            Caption = 'Evaluation Nos.';
            TableRelation = "No. Series";
        }
        field(4; "Question Nos."; Code[20])
        {
            Caption = 'Question Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
