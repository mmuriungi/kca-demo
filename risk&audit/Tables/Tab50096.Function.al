table 51320 "Function"
{
    Caption = 'Function';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Function Code"; Code[90])
        {
            Caption = 'Function Code';
        }
        field(2; "Function Description"; Text[250])
        {
            Caption = 'Function Description';
        }
    }
    keys
    {
        key(PK; "Function Code")
        {
            Clustered = true;
        }
    }
}
