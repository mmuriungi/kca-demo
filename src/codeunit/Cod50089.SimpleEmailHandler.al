codeunit 50114 "Simple Email Handler"
{
    procedure SendEmail(ToRecipients: Text; Subject: Text; Body: Text; IsHTML: Boolean): Boolean
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenario: Enum "Email Scenario";
        Recipients: List of [Text];
        RecipientList: List of [Text];
        Recipient: Text;
    begin
        // Split recipients if multiple are provided (comma or semicolon separated)
        if StrPos(ToRecipients, ';') > 0 then
            RecipientList := ToRecipients.Split(';')
        else if StrPos(ToRecipients, ',') > 0 then
            RecipientList := ToRecipients.Split(',')
        else
            RecipientList.Add(ToRecipients);

        // Validate each recipient
        foreach Recipient in RecipientList do begin
            Recipient := DelChr(Recipient, '<>', ' ');
            if Recipient <> '' then
                Recipients.Add(Recipient);
        end;

        if Recipients.Count = 0 then
            Error('No valid recipients provided');

        // Create email message
        EmailMessage.Create(Recipients, Subject, Body, IsHTML);

        // Send email using default scenario
        exit(Email.Send(EmailMessage, EmailScenario::"Default"));
    end;

    procedure SendEmailWithAttachment(ToRecipients: Text; Subject: Text; Body: Text; IsHTML: Boolean; AttachmentPath: Text; AttachmentName: Text): Boolean
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenario: Enum "Email Scenario";
        Recipients: List of [Text];
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        // Create basic email first
        Recipients.Add(ToRecipients);
        EmailMessage.Create(Recipients, Subject, Body, IsHTML);

        // Add attachment if file exists
        if Exists(AttachmentPath) then begin
            TempBlob.CreateInStream(InStr);
            EmailMessage.AddAttachment(AttachmentName, 'application/octet-stream', InStr);
        end;

        // Send email
        exit(Email.Send(EmailMessage, EmailScenario::"Default"));
    end;

    procedure SendCRMCampaignEmail(CampaignNo: Code[20]; CustomerNo: Code[20]): Boolean
    var
        CRMCampaign: Record "CRM Campaign";
        Customer: Record Customer;
        Contact: Record Contact;
        RecipientEmail: Text;
        EmailBody: Text;
    begin
        if not CRMCampaign.Get(CampaignNo) then
            Error('Campaign %1 not found', CampaignNo);

        if not Customer.Get(CustomerNo) then
            Error('Customer %1 not found', CustomerNo);

        // Get email from customer or contact
        RecipientEmail := Customer."E-Mail";
        if RecipientEmail = '' then
            if Contact.Get(Customer."Primary Contact No.") then
                RecipientEmail := Contact."E-Mail";

        if RecipientEmail = '' then
            Error('No email address found for customer %1', CustomerNo);

        // Build email body
        EmailBody := '<html><body>';
        EmailBody += '<h2>' + CRMCampaign.Description + '</h2>';
        EmailBody += '<p>Dear ' + Customer.Name + ',</p>';
        EmailBody += '<p>We are reaching out to you regarding our campaign: ' + CRMCampaign.Description + '</p>';
        EmailBody += '<p>For more information, please contact us.</p>';
        EmailBody += '<p>Best regards,<br>Appkings Solutions</p>';
        EmailBody += '</body></html>';

        exit(SendEmail(RecipientEmail, CRMCampaign.Description, EmailBody, true));
    end;

    procedure SendLegalNotificationEmail(CaseNo: Code[20]; NotificationType: Text[50]): Boolean
    var
        LegalCase: Record "Legal Case";
        LegalSetup: Record "Legal Affairs Setup";
        EmailBody: Text;
        Subject: Text;
        Recipients: Text;
    begin
        if not LegalCase.Get(CaseNo) then
            Error('Legal case %1 not found', CaseNo);

        LegalSetup.Get();
        Recipients := LegalSetup."Legal Department Email";

        case NotificationType of
            'NEW_CASE':
                begin
                    Subject := StrSubstNo('New Legal Case Created: %1', CaseNo);
                    EmailBody := BuildLegalCaseEmailBody(LegalCase, 'A new legal case has been created');
                end;
            'STATUS_CHANGE':
                begin
                    Subject := StrSubstNo('Legal Case Status Updated: %1', CaseNo);
                    EmailBody := BuildLegalCaseEmailBody(LegalCase, 'The status of this legal case has been updated');
                end;
            'DOCUMENT_ADDED':
                begin
                    Subject := StrSubstNo('New Document Added to Case: %1', CaseNo);
                    EmailBody := BuildLegalCaseEmailBody(LegalCase, 'A new document has been added to this legal case');
                end;
        end;

        exit(SendEmail(Recipients, Subject, EmailBody, true));
    end;

    procedure SendFoundationDonationAcknowledgement(DonorNo: Code[20]; DonationNo: Code[20]): Boolean
    var
        Donor: Record "Foundation Donor";
        EmailBody: Text;
        Subject: Text;
        DonorEmail: Text;
    begin
        if not Donor.Get(DonorNo) then
            Error('Donor %1 not found', DonorNo);

        // Get email from Donor record
        DonorEmail := Donor.Email;

        if DonorEmail = '' then
            Error('No email address found for donor %1', DonorNo);

        Subject := 'Thank You for Your Generous Donation';
        EmailBody := BuildDonationAcknowledgementEmail(DonorNo, DonationNo);

        exit(SendEmail(DonorEmail, Subject, EmailBody, true));
    end;

    local procedure BuildLegalCaseEmailBody(LegalCase: Record "Legal Case"; Introduction: Text): Text
    var
        EmailBody: Text;
    begin
        EmailBody := '<html><body>';
        EmailBody += '<h3>' + Introduction + '</h3>';
        EmailBody += '<p><strong>Case Details:</strong></p>';
        EmailBody += '<ul>';
        EmailBody += '<li><strong>Case No:</strong> ' + LegalCase."Case No." + '</li>';
        EmailBody += '<li><strong>Case Title:</strong> ' + LegalCase."Case Title" + '</li>';
        EmailBody += '<li><strong>Case Type:</strong> ' + Format(LegalCase."Case Type") + '</li>';
        EmailBody += '<li><strong>Status:</strong> ' + Format(LegalCase."Case Status") + '</li>';
        EmailBody += '<li><strong>Priority:</strong> ' + Format(LegalCase.Priority) + '</li>';
        EmailBody += '<li><strong>Created Date:</strong> ' + Format(LegalCase."Date Created") + '</li>';
        EmailBody += '</ul>';
        EmailBody += '<p>Please log into the system for more details.</p>';
        EmailBody += '<hr>';
        EmailBody += '<p><em>This is an automated message. Please do not reply to this email.</em></p>';
        EmailBody += '</body></html>';

        exit(EmailBody);
    end;

    local procedure BuildDonationAcknowledgementEmail(DonorNo: Code[20]; DonationNo: Code[20]): Text
    var
        EmailBody: Text;
        Donor: Record "Foundation Donor";
    begin
        Donor.Get(DonorNo);

        EmailBody := '<html><body>';
        EmailBody += '<h2>Thank You for Your Support!</h2>';
        EmailBody += '<p>Dear ' + Donor.Name + ',</p>';
        EmailBody += '<p>We are deeply grateful for your generous donation to Appkings Solutions Foundation.</p>';
        EmailBody += '<p>Your contribution makes a significant difference in supporting our students and programs.</p>';
        EmailBody += '<p><strong>Donation Reference:</strong> ' + DonationNo + '</p>';
        EmailBody += '<p>A formal receipt will be sent to you separately for your records.</p>';
        EmailBody += '<p>Thank you once again for your continued support.</p>';
        EmailBody += '<p>Warm regards,<br>Appkings Solutions Foundation</p>';
        EmailBody += '<hr>';
        EmailBody += '<p><em>This is an automated acknowledgement. For any queries, please contact our Foundation office.</em></p>';
        EmailBody += '</body></html>';

        exit(EmailBody);
    end;

    procedure SendSimpleEmail(ToEmail: Text; Subject: Text; Body: Text): Boolean
    begin
        exit(SendEmail(ToEmail, Subject, Body, false));
    end;

    procedure SendHTMLEmail(ToEmail: Text; Subject: Text; HTMLBody: Text): Boolean
    begin
        exit(SendEmail(ToEmail, Subject, HTMLBody, true));
    end;
}