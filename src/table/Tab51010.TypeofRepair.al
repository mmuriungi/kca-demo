table 51010 "Type of Repair"
{
    Caption = 'Type of Repair';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[260])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "No.", Description)
        {
            Clustered = true;
        }
    }
}
