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
    var
        TxtList: List of [TExt];

    trigger OnRun()
    begin
        SendImprestDueDateReminder();
    end;

    procedure SendImprestDueDateReminder()
    var
        Imprest: Record "FIN-Imprest Header";
        Msg: Text;
        employeeDetails: List of [Text];
    begin
        Imprest.Reset();
        Imprest.SetRange("Expected Date of Surrender", CalcDate('1D', Today));
        Imprest.SetRange("Surrender Notification Sent", false);
        if Imprest.FindSet() then begin
            repeat
                Clear(TxtList);
                TxtList := GetNotificationDetails(Enum::"Notification Type"::"Imprest Due");
                employeeDetails := getEmployeeDetails(Imprest."Staff No");
                if employeeDetails.Get(2) <> '' then begin
                    fnSendemail(employeeDetails.Get(1), TxtList.Get(1), TxtList.Get(2), employeeDetails.Get(2), '', '', false, '', '', '');
                end;
                Imprest."Surrender Notification Sent" := true;
                Imprest.Modify();
            until Imprest.Next() = 0;
        end;
    end;

    procedure getEmployeeEmail(empNo: code[25]): Text
    var
        Employee: Record "HRM-Employee C";
    begin
        Employee.Reset();
        Employee.SetRange("No.", empNo);
        if Employee.FindFirst() then begin
            exit(Employee."E-Mail");
        end;
    end;

    procedure getEmployeeDetails(empNo: code[25]) ret_value: List of [text];
    var
        Employee: Record "HRM-Employee C";
    begin
        Employee.Reset();
        Employee.SetRange("No.", empNo);
        if Employee.FindFirst() then begin
            ret_value.Add(Employee."First Name");
            ret_value.Add(Employee."E-Mail");
            exit(ret_value);
        end;
    end;

    procedure GetNotificationMessage(NotifType: enum "Notification Type"): Text
    var
        NotificationSetup: Record "Automated Notification Setup";
    begin
        NotificationSetup.Reset();
        NotificationSetup.SetRange("Notification Type", NotifType);
        if NotificationSetup.FindFirst() then
            exit(NotificationSetup."Notification Message");
    end;

    procedure GetNotificationDetails(NotifType: enum "Notification Type") ret_evalu: List of [Text]
    var
        NotificationSetup: Record "Automated Notification Setup";
    begin
        NotificationSetup.Reset();
        NotificationSetup.SetRange("Notification Type", NotifType);
        if NotificationSetup.FindFirst() then
            ret_evalu.Add(NotificationSetup.Subject);
        ret_evalu.Add(NotificationSetup."Notification Message");
    end;

    procedure fnSendemail(recipientName: Text;
        subject: Text;
        body: text;
        recipientEmail: Text;
        addCC: Text;
        addBcc: text;
        hasAttachment: Boolean;
        attachmentBase64: Text;
        attachmentName: Text;
        attachmentType: Text
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
        Detail: Text;
        Dict: Dictionary of [Integer, Text];
        j: Integer;
        Receipient: Text;
    begin
        Companyinforec.GET;
        if RecipientEmail <> '' then begin
            CuEmailMessage.Create('', Subject, '');
            CuEmailMessage.SetBodyHTMLFormatted(true);
            CuEmailMessage.SetRecipients(EmailReceipientType::"To", RecipientEmail);
            if AddCC <> '' then
                CuEmailMessage.SetRecipients(EmailReceipientType::CC, AddCC);
            if AddBcc <> '' then
                CuEmailMessage.SetRecipients(EmailReceipientType::BCC, AddBcc);
            if hasAttachment then begin
                CuEmailMessage.AddAttachment(AttachmentName + '.' + attachmentType, AttachmentType, AttachmentBase64);
            end;
            CuEmailMessage.AppendToBody('<html> <body> <font face="Maiandra GD,Garamond,Tahoma", size = "3">');
            CuEmailMessage.AppendToBody('Dear ' + 'Sir/Madam' + ',');
            CuEmailMessage.AppendToBody('<br><br>');
            CuEmailMessage.AppendToBody(Body);
            CuEmailMessage.AppendToBody('<br><br>');
            CuEmailMessage.AppendToBody('<HR>');
            CuEmailMessage.AppendToBody('Kind Regards');
            CuEmailMessage.AppendToBody('<br>');
            //CuEmailMessage.AppendToBody('<img src="https://telpostapension.org/img/logo-full.jpg" alt="Logo" />');
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

    procedure fnSendemail(recipientName: list of [Text];
    subject: Text;
    body: text;
    recipientEmail: list of [Text];
    addCC: Text;
    addBcc: text;
    hasAttachment: Boolean;
    attachmentBase64: Text;
    attachmentName: Text;
    attachmentType: Text
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
        Detail: Text;
        Dict: Dictionary of [Integer, Text];
        j: Integer;
        Receipient: Text;
    begin
        Companyinforec.GET;
        if RecipientEmail.Count <> 0 then begin
            CuEmailMessage.Create('', Subject, '');
            CuEmailMessage.SetBodyHTMLFormatted(true);
            CuEmailMessage.SetRecipients(EmailReceipientType::"To", RecipientEmail);
            if AddCC <> '' then
                CuEmailMessage.SetRecipients(EmailReceipientType::CC, AddCC);
            if AddBcc <> '' then
                CuEmailMessage.SetRecipients(EmailReceipientType::BCC, AddBcc);
            if hasAttachment then begin
                CuEmailMessage.AddAttachment(AttachmentName + '.' + attachmentType, AttachmentType, AttachmentBase64);
            end;
            CuEmailMessage.AppendToBody('<html> <body> <font face="Maiandra GD,Garamond,Tahoma", size = "3">');
            CuEmailMessage.AppendToBody('Dear ' + 'Sir/Madam' + ',');
            CuEmailMessage.AppendToBody('<br><br>');
            CuEmailMessage.AppendToBody(Body);
            CuEmailMessage.AppendToBody('<br><br>');
            CuEmailMessage.AppendToBody('<HR>');
            CuEmailMessage.AppendToBody('Kind Regards');
            CuEmailMessage.AppendToBody('<br>');
            //CuEmailMessage.AppendToBody('<img src="https://telpostapension.org/img/logo-full.jpg" alt="Logo" />');
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
            //CuEmailMessage.AppendToBody('<img src="https://telpostapension.org/img/logo-full.jpg" alt="Logo" />');
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

    procedure fnGetEmployeeName(UserID: Code[50])
    var
        Emp: Record "HRM-Employee C";
    begin
        Emp.Reset();
        Emp.SetRange("User ID");
    end;

    procedure FnSendEndofContractNotification()
    var
        EmailBody: Label 'This is to notify you that the contract %1 with %2 is set to expire in three months on %3';
        ObjContractsHeader: record "Project Header";
        PurchSetup: Record "Purchases & Payables Setup";
        RecipientsEmail: Text;
    begin
        ObjContractsHeader.Reset();
        ObjContractsHeader.SetRange("No.", ObjContractsHeader."No.");
        if ObjContractsHeader.FindSet() then begin
            repeat
                if (CalcDate(PurchSetup."Contract End Days", Today) = ObjContractsHeader."Estimated End Date") then begin

                    UserSetup.Reset();
                    UserSetup.SetRange(UserSetup."User ID", ObjContractsHeader."User ID");
                    if UserSetup.FindFirst() then begin
                        RecipientsEmail := UserSetup."E-Mail";
                        fnSendemail(UserSetup."User ID", 'Three Months Prior Contract Expiry Notice', StrSubstNo(EmailBody, ObjContractsHeader."No.", ObjContractsHeader."Name", ObjContractsHeader."Estimated End Date"), RecipientsEmail, '', '', false, '', '', '');
                    end;
                end;
            until ObjContractsHeader.Next() = 0;
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




codeunit 52178867 "Assessment"
{
    procedure PopulatePostGraduate(Stud: Record "ACA-Course Registration")
    var
        //Stud: Record "ACA-Course Registration";
        Graduate: Record "Postgrad Supervisor Applic.";
        Cust: Record Customer;
    begin
        Graduate.Delete();

        Stud.SetRange("Academic Year", Stud."Academic Year");
        Stud.SetRange(Stage, Stud.Stage);
        Stud.SetRange(Programmes, Stud.Programmes);
        Stud.SetRange(Semester, Stud.Semester);
        Stud.SetRange(Status, Stud.Status::Current);

        if Stud.FindSet() then begin
            if not Graduate.Get(Stud."Student No.") then begin
                Graduate.Init();
                Graduate."Student No." := Stud."Student No.";

                Graduate.Insert();
            end;
        end;
    end;

}