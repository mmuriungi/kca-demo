page 52179067 "Risk Register Card"
{
    Caption = 'Risk Register Card';
    PageType = Card;
    SourceTable = "Risk Register";
    ApplicationArea = All;
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Function Code"; Rec."Function Code")
                {
                    ApplicationArea = All;
                }
                field("Strategic Pillar"; Rec."Strategic Pillar")
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
            }
            group(RiskDescription)
            {
                Caption = 'Risk Description';
                field("Risk Description"; Rec."Risk Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Risk Cause"; Rec."Risk Cause")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Risk Effects"; Rec."Risk Effects")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(InherentRisk)
            {
                Caption = 'Inherent Risk Assessment';
                field("Inherent Likelihood"; Rec."Inherent Likelihood")
                {
                    ApplicationArea = All;
                }
                field("Inherent Impact"; Rec."Inherent Impact")
                {
                    ApplicationArea = All;
                }
                field("Inherent Rating"; Rec."Inherent Rating")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }
                field("Inherent Risk Level"; Rec."Inherent Risk Level")
                {
                    ApplicationArea = All;
                    StyleExpr = InherentRiskStyle;
                }
            }
            group(ResidualRisk)
            {
                Caption = 'Residual Risk Assessment';
                field("Residual Likelihood"; Rec."Residual Likelihood")
                {
                    ApplicationArea = All;
                }
                field("Residual Impact"; Rec."Residual Impact")
                {
                    ApplicationArea = All;
                }
                field("Residual Rating"; Rec."Residual Rating")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }
                field("Residual Risk Level"; Rec."Residual Risk Level")
                {
                    ApplicationArea = All;
                    StyleExpr = ResidualRiskStyle;
                }
            }
            group(Treatment)
            {
                Caption = 'Risk Treatment';
                field("Treatment Strategy"; Rec."Treatment Strategy")
                {
                    ApplicationArea = All;
                }
                field("Risk Appetite"; Rec."Risk Appetite")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Risk Tolerance"; Rec."Risk Tolerance")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(Review)
            {
                Caption = 'Review Information';
                field("Review Period"; Rec."Review Period")
                {
                    ApplicationArea = All;
                }
                field("Last Review Date"; Rec."Last Review Date")
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
            part(RiskMitigationFactBox; "Risk Mitigation FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Risk ID" = field("Risk ID");
            }
            part(RiskIncidentFactBox; "Risk Incident FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Related Risk ID" = field("Risk ID");
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(CreateMitigation)
            {
                Caption = 'Create Mitigation';
                Image = Planning;
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    RiskMitigation: Record "Risk Mitigation";
                    RiskMitigationCard: Page "Risk Mitigation Card";
                begin
                    RiskMitigation.Init();
                    RiskMitigation."Risk ID" := Rec."Risk ID";
                    RiskMitigation.Insert(true);
                    
                    RiskMitigationCard.SetRecord(RiskMitigation);
                    RiskMitigationCard.Run();
                end;
            }
            action(ViewMitigations)
            {
                Caption = 'View Mitigations';
                Image = Planning;
                ApplicationArea = All;
                RunObject = page "Risk Mitigation List";
                RunPageLink = "Risk ID" = field("Risk ID");
            }
            action(ViewIncidents)
            {
                Caption = 'View Incidents';
                Image = ErrorLog;
                ApplicationArea = All;
                RunObject = page "Risk Incident List";
                RunPageLink = "Related Risk ID" = field("Risk ID");
            }
            action(ViewKRIs)
            {
                Caption = 'View KRIs';
                Image = Statistics;
                ApplicationArea = All;
                RunObject = page "Key Risk Indicators List";
                RunPageLink = "Related Risk ID" = field("Risk ID");
            }
            action(ScenarioAnalysis)
            {
                Caption = 'Scenario Analysis';
                Image = Simulate;
                ApplicationArea = All;
                RunObject = page "Risk Scenario Analysis List";
                RunPageLink = "Related Risk ID" = field("Risk ID");
            }
        }
        area(reporting)
        {
            action(PrintRiskCard)
            {
                Caption = 'Print Risk Card';
                Image = Print;
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    RiskRegister: Record "Risk Register";
                begin
                    RiskRegister.SetRange("Risk ID", Rec."Risk ID");
                    Report.RunModal(Report::"Risk Register Report", true, true, RiskRegister);
                end;
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