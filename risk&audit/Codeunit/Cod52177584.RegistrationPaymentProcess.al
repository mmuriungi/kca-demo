codeunit 52177584 "Registration Payment Process"
{
    procedure FnReportRisk(var ObjRiskHeader: record "Risk Header"; MyRecipients: Text[500])
    var

        // CuEmailMessage: Codeunit "Email Message";
        // CuEmail: Codeunit Email;
        LblMailBody: Label ' The risk has been Reported. <br><br> Kind Regards, KEPHIS';
        FilePath: Text[250];
        FileName: Text[250];
        Body: Label 'Risk Has been Reported';
        //TbGeneralSetups: record "General Setups";
        CompanyInfo: record "Company Information";
        EmailAddress: Text[250];
        CompName: Text[250];
        Receipient: Text[250];
        TbUserSetup: record "User Setup";
        Subject: Text;
        SenderName: Text;
        EmailBody: Text[3000];
        // Base64: Codeunit "Base64 Convert";
        MyRecordRef: RecordRef;
        MyInStream: InStream;
        MyOutStream: OutStream;
        // CuTempBlob: codeunit "Temp Blob";
        MyBase64: Text;
        SMTPMail: Codeunit "SMTP Mail";
        KobbyGlobal: Codeunit "Kobby Global Functions";
        SMTP: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        //  SenderName: Text;
        SenderAddress: Text;

    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        SenderAddress := CompanyInfo."E-Mail";
        SenderName := CompanyInfo.Name;
        // Set a filter to get unapproved do

        // ObjRiskHeader.CalcFields(ObjRegistration."E-Mail");
        if ObjRiskHeader."Auditor Email" <> '' then begin

            // CuTempBlob.CreateOutStream(MyOutStream);
            ObjRiskHeader.Reset();
            ObjRiskHeader.Setrange("No.", ObjRiskHeader."No.");
            if ObjRiskHeader.FindFirst() then begin




                Subject := 'Risk Reporting';
                EmailBody := StrSubstNo('Dear, ' + ' ' + '' + ObjRiskHeader."Auditor Name" + ' ' + '' + '<br><br>'' The risk' + ' ' + '(' + '' + ObjRiskHeader."No." + ')' + ' ' + ', ' + ObjRiskHeader."Risk Description2" + ' ' + ' has been submitted by the risk champion for your review.,  ' + ' ' + LblMailBody);
                //  FnSendEmailGlobal.FnSendEmailGlobal(ObjUserSetup."Full Name", 'UnApproved Documents', Message, ObjUserSetup."E-Mail", '');
                SMTP.CreateMessage(SenderName, SenderAddress, ObjRiskHeader."Auditor Email", 'Risk Reporting', '', true);
                SMTP.AppendBody(StrSubstNo(EmailBody, ObjRiskHeader."Auditor Name"));


                SMTP.Send;

                if ObjRiskHeader."Document Status" = ObjRiskHeader."Document Status"::New then
                    ObjRiskHeader."Document Status" := ObjRiskHeader."Document Status"::"Risk Owner";
                ObjRiskHeader.Modify();
                Message('Notification Sent');
            end;
        end;
    end;

    procedure FnSendToRiskManager(RiskHeader: Record "Risk Header")
    var
        LblMailBody: Label 'Risk has been reported. Kind Regards, KEPHIS';
        CompanyInfo: Record "Company Information";
        RiskManager: Record "Internal Audit Champions";
        SenderAddress: Text[250];
        SenderName: Text[250];
        Subject: Text;
        EmailBody: Text[3000];
        SMTP: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        RiskHeaderRec: Record "Risk Header"; // Temporary record for filtering
    begin
        // Get company information
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        SenderAddress := CompanyInfo."E-Mail";
        SenderName := CompanyInfo.Name;

        // Filter to find the specific risk document in the "Risk Header" table
        RiskHeaderRec.Reset();
        RiskHeaderRec.SetRange("No.", RiskHeader."No.");  // Filter by the specific Risk No.

        if not RiskHeaderRec.FindFirst() then
            Error('Risk document not found.');

        // Filter to find the Risk Manager in the "Internal Audit Champions" table
        RiskManager.Reset();
        RiskManager.SetRange(Type, RiskManager.Type::"Risk Manager");

        // Check if there is at least one Risk Manager
        if RiskManager.FindFirst() then begin
            // Create the email subject and body
            Subject := 'Risk Reporting';
            EmailBody := StrSubstNo(
                'Dear %1,' + '<br/><br/>' +
                'Risk No: %2' + '<br/>' +
                'Description: %3' + '<br/>' +
                'The risk has been submitted by the risk champion for your review.' + '<br/><br/>' +
                '%4',
                RiskManager."Employee Name",
                RiskHeaderRec."No.",
                RiskHeaderRec."Risk Description2",
                LblMailBody
            );

            // Create and send the email
            SMTP.CreateMessage(
                SenderName,
                SenderAddress,
                RiskManager."E-Mail",   // Send to Risk Manager's email
                Subject,
                '',
                true  // HTML format
            );
            SMTP.AppendBody(EmailBody);
            SMTP.Send();

            // Update the risk status to indicate it has been sent to the Risk Owner
            if RiskHeaderRec."Document Status" = RiskHeaderRec."Document Status"::"Risk Owner" then
                RiskHeaderRec."Document Status" := RiskHeaderRec."Document Status"::"Risk Manager";

            RiskHeaderRec.Modify();
            Message('Notification sent to Risk Manager: %1', RiskManager."Employee Name");
        end else begin
            // No Risk Manager found
            Error('No Risk Manager found in the Internal Audit Champions table.');
        end;
    end;

    procedure FnSendToRiskManagers(DocNo: Code[20])
    var
        LblMailBody: Label 'Risk has been reported. Kind Regards, KEPHIS';
        CompanyInfo: Record "Company Information";
        RiskManager: Record "Internal Audit Champions";
        SenderAddress: Text[250];
        SenderName: Text[250];
        Subject: Text;
        EmailBody: Text[3000];
        SMTP: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        RiskHeaderRec: Record "Risk Header";
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        SenderAddress := CompanyInfo."E-Mail";
        SenderName := CompanyInfo.Name;

        RiskHeaderRec.Reset();
        RiskHeaderRec.SetRange("No.", DocNo);
        if RiskHeaderRec.FindFirst() then begin
            if RiskHeaderRec."Document Status" = RiskHeaderRec."Document Status"::"Risk Owner" then begin
                RiskHeaderRec."Document Status" := RiskHeaderRec."Document Status"::"Risk Manager";
                RiskHeaderRec.Modify();
            end;
            // Filter to find the Risk Manager in the "Internal Audit Champions" table
            RiskManager.Reset();
            RiskManager.SetRange(Type, RiskManager.Type::"Risk Manager");
            if RiskManager.FindSet() then begin
                repeat
                    Subject := 'Risk Reporting';
                    EmailBody := StrSubstNo(
                        'Dear %1,' + '<br><br>' +
                        'Risk No: %2' + '<br><br>' +
                        'Description: %3' + '<br><br>' +
                        'The risk has been submitted by the risk champion for your review.' + '<br><br>' +
                        '%4',
                        RiskManager."Employee Name",
                        RiskHeaderRec."No.",
                        RiskHeaderRec."Risk Description2",
                        LblMailBody
                    );

                    // Create and send the email
                    SMTP.CreateMessage(
                        SenderName,
                        SenderAddress,
                        RiskManager."E-Mail",   // Send to Risk Manager's email
                        Subject,
                        '',
                        true  // HTML format
                    );
                    SMTP.AppendBody(EmailBody);
                    SMTP.Send();

                    // Update the risk status to indicate it has been sent to the Risk Owner

                    Message('Notification sent to Risk Manager: %1', RiskManager."Employee Name");

                until RiskManager.Next = 0;
            end else
                Error('No Risk Manager found in the Internal Audit Champions table.');

        end;
    end;

    procedure FnReportTreatment(var ObjeTreatment: record Treatment; MyRecipients: Text[500])
    var

        // CuEmailMessage: Codeunit "Email Message";
        // CuEmail: Codeunit Email;
        LblMailBody: Label ' Treatment Has been Reported. Kind Regards, KEPHIS';
        FilePath: Text[250];
        FileName: Text[250];
        Body: Label 'Treatment Has been Reported';
        //TbGeneralSetups: record "General Setups";
        CompanyInfo: record "Company Information";
        EmailAddress: Text[250];
        CompName: Text[250];
        Receipient: Text[250];
        TbUserSetup: record "User Setup";
        Subject: Text;
        SenderName: Text;
        EmailBody: Text[3000];
        // Base64: Codeunit "Base64 Convert";
        MyRecordRef: RecordRef;
        MyInStream: InStream;
        MyOutStream: OutStream;
        // CuTempBlob: codeunit "Temp Blob";
        MyBase64: Text;
        SMTPMail: Codeunit "SMTP Mail";
        KobbyGlobal: Codeunit "Kobby Global Functions";

    begin

        // ObjRiskHeader.CalcFields(ObjRegistration."E-Mail");
        if ObjeTreatment.Email <> '' then begin

            // CuTempBlob.CreateOutStream(MyOutStream);
            ObjeTreatment.Reset();
            ObjeTreatment.Setrange("Entry No.", ObjeTreatment."Entry No.");
            if ObjeTreatment.FindFirst() then begin


                EmailBody := StrSubstNo('Dear, ' + ' ' + '' + ObjeTreatment."Responsibility Name" + ' ' + ' You have been assigned the task of addressing the risk related to ' + '' + ObjeTreatment."Treatment (risk champion suggestions)" + '' + ' through a treatment, ' + ' ' + '' + ObjeTreatment."Action points (risk owner in point form) To have a treatment action plan on the side" + ' ' + ' ' + ' Your prompt action on this matter is appreciated. The deadline for completing this treatment is,  ' + ' ' + ' ' + Format(ObjeTreatment."Timelines(when I will be carried out)"), LblMailBody);

                Subject := 'Reported Treatment';

                KobbyGlobal.FnSendEmailGlobal('', 'TREATMENT', StrSubstNo(EmailBody, ObjeTreatment."Entry No.", ObjeTreatment."Timelines(when I will be carried out)"),
                       ObjeTreatment.Email, '');
                Message('Notification Sent');
                //
            end;
        end;
    end;

    procedure FnRejectRisk(var ObjRiskHeader: record "Risk Header"; MyRecipients: Text[500])
    var

        // CuEmailMessage: Codeunit "Email Message";
        // CuEmail: Codeunit Email;
        LblMailBody: Label ' Dear %1, Thank you for your cooperation. Kind Regards, KEPHIS ';
        FilePath: Text[250];
        FileName: Text[250];
        Body: Label 'Risk Has been Reported';
        // TbGeneralSetups: record "General Setups";
        CompanyInfo: record "Company Information";
        EmailAddress: Text[250];
        CompName: Text[250];
        Receipient: Text[250];
        TbUserSetup: record "User Setup";
        Subject: Text;
        SenderName: Text;
        EmailBody: Text[3000];
        //  Base64: Codeunit "Base64 Convert";
        MyRecordRef: RecordRef;
        MyInStream: InStream;
        MyOutStream: OutStream;
        //CuTempBlob: codeunit "Temp Blob";
        MyBase64: Text;
    // SMTPMail: Codeunit Email;

    begin

        // ObjRiskHeader.CalcFields(ObjRegistration."E-Mail");
        if ObjRiskHeader."Employee Email" <> '' then begin

            //CuTempBlob.CreateOutStream(MyOutStream);
            ObjRiskHeader.Reset();
            ObjRiskHeader.Setrange("No.", ObjRiskHeader."No.");
            if ObjRiskHeader.FindFirst() then begin

                //  CuTempBlob.CreateInStream(MyInStream);
                //Email
                // MyBase64 := Base64.ToBase64(MyInStream);
                EmailBody := StrSubstNo('Dear Risk Owner,' + ' ' + '' + 'Your Risk has Been Rejected because of  ' + ' ' + ' ' + ObjRiskHeader."Rejection Reason" + ' ' + ' ' + 'For Risk ' + ' ' + ' ' + ObjRiskHeader."No.", LblMailBody);
                //Subject := ObjRegistration."Email Subject";
                Subject := 'Rejected Risk';
                //  CuEmailMessage.Create(ObjRiskHeader."Employee Email", Subject, EmailBody);
                //email attachment
                // CuEmailMessage.AddAttachment(FileName, 'PDF', MyBase64);
                // SMTPMail.Send(CuEmailMessage);
                if ObjRiskHeader."Document Status" = ObjRiskHeader."Document Status"::"Risk Owner" then
                    ObjRiskHeader."Document Status" := ObjRiskHeader."Document Status"::New;
                // ObjRiskHeader.Rejected := true;
                ObjRiskHeader.Modify();
                Message('Notification Sent');
            end;
        end;
    end;

}
