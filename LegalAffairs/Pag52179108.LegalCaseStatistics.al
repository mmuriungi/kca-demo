page 52179108 "Legal Case Statistics"
{
    PageType = CardPart;
    SourceTable = "Legal Case";
    Caption = 'Legal Case Statistics';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Case Information';
                
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                    StyleExpr = 'Strong';
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case status.';
                    StyleExpr = StatusStyle;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                    StyleExpr = PriorityStyle;
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level.';
                    StyleExpr = RiskStyle;
                }
            }
            
            group(Dates)
            {
                Caption = 'Key Dates';
                
                field("Filing Date"; Rec."Filing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filing date.';
                }
                field("Next Court Date"; Rec."Next Court Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next court date.';
                    StyleExpr = CourtDateStyle;
                }
                field("Case Closed Date"; Rec."Case Closed Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case closed date.';
                    Visible = Rec."Case Status" = Rec."Case Status"::Closed;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial';
                
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the claim amount.';
                    StyleExpr = 'Strong';
                }
                field("Settlement Amount"; Rec."Settlement Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the settlement amount.';
                    Visible = Rec."Settlement Amount" <> 0;
                }
                field("Estimated Costs"; Rec."Estimated Costs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated costs.';
                }
                field("Actual Costs"; Rec."Actual Costs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual costs.';
                }
            }
            
            group(Progress)
            {
                Caption = 'Progress';
                
                field("Days Since Filing"; DaysSinceFiling)
                {
                    ApplicationArea = All;
                    Caption = 'Days Since Filing';
                    ToolTip = 'Shows the number of days since the case was filed.';
                    Editable = false;
                }
                field("Days to Court Date"; DaysToCourtDate)
                {
                    ApplicationArea = All;
                    Caption = 'Days to Court Date';
                    ToolTip = 'Shows the number of days until the next court date.';
                    Editable = false;
                    Visible = Rec."Next Court Date" <> 0D;
                    StyleExpr = CourtDateCountdownStyle;
                }
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        CalculateStatistics();
        SetStyles();
    end;
    
    local procedure CalculateStatistics()
    begin
        if Rec."Filing Date" <> 0D then
            DaysSinceFiling := Today - Rec."Filing Date"
        else
            DaysSinceFiling := 0;
            
        if Rec."Next Court Date" <> 0D then
            DaysToCourtDate := Rec."Next Court Date" - Today
        else
            DaysToCourtDate := 0;
            
        Rec.CalcFields("Actual Costs");
    end;
    
    local procedure SetStyles()
    begin
        StatusStyle := 'Standard';
        PriorityStyle := 'Standard';
        RiskStyle := 'Standard';
        CourtDateStyle := 'Standard';
        CourtDateCountdownStyle := 'Standard';
        
        case Rec."Case Status" of
            Rec."Case Status"::Closed, Rec."Case Status"::Settled:
                StatusStyle := 'Favorable';
            Rec."Case Status"::"Under Appeal":
                StatusStyle := 'Attention';
        end;
        
        case Rec.Priority of
            Rec.Priority::High, Rec.Priority::Urgent:
                PriorityStyle := 'Unfavorable';
            Rec.Priority::Medium:
                PriorityStyle := 'Attention';
        end;
        
        case Rec."Risk Level" of
            Rec."Risk Level"::High, Rec."Risk Level"::Critical:
                RiskStyle := 'Unfavorable';
            Rec."Risk Level"::Medium:
                RiskStyle := 'Attention';
        end;
        
        if (Rec."Next Court Date" <> 0D) and (Rec."Next Court Date" <= Today + 7) then
            CourtDateStyle := 'Unfavorable';
            
        if DaysToCourtDate <= 3 then
            CourtDateCountdownStyle := 'Unfavorable'
        else if DaysToCourtDate <= 7 then
            CourtDateCountdownStyle := 'Attention';
    end;
    
    var
        StatusStyle: Text;
        PriorityStyle: Text;
        RiskStyle: Text;
        CourtDateStyle: Text;
        CourtDateCountdownStyle: Text;
        DaysSinceFiling: Integer;
        DaysToCourtDate: Integer;
}