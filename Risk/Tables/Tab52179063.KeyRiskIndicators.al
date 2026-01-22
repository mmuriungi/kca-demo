table 52179063 "Key Risk Indicators"
{
    Caption = 'Key Risk Indicators';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "KRI ID"; Code[20])
        {
            Caption = 'KRI ID';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "KRI ID" <> xRec."KRI ID" then begin
                    GetRiskSetup();
                    NoSeriesMgt.TestManual(RiskSetup."KRI Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Related Risk ID"; Code[20])
        {
            Caption = 'Related Risk ID';
            DataClassification = CustomerContent;
            TableRelation = "Risk Register"."Risk ID";
        }
        field(3; "KRI Name"; Text[100])
        {
            Caption = 'KRI Name';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Measurement Method"; Text[100])
        {
            Caption = 'Measurement Method';
            DataClassification = CustomerContent;
        }
        field(10; "Current Value"; Decimal)
        {
            Caption = 'Current Value';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                UpdateStatus();
            end;
        }
        field(11; "Target Value"; Decimal)
        {
            Caption = 'Target Value';
            DataClassification = CustomerContent;
        }
        field(12; "Threshold - Green"; Decimal)
        {
            Caption = 'Threshold - Green';
            DataClassification = CustomerContent;
        }
        field(13; "Threshold - Yellow"; Decimal)
        {
            Caption = 'Threshold - Yellow';
            DataClassification = CustomerContent;
        }
        field(14; "Threshold - Red"; Decimal)
        {
            Caption = 'Threshold - Red';
            DataClassification = CustomerContent;
        }
        field(20; "Alert Status"; Option)
        {
            Caption = 'Alert Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Green,Yellow,Red;
            Editable = false;
        }
        field(21; "Monitoring Frequency"; Option)
        {
            Caption = 'Monitoring Frequency';
            DataClassification = CustomerContent;
            OptionMembers = " ",Daily,Weekly,Monthly,Quarterly,Annual;
        }
        field(22; "Last Measured Date"; Date)
        {
            Caption = 'Last Measured Date';
            DataClassification = CustomerContent;
        }
        field(23; "Next Measurement Date"; Date)
        {
            Caption = 'Next Measurement Date';
            DataClassification = CustomerContent;
        }
        field(30; "Data Source"; Text[100])
        {
            Caption = 'Data Source';
            DataClassification = CustomerContent;
        }
        field(31; "Responsible Person"; Code[50])
        {
            Caption = 'Responsible Person';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(32; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(40; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(50; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
    
    keys
    {
        key(PK; "KRI ID") { Clustered = true; }
        key(RiskID; "Related Risk ID") { }
        key(AlertStatus; "Alert Status") { }
        key(NextMeasurement; "Next Measurement Date") { }
    }
    
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "KRI ID" = '' then begin
            GetRiskSetup();
            NoSeriesMgt.InitSeries(RiskSetup."KRI Nos.", xRec."No. Series", 0D, "KRI ID", "No. Series");
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
    
    local procedure UpdateStatus()
    begin
        if "Current Value" <= "Threshold - Green" then
            "Alert Status" := "Alert Status"::Green
        else if "Current Value" <= "Threshold - Yellow" then
            "Alert Status" := "Alert Status"::Yellow
        else if "Current Value" <= "Threshold - Red" then
            "Alert Status" := "Alert Status"::Red;
            
        "Last Measured Date" := Today;
        CalculateNextMeasurementDate();
    end;
    
    local procedure CalculateNextMeasurementDate()
    begin
        case "Monitoring Frequency" of
            "Monitoring Frequency"::Daily:
                "Next Measurement Date" := CalcDate('<1D>', "Last Measured Date");
            "Monitoring Frequency"::Weekly:
                "Next Measurement Date" := CalcDate('<1W>', "Last Measured Date");
            "Monitoring Frequency"::Monthly:
                "Next Measurement Date" := CalcDate('<1M>', "Last Measured Date");
            "Monitoring Frequency"::Quarterly:
                "Next Measurement Date" := CalcDate('<3M>', "Last Measured Date");
            "Monitoring Frequency"::Annual:
                "Next Measurement Date" := CalcDate('<1Y>', "Last Measured Date");
        end;
    end;
}