page 50254 "Proc-Committee Card"
{
    Caption = 'Committee Card';
    PageType = Card;
    SourceTable = "Proc-Committee Appointment H";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Fieldseditable;
                Caption = 'General';

                field("Ref No"; Rec."Ref No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To field.';
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Method field.';
                }
                field("Tender/Quote No"; Rec."Tender/Quote No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Quote No field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
            group("Description ")
            {
                Editable = Fieldseditable;
                field(Description; Rec.Description)
                {
                    ShowCaption = false;
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part("Committee"; "Proc-Committee Members")
            {
                Editable = Fieldseditable;
                ApplicationArea = all;
                SubPageLink = "Ref No" = field("Ref No");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(sendApproval)
            {
                ApplicationArea = all;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Code";
                    Text000: Label 'Are you sure you want to send for approval?';
                begin
                    // IF ApprovalMgt.IsCommitteeAppointmentEnabled(Rec) = true then
                    //     ApprovalMgt.OnSendCommitteeAppointmentforApproval(Rec) else
                    //     Error('No workflow enabled');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = category4;
                RunObject = page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("Ref No");
            }
            action(cancellsApproval)
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Code";
                    Text001: Label 'Are you sure you want Cancel the approval request?';
                begin

                    // ApprovalMgt.OnCancelCommitteeAppointmentForApproval(Rec);


                end;

            }
            action(Email)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendEmailPDF;
                trigger OnAction()
                begin
                    rec.Reset();
                    rec.SetRange("Ref No", rec."Ref No");
                    if rec.Find('-') then
                        EmailSalesInvoice_gFnc(rec."Ref No")
                end;

            }
            action("Opening Appointment")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = report;
                trigger OnAction()
                begin
                    Appointedmbrs.Reset();
                    Appointedmbrs.SetRange("Ref No", rec."Ref No");
                    if Appointedmbrs.Find('-') then
                        report.Run(report::"Opening Appointment", true, true, Appointedmbrs);
                end;
            }
            action("Evaluation Appointment")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = report;
                trigger OnAction()
                begin
                    Appointedmbrs.Reset();
                    Appointedmbrs.SetRange("Ref No", rec."Ref No");
                    if Appointedmbrs.Find('-') then
                        report.Run(report::"Evaluation Appointment", true, true, Appointedmbrs);

                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        if rec.Status <> rec.Status::Open then Fieldseditable := false else Fieldseditable := true;
    end;

    Procedure InvoiceMail(Custno: Code[20])
    begin
        Commitm.RESET;
        Commitm.SetRange("Ref No", rec."Ref No");
        // Commitm.SETRANGE("Member No", Custno);
        IF Commitm.FindSet() THEN BEGIN
            repeat
                //Recipients.Add(Commitm."EMail");
                EmailID := Commitm.Email;
                Custno := Commitm."Member No";
                Commitmname := Commitm.Name;

                CF_FTLCommitmInvoice.SETTABLEVIEW(Commitm);
                XmlParameters := CF_FTLCommitmInvoice.RUNREQUESTPAGE(Custno);
                Commitm."Description Blob".CREATEOUTSTREAM(OStream, TEXTENCODING::UTF8);
                Commitm."Description Blob".CREATEINSTREAM(IStream, TEXTENCODING::UTF8);
                REPORT.SAVEAS(report::"Opening Appointment", XmlParameters, REPORTFORMAT::Pdf, OStream);

                CLEAR(SMTPMail);
                SMTPMail.Create(EmailID, 'Appointment Letter', Body);
                SMTPMail.AddAttachment(Commitmname, Commitmname + '.pdf', IStream);
                SMTPMail.Run();
                clear(CF_FTLCommitmInvoice);

                Subject := StrSubstNo(TaskMessage1, Commitm.Name);
                Body := StrSubstNo(TaskSubject1, Commitm.Role, Commitm.Committee, rec."Tender/Quote No");
                EmailMessage.Create(EmailID, Subject, Body, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            until Commitm.Next() = 0;
            MESSAGE('Mail sent to %1', Commitmname);
        end;
    END;

    procedure EmailSalesInvoice_gFnc(RefNo: Code[50]): Boolean

    var

        Commitm: Record "Proc-Committee Members";
        CompanyInfo: Record "Company Information";
        EmailInStream: InStream;
        EmailOutStream: OutStream;
        tempBlob: Codeunit "Temp Blob";
        receipent: List of [Text];
        ShipmentNo: Code[20];
        SalesShipmentHeader: Record "Sales Shipment Header";

    begin
        Clear(Commitm);
        Commitm.Reset;
        Commitm.Setrange("Ref No", RefNo);
        if Commitm.Findset then begin
            repeat
                receipent.Add(Commitm."EMail");
                EmailID := Commitm.Email;
                if Commitm.Committee = Commitm.Committee::Evaluation then
                    ReportID := report::"Evaluation Appointment"
                else
                    if Commitm.Committee = Commitm.Committee::Opening then
                        ReportID := report::"Opening Appointment";
            until Commitm.Next() = 0;
            XmlParameters := CF_FTLCommitmInvoice.RUNREQUESTPAGE(Commitm."Member No");
            TempBlob_lCdu.CreateOutStream(Out);
            RecRef.GetTable(Commitm);
            REPORT.SaveAs(ReportID, XmlParameters, REPORTFORMAT::Pdf, Out);
            TempBlob_lCdu.CREATEINSTREAM(Instr);
            MyPath := STRSUBSTNO('%2 %1.pdf', Commitm.Name, 'Appointment Letter');
            //REPORT.SaveAspdf(ReportID, MyPath + '' + Commitm.Name, Commitm);
            SMTPMail.AddAttachment(Commitm.Name, MyPath, Instr);
            SMTPMail.AddRecipient(RecipientType::"To", EmailID);
            Subject := StrSubstNo(TaskMessage1, Commitm.Name);
            Body := StrSubstNo(TaskSubject1, Commitm.Role, Commitm.Committee, rec."Tender/Quote No");
            SMTPMail.Create(EmailID, Subject, Body, true);
            EMail.Send(SMTPMail, Enum::"Email Scenario"::Default);
        end;
        Clear(CompanyInfo);
        CompanyInfo.Get();
    end;



    var
        purchasequote: Record "Proc-Purchase Quote Header";
        TempEmailItem: Record "Email Item";
        TaskMessage1: Label 'Dear %1';
        TaskSubject1: Label 'You have been choosen as %1 in the %2 for tender %3';
        Email: Codeunit Email;
        Subject: Text;
        Commitmname: Text;
        emailscenario: Enum "Email Scenario";
        EmailMessage: Codeunit "Email Message";
        Recipients: List of [Text];
        Body: Text;
        CF_FTLCommitmInvoice: report "Opening Appointment";
        XmlParameters: Text;

        OStream: OutStream;
        IStream: InStream;

        Fieldseditable: Boolean;
        Appointedmbrs: Record "Proc-Committee Members";
        EmailID: Text[250];
        SMTPMail: codeunit "Email Message";
        TempBlob_lCdu: Codeunit "Temp Blob";
        Out: OutStream;
        Instr: InStream;
        RecRef: RecordRef;
        FileManagement_lCdu: Codeunit "File Management";
        ReportSelection_lRec: Record "Report Selections";
        ReportID: Integer;
        Commitm: Record "Proc-Committee Members";
        MyPath: Text;
        ReprotLayoutSelection_lRec: Record "Report Layout Selection";
        CustomReportLayout_lRec: Record "Custom Report Layout";
        RecipientType: Enum "Email Recipient Type";

        Appointhe: Record "Proc-Committee Appointment H";

}
