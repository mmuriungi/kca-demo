table 50714 UpdateEmail
{
    Caption = 'UpdateEmail';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; lineNo; Integer)
        {
            Caption = 'lineNo';
        }
        field(2; adm; Code[20])
        {
            Caption = 'adm';
        }
        field(3; indexNo; Code[20])
        {
            Caption = 'indexNo';
        }
    }
    keys
    {
        key(PK; lineNo)
        {
            Clustered = true;
        }
    }
}
