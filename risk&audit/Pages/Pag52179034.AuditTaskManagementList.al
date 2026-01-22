page 52179034 "Audit Task Management List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Task Management";
    Caption = 'Audit Task Management';
    CardPageId = "Audit Task Management Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Task Type"; Rec."Task Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task type.';
                }
                field("Completion %"; Rec."Completion %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion percentage.';
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
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Assign Task")
            {
                ApplicationArea = All;
                Caption = 'Assign Task';
                Image = Allocate;
                ToolTip = 'Assign the selected task to an auditor.';
                
                trigger OnAction()
                begin
                    Message('Use the card page to assign tasks to auditors.');
                end;
            }
            action("Mark Complete")
            {
                ApplicationArea = All;
                Caption = 'Mark Complete';
                Image = Completed;
                ToolTip = 'Mark the selected task as completed.';
                
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
            action("Update Progress")
            {
                ApplicationArea = All;
                Caption = 'Update Progress';
                Image = Progress;
                ToolTip = 'Update the progress percentage.';
                
                trigger OnAction()
                begin
                    Message('Use the card page to update task progress.');
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
            action("Working Papers")
            {
                ApplicationArea = All;
                Caption = 'Working Papers';
                Image = Documents;
                ToolTip = 'View working papers for this task.';
                
                trigger OnAction()
                var
                    WorkingPaper: Record "Working Paper Management";
                begin
                    WorkingPaper.SetRange("Audit No.", Rec."Audit No.");
                    Page.Run(Page::"Audit Working Paper", WorkingPaper);
                end;
            }
        }
        area(Reporting)
        {
            action("Task Report")
            {
                ApplicationArea = All;
                Caption = 'Task Progress Report';
                Image = Report;
                ToolTip = 'Print task progress report.';
                
                trigger OnAction()
                begin
                    Message('Task progress report will be implemented.');
                end;
            }
        }
    }
}