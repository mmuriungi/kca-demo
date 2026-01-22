table 52179109 "Compliance Monitoring"
{
    Caption = 'Compliance Monitoring';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Monitoring No."; Code[20])
        {
            Caption = 'Monitoring No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Compliance Area"; Text[100])
        {
            Caption = 'Compliance Area';
            DataClassification = ToBeClassified;
        }
        field(3; "Monitoring Date"; Date)
        {
            Caption = 'Monitoring Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Next Review Date"; Date)
        {
            Caption = 'Next Review Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Compliance Status"; Option)
        {
            Caption = 'Compliance Status';
            OptionMembers = Compliant,"Partially Compliant","Non-Compliant";
            OptionCaption = 'Compliant,Partially Compliant,Non-Compliant';
            DataClassification = ToBeClassified;
        }
        field(6; "Risk Level"; Option)
        {
            Caption = 'Risk Level';
            OptionMembers = Low,Medium,High,Critical;
            OptionCaption = 'Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(7; "Responsible Person"; Code[50])
        {
            Caption = 'Responsible Person';
            TableRelation = "HRM-Employee C"."No.";
            DataClassification = ToBeClassified;
        }
        field(8; "Compliance Score"; Decimal)
        {
            Caption = 'Compliance Score';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(9; "Action Required"; Boolean)
        {
            Caption = 'Action Required';
            DataClassification = ToBeClassified;
        }
        field(10; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Monitoring No.")
        {
            Clustered = true;
        }
        key(AreaDate; "Compliance Area", "Monitoring Date")
        {
        }
        key(Status; "Compliance Status", "Risk Level")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
}