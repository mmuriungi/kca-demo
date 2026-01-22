page 52179045 "Compliance Monitoring Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Compliance Monitoring";
    Caption = 'Compliance Monitoring Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Monitoring No."; Rec."Monitoring No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the monitoring number.';
                }
                field("Compliance Area"; Rec."Compliance Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the compliance area.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                    MultiLine = true;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
            }
            
            group(Assessment)
            {
                Caption = 'Assessment';
                
                field("Monitoring Date"; Rec."Monitoring Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the monitoring date.';
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next review date.';
                }
                field("Compliance Status"; Rec."Compliance Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the compliance status.';
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level.';
                }
                field("Compliance Score"; Rec."Compliance Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the compliance score.';
                }
                field("Action Required"; Rec."Action Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if action is required.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Complete Review")
            {
                ApplicationArea = All;
                Caption = 'Complete Review';
                Image = Completed;
                ToolTip = 'Mark review as completed.';
                
                trigger OnAction()
                begin
                    Rec."Monitoring Date" := Today;
                    Rec."Next Review Date" := CalcDate('<+3M>', Today);
                    Rec.Modify();
                    Message('Review completed for %1', Rec."Compliance Area");
                    CurrPage.Update();
                end;
            }
        }
    }
}