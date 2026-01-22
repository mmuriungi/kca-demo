table 51304 "Part-Timer Rates"
{
    Caption = 'Part-Timer Rates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Programme Category"; Enum "Programme Category")
        {
            Caption = 'Programme Category';
        }
        field(2; "Rate per Hour"; Decimal)
        {
            Caption = 'Rate per Hour';
        }
    }
    keys
    {
        key(PK; "Programme Category")
        {
            Clustered = true;
        }
    }
}
