table 50124 "Invigilator Setup"
{
    Caption = 'Invigilator Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "First 100"; Integer)
        {
            Caption = 'First 100';
        }
        field(2; "Next 50"; Integer)
        {
            Caption = 'Next 50';
        }
    }
    keys
    {
        key(PK; "First 100")
        {
            Clustered = true;
        }
    }
}
