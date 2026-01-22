table 50128 "Koha Setup"
{
    Caption = 'Koha Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; Code[25])
        {
            Caption = 'Pk';
        }
        field(2; "Base Url"; Text[250])
        {
            Caption = 'Base Url';
        }
        field(3; Username; Text[250])
        {
            Caption = 'Username';
        }
        field(4; Password; Text[250])
        {
            Caption = 'Password';
        }
        field(5; "Auto Push Records"; Boolean)
        {
            Caption = 'Auto Push Records';
        }
    }
    keys
    {
        key(PK; Pk)
        {
            Clustered = true;
        }
    }
}
