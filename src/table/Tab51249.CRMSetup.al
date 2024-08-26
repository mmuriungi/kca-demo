// Table: CRM Setup
table 51249 "CRM Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Event Nos."; Code[20])
        {
            Caption = 'Event Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Donation Nos."; Code[20])
        {
            Caption = 'Donation Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
