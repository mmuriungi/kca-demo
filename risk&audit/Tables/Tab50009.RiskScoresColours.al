table 50009 "Risk Scores Colours"
{
    Caption = 'Risk Scores Colours';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Score"; Integer)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
        field(2; "Colour"; Text[50])
        {
            Caption = 'Colour';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Score")
        {
            Clustered = true;
        }
    }
}
