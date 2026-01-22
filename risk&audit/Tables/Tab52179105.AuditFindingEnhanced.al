table 52179105 "Audit Finding Enhanced"
{
    Caption = 'Audit Finding Enhanced';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Finding No."; Code[20])
        {
            Caption = 'Finding No.';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if "Finding No." <> xRec."Finding No." then begin
                    AuditSetup.Get();
                    NoSeriesMgt.TestManual(AuditSetup."Audit Finding Nos.");
                end;
            end;
        }
        field(2; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                AuditHeader: Record "Audit Header";
            begin
                if AuditHeader.Get("Audit No.") then begin
                    "Audit Description" := AuditHeader.Description;
                    "Department Code" := AuditHeader."Shortcut Dimension 1 Code";
                end;
            end;
        }
        field(3; "Audit Description"; Text[100])
        {
            Caption = 'Audit Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Finding Type"; Option)
        {
            Caption = 'Finding Type';
            OptionMembers = " ",Compliance,Financial,Operational,IT,Strategic;
            OptionCaption = ' ,Compliance,Financial,Operational,IT,Strategic';
            DataClassification = ToBeClassified;
        }
        field(5; "Finding Category"; Option)
        {
            Caption = 'Finding Category';
            OptionMembers = " ","Control Weakness","Process Inefficiency","Policy Violation","Regulatory Non-compliance","Financial Discrepancy","System Issue",Other;
            OptionCaption = ' ,Control Weakness,Process Inefficiency,Policy Violation,Regulatory Non-compliance,Financial Discrepancy,System Issue,Other';
            DataClassification = ToBeClassified;
        }
        field(6; "Finding Title"; Text[100])
        {
            Caption = 'Finding Title';
            DataClassification = ToBeClassified;
        }
        field(7; "Finding Description"; Text[250])
        {
            Caption = 'Finding Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Detailed Description"; Blob)
        {
            Caption = 'Detailed Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Risk Severity"; Option)
        {
            Caption = 'Risk Severity';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(10; "Risk Impact"; Option)
        {
            Caption = 'Risk Impact';
            OptionMembers = " ",Minimal,Minor,Moderate,Major,"Severe/Catastrophic";
            OptionCaption = ' ,Minimal,Minor,Moderate,Major,Severe/Catastrophic';
            DataClassification = ToBeClassified;
        }
        field(11; "Risk Likelihood"; Option)
        {
            Caption = 'Risk Likelihood';
            OptionMembers = " ",Rare,Unlikely,Possible,Likely,"Almost Certain";
            OptionCaption = ' ,Rare,Unlikely,Possible,Likely,Almost Certain';
            DataClassification = ToBeClassified;
        }
        field(12; "Business Impact"; Text[250])
        {
            Caption = 'Business Impact';
            DataClassification = ToBeClassified;
        }
        field(13; "Root Cause"; Text[250])
        {
            Caption = 'Root Cause';
            DataClassification = ToBeClassified;
        }
        field(14; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(15; "Process Area"; Text[100])
        {
            Caption = 'Process Area';
            DataClassification = ToBeClassified;
        }
        field(16; "Criteria"; Text[250])
        {
            Caption = 'Criteria';
            DataClassification = ToBeClassified;
        }
        field(17; "Condition"; Text[250])
        {
            Caption = 'Condition';
            DataClassification = ToBeClassified;
        }
        field(18; "Cause"; Text[250])
        {
            Caption = 'Cause';
            DataClassification = ToBeClassified;
        }
        field(19; "Effect"; Text[250])
        {
            Caption = 'Effect';
            DataClassification = ToBeClassified;
        }
        field(20; "Recommendation"; Text[250])
        {
            Caption = 'Recommendation';
            DataClassification = ToBeClassified;
        }
        field(21; "Management Response"; Text[250])
        {
            Caption = 'Management Response';
            DataClassification = ToBeClassified;
        }
        field(22; "Responsible Person"; Code[50])
        {
            Caption = 'Responsible Person';
            TableRelation = "HRM-Employee C"."No.";
            DataClassification = ToBeClassified;
        }
        field(23; "Target Completion Date"; Date)
        {
            Caption = 'Target Completion Date';
            DataClassification = ToBeClassified;
        }
        field(24; "Finding Status"; Option)
        {
            Caption = 'Finding Status';
            OptionMembers = Open,"Under Review","Awaiting Response",Accepted,Disputed,Closed;
            OptionCaption = 'Open,Under Review,Awaiting Response,Accepted,Disputed,Closed';
            DataClassification = ToBeClassified;
        }
        field(25; "Working Paper Reference"; Code[20])
        {
            Caption = 'Working Paper Reference';
            TableRelation = "Working Paper Management"."WP No.";
            DataClassification = ToBeClassified;
        }
        field(26; "Supporting Documents"; Integer)
        {
            Caption = 'Supporting Documents';
            FieldClass = FlowField;
            CalcFormula = Count("Working Paper Management" WHERE("Finding No." = FIELD("Finding No.")));
            Editable = false;
        }
        field(27; "Repeat Finding"; Boolean)
        {
            Caption = 'Repeat Finding';
            DataClassification = ToBeClassified;
        }
        field(28; "Previous Finding No."; Code[20])
        {
            Caption = 'Previous Finding No.';
            TableRelation = "Audit Finding Enhanced"."Finding No.";
            DataClassification = ToBeClassified;
        }
        field(29; "Financial Impact"; Decimal)
        {
            Caption = 'Financial Impact';
            DataClassification = ToBeClassified;
        }
        field(30; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(35; "Risk Score"; Integer)
        {
            Caption = 'Risk Score';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Exception Amount"; Decimal)
        {
            Caption = 'Exception Amount';
            DataClassification = ToBeClassified;
        }
        field(37; "Test Sample Size"; Integer)
        {
            Caption = 'Test Sample Size';
            DataClassification = ToBeClassified;
        }
        field(38; "Exceptions Found"; Integer)
        {
            Caption = 'Exceptions Found';
            DataClassification = ToBeClassified;
        }
        field(39; "Tolerable Level"; Integer)
        {
            Caption = 'Tolerable Level';
            DataClassification = ToBeClassified;
        }
        field(40; "Compliance Rating"; Option)
        {
            Caption = 'Compliance Rating';
            OptionMembers = " ",Compliant,"Partially Compliant","Non-Compliant";
            OptionCaption = ' ,Compliant,Partially Compliant,Non-Compliant';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Finding No.")
        {
            Clustered = true;
        }
        key(AuditNo; "Audit No.", "Finding No.")
        {
        }
        key(Severity; "Risk Severity", "Finding Status")
        {
        }
        key(Department; "Department Code", "Risk Severity")
        {
        }
    }
    
    trigger OnInsert()
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Finding No." = '' then begin
            AuditSetup.Get();
            AuditSetup.TestField("Audit Finding Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Finding Nos.", xRec."No. Series", 0D, "Finding No.", "No. Series");
        end;
        
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
        CalculateRiskScore();
    end;
    
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        
    local procedure CalculateRiskScore()
    var
        ImpactScore: Integer;
        LikelihoodScore: Integer;
    begin
        case "Risk Impact" of
            "Risk Impact"::Minimal:
                ImpactScore := 1;
            "Risk Impact"::Minor:
                ImpactScore := 2;
            "Risk Impact"::Moderate:
                ImpactScore := 3;
            "Risk Impact"::Major:
                ImpactScore := 4;
            "Risk Impact"::"Severe/Catastrophic":
                ImpactScore := 5;
        end;
        
        case "Risk Likelihood" of
            "Risk Likelihood"::Rare:
                LikelihoodScore := 1;
            "Risk Likelihood"::Unlikely:
                LikelihoodScore := 2;
            "Risk Likelihood"::Possible:
                LikelihoodScore := 3;
            "Risk Likelihood"::Likely:
                LikelihoodScore := 4;
            "Risk Likelihood"::"Almost Certain":
                LikelihoodScore := 5;
        end;
        
        "Risk Score" := ImpactScore * LikelihoodScore;
    end;
}