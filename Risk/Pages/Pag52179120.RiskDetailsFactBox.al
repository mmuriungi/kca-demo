page 52161 "Risk Details FactBox"
{
    Caption = 'Risk Details';
    PageType = CardPart;
    SourceTable = "Risk Register";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("Risk ID"; Rec."Risk ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the risk.';
                }
                field("Risk Title"; Rec."Risk Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the risk.';
                }
                field("Risk Category"; Rec."Risk Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category of the risk.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code associated with the risk.';
                }
                field("Risk Owner"; Rec."Risk Owner")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the person responsible for managing the risk.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the risk.';
                }
            }
            
            group(RiskAssessment)
            {
                Caption = 'Risk Assessment';
                
                field("Inherent Likelihood"; Rec."Inherent Likelihood")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the inherent likelihood of the risk occurring.';
                }
                field("Inherent Impact"; Rec."Inherent Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the inherent impact level of the risk.';
                }
                field("Inherent Risk Level"; Rec."Inherent Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated inherent risk level.';
                    StyleExpr = InherentRiskStyleExpr;
                }
                field("Residual Likelihood"; Rec."Residual Likelihood")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the residual likelihood after controls.';
                }
                field("Residual Impact"; Rec."Residual Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the residual impact after controls.';
                }
                field("Residual Risk Level"; Rec."Residual Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated residual risk level.';
                    StyleExpr = ResidualRiskStyleExpr;
                }
            }
            
            group(Treatment)
            {
                Caption = 'Risk Treatment';
                
                field("Treatment Strategy"; Rec."Treatment Strategy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the strategy for treating the risk.';
                }
            }
            
            group(ReviewInfo)
            {
                Caption = 'Review Information';
                
                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the risk was last reviewed.';
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the risk should be reviewed next.';
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(ViewRiskDetails)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                Image = View;
                ToolTip = 'View detailed information about the risk.';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"Risk Register Card", Rec);
                end;
            }
            action(ViewMitigations)
            {
                ApplicationArea = All;
                Caption = 'View Mitigations';
                Image = TaskList;
                ToolTip = 'View mitigation actions for this risk.';
                
                trigger OnAction()
                var
                    RiskMitigation: Record "Risk Mitigation";
                begin
                    RiskMitigation.SetRange("Risk ID", Rec."Risk ID");
                    Page.Run(Page::"Risk Mitigation List", RiskMitigation);
                end;
            }
        }
    }
    
    var
        InherentRiskStyleExpr: Text;
        ResidualRiskStyleExpr: Text;
    
    trigger OnAfterGetRecord()
    begin
        SetRiskLevelStyles();
    end;
    
    local procedure SetRiskLevelStyles()
    begin
        // Set style for Inherent Risk Level
        case Rec."Inherent Risk Level" of
            Rec."Inherent Risk Level"::Very_Low:
                InherentRiskStyleExpr := 'Favorable';
            Rec."Inherent Risk Level"::Low:
                InherentRiskStyleExpr := 'Favorable';
            Rec."Inherent Risk Level"::Medium:
                InherentRiskStyleExpr := 'Ambiguous';
            Rec."Inherent Risk Level"::High:
                InherentRiskStyleExpr := 'Unfavorable';
            Rec."Inherent Risk Level"::Very_High:
                InherentRiskStyleExpr := 'Attention';
            else
                InherentRiskStyleExpr := '';
        end;
        
        // Set style for Residual Risk Level
        case Rec."Residual Risk Level" of
            Rec."Residual Risk Level"::Very_Low:
                ResidualRiskStyleExpr := 'Favorable';
            Rec."Residual Risk Level"::Low:
                ResidualRiskStyleExpr := 'Favorable';
            Rec."Residual Risk Level"::Medium:
                ResidualRiskStyleExpr := 'Ambiguous';
            Rec."Residual Risk Level"::High:
                ResidualRiskStyleExpr := 'Unfavorable';
            Rec."Residual Risk Level"::Very_High:
                ResidualRiskStyleExpr := 'Attention';
            else
                ResidualRiskStyleExpr := '';
        end;
    end;
}
