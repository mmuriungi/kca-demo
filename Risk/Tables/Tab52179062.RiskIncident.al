table 52179062 "Risk Incident"
{
    Caption = 'Risk Incident';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Incident ID"; Code[20])
        {
            Caption = 'Incident ID';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "Incident ID" <> xRec."Incident ID" then begin
                    GetRiskSetup();
                    NoSeriesMgt.TestManual(RiskSetup."Incident Nos.");
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
        field(3; "Incident Title"; Text[100])
        {
            Caption = 'Incident Title';
            DataClassification = CustomerContent;
        }
        field(4; "Incident Description"; Text[250])
        {
            Caption = 'Incident Description';
            DataClassification = CustomerContent;
        }
        field(5; "Root Cause"; Text[250])
        {
            Caption = 'Root Cause';
            DataClassification = CustomerContent;
        }
        field(6; "Impact Assessment"; Text[250])
        {
            Caption = 'Impact Assessment';
            DataClassification = CustomerContent;
        }
        field(10; "Incident Type"; Enum "Incident Type")
        {
            Caption = 'Incident Type';
            DataClassification = CustomerContent;
        }
        field(11; Severity; Enum "Incident Severity")
        {
            Caption = 'Severity';
            DataClassification = CustomerContent;
        }
        field(12; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(20; "Occurrence Date"; Date)
        {
            Caption = 'Occurrence Date';
            DataClassification = CustomerContent;
        }
        field(21; "Detection Date"; Date)
        {
            Caption = 'Detection Date';
            DataClassification = CustomerContent;
        }
        field(22; "Reported By"; Code[50])
        {
            Caption = 'Reported By';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(23; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(30; Status; Enum "Risk Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(31; "Priority"; Option)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
            OptionMembers = " ",Low,Medium,High,Critical;
        }
        field(40; "Response Actions"; Text[250])
        {
            Caption = 'Response Actions';
            DataClassification = CustomerContent;
        }
        field(41; "Resolution Description"; Text[250])
        {
            Caption = 'Resolution Description';
            DataClassification = CustomerContent;
        }
        field(42; "Lessons Learned"; Text[250])
        {
            Caption = 'Lessons Learned';
            DataClassification = CustomerContent;
        }
        field(50; "Financial Impact"; Decimal)
        {
            Caption = 'Financial Impact';
            DataClassification = CustomerContent;
        }
        field(51; "Operational Impact Hours"; Decimal)
        {
            Caption = 'Operational Impact (Hours)';
            DataClassification = CustomerContent;
        }
        field(52; "Customer Impact"; Integer)
        {
            Caption = 'Customer Impact (Number)';
            DataClassification = CustomerContent;
        }
        field(60; "Target Resolution Date"; Date)
        {
            Caption = 'Target Resolution Date';
            DataClassification = CustomerContent;
        }
        field(61; "Actual Resolution Date"; Date)
        {
            Caption = 'Actual Resolution Date';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                if "Actual Resolution Date" <> 0D then
                    Status := Status::Closed;
            end;
        }
        field(70; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(71; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
    
    keys
    {
        key(PK; "Incident ID") { Clustered = true; }
        key(RiskID; "Related Risk ID") { }
        key(OccurrenceDate; "Occurrence Date") { }
        key(Severity; Severity, "Priority") { }
    }
    
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Incident ID" = '' then begin
            GetRiskSetup();
            NoSeriesMgt.InitSeries(RiskSetup."Incident Nos.", xRec."No. Series", 0D, "Incident ID", "No. Series");
        end;
        
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Detection Date" := Today;
        Status := Status::Open;
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
}