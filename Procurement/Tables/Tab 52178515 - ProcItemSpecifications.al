table 52178515 "Proc Item Specifications"
{
    Caption = 'Proc Item Specifications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; "Item No"; Code[50])
        {
            Caption = 'Item No';
        }
        field(3; "S/No"; Code[20])
        {
            Caption = 'S/No';
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "No.", "Item No", "S/No")
        {
            Clustered = true;
        }
    }
}
