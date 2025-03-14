table 50122 "Exam First Day Units"
{
    Caption = 'Exam First Day Units';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Unit; Code[25])
        {
            Caption = 'Unit';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Unit)
        {
            Clustered = true;
        }
    }
}
