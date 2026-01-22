page 52179039 "Audit Action Tracking Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Audit Action Tracking";
    Caption = 'Audit Action Tracking Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
                field("Finding Description"; Rec."Finding Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the finding description.';
                    Editable = false;
                }
                field("Action Description"; Rec."Action Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action description.';
                    MultiLine = true;
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
            }
            
            group(Assignment)
            {
                Caption = 'Assignment';
                
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field("Responsible Person Name"; Rec."Responsible Person Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person name.';
                    Editable = false;
                }
                field("Responsible Email"; Rec."Responsible Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person email.';
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
            }
            
            group(Timeline)
            {
                Caption = 'Timeline';
                
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target completion date.';
                }
                field("Original Target Date"; Rec."Original Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the original target date.';
                    Editable = false;
                }
                field("Revised Target Date"; Rec."Revised Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the revised target date.';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion date.';
                }
                field("Days Overdue"; Rec."Days Overdue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days overdue.';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = Rec."Days Overdue" > 0;
                }
            }
            
            group(Progress)
            {
                Caption = 'Progress';
                
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
                field("Management Response"; Rec."Management Response")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the management response.';
                    MultiLine = true;
                }
                field("Auditee Comments"; Rec."Auditee Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the auditee comments.';
                    MultiLine = true;
                }
                field("Evidence of Implementation"; Rec."Evidence of Implementation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies evidence of implementation.';
                    MultiLine = true;
                }
            }
            
            group(FollowUp)
            {
                Caption = 'Follow-up';
                
                field("Follow-up Date"; Rec."Follow-up Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the follow-up date.';
                }
                field("Follow-up Status"; Rec."Follow-up Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the follow-up status.';
                }
                field("Verification Status"; Rec."Verification Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the verification status.';
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who verified the implementation.';
                }
                field("Verification Date"; Rec."Verification Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the verification date.';
                }
            }
            
            group(Escalation)
            {
                Caption = 'Escalation';
                
                field("Escalated"; Rec."Escalated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the action has been escalated.';
                }
                field("Escalation Date"; Rec."Escalation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the escalation date.';
                }
                field("Escalated To"; Rec."Escalated To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the action was escalated to.';
                }
                field("Reminder Count"; Rec."Reminder Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of reminders sent.';
                    Editable = false;
                }
                field("Last Reminder Date"; Rec."Last Reminder Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last reminder date.';
                    Editable = false;
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
                ToolTip = 'Mark this action as fully implemented.';
                
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
            action("Verify Implementation")
            {
                ApplicationArea = All;
                Caption = 'Verify Implementation';
                Image = Approve;
                ToolTip = 'Verify that the action has been implemented.';
                
                trigger OnAction()
                begin
                    if Rec."Implementation Status" = Rec."Implementation Status"::"Fully Implemented" then begin
                        Rec."Verification Status" := Rec."Verification Status"::Verified;
                        Rec."Verified By" := UserId;
                        Rec."Verification Date" := Today;
                        Rec.Modify();
                        Message('Implementation verified successfully.');
                        CurrPage.Update();
                    end else
                        Message('Action must be fully implemented before verification.');
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
        }
    }
}