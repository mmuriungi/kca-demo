codeunit 50103 "Registration Payment Process"
{
    procedure FnReportRisk(var ObjRiskHeader: record "Risk Header"; MyRecipients: Text[500])
    var
        LblMailBody: Label ' The risk has been Reported. <br><br> Kind Regards, KEPHIS';
        Subject: Text;
        EmailBody: Text[3000];
        NotificationsHandler: Codeunit "Notifications Handler";

    begin
        // Check if auditor email exists
        if ObjRiskHeader."Auditor Email" <> '' then begin
            ObjRiskHeader.Reset();
            ObjRiskHeader.Setrange("No.", ObjRiskHeader."No.");
            if ObjRiskHeader.FindFirst() then begin
                Subject := 'Risk Reporting';
                EmailBody := StrSubstNo('Dear, ' + ' ' + '' + ObjRiskHeader."Auditor Name" + ' ' + '' + '<br><br>'' The risk' + ' ' + '(' + '' + ObjRiskHeader."No." + ')' + ' ' + ', ' + ObjRiskHeader."Risk Description2" + ' ' + ' has been submitted by the risk champion for your review.,  ' + ' ' + LblMailBody);
                
                // Use Notifications Handler to send email
                NotificationsHandler.fnSendemail(
                    ObjRiskHeader."Auditor Name",
                    Subject,
                    EmailBody,
                    ObjRiskHeader."Auditor Email",
                    '',  // CC
                    '',  // BCC
                    false,  // Has Attachment
                    '',  // Attachment Base64
                    '',  // Attachment Name
                    ''   // Attachment Type
                );

                // Update document status
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
        RiskManager: Record "Internal Audit Champions";
        Subject: Text;
        EmailBody: Text[3000];
        RiskHeaderRec: Record "Risk Header"; // Temporary record for filtering
        NotificationsHandler: Codeunit "Notifications Handler";
    begin
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

            // Use Notifications Handler to send email
            NotificationsHandler.fnSendemail(
                RiskManager."Employee Name",
                Subject,
                EmailBody,
                RiskManager."E-Mail",
                '',  // CC
                '',  // BCC
                false,  // Has Attachment
                '',  // Attachment Base64
                '',  // Attachment Name
                ''   // Attachment Type
            );

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
        RiskManager: Record "Internal Audit Champions";
        Subject: Text;
        EmailBody: Text[3000];
        RiskHeaderRec: Record "Risk Header";
        NotificationsHandler: Codeunit "Notifications Handler";
    begin
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

                    // Use Notifications Handler to send email
                    NotificationsHandler.fnSendemail(
                        RiskManager."Employee Name",
                        Subject,
                        EmailBody,
                        RiskManager."E-Mail",
                        '',  // CC
                        '',  // BCC
                        false,  // Has Attachment
                        '',  // Attachment Base64
                        '',  // Attachment Name
                        ''   // Attachment Type
                    );

                    Message('Notification sent to Risk Manager: %1', RiskManager."Employee Name");

                until RiskManager.Next = 0;
            end else
                Error('No Risk Manager found in the Internal Audit Champions table.');

        end;
    end;

    procedure FnReportTreatment(var ObjeTreatment: record Treatment; MyRecipients: Text[500])
    var
        LblMailBody: Label ' Treatment Has been Reported. Kind Regards, KEPHIS';
        Subject: Text;
        EmailBody: Text[3000];
        NotificationsHandler: Codeunit "Notifications Handler";

    begin
        // Check if email exists
        if ObjeTreatment.Email <> '' then begin
            ObjeTreatment.Reset();
            ObjeTreatment.Setrange("Entry No.", ObjeTreatment."Entry No.");
            if ObjeTreatment.FindFirst() then begin
                EmailBody := StrSubstNo('Dear, ' + ' ' + '' + ObjeTreatment."Responsibility Name" + ' ' + ' You have been assigned the task of addressing the risk related to ' + '' + ObjeTreatment."Treatment (risk champion suggestions)" + '' + ' through a treatment, ' + ' ' + '' + ObjeTreatment."Action points (risk owner in point form) To have a treatment action plan on the side" + ' ' + ' ' + ' Your prompt action on this matter is appreciated. The deadline for completing this treatment is,  ' + ' ' + ' ' + Format(ObjeTreatment."Timelines(when I will be carried out)"), LblMailBody);

                Subject := 'Reported Treatment';

                // Use Notifications Handler to send email
                NotificationsHandler.fnSendemail(
                    ObjeTreatment."Responsibility Name",
                    Subject,
                    EmailBody,
                    ObjeTreatment.Email,
                    '',  // CC
                    '',  // BCC
                    false,  // Has Attachment
                    '',  // Attachment Base64
                    '',  // Attachment Name
                    ''   // Attachment Type
                );
                
                Message('Notification Sent');
            end;
        end;
    end;

    procedure FnRejectRisk(var ObjRiskHeader: record "Risk Header"; MyRecipients: Text[500])
    var
        LblMailBody: Label ' Dear %1, Thank you for your cooperation. Kind Regards, KEPHIS ';
        Subject: Text;
        EmailBody: Text[3000];
        NotificationsHandler: Codeunit "Notifications Handler";

    begin
        // Check if employee email exists
        if ObjRiskHeader."Employee Email" <> '' then begin
            ObjRiskHeader.Reset();
            ObjRiskHeader.Setrange("No.", ObjRiskHeader."No.");
            if ObjRiskHeader.FindFirst() then begin
                // Prepare email content
                EmailBody := StrSubstNo('Dear Risk Owner,' + ' ' + '' + 'Your Risk has Been Rejected because of  ' + ' ' + ' ' + ObjRiskHeader."Rejection Reason" + ' ' + ' ' + 'For Risk ' + ' ' + ' ' + ObjRiskHeader."No.", LblMailBody);
                Subject := 'Rejected Risk';
                
                // Use Notifications Handler to send email
                NotificationsHandler.fnSendemail(
                    'Risk Owner',  // Recipient name
                    Subject,
                    EmailBody,
                    ObjRiskHeader."Employee Email",
                    '',  // CC
                    '',  // BCC
                    false,  // Has Attachment
                    '',  // Attachment Base64
                    '',  // Attachment Name
                    ''   // Attachment Type
                );
                
                // Update document status
                if ObjRiskHeader."Document Status" = ObjRiskHeader."Document Status"::"Risk Owner" then
                    ObjRiskHeader."Document Status" := ObjRiskHeader."Document Status"::New;
                ObjRiskHeader.Modify();
                Message('Notification Sent');
            end;
        end;
    end;

}
