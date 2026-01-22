table 52179060 "Risk Management Setup"
{
    Caption = 'Risk Management Setup';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Risk Nos."; Code[20])
        {
            Caption = 'Risk Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(11; "Mitigation Nos."; Code[20])
        {
            Caption = 'Mitigation Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(12; "Incident Nos."; Code[20])
        {
            Caption = 'Incident Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(13; "KRI Nos."; Code[20])
        {
            Caption = 'KRI Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(20; "Default Review Period"; DateFormula)
        {
            Caption = 'Default Review Period';
            DataClassification = CustomerContent;
        }
        field(21; "Alert Days Before Review"; Integer)
        {
            Caption = 'Alert Days Before Review';
            DataClassification = CustomerContent;
        }
        field(30; "Risk Manager"; Code[50])
        {
            Caption = 'Risk Manager';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(31; "Risk Committee Chair"; Code[50])
        {
            Caption = 'Risk Committee Chair';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(40; "Enable Notifications"; Boolean)
        {
            Caption = 'Enable Notifications';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(41; "Auto Calculate Ratings"; Boolean)
        {
            Caption = 'Auto Calculate Ratings';
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }
    
    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
    
    trigger OnInsert()
    begin
        "Primary Key" := '';
    end;
}