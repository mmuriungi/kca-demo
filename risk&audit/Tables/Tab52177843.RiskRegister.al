table 51327 "Risk Register"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Corporate,Department,Project';
            OptionMembers = " ",Corporate,Department,Project;
        }
        field(3; Category; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Value at Risk"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Value at Risk Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Gross (L*I)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Existing Control / Mitigation"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Residual (L*I)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "KRI(s) Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Mitigation Action"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Mitigation Owner"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "KRI(s) Status"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; "Risk Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Risk Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk,Risk Opportunity';
            OptionMembers = " ",Risk,"Risk Opportunity";
        }
        field(20; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Risk Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Drivers,Mitigation Proposal,Effects,Value Explanation,Existing Control,KRI(s),Response,M&E,Risk Category,Risk Opportunity';
            OptionMembers = " ",Drivers,"Mitigation Proposal",Effects,"Value Explanation","Existing Control","KRI(s)",Response,"M&E","Risk Category","Risk Opportunity";
        }
        field(22; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Mitigation Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Not Done,In Progress,Done';
            OptionMembers = " ","Not Done","In Progress",Done;
        }
        // Enhanced ERM Fields
        field(30; "Risk ID"; Code[20])
        {
            Caption = 'Risk ID';
            DataClassification = CustomerContent;
        }
        field(31; "Risk Title"; Text[100])
        {
            Caption = 'Risk Title';
            DataClassification = CustomerContent;
        }
        field(32; "Risk Cause"; Text[250])
        {
            Caption = 'Risk Cause';
            DataClassification = CustomerContent;
        }
        field(33; "Risk Effects"; Text[250])
        {
            Caption = 'Risk Effects/Consequences';
            DataClassification = CustomerContent;
        }
        field(34; "Risk Category"; Enum "Risk Category")
        {
            Caption = 'Risk Category';
            DataClassification = CustomerContent;
        }
        field(35; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(36; "Function Code"; Code[20])
        {
            Caption = 'Function Code';
            DataClassification = CustomerContent;
        }
        field(37; "Strategic Pillar"; Code[20])
        {
            Caption = 'Strategic Pillar';
            DataClassification = CustomerContent;
        }
        field(40; "Inherent Likelihood"; Enum "Risk Likelihood")
        {
            Caption = 'Inherent Likelihood';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                CalculateInherentRating();
            end;
        }
        field(41; "Inherent Impact"; Enum "Risk Impact Level")
        {
            Caption = 'Inherent Impact';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                CalculateInherentRating();
            end;
        }
        field(42; "Inherent Rating"; Integer)
        {
            Caption = 'Inherent Rating';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(43; "Inherent Risk Level"; Enum "Risk Rating")
        {
            Caption = 'Inherent Risk Level';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50; "Residual Likelihood"; Enum "Risk Likelihood")
        {
            Caption = 'Residual Likelihood';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                CalculateResidualRating();
            end;
        }
        field(51; "Residual Impact"; Enum "Risk Impact Level")
        {
            Caption = 'Residual Impact';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                CalculateResidualRating();
            end;
        }
        field(52; "Residual Rating"; Integer)
        {
            Caption = 'Residual Rating';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "Residual Risk Level"; Enum "Risk Rating")
        {
            Caption = 'Residual Risk Level';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60; "Treatment Strategy"; Enum "Risk Treatment Strategy")
        {
            Caption = 'Treatment Strategy';
            DataClassification = CustomerContent;
        }
        field(61; "Risk Owner"; Code[50])
        {
            Caption = 'Risk Owner';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(62; Status; Enum "Risk Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(70; "Risk Appetite"; Text[100])
        {
            Caption = 'Risk Appetite';
            DataClassification = CustomerContent;
        }
        field(71; "Risk Tolerance"; Text[100])
        {
            Caption = 'Risk Tolerance';
            DataClassification = CustomerContent;
        }
        field(80; "Last Review Date"; Date)
        {
            Caption = 'Last Review Date';
            DataClassification = CustomerContent;
        }
        field(81; "Next Review Date"; Date)
        {
            Caption = 'Next Review Date';
            DataClassification = CustomerContent;
        }
        field(82; "Review Period"; DateFormula)
        {
            Caption = 'Review Period';
            DataClassification = CustomerContent;
            
            trigger OnValidate()
            begin
                if Format("Review Period") <> '' then
                    "Next Review Date" := CalcDate("Review Period", Today);
            end;
        }
        field(90; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(91; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(92; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(93; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(RiskID; "Risk ID") { }
        key(Category; "Risk Category") { }
        key(Department; "Department Code") { }
        key(RiskLevel; "Inherent Risk Level", "Residual Risk Level") { }
        key(ReviewDate; "Next Review Date") { }
    }

    fieldgroups
    {
    }
    
    trigger OnInsert()
    begin
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
    
    local procedure CalculateInherentRating()
    begin
        if ("Inherent Likelihood" <> "Inherent Likelihood"::" ") and ("Inherent Impact" <> "Inherent Impact"::" ") then begin
            "Inherent Rating" := "Inherent Likelihood".AsInteger() * "Inherent Impact".AsInteger();
            "Inherent Risk Level" := GetRiskLevel("Inherent Rating");
        end else begin
            "Inherent Rating" := 0;
            "Inherent Risk Level" := "Inherent Risk Level"::" ";
        end;
    end;
    
    local procedure CalculateResidualRating()
    begin
        if ("Residual Likelihood" <> "Residual Likelihood"::" ") and ("Residual Impact" <> "Residual Impact"::" ") then begin
            "Residual Rating" := "Residual Likelihood".AsInteger() * "Residual Impact".AsInteger();
            "Residual Risk Level" := GetRiskLevel("Residual Rating");
        end else begin
            "Residual Rating" := 0;
            "Residual Risk Level" := "Residual Risk Level"::" ";
        end;
    end;
    
    local procedure GetRiskLevel(Rating: Integer): Enum "Risk Rating"
    begin
        case Rating of
            1..5:
                exit("Risk Rating"::Very_Low);
            6..10:
                exit("Risk Rating"::Low);
            11..15:
                exit("Risk Rating"::Medium);
            16..20:
                exit("Risk Rating"::High);
            21..25:
                exit("Risk Rating"::Very_High);
            else
                exit("Risk Rating"::" ");
        end;
    end;
}

