table 50127 "Venue General Setup"
{
    Caption = 'Venue General Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; Code[10])
        {
            Caption = 'Pk';
        }
        field(2; "Venue Booking Nos"; Code[25])
        {
            Caption = 'Venue Booking Nos';
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; Pk)
        {
            Clustered = true;
        }
    }
}
