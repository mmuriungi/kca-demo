page 52179041 "Audit Notifications Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Audit Notifications";
    Caption = 'Audit Notifications Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Auto Generated"; Rec."Auto Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this notification was auto-generated.';
                }
            }
            
            group(MessageContent)
            {
                Caption = 'Content';
                
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the notification subject.';
                }
                field("Message Text"; Rec."Message Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the message text.';
                    MultiLine = true;
                }
            }
            
            group(Recipient)
            {
                Caption = 'Recipient';
                
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
            }
            
            group(Timeline)
            {
                Caption = 'Timeline';
                
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
                field("Sent Date"; Rec."Sent Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the notification was sent.';
                    Editable = false;
                }
                field("Read Date"; Rec."Read Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the notification was read.';
                    Editable = false;
                }
            }
            
            group(Status)
            {
                Caption = 'Status';
                
                field("Delivery Status"; Rec."Delivery Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery status.';
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
                field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the response was received.';
                    Editable = false;
                }
            }
            
            group(RelatedDocument)
            {
                Caption = 'Related Document';
                
                field("Related Document Type"; Rec."Related Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related document type.';
                }
                field("Related Document No."; Rec."Related Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related document number.';
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
                ToolTip = 'Send this notification.';
                
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
        }
    }
}