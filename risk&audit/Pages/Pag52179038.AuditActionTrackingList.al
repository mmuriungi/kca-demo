page 52179038 "Audit Action Tracking List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Action Tracking";
    Caption = 'Audit Action Tracking';
    CardPageId = "Audit Action Tracking Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Action No."; Rec."Action No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action number.';
                }
                field("Finding No."; Rec."Finding No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related finding number.';
                }
                field("Action Description"; Rec."Action Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action description.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field("Responsible Person Name"; Rec."Responsible Person Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person name.';
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target completion date.';
                }
                field("Implementation Status"; Rec."Implementation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the implementation status.';
                }
                field("Completion %"; Rec."Completion %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion percentage.';
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk rating.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Days Overdue"; Rec."Days Overdue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days overdue.';
                    Style = Attention;
                    StyleExpr = Rec."Days Overdue" > 0;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Update Status")
            {
                ApplicationArea = All;
                Caption = 'Update Status';
                Image = Progress;
                ToolTip = 'Update the implementation status.';
                
                trigger OnAction()
                begin
                    Message('Use the card page to update action status and progress.');
                end;
            }
            action("Mark Complete")
            {
                ApplicationArea = All;
                Caption = 'Mark Complete';
                Image = Completed;
                ToolTip = 'Mark the selected action as fully implemented.';
                
                trigger OnAction()
                begin
                    if Rec."Implementation Status" <> Rec."Implementation Status"::"Fully Implemented" then begin
                        Rec."Implementation Status" := Rec."Implementation Status"::"Fully Implemented";
                        Rec."Completion %" := 100;
                        Rec."Completion Date" := Today;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
            action("Send Reminder")
            {
                ApplicationArea = All;
                Caption = 'Send Reminder';
                Image = SendMail;
                ToolTip = 'Send a reminder to the responsible person.';
                
                trigger OnAction()
                begin
                    if Rec."Responsible Email" <> '' then begin
                        Rec."Reminder Count" := Rec."Reminder Count" + 1;
                        Rec."Last Reminder Date" := Today;
                        Rec.Modify();
                        Message('Reminder sent to %1', Rec."Responsible Email");
                        CurrPage.Update();
                    end else
                        Message('No email address found for responsible person.');
                end;
            }
            action("Escalate")
            {
                ApplicationArea = All;
                Caption = 'Escalate';
                Image = Escalate;
                ToolTip = 'Escalate this overdue action.';
                
                trigger OnAction()
                begin
                    if Rec."Days Overdue" > 0 then begin
                        Rec.Escalated := true;
                        Rec."Escalation Date" := Today;
                        Rec.Modify();
                        Message('Action has been escalated.');
                        CurrPage.Update();
                    end else
                        Message('Action is not overdue and cannot be escalated.');
                end;
            }
        }
        area(Navigation)
        {
            action("Related Finding")
            {
                ApplicationArea = All;
                Caption = 'Related Finding';
                Image = Navigate;
                ToolTip = 'Open the related audit finding.';
                
                trigger OnAction()
                var
                    Finding: Record "Audit Finding Enhanced";
                begin
                    if Finding.Get(Rec."Finding No.") then
                        Message('Finding: %1 - %2', Finding."Finding No.", Finding."Finding Title");
                end;
            }
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
        area(Reporting)
        {
            action("Action Status Report")
            {
                ApplicationArea = All;
                Caption = 'Action Status Report';
                Image = Report;
                ToolTip = 'Print action status report.';
                
                trigger OnAction()
                begin
                    Message('Action status report will be implemented.');
                end;
            }
        }
    }
}