// Page: Event Feedback List
page 50319 "Event Feedback List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Event Feedback";
   // Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Event No."; Rec."Event No.")
                {
                    ApplicationArea = All;
                }
                field("Attendee No."; Rec."Attendee No.")
                {
                    ApplicationArea = All;
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Feedback Date"; Rec."Feedback Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
           action("Send Feedback")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendMail;

                trigger OnAction()
                var
                    recipientName: Text;
                    subject: Text;
                    body: Text;
                    recipientEmail: Text;
                    addCC: Text;
                    addBcc: Text;
                    hasAttachment: Boolean;
                    attachmentBase64: Text;
                    attachmentName: Text;
                    attachmentType: Text;
                    response: Text;
                    Attendee: Record "Event Attendee";
                    Companyinforec: Record "Company Information";
                    Notification: Codeunit "Notifications Handler";
                begin
                    if Attendee.Get(Rec."Attendee No.") then begin
                        recipientName := Attendee."Attendee No.";
                        recipientEmail := Attendee."Email";
                        
                        if recipientEmail = '' then
                            Error('Recipient email not provided for Attendee: %1', recipientName);

                        subject := 'Feedback for event ' + Rec."Event No.";
                        body := 
                            '<html><body>' +
                            '<font face="Maiandra GD,Garamond,Tahoma" size="3">' +
                            'Dear ' + recipientName + ',<br><br>' +
                            'Thank you for attending the event. We truly appreciate your time and effort in participating. Here is your feedback from the Event.<br><br>' +
                            '<hr>' +
                            '</font></body></html>';

                        addCC := '';
                        addBcc := '';
                        hasAttachment := false;
                        attachmentBase64 := '';
                        attachmentName := '';
                        attachmentType := '';

                        response := Notification.fnSendemail(
                            recipientName, subject, body, recipientEmail, addCC, addBcc,
                            hasAttachment, attachmentBase64, attachmentName, attachmentType);

                        if response <> '' then
                            Message(response);
                    end else
                        Error('Attendee record not found for No: %1', Rec."Attendee No.");
                end;
            }

        }
    }
}
