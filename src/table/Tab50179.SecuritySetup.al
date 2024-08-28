table 50179 "Security Setup"
{
    Caption = 'Security Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            TableRelation = "No. Series";
        }
        field(2; "Incident Nos"; Code[25])
        {
            Caption = 'Incident Nos';
            TableRelation = "No. Series";
        }
        field(3; "Guest Nos"; Code[25])
        {
            Caption = 'Guest Nos';
            TableRelation = "No. Series";
        }
        field(4; "Daily OB Nos"; Code[25])
        {
            Caption = 'Daily OB Nos';
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
