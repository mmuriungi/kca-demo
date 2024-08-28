// Table: Donation
table 51247 "Donation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Donor No."; Code[20])
        {
            Caption = 'Donor No.';
            TableRelation = Customer where(status = const(Alumni));
        }
        field(3; "Donation Date"; Date)
        {
            Caption = 'Donation Date';
        }
        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
            TableRelation = "Campaign";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
