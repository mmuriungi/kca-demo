page 52179044 "Compliance Monitoring List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Compliance Monitoring";
    Caption = 'Compliance Monitoring';
    CardPageId = "Compliance Monitoring Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
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
            action("Review Compliance")
            {
                ApplicationArea = All;
                Caption = 'Review Compliance';
                Image = Review;
                ToolTip = 'Review compliance status.';
                
                trigger OnAction()
                begin
                    Rec."Monitoring Date" := Today;
                    Rec.Modify();
                    Message('Compliance review updated for %1', Rec."Compliance Area");
                    CurrPage.Update();
                end;
            }
            action("Schedule Review")
            {
                ApplicationArea = All;
                Caption = 'Schedule Next Review';
                Image = Calendar;
                ToolTip = 'Schedule the next compliance review.';
                
                trigger OnAction()
                begin
                    Rec."Next Review Date" := CalcDate('<+3M>', Today);
                    Rec.Modify();
                    Message('Next review scheduled for %1', Rec."Next Review Date");
                    CurrPage.Update();
                end;
            }
        }
    }
}