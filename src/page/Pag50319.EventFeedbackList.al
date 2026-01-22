// Page: Event Feedback List
page 50319 "Event Feedback List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Event Feedback";
    //Editable = false;

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
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    //Visible = false;
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
            action(SendFeedbackEmail)
            {
                Caption = 'Send Feedback';
                Image = SendEmail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send the selected feedback to the attendee via email.';

                trigger OnAction()
                var
                    RecipientName: Text;
                    Subject: Text;
                    Body: Text;
                    RecipientEmail: Text;
                    AddCC: Text;
                    AddBcc: Text;
                    HasAttachment: Boolean;
                    AttachmentBase64: Text;
                    AttachmentName: Text;
                    AttachmentType: Text;
                    Res: Text;
                    ResponseJson: JsonObject;
                    Sent: Boolean;
                    Status: Text;
                    MessageText: Text;
                    SentToken: JsonToken;
                    StatusToken: JsonToken;
                    MessageTextToken: JsonToken;
                begin
                    RecipientName := Rec."Attendee No.";
                    RecipientEmail := Rec."Email";
                    Subject := 'Feedback on ' + Rec."Event No.";
                    Body := Rec."Comment";
                    AddCC := '';
                    AddBcc := '';
                    HasAttachment := false;
                    AttachmentBase64 := '';
                    AttachmentName := '';
                    AttachmentType := '';


                    Res := Notification.fnSendemail(
                        RecipientName,
                        Subject,
                        Body,
                        RecipientEmail,
                        AddCC,
                        AddBcc,
                        HasAttachment,
                        AttachmentBase64,
                        AttachmentName,
                        AttachmentType);

                    if ResponseJson.ReadFrom(Res) then begin
                        if ResponseJson.Get('sent', SentToken) then
                            Sent := SentToken.AsValue().AsBoolean()
                        else
                            Sent := false;

                        if ResponseJson.Get('status', StatusToken) then
                            Status := StatusToken.AsValue().AsText()
                        else
                            Status := '';

                        if ResponseJson.Get('message', MessageTextToken) then
                            MessageText := MessageTextToken.AsValue().AsText()
                        else
                            MessageText := '';


                        if Sent then
                            Message(MessageText)
                        else
                            Error(MessageText);
                    end else
                        Error('Invalid response from email procedure.');
                end;
            }
        }
    }

    var
        Notification: Codeunit "Notifications Handler";
}
