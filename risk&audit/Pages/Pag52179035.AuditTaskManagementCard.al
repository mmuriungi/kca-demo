page 52179035 "Audit Task Management Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Audit Task Management";
    Caption = 'Audit Task Management Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Task No."; Rec."Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task number.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit number.';
                }
                field("Task Description"; Rec."Task Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task description.';
                }
                field("Task Type"; Rec."Task Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task type.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
            }
            
            group(Assignment)
            {
                Caption = 'Assignment';
                
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the task is assigned to.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date.';
                }
                field("Estimated Hours"; Rec."Estimated Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated hours.';
                }
                field("Actual Hours"; Rec."Actual Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual hours.';
                }
            }
            
            group(Progress)
            {
                Caption = 'Progress';
                
                field("Completion %"; Rec."Completion %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion percentage.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Mark Complete")
            {
                ApplicationArea = All;
                Caption = 'Mark Complete';
                Image = Completed;
                ToolTip = 'Mark this task as completed.';
                
                trigger OnAction()
                begin
                    if Rec.Status <> 3 then begin // Completed
                        Rec.Status := 3;
                        Rec."Completion %" := 100;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
            action("Start Task")
            {
                ApplicationArea = All;
                Caption = 'Start Task';
                Image = Start;
                ToolTip = 'Start working on this task.';
                
                trigger OnAction()
                begin
                    if Rec.Status = 0 then begin // Not Started
                        Rec.Status := 1; // In Progress
                        Rec."Start Date" := Today;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
        }
        area(Navigation)
        {
            action("Related Audit")
            {
                ApplicationArea = All;
                Caption = 'Related Audit';
                Image = Navigate;
                ToolTip = 'Open the related audit record.';
                
                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    if AuditHeader.Get(Rec."Audit No.") then
                        Page.Run(Page::"Audit Card", AuditHeader);
                end;
            }
        }
    }
}