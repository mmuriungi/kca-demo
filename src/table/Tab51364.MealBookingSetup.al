table 51364 "Meal Booking Setup"
{
    Caption = 'Meal Booking Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; Code[10])
        {
            Caption = 'Pk';
        }
        field(2; "Meal Booking Nos"; Code[25])
        {
            Caption = 'Meal Booking Nos';
            TableRelation = "No. Series";
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
