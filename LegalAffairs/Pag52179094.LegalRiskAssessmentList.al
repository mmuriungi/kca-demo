page 52179094 "Legal Risk Assessment List"
{
    PageType = List;
    SourceTable = "Legal Risk Assessment";
    Caption = 'Legal Risk Assessment List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Risk Assessment Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Assessment No."; Rec."Assessment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the assessment number.';
                }
                field("Risk Type"; Rec."Risk Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk type.';
                }
                field("Risk Description"; Rec."Risk Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk description.';
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level.';
                    StyleExpr = RiskStyle;
                }
                field(Probability; Rec.Probability)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the probability of the risk occurring.';
                }
                field(Impact; Rec.Impact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the impact level of the risk.';
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated risk score.';
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related case number.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related contract number.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field("Assessment Date"; Rec."Assessment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the assessment date.';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review date.';
                    StyleExpr = ReviewDateStyle;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk status.';
                    StyleExpr = StatusStyle;
                }
                field("Financial Impact"; Rec."Financial Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated financial impact.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Assessment")
            {
                ApplicationArea = All;
                Caption = 'New Assessment';
                Image = New;
                ToolTip = 'Create a new risk assessment.';
                RunPageMode = Create;
                RunObject = page "Legal Risk Assessment Card";
            }
            action("Update Status")
            {
                ApplicationArea = All;
                Caption = 'Update Status';
                Image = UpdateUnitCost;
                ToolTip = 'Update the risk status.';
                
                trigger OnAction()
                begin
                    UpdateRiskStatus();
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;
    
    local procedure SetStyles()
    begin
        RiskStyle := 'Standard';
        StatusStyle := 'Standard';
        ReviewDateStyle := 'Standard';
        
        case Rec."Risk Level" of
            Rec."Risk Level"::Critical:
                RiskStyle := 'Unfavorable';
            Rec."Risk Level"::High:
                RiskStyle := 'Unfavorable';
            Rec."Risk Level"::Medium:
                RiskStyle := 'Attention';
            Rec."Risk Level"::Low:
                RiskStyle := 'Favorable';
        end;
        
        case Rec.Status of
            Rec.Status::Mitigated, Rec.Status::Closed:
                StatusStyle := 'Favorable';
            Rec.Status::Active:
                StatusStyle := 'Attention';
        end;
        
        if (Rec."Review Date" <> 0D) and (Rec."Review Date" <= Today + 30) then
            ReviewDateStyle := 'Attention';
        if (Rec."Review Date" <> 0D) and (Rec."Review Date" <= Today) then
            ReviewDateStyle := 'Unfavorable';
    end;
    
    local procedure UpdateRiskStatus()
    begin
        // This would open a dialog to update risk status
        Message('Risk status update functionality would be implemented here.');
    end;
    
    var
        RiskStyle: Text;
        StatusStyle: Text;
        ReviewDateStyle: Text;
}