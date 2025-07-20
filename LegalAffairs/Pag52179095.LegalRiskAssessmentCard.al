page 52179095 "Legal Risk Assessment Card"
{
    PageType = Card;
    SourceTable = "Legal Risk Assessment";
    Caption = 'Legal Risk Assessment Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
                    MultiLine = true;
                }
                field("Mitigation Strategy"; Rec."Mitigation Strategy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mitigation strategy.';
                    MultiLine = true;
                }
            }
            
            group("Risk Assessment")
            {
                Caption = 'Risk Assessment';
                
                field(Probability; Rec.Probability)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the probability of the risk occurring.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Impact; Rec.Impact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the impact level of the risk.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated risk score.';
                    Editable = false;
                    StyleExpr = RiskScoreStyle;
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level.';
                    Editable = false;
                    StyleExpr = RiskLevelStyle;
                }
            }
            
            group(Assignment)
            {
                Caption = 'Assignment';
                
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk status.';
                }
            }
            
            group(Timeline)
            {
                Caption = 'Timeline';
                
                field("Assessment Date"; Rec."Assessment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the assessment date.';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review date.';
                }
            }
            
            group("Impact Assessment")
            {
                Caption = 'Impact Assessment';
                
                field("Financial Impact Amount"; Rec."Financial Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated financial impact.';
                }
            }
            
            group(References)
            {
                Caption = 'References';
                
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
                field("Legal Opinion Required"; Rec."Legal Opinion Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a legal opinion is required.';
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Close Risk")
            {
                ApplicationArea = All;
                Caption = 'Close Risk';
                Image = Close;
                ToolTip = 'Close this risk assessment.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
            action("Mark Mitigated")
            {
                ApplicationArea = All;
                Caption = 'Mark Mitigated';
                Image = Completed;
                ToolTip = 'Mark this risk as mitigated.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Mitigated;
                    Rec.Modify(true);
                    CurrPage.Update();
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
        RiskScoreStyle := 'Standard';
        RiskLevelStyle := 'Standard';
        
        case Rec."Risk Level" of
            Rec."Risk Level"::Critical:
                begin
                    RiskScoreStyle := 'Unfavorable';
                    RiskLevelStyle := 'Unfavorable';
                end;
            Rec."Risk Level"::High:
                begin
                    RiskScoreStyle := 'Unfavorable';
                    RiskLevelStyle := 'Unfavorable';
                end;
            Rec."Risk Level"::Medium:
                begin
                    RiskScoreStyle := 'Attention';
                    RiskLevelStyle := 'Attention';
                end;
            Rec."Risk Level"::Low:
                begin
                    RiskScoreStyle := 'Favorable';
                    RiskLevelStyle := 'Favorable';
                end;
        end;
    end;
    
    var
        RiskScoreStyle: Text;
        RiskLevelStyle: Text;
}