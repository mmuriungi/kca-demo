page 52179066 "Risk Register List"
{
    Caption = 'Risk Register';
    PageType = List;
    SourceTable = "Risk Register";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Risk Register Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Risk ID"; Rec."Risk ID")
                {
                    ApplicationArea = All;
                }
                field("Risk Title"; Rec."Risk Title")
                {
                    ApplicationArea = All;
                }
                field("Risk Category"; Rec."Risk Category")
                {
                    ApplicationArea = All;
                }
                field("Risk Type"; Rec."Risk Type")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Inherent Risk Level"; Rec."Inherent Risk Level")
                {
                    ApplicationArea = All;
                    StyleExpr = InherentRiskStyle;
                }
                field("Residual Risk Level"; Rec."Residual Risk Level")
                {
                    ApplicationArea = All;
                    StyleExpr = ResidualRiskStyle;
                }
                field("Treatment Strategy"; Rec."Treatment Strategy")
                {
                    ApplicationArea = All;
                }
                field("Risk Owner"; Rec."Risk Owner")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(RiskDetailsFactBox; "Risk Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Risk ID" = field("Risk ID");
            }
        }
    }
    
    actions
    {
        area(creation)
        {
            action(NewRisk)
            {
                Caption = 'New Risk';
                Image = New;
                ApplicationArea = All;
                RunObject = page "Risk Register Card";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            action(Mitigations)
            {
                Caption = 'Risk Mitigations';
                Image = Planning;
                ApplicationArea = All;
                RunObject = page "Risk Mitigation List";
                RunPageLink = "Risk ID" = field("Risk ID");
            }
            action(Incidents)
            {
                Caption = 'Related Incidents';
                Image = ErrorLog;
                ApplicationArea = All;
                RunObject = page "Risk Incident List";
                RunPageLink = "Related Risk ID" = field("Risk ID");
            }
            action(KRIs)
            {
                Caption = 'Key Risk Indicators';
                Image = Statistics;
                ApplicationArea = All;
                RunObject = page "Key Risk Indicators List";
                RunPageLink = "Related Risk ID" = field("Risk ID");
            }
            group(Reports)
            {
                Caption = 'Reports';
                action(RiskHeatMap)
                {
                    Caption = 'Risk Heat Map';
                    Image = Matrix;
                    ApplicationArea = All;
                    RunObject = report "Risk Heat Map Report";
                }
                action(RiskRegisterReport)
                {
                    Caption = 'Risk Register Report';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = report "Risk Register Report";
                }
            }
        }
        area(navigation)
        {
            action(Setup)
            {
                Caption = 'Risk Management Setup';
                Image = Setup;
                ApplicationArea = All;
                RunObject = page "Risk Management Setup";
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetRiskLevelStyles();
    end;
    
    var
        InherentRiskStyle: Text;
        ResidualRiskStyle: Text;
    
    local procedure SetRiskLevelStyles()
    begin
        case Rec."Inherent Risk Level" of
            Rec."Inherent Risk Level"::Very_Low:
                InherentRiskStyle := 'Favorable';
            Rec."Inherent Risk Level"::Low:
                InherentRiskStyle := 'Favorable';
            Rec."Inherent Risk Level"::Medium:
                InherentRiskStyle := 'Ambiguous';
            Rec."Inherent Risk Level"::High:
                InherentRiskStyle := 'Unfavorable';
            Rec."Inherent Risk Level"::Very_High:
                InherentRiskStyle := 'Attention';
            else
                InherentRiskStyle := 'None';
        end;
        
        case Rec."Residual Risk Level" of
            Rec."Residual Risk Level"::Very_Low:
                ResidualRiskStyle := 'Favorable';
            Rec."Residual Risk Level"::Low:
                ResidualRiskStyle := 'Favorable';
            Rec."Residual Risk Level"::Medium:
                ResidualRiskStyle := 'Ambiguous';
            Rec."Residual Risk Level"::High:
                ResidualRiskStyle := 'Unfavorable';
            Rec."Residual Risk Level"::Very_High:
                ResidualRiskStyle := 'Attention';
            else
                ResidualRiskStyle := 'None';
        end;
    end;
}