codeunit 50078 Mailsendmgt
{
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee C";
        mail: Text;
        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        EmailSubject: Text[50];
        EmailBody: Text[500];
        EmailRecipient: List of [Text];
        //SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;
        meetingInfo: Record MeetingsInfo;
        meetingattendees: Record MeetingAtendees;
        sendMail: Codeunit "Email Message";
        agenda: Record MeeingAgenda;

    procedure Send(docId: Code[20])
    var
        Recipients: List of [Text];
    begin
        meetingInfo.Reset();
        meetingInfo.SetRange("Meeting Code", docId);
        if meetingInfo.Find('-') then begin
            if meetingInfo."Invite Sent" = false then begin
                meetingattendees.Reset();
                meetingattendees.SetRange("Meeting Code", meetingInfo."Meeting Code");
                if meetingattendees.Find('-') then begin
                    repeat
                        Recipients.Add(meetingattendees.email);
                    until meetingattendees.Next() = 0
                end;
                agenda.Reset();
                agenda.SetRange("Meeting Code", docId);
                IF agenda.Find('-') then begin
                    EmailSubject := 'MEETING ATTENDANCE NOTIFICATION FOR' + ' ' + meetingInfo."Meeting Title";
                    EmailBody := 'Hello <br> You have been selected to attend meeting on' + ' ' + meetingInfo."Meeting Title" + ' ' + 'meeting time will be at' + ' ' + Format(meetingInfo."Meeting Start Time") + 'The Venue will be at' + ' ' + meetingInfo."Meeting Venue" + '.<br>' + agenda."Agenda Item";
                    sendMail.Create(Recipients, EmailSubject, EmailBody, true);
                    emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
                end;
            end else
                Message('Meeting Invite Already Sent!!');



        end;



    end;

    procedure CancelMeeting(docId: Code[20])
    begin
        IF CONFIRM('This will Clear The current venue Booking', TRUE) = FALSE THEN EXIT;
        meetingInfo.Reset();
        meetingInfo.SetRange("Meeting Code", docId);
        if meetingInfo.Find('-') then begin
            meetingInfo."Meeting Venue" := '';
        end;
    end;

    local procedure SendWithAttachemnt()
    var
    begin

        // Clear(EmailBody);
        // Clear(EmailSubject);
        // Clear(EmailRecipient);
        // rec.Reset();
        // rec.SetRange("Application No", rec."Application No");
        // if rec.Find('-') then
        //     mail := Rec."E-Mail";
        // EmailBody := 'Hello, Reference is made to your application for the position of' + ' ' + Rec."Job Applied for Description" + ' ' + 'at our institution.We are glad to inform you that you have been shortlisted for an interview scheduled on' + ' ' + Format(Rec."Interview date") + ' ' + 'on' + ' ' + Rec."Interview Time" + ' ' + 'at' + ' ' + Rec."Interview venue" + '. Please note that this is a system generated E-mail. Please send your Reponse to hr@cuea.edu';
        // EmailSubject := 'INTERVIEW INVITE';
        // TempBlob.CreateOutStream(AttachmentOutStream);

        // Report.SaveAs(85525, Rec."Application No", ReportFormat::Pdf, AttachmentOutStream);

        // TempBlob.CreateInStream(AttachmentInStream);
        // SendMail.Create(mail, EmailSubject, EmailBody);

        // //SendMail.Create(mail, EmailSubject, EmailBody);

        // SendMail.AddAttachment(mail + '.pdf', 'PDF', AttachmentInStream);

        // // emailObj.Send(SendMail);

        // emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);

    end;
}
