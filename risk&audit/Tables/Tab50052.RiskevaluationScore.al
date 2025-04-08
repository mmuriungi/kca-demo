table 50052 "Risk Evaluation Score"
{
    Caption = 'Risk Evaluation Score';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Description; Code[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(2; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
        field(3; "Risk Rating"; Enum "Audit Risk Ratings")
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            OptionMembers = ,Impact,Likelihood;
        }

        //
    }
    keys
    {
        key(PK; Description, Score)
        {
            Clustered = true;
        }
    }
}
