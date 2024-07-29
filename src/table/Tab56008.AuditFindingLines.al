table 56008 "Audit Finding Lines"
{
    Caption = 'Audit Finding Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Audit Line No."; Integer)
        {
            Caption = 'Audit Line No.';
            AutoIncrement = true;
        }
        field(2; "No."; Code[30])
        {
            Caption = 'No.';
            Editable = true;

        }
        field(3; "Section Code"; Code[30])
        {
            Caption = 'Section Code';

        }
        field(4; "Feed back"; Option)
        {

            OptionMembers = "",Positive,Negative;

        }
        field(5; "Areas of improvement"; Text[250])
        {
            Caption = 'Areas of improvement';
        }
        field(6; Observations; Option)
        {
            OptionMembers = "",Major,Minor;
        }
        field(7; Recommendations; Text[250])
        {

        }
    }

    keys
    {
        key(PK; "Audit Line No.")
        {
            Clustered = true;
        }
    }
}
