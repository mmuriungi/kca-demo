table 52179110 "Risk Assessment Enhanced"
{
    Caption = 'Risk Assessment Enhanced';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Assessment No."; Code[20])
        {
            Caption = 'Assessment No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Audit Universe Code"; Code[20])
        {
            Caption = 'Audit Universe Code';
            TableRelation = "Audit Universe".Code;
            DataClassification = ToBeClassified;
        }
        field(3; "Assessment Date"; Date)
        {
            Caption = 'Assessment Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Risk Category"; Option)
        {
            Caption = 'Risk Category';
            OptionMembers = Financial,Operational,Compliance,Strategic,Reputational;
            OptionCaption = 'Financial,Operational,Compliance,Strategic,Reputational';
            DataClassification = ToBeClassified;
        }
        field(5; "Inherent Risk"; Integer)
        {
            Caption = 'Inherent Risk';
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 5;
        }
        field(6; "Control Risk"; Integer)
        {
            Caption = 'Control Risk';
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 5;
        }
        field(7; "Detection Risk"; Integer)
        {
            Caption = 'Detection Risk';
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 5;
        }
        field(8; "Overall Risk"; Decimal)
        {
            Caption = 'Overall Risk';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(9; "Risk Description"; Text[250])
        {
            Caption = 'Risk Description';
            DataClassification = ToBeClassified;
        }
        field(10; "Mitigation Strategy"; Text[250])
        {
            Caption = 'Mitigation Strategy';
            DataClassification = ToBeClassified;
        }
        field(11; "Assessment Status"; Option)
        {
            Caption = 'Assessment Status';
            OptionMembers = Draft,"Under Review",Approved,Rejected;
            OptionCaption = 'Draft,Under Review,Approved,Rejected';
            DataClassification = ToBeClassified;
        }
        field(12; "Assessed By"; Code[50])
        {
            Caption = 'Assessed By';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
        }
        field(13; "Review Date"; Date)
        {
            Caption = 'Review Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Assessment No.")
        {
            Clustered = true;
        }
        key(Universe; "Audit Universe Code", "Assessment Date")
        {
        }
        key(Risk; "Overall Risk", "Assessment Status")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
}