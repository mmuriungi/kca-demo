table 50125 "Aca-Programmes_Buffer"
{
    Caption = 'Aca-Programmes_Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; User_Id; Code[50])
        {
            Caption = 'User_Id';
        }
        field(2; "Programme Code"; Code[50])
        {
            Caption = 'Programme Code';
        }
    }
    keys
    {
        key(PK; User_Id,"Programme Code")
        {
            Clustered = true;
        }
    }
}
