table 51389 "Mpesa Bank Accounts Setup"
{
    Caption = 'Mpesa Bank Accounts Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Mpesa Code"; Code[20])
        {
            Caption = 'Mpesa Code';
        }
        field(2; "Bank Account Code"; Code[20])
        {
            Caption = 'Bank Account Code';
        }
    }
    keys
    {
        key(PK; "Mpesa Code")
        {
            Clustered = true;
        }
    }
}
