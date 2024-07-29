table 50118 "Prequalifications Date"
{
    Caption = 'Prequalifications Date';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Preq Year"; Code[20])
        {
            Caption = 'Preq Year';
        }
        field(2; "Reference Date"; date)
        {
            Caption = 'Reference Date';
        }
    }
    keys
    {
        key(PK; "Preq Year")
        {
            Clustered = true;
        }
    }
}
