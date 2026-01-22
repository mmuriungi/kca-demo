table 50120 "Preq Categories/Years"
{
    Caption = 'Preq Categories/Years';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Preq Year"; Code[20])
        {
            Caption = 'Preq Year';
        }
        field(2; "Preq Category"; Code[20])
        {
            Caption = 'Preq Category';
        }
        field(3; "Prequalified Supliers"; Integer)
        {
            Caption = 'Prequalified Supliers';
        }
        field(4; Description; text[250])
        {

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
