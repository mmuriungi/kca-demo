page 52179040 "Audit Notifications List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Notifications";
    Caption = 'Audit Notifications';
    CardPageId = "Audit Notifications Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Notification No."; Rec."Notification No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification number.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit number.';
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification type.';
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification subject.';
                }
                field("Recipient Email"; Rec."Recipient Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the recipient email.';
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the recipient name.';
                }
                field("Notification Date"; Rec."Notification Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification date.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date.';
                }
                field("Delivery Status"; Rec."Delivery Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery status.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Response Required"; Rec."Response Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a response is required.';
                }
                field("Response Received"; Rec."Response Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a response has been received.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Send Notification")
            {
                ApplicationArea = All;
                Caption = 'Send Notification';
                Image = SendMail;
                ToolTip = 'Send the selected notification.';
                
                trigger OnAction()
                begin
                    if Rec."Delivery Status" = Rec."Delivery Status"::Pending then begin
                        Rec."Delivery Status" := Rec."Delivery Status"::Sent;
                        Rec."Sent Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Notification sent to %1', Rec."Recipient Email");
                        CurrPage.Update();
                    end else
                        Message('Notification has already been sent.');
                end;
            }
            action("Mark as Read")
            {
                ApplicationArea = All;
                Caption = 'Mark as Read';
                Image = View;
                ToolTip = 'Mark the notification as read.';
                
                trigger OnAction()
                begin
                    if Rec."Read Date" = 0DT then begin
                        Rec."Read Date" := CurrentDateTime;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
            action("Record Response")
            {
                ApplicationArea = All;
                Caption = 'Record Response';
                Image = Comment;
                ToolTip = 'Record that a response has been received.';
                
                trigger OnAction()
                begin
                    if Rec."Response Required" and not Rec."Response Received" then begin
                        Rec."Response Received" := true;
                        Rec."Response Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Response recorded for notification %1', Rec."Notification No.");
                        CurrPage.Update();
                    end else if not Rec."Response Required" then
                        Message('No response required for this notification.')
                    else
                        Message('Response has already been recorded.');
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
        area(Reporting)
        {
            action("Notification Report")
            {
                ApplicationArea = All;
                Caption = 'Notification Report';
                Image = Report;
                ToolTip = 'Print notification report.';
                
                trigger OnAction()
                begin
                    Message('Notification report will be implemented.');
                end;
            }
        }
    }
}