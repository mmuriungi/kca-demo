table 52179081 "Legal Affairs Setup"
{
    Caption = 'Legal Affairs Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Case Nos."; Code[20])
        {
            Caption = 'Case Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Document Nos."; Code[20])
        {
            Caption = 'Document Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "Legal Invoice Nos."; Code[20])
        {
            Caption = 'Legal Invoice Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Compliance Task Nos."; Code[20])
        {
            Caption = 'Compliance Task Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Contract Expiry Alert Days"; Integer)
        {
            Caption = 'Contract Expiry Alert Days';
            DataClassification = ToBeClassified;
            InitValue = 90;
        }
        field(7; "Deadline Alert Days"; Integer)
        {
            Caption = 'Deadline Alert Days';
            DataClassification = ToBeClassified;
            InitValue = 7;
        }
        field(8; "Default Document Storage Path"; Text[250])
        {
            Caption = 'Default Document Storage Path';
            DataClassification = ToBeClassified;
        }
        field(9; "Enable Email Notifications"; Boolean)
        {
            Caption = 'Enable Email Notifications';
            DataClassification = ToBeClassified;
        }
        field(10; "Legal Department Email"; Text[100])
        {
            Caption = 'Legal Department Email';
            DataClassification = ToBeClassified;
        }
        field(11; "Risk Assessment Period"; DateFormula)
        {
            Caption = 'Risk Assessment Period';
            DataClassification = ToBeClassified;
        }
        field(12; "Court Date Reminder Days"; Integer)
        {
            Caption = 'Court Date Reminder Days';
            DataClassification = ToBeClassified;
            InitValue = 7;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        
    end;

    trigger OnModify()
    begin
        
    end;

    trigger OnDelete()
    begin
        
    end;
}