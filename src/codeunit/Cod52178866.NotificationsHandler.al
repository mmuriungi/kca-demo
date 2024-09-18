dotnet
{
    assembly(mscorlib)
    {
        type("System.Char"; Char)
        {

        }
    }
}
codeunit 52178866 "Notifications Handler"
{

    trigger OnRun()
    begin

    end;

    procedure fnSendemail(recipientName: Text;
        subject: Text;
        body: text;
        recipientEmail: list of [Text];
        addCC: list of [Text];
        addBcc: list of [text];
        hasAttachment: Boolean;
        AttachmentDict: Dictionary of [Text, Dictionary of [Integer, Text]]
    ) res: Text
    var
        Companyinforec: Record "Company Information";
        CuEmail: Codeunit Email;
        CuEmailMessage: Codeunit "Email Message";
        EmailReceipientType: Enum "Email Recipient Type";
        Response: JsonObject;
        InputTkn: JsonToken;
        EmailAccount: Record "Email Account";
        templobCu: Codeunit "Temp Blob";
        i: Integer;
        attachmentName: Text;
        attachmentType: Text;
        Detail: Text;
        Dict: Dictionary of [Integer, Text];
        attachmentBase64: Text;
        j: Integer;
        Receipient: Text;
    begin
        Companyinforec.GET;
        if recipientEmail.Count > 0 then begin
            foreach Receipient in recipientEmail do begin
                if not fnvalidateemail(Receipient) then begin
                    //remove invalid email address
                    recipientEmail.Remove(Receipient);
                end;
            end;
        end;

        if RecipientEmail.Count > 0 then begin
            CuEmailMessage.Create('', Subject, '');
            CuEmailMessage.SetBodyHTMLFormatted(true);
            CuEmailMessage.SetRecipients(EmailReceipientType::"To", RecipientEmail);
            if AddCC.Count > 0 then
                CuEmailMessage.SetRecipients(EmailReceipientType::CC, AddCC);
            if AddBcc.Count > 0 then
                CuEmailMessage.SetRecipients(EmailReceipientType::BCC, AddBcc);
            if hasAttachment then begin
                //get name and type of attachment
                i := 1;
                foreach dict in AttachmentDict.Values do begin
                    foreach detail in dict.Values do begin
                        AttachmentDict.Keys.Get(i, attachmentName);
                        dict.Get(1, attachmentType);
                        Dict.Get(2, attachmentBase64);
                    end;
                    CuEmailMessage.AddAttachment(AttachmentName + '.' + attachmentType, AttachmentType, AttachmentBase64);
                    i += 1;
                end;

            end;
            CuEmailMessage.AppendToBody('<html> <body> <font face="Maiandra GD,Garamond,Tahoma", size = "3">');
            CuEmailMessage.AppendToBody('Dear ' + 'Sir/Madam' + ',');
            CuEmailMessage.AppendToBody('<br><br>');
            CuEmailMessage.AppendToBody(Body);
            CuEmailMessage.AppendToBody('<br><br>');
            CuEmailMessage.AppendToBody('<HR>');
            CuEmailMessage.AppendToBody('Kind Regards');
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody('<img src="https://telpostapension.org/img/logo-full.jpg" alt="Logo" />');
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody(Companyinforec.Name);
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody(Companyinforec.Address);
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody('Tel: ' + Companyinforec."Phone No.");
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody(Companyinforec."E-Mail");
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody(Companyinforec."Home Page");
            CuEmailMessage.AppendToBody('<br>');
            CuEmailMessage.AppendToBody('<br>');
            if CuEmail.Send(CuEmailMessage) then begin
                Response.Add('sent', true);
                Response.Add('status', '200');
                Response.Add('message', 'Email Sent Successfully');
            end else begin
                Response.Add('sent', false);
                Response.Add('status', '400');
                Response.Add('message', 'Email Not Sent');
                Response.Add('error', GetLastErrorText());
            end;
        end else begin
            Response.Add('sent', false);
            Response.Add('status', '400');
            Response.Add('message', 'Invalid Email Address');
            response.Add('error', 'Invalid Email Address. Please check email format and try again');
        end;
        Response.WriteTo(res);
        exit(res);
    end;

    procedure fnvalidateemail(emailaddress: Text[100]): Boolean

    var
        //RegEx: dotnet Regex;
        //DotNetString: dotnet String;
        //EmailAddrArray: dotnet Array;
        //Convert: dotnet Convert;
        I: Integer;
        init: Codeunit "System Initialization";
        //reg: DotNet Regex;
        faAll: Record "Source Code";
    begin
        // EmailAddress := ConvertStr(EmailAddress, ',', ';');
        // EmailAddress := DelChr(EmailAddress, '<>');
        //EmailAddrArray := RegEx.Split(EmailAddress, ';');
        // for I := 1 to EmailAddrArray.GetLength(0) do begin
        //     EmailAddress := EmailAddrArray.GetValue(I - 1);
        //     if not RegEx.IsMatch
        //           (EmailAddress, '^[\w!#$%&*+\-/=?\^_`{|}~]+(\.[\w!#$%&*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$') then begin
        //         exit(false);
        //     end else
        //         exit(true);
        // end;
        if emailaddress <> '' then
            exit(true)
        else
            exit(false);
    end;

    procedure fngetEmail(usersId: Code[20]): Text;
    begin
        if not Usersetup.Get(usersId) then exit;
        if not fnvalidateemail(Usersetup."E-Mail") then
            exit;
        exit(Usersetup."E-Mail");
    end;

    procedure fnGetReportBase64(reportId: Integer; parameters: text; recRef: RecordRef): Text
    var
        cuTemplob: Codeunit "Temp Blob";
        BcInstream: InStream;
        bcOutStream: OutStream;
        cuBase64: Codeunit "Base64 Convert";
        FileName: Text;
        rpVariant: RecordId;
    begin
        cuTemplob.CreateOutStream(BcOutStream);
        Report.SaveAs(reportId, Parameters, ReportFormat::Pdf, bcOutStream, RecRef);
        cuTemplob.CreateInStream(BcInstream);
        exit(cuBase64.ToBase64(BcInstream));
    end;

    procedure fnGetReportBase64(reportId: Integer; parameters: text; RecId: RecordId): Text
    var
        cuTemplob: Codeunit "Temp Blob";
        BcInstream: InStream;
        bcOutStream: OutStream;
        cuBase64: Codeunit "Base64 Convert";
        FileName: Text;
        recref: RecordRef;
    begin
        cuTemplob.CreateOutStream(BcOutStream);
        recref.Get(RecId);
        Report.SaveAs(reportId, Parameters, ReportFormat::Pdf, bcOutStream, recref);
        cuTemplob.CreateInStream(BcInstream);
        exit(cuBase64.ToBase64(BcInstream));
    end;

    procedure fnGetAttachmentBase64(DocAttach: Record "Document Attachment"): Text
    Var
        Templob: Codeunit "Temp Blob";
        DocInstream: InStream;
        Base64: Codeunit "Base64 Convert";
        DocOutStream: OutStream;
    begin
        Templob.CreateOutStream(DocOutStream);
        if DocAttach."Document Reference ID".HasValue then begin
            DocAttach."Document Reference ID".ExportStream(DocOutStream);
            Templob.CreateInStream(DocInstream);
            exit(Base64.ToBase64(DocInstream));
        end;
    end;

    var
        Approvals: Record "Approval Entry";
        Employees: Record "HRM-Employee C";
        Usersetup: Record "User Setup";
        HRSetup: Record "Human Resources Setup";
        RecipientsName: Text;
        RecipientEmail: Text;
        subject: Text;
        body: Text;

}
