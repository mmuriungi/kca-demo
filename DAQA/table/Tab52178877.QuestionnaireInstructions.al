table 51358 "Questionnaire Instructions"
{
    Caption = 'Questionnaire Instructions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Survey Code"; Code[25])
        {
            Caption = 'Survey Code';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(3; Instructions; Text[2048])
        {
            Caption = 'Instructions';
        }
    }
    keys
    {
        key(PK; "Survey Code", "Entry No.")
        {
            Clustered = true;
        }
    }
}
