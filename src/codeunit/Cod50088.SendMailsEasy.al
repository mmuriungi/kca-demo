#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50088 "Send Mails Easy"
{

    trigger OnRun()
    begin
        //GenerateAdmLetter('B100/0029G/19','AdmLetter'+'B1000029G19');
        //GenerateStudentExamCard('A102/0039G/20','SEM1 20/21','');SendEmailEasy_WithAttachment
        // //  SendEmailEasy('Hallo','Wanjala Tinga','We are Simply Testing the Mailing Functionality Here','If you received this, we Love you',
        // //  'System Generated Mails are not to be replied to','Contact 0704121064 for Assistance','wanjalatom2003@gmail.com','AUTOMATIC MAILS TEST');
        // // SendEmailEasy_WithAttachment('Hallo','Wanjala Tinga','We are Simply Testing the Mailing Functionality Here','If you received this, we Love you',
        // // 'System Generated Mails are not to be replied to','Contact 0704121064 for Assistance','wanjalatom2003@gmail.com','AUTOMATIC MAILS TEST',
        // // 'D:\NavInstallationTools.psm1','D:\NavInstallationTools.psm1');
    end;


    procedure SendEmailEasy(Salutation: Text[100]; UserFullNames: Text[150]; Paragraph1: Text[963]; Paragraph2: Text[963]; Disclaimer1: Text[369]; Disclaimer2: Text[369]; EmailID: Text[639]; MailSubject: Text[639])
    var
        EmailHandler: Codeunit "Simple Email Handler";
        EmailBody: Text;
    begin
        EmailBody := '<html><body>';
        EmailBody += Salutation + ', ' + UserFullNames + ',<br><br>';
        EmailBody += Paragraph1 + '<br><br>';
        EmailBody += Paragraph2 + '<hr>';
        EmailBody += Disclaimer1 + '<br>';
        EmailBody += Disclaimer2;
        EmailBody += '</body></html>';
        
        EmailHandler.SendHTMLEmail(EmailID, MailSubject, EmailBody);
    end;


    procedure SendEmailEasy_WithAttachment(Salutation: Text[100]; UserFullNames: Text[150]; Paragraph1: Text[963]; Paragraph2: Text[963]; Disclaimer1: Text[369]; Disclaimer2: Text[369]; EmailID: Text[639]; MailSubject: Text[639]; Filepaths: Text[250]; AttachmentTitle: Code[250])
    var
        EmailHandler: Codeunit "Simple Email Handler";
        EmailBody: Text;
        filename: Text[250];
    begin
        filename := Filepaths;
        if not Exists(filename) then
            Error('File not found!');

        EmailBody := '<html><body>';
        EmailBody += Salutation + ', ' + UserFullNames + ',<br><br>';
        EmailBody += Paragraph1 + '<br><br>';
        EmailBody += Paragraph2 + '<hr>';
        EmailBody += Disclaimer1 + '<br>';
        EmailBody += Disclaimer2;
        EmailBody += '</body></html>';
        
        EmailHandler.SendEmailWithAttachment(EmailID, MailSubject, EmailBody, true, filename, AttachmentTitle);
    end;
}

