table 52179061 "Risk Mitigation"
{
    Caption = 'Risk Mitigation';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Mitigation ID"; Code[20])
        {
            Caption = 'Mitigation ID';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "Mitigation ID" <> xRec."Mitigation ID" then begin
                    GetRiskSetup();
                    NoSeriesMgt.TestManual(RiskSetup."Mitigation Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Risk ID"; Code[20])
        {
            Caption = 'Risk ID';
            DataClassification = CustomerContent;
            TableRelation = "Risk Register"."Risk ID";
        }
        field(3; "Mitigation Title"; Text[100])
        {
            Caption = 'Mitigation Title';
            DataClassification = CustomerContent;
        }
        field(4; "Mitigation Description"; Text[250])
        {
            Caption = 'Mitigation Description';
            DataClassification = CustomerContent;
        }
        field(5; "Action Required"; Text[250])
        {
            Caption = 'Action Required';
            DataClassification = CustomerContent;
        }
        field(10; "Responsible Person"; Code[50])
        {
            Caption = 'Responsible Person';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(11; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(20; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(21; "Target Date"; Date)
        {
            Caption = 'Target Date';
            DataClassification = CustomerContent;
        }
        field(22; "Actual Completion Date"; Date)
        {
            Caption = 'Actual Completion Date';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                if "Actual Completion Date" <> 0D then
                    Status := Status::Completed;
            end;
        }
        field(30; Status; Enum "Mitigation Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(31; "Progress %"; Decimal)
        {
            Caption = 'Progress %';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
        }
        field(32; "Days Remaining"; Integer)
        {
            Caption = 'Days Remaining';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; Priority; Enum "CRM Priority Level")
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(40; "Budget Required"; Boolean)
        {
            Caption = 'Budget Required';
            DataClassification = CustomerContent;
        }
        field(41; "Budget Amount"; Decimal)
        {
            Caption = 'Budget Amount';
            DataClassification = CustomerContent;
        }
        field(42; "Actual Cost"; Decimal)
        {
            Caption = 'Actual Cost';
            DataClassification = CustomerContent;
        }
        field(50; "Control Effectiveness"; Option)
        {
            Caption = 'Control Effectiveness';
            DataClassification = CustomerContent;
            OptionMembers = " ",Ineffective,Partially_Effective,Effective,Highly_Effective;
        }
        field(51; "Last Review Date"; Date)
        {
            Caption = 'Last Review Date';
            DataClassification = CustomerContent;
        }
        field(52; "Next Review Date"; Date)
        {
            Caption = 'Next Review Date';
            DataClassification = CustomerContent;
        }
        field(60; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(63; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
    
    keys
    {
        key(PK; "Mitigation ID") { Clustered = true; }
        key(RiskID; "Risk ID") { }
        key(TargetDate; "Target Date") { }
        key(Status; Status) { }
    }
    
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Mitigation ID" = '' then begin
            GetRiskSetup();
            NoSeriesMgt.InitSeries(RiskSetup."Mitigation Nos.", xRec."No. Series", 0D, "Mitigation ID", "No. Series");
        end;
        
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
        CalculateDaysRemaining();
        UpdateStatus();
    end;
    
    var
        RiskSetup: Record "Risk Management Setup";
        RiskSetupRead: Boolean;
    
    local procedure GetRiskSetup()
    begin
        if not RiskSetupRead then begin
            RiskSetup.Get();
            RiskSetupRead := true;
        end;
    end;
    
    local procedure CalculateDaysRemaining()
    begin
        if ("Target Date" <> 0D) and ("Actual Completion Date" = 0D) then
            "Days Remaining" := "Target Date" - Today
        else
            "Days Remaining" := 0;
    end;
    
    local procedure UpdateStatus()
    begin
        if "Actual Completion Date" <> 0D then
            Status := Status::Completed
        else if ("Target Date" <> 0D) and (Today > "Target Date") then
            Status := Status::Overdue
        else if ("Days Remaining" <= 7) and ("Days Remaining" > 0) then
            Status := Status::At_Risk;
    end;
}