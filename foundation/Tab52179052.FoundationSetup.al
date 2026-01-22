table 52179052 "Foundation Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Foundation Setup';
    
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Donor Nos."; Code[20])
        {
            Caption = 'Donor Nos.';
            TableRelation = "No. Series";
        }
        field(11; "Donation Nos."; Code[20])
        {
            Caption = 'Donation Nos.';
            TableRelation = "No. Series";
        }
        field(12; "Campaign Nos."; Code[20])
        {
            Caption = 'Campaign Nos.';
            TableRelation = "No. Series";
        }
        field(13; "Pledge Nos."; Code[20])
        {
            Caption = 'Pledge Nos.';
            TableRelation = "No. Series";
        }
        field(14; "Grant Nos."; Code[20])
        {
            Caption = 'Grant Nos.';
            TableRelation = "No. Series";
        }
        field(15; "Scholarship Nos."; Code[20])
        {
            Caption = 'Scholarship Nos.';
            TableRelation = "No. Series";
        }
        field(16; "Event Nos."; Code[20])
        {
            Caption = 'Event Nos.';
            TableRelation = "No. Series";
        }
        field(17; "Partnership Nos."; Code[20])
        {
            Caption = 'Partnership Nos.';
            TableRelation = "No. Series";
        }
        field(18; "Grant Application Nos."; Code[20])
        {
            Caption = 'Grant Application Nos.';
            TableRelation = "No. Series";
        }
        field(19; "Scholarship Application Nos."; Code[20])
        {
            Caption = 'Scholarship Application Nos.';
            TableRelation = "No. Series";
        }
        field(25; "Event Registration Nos."; Code[20])
        {
            Caption = 'Event Registration Nos.';
            TableRelation = "No. Series";
        }
        field(30; "Default Donation GL Account"; Code[20])
        {
            Caption = 'Default Donation GL Account';
            TableRelation = "G/L Account";
        }
        field(31; "Default Grant GL Account"; Code[20])
        {
            Caption = 'Default Grant GL Account';
            TableRelation = "G/L Account";
        }
        field(32; "Default Scholarship GL Account"; Code[20])
        {
            Caption = 'Default Scholarship GL Account';
            TableRelation = "G/L Account";
        }
        field(40; "Enable PayPal"; Boolean)
        {
            Caption = 'Enable PayPal';
        }
        field(41; "PayPal API Key"; Text[100])
        {
            Caption = 'PayPal API Key';
            ExtendedDatatype = Masked;
        }
        field(42; "PayPal Secret"; Text[100])
        {
            Caption = 'PayPal Secret';
            ExtendedDatatype = Masked;
        }
        field(45; "Enable M-Pesa"; Boolean)
        {
            Caption = 'Enable M-Pesa';
        }
        field(46; "M-Pesa Consumer Key"; Text[100])
        {
            Caption = 'M-Pesa Consumer Key';
            ExtendedDatatype = Masked;
        }
        field(47; "M-Pesa Consumer Secret"; Text[100])
        {
            Caption = 'M-Pesa Consumer Secret';
            ExtendedDatatype = Masked;
        }
        field(48; "M-Pesa Shortcode"; Code[10])
        {
            Caption = 'M-Pesa Shortcode';
        }
        field(50; "Auto Send Acknowledgment"; Boolean)
        {
            Caption = 'Auto Send Acknowledgment';
        }
        field(51; "Acknowledgment Template"; Code[20])
        {
            Caption = 'Acknowledgment Template';
        }
        field(52; "Thank You Template"; Code[20])
        {
            Caption = 'Thank You Template';
        }
        field(53; "Tax Certificate Template"; Code[20])
        {
            Caption = 'Tax Certificate Template';
        }
        field(60; "Min. Major Donor Amount"; Decimal)
        {
            Caption = 'Min. Major Donor Amount';
            DecimalPlaces = 2:2;
        }
        field(61; "Bronze Level Amount"; Decimal)
        {
            Caption = 'Bronze Level Amount';
            DecimalPlaces = 2:2;
        }
        field(62; "Silver Level Amount"; Decimal)
        {
            Caption = 'Silver Level Amount';
            DecimalPlaces = 2:2;
        }
        field(63; "Gold Level Amount"; Decimal)
        {
            Caption = 'Gold Level Amount';
            DecimalPlaces = 2:2;
        }
        field(64; "Platinum Level Amount"; Decimal)
        {
            Caption = 'Platinum Level Amount';
            DecimalPlaces = 2:2;
        }
        field(65; "Diamond Level Amount"; Decimal)
        {
            Caption = 'Diamond Level Amount';
            DecimalPlaces = 2:2;
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