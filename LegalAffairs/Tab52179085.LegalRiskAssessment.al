table 52179085 "Legal Risk Assessment"
{
    Caption = 'Legal Risk Assessment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Assessment No."; Code[20])
        {
            Caption = 'Assessment No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Risk Type"; Option)
        {
            Caption = 'Risk Type';
            OptionMembers = " ","Contract Risk","Litigation Risk","Compliance Risk","Regulatory Risk","Reputational Risk","Financial Risk","Operational Risk","Data Privacy Risk","Employment Risk";
            OptionCaption = ' ,Contract Risk,Litigation Risk,Compliance Risk,Regulatory Risk,Reputational Risk,Financial Risk,Operational Risk,Data Privacy Risk,Employment Risk';
            DataClassification = ToBeClassified;
        }
        field(3; "Risk Description"; Text[250])
        {
            Caption = 'Risk Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Case"."Case No.";
        }
        field(5; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "Project Header"."No.";
        }
        field(6; "Risk Level"; Option)
        {
            Caption = 'Risk Level';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(7; "Probability"; Option)
        {
            Caption = 'Probability';
            OptionMembers = " ","Very Low",Low,Medium,High,"Very High";
            OptionCaption = ' ,Very Low,Low,Medium,High,Very High';
            DataClassification = ToBeClassified;
        }
        field(8; Impact; Option)
        {
            Caption = 'Impact';
            OptionMembers = " ",Minimal,Minor,Moderate,Major,Severe;
            OptionCaption = ' ,Minimal,Minor,Moderate,Major,Severe';
            DataClassification = ToBeClassified;
        }
        field(9; "Risk Score"; Integer)
        {
            Caption = 'Risk Score';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Mitigation Strategy"; Text[250])
        {
            Caption = 'Mitigation Strategy';
            DataClassification = ToBeClassified;
        }
        field(11; "Responsible Person"; Code[20])
        {
            Caption = 'Responsible Person';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(12; "Assessment Date"; Date)
        {
            Caption = 'Assessment Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Review Date"; Date)
        {
            Caption = 'Review Date';
            DataClassification = ToBeClassified;
        }
        field(14; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Active,Mitigated,Closed,Monitoring;
            OptionCaption = 'Active,Mitigated,Closed,Monitoring';
            DataClassification = ToBeClassified;
        }
        field(15; "Financial Impact"; Decimal)
        {
            Caption = 'Financial Impact';
            DataClassification = ToBeClassified;
        }
        field(16; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Action Plan"; Blob)
        {
            Caption = 'Action Plan';
            DataClassification = ToBeClassified;
        }
        field(20; "Legal Opinion Required"; Boolean)
        {
            Caption = 'Legal Opinion Required';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Assessment No.")
        {
            Clustered = true;
        }
        key(SK1; "Risk Level", Status)
        {
        }
        key(SK2; "Case No.")
        {
        }
        key(SK3; "Contract No.")
        {
        }
        key(SK4; "Review Date", Status)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
        "Assessment Date" := Today;
        CalculateRiskScore();
    end;

    trigger OnModify()
    begin
        CalculateRiskScore();
    end;

    local procedure CalculateRiskScore()
    begin
        "Risk Score" := Probability * Impact;
        
        case "Risk Score" of
            1..4:
                "Risk Level" := "Risk Level"::Low;
            5..9:
                "Risk Level" := "Risk Level"::Medium;
            10..15:
                "Risk Level" := "Risk Level"::High;
            16..25:
                "Risk Level" := "Risk Level"::Critical;
        end;
    end;
}