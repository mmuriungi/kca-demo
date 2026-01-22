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
        field(10; "Customer Nos."; Code[20])
        {
            Caption = 'Customer Nos.';
            TableRelation = "No. Series";
        }
        field(11; "Lead Nos."; Code[20])
        {
            Caption = 'Lead Nos.';
            TableRelation = "No. Series";
        }
        field(12; "Campaign Nos."; Code[20])
        {
            Caption = 'Campaign Nos.';
            TableRelation = "No. Series";
        }
        field(13; "Support Ticket Nos."; Code[20])
        {
            Caption = 'Support Ticket Nos.';
            TableRelation = "No. Series";
        }
        field(14; "Interaction Nos."; Code[20])
        {
            Caption = 'Interaction Nos.';
            TableRelation = "No. Series";
        }
        field(15; "Transaction Nos."; Code[20])
        {
            Caption = 'Transaction Nos.';
            TableRelation = "No. Series";
        }
        field(20; "Default Lead Score Threshold"; Integer)
        {
            Caption = 'Default Lead Score Threshold';
            MinValue = 0;
            MaxValue = 100;
        }
        field(21; "Auto-Convert Hot Leads"; Boolean)
        {
            Caption = 'Auto-Convert Hot Leads';
        }
        field(22; "Email Integration Enabled"; Boolean)
        {
            Caption = 'Email Integration Enabled';
        }
        field(23; "SMS Integration Enabled"; Boolean)
        {
            Caption = 'SMS Integration Enabled';
        }
        field(24; "Default Campaign Duration"; Integer)
        {
            Caption = 'Default Campaign Duration (Days)';
            MinValue = 1;
        }
        field(25; "Support SLA Hours"; Integer)
        {
            Caption = 'Support SLA Hours';
            MinValue = 1;
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
