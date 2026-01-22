table 51354 FAQ
{
    Caption = 'FAQ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; Question; Text[2048])
        {
            Caption = 'Question';
        }
        field(3; Answer; Text[2048])
        {
            Caption = 'Answer';
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
