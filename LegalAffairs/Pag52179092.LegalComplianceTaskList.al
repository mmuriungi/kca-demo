page 52179092 "Legal Compliance Task List"
{
    PageType = List;
    SourceTable = "Legal Compliance Task";
    Caption = 'Legal Compliance Task List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Compliance Task Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Task No."; Rec."Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task number.';
                }
                field("Compliance Type"; Rec."Compliance Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the compliance type.';
                }
                field("Task Description"; Rec."Task Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task description.';
                }
                field("Regulation/Law"; Rec."Regulation/Law")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the regulation or law.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date.';
                    StyleExpr = DueDateStyle;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the task is assigned to.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task status.';
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
                field("Completion Date"; Rec."Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion date.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Penalty Amount"; Rec."Penalty Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the penalty amount for non-compliance.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Task")
            {
                ApplicationArea = All;
                Caption = 'New Task';
                Image = New;
                ToolTip = 'Create a new compliance task.';
                RunPageMode = Create;
                RunObject = page "Legal Compliance Task Card";
            }
            action("Mark Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark Completed';
                Image = Completed;
                ToolTip = 'Mark the selected task as completed.';
                
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Completed then begin
                        Rec.Status := Rec.Status::Completed;
                        Rec."Completion Date" := Today;
                        Rec.Modify(true);
                        CurrPage.Update();
                    end;
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
        StatusStyle := 'Standard';
        PriorityStyle := 'Standard';
        RiskStyle := 'Standard';
        DueDateStyle := 'Standard';
        
        case Rec.Status of
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
            Rec.Status::Overdue, Rec.Status::"Non-Compliant":
                StatusStyle := 'Unfavorable';
            Rec.Status::"In Progress":
                StatusStyle := 'Attention';
        end;
        
        case Rec.Priority of
            Rec.Priority::High, Rec.Priority::Critical:
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
        
        if (Rec."Due Date" <> 0D) and (Rec."Due Date" <= Today) and (Rec.Status <> Rec.Status::Completed) then
            DueDateStyle := 'Unfavorable'
        else if (Rec."Due Date" <> 0D) and (Rec."Due Date" <= Today + 7) then
            DueDateStyle := 'Attention';
    end;
    
    var
        StatusStyle: Text;
        PriorityStyle: Text;
        RiskStyle: Text;
        DueDateStyle: Text;
}