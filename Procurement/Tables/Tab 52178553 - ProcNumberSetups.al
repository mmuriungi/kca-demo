table 52178553 "Proc Number Setups"
{
    Caption = 'Proc Number Setups';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Doc Type"; Enum "Proc Document Types")
        {
            Caption = 'Doc Type';
        }
        field(2; FY; Code[50])
        {
            Caption = 'FY';
        }
        field(3; Prefix; Code[10])
        {
            Caption = 'Prefix';
        }
        field(4; "Number Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
            Caption = 'Number Series';
        }
        field(5; "Institution Code"; Code[20])
        {
            Caption = 'Institution Code';
        }
    }
    keys
    {
        key(PK; "Doc Type")
        {
            Clustered = true;
        }
    }
}
