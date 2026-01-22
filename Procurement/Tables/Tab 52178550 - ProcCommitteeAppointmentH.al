table 52178550 "Proc-Committee Appointment H"
{
    LookupPageId = "Proc-Committee List";
    DrillDownPageId = "Proc-Committee List";
    Caption = 'Proc-Committee Appointment H';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ref No"; Code[20])
        {
            Caption = 'Ref No';
            Editable = false;
        }
        field(2; "Date"; DateTime)
        {
            Editable = false;
            Caption = 'Date';
        }
        field(3; "Tender/Quote No"; Code[50])
        {
            Caption = 'Tender/RFQ No';
            TableRelation = "PROC-Purchase Quote Header"."No." where("Procurement methods" = field("Procurement Method"), Status = filter(Released));
            trigger OnValidate()
            begin
                if "Procurement Method" = "Procurement Method"::" " then Error('First choose the procurement method!');
            end;
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(5; "Created By"; Code[50])
        {
            Editable = false;
            Caption = 'Created By';
        }
        field(6; Status; Option)
        {
            Editable = false;
            Caption = 'Status';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    //Date := CurrentDateTime;
                    Modify();
                end;

            end;
        }
        field(7; "Responsibility Centre"; Code[50])
        {
            Caption = 'Responsibility Centre';
            TableRelation = "Responsibility Center".Code;
        }
        field(8; "Procurement Method"; Enum "Proc-Procurement Methods")
        {

        }
        field(9; "To"; Text[250])
        {
            TableRelation = "HRM-Jobs"."Job ID";
            trigger OnValidate()
            begin
                Hrmjobs.Reset();
                Hrmjobs.SetRange("Job ID", "To");
                if Hrmjobs.Find('-') then
                    "To" := Hrmjobs."Job Title";
            end;

        }


    }
    keys
    {
        key(PK; "Ref No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Ref No", Description)
        {
        }
    }
    trigger OnInsert()
    begin

        if "Ref No" = '' then
            Purchasespaybles.reset();
        Purchasespaybles.SetRange("Doc Type", Purchasespaybles."Doc Type"::"Appointment Doc");
        if Purchasespaybles.Find('-') then begin
            Newrefcode := Noseriesmgt.GetNextNo(Purchasespaybles."Number Series", Today, true);
            "Ref No" := Purchasespaybles."Institution Code" + '/' + Purchasespaybles.FY + '/' + Purchasespaybles.Prefix + '-' + Newrefcode;
            "Created By" := UserId;
            Date := CurrentDateTime;
        end;

    end;

    Procedure UpdateCommitteeMembership()
    begin

        rec.Reset();
        rec.SetRange("Ref No", rec."Ref No");
        if rec.Find('-') then begin
            Appointendmembers.Reset();
            Appointendmembers.SetRange("Ref No", rec."Ref No");
            if Appointendmembers.Find('-') then
                repeat
                    Commiteemembership.Reset();
                    Commiteemembership.SetRange("No.", rec."Tender/Quote No");
                    Commiteemembership.SetRange("Staff No.", Appointendmembers."Member No");
                    Commiteemembership.SetRange("Committee Type", Appointendmembers.Committee);
                    Commiteemembership.SetFilter("Entry No.", '<>%1', 0);
                    if not Commiteemembership.Find('-') then begin
                        Commiteemembership.Init();
                        Commiteemembership."Entry No." := Commiteemembership."Entry No." + 1;
                        Commiteemembership."Staff No." := Appointendmembers."Member No";
                        Commiteemembership.Name := Appointendmembers.Name;
                        Commiteemembership."Member Type" := Appointendmembers."Member Type";
                        Commiteemembership.Email := Appointendmembers.Email;
                        Commiteemembership."Telephone No." := Appointendmembers."Phone No";
                        Commiteemembership."No." := rec."Tender/Quote No";
                        Commiteemembership."Committee Type" := Appointendmembers.Committee;
                        Commiteemembership.Role := Appointendmembers.Role;
                        Commiteemembership.Insert();
                    end else begin
                        Commiteemembership."Staff No." := Appointendmembers."Member No";
                        Commiteemembership.Name := Appointendmembers.Name;
                        Commiteemembership."Member Type" := Appointendmembers."Member Type";
                        Commiteemembership.Email := Appointendmembers.Email;
                        Commiteemembership."Telephone No." := Appointendmembers."Phone No";
                        Commiteemembership."No." := rec."Tender/Quote No";
                        Commiteemembership."Committee Type" := Appointendmembers.Committee;
                        Commiteemembership.Role := Appointendmembers.Role;
                        Commiteemembership.Modify();
                    end;
                until Appointendmembers.Next() = 0;

        end;
    end;

    procedure SendLettersAttachemnt()
    var
        Committee: Record "Proc-Committee Membership";
        Evaluation: report "Evaluation Appointment";
        Appointedmbrs: Record "Proc-Committee Members";
        EmailRecipient: List of [text];
        EmailBody: Text;
        EmailSubject: Text;
        salutation: Text[50];
        SendMail: Codeunit "Email Message";
        FileMgt: Codeunit "File Management";
        emailObj: codeunit Email;
        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";

        mail: Text;
        RecordRef: RecordRef;
    begin

        Appointhe.Reset();
        Appointhe.SetRange("Ref No", rec."Ref No");
        if Appointhe.Find('-') then begin
            //if Appointhe.Status <> Appointhe.Status::Approved then Error('The committee has not been approved!');
            Committee.Reset();
            Committee.SetRange("No.", Appointhe."Tender/Quote No");
            Committee.Setfilter("Staff No.", '<>%1', '');
            If Committee.Find('-') then begin
                Clear(AttachmentOutStream);
                Clear(AttachmentInStream);
                Clear(SendMail);
                Clear(emailObj);
                repeat
                    if Committee."Committee Type" = Committee."Committee Type"::"Evaluation Committee" then begin
                        Appointedmbrs.Reset();
                        Appointedmbrs.SetRange("Ref No", rec."Ref No");
                        Appointedmbrs.SetRange("Member No", Committee."Staff No.");
                        Appointedmbrs.SetRange(Committee, Appointedmbrs.Committee::Evaluation);
                        if Appointedmbrs.Find('-') then begin
                            EmailBody := 'Hello' + ' ' + Appointedmbrs.Name + ' ' + ',<br></br> This is to inform you that you have been selected as an evaluation committee member in the tender' + ' ' + rec."Tender/Quote No" + ' ' + '. Attached is your letter.<br><br/> Please note that this is a system generated E-mail.';
                            EmailSubject := 'Appointment Letter';
                            TempBlob.CreateOutStream(AttachmentOutStream);
                            RecordRef.GetTable(Appointedmbrs);
                            report.SaveAs(report::"Evaluation Appointment", Committee."Staff No.", ReportFormat::Pdf, AttachmentOutStream, RecordRef);
                            TempBlob.CreateInStream(AttachmentInStream);
                            SendMail.Create(Appointedmbrs.Email, EmailSubject, EmailBody, true);
                            SendMail.AddAttachment(Appointedmbrs.Name + '.pdf', 'PDF', AttachmentInStream);
                            emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
                        end;
                    end else
                        if Committee."Committee Type" = Committee."Committee Type"::"Opening Commitee" then begin
                            Appointedmbrs.Reset();
                            Appointedmbrs.SetRange("Ref No", rec."Ref No");
                            Appointedmbrs.SetRange("Member No", Committee."Staff No.");
                            Appointedmbrs.SetRange(Committee, Appointedmbrs.Committee::Opening);
                            if Appointedmbrs.Find('-') then begin
                                EmailBody := 'Hello' + ' ' + Appointedmbrs.Name + ' ' + ',<br></br> This is to inform you that you have been selected as an opening committee member in the tender' + ' ' + rec."Tender/Quote No" + ' ' + '. Attached is your letter.<br><br/> Please note that this is a system generated E-mail.';
                                EmailSubject := 'Appointment Letter';
                                TempBlob.CreateOutStream(AttachmentOutStream);
                                RecordRef.GetTable(Appointedmbrs);
                                Report.SaveAs(report::"Opening Appointment", Committee."Staff No.", ReportFormat::Pdf, AttachmentOutStream, RecordRef);
                                TempBlob.CreateInStream(AttachmentInStream);
                                SendMail.Create(Appointedmbrs.Email, EmailSubject, EmailBody, true);
                                SendMail.AddAttachment(Appointedmbrs.Name + '.pdf', 'PDF', AttachmentInStream);
                                emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
                            end;
                        end;
                until Committee.Next() = 0;
                Message('Sent Successfully');
            end;

        end;
    end;



    var
        Approvalentry: Record "Approval Entry";
        Appointendmembers: Record "Proc-Committee Members";
        Commiteemembership: Record "Proc-Committee Membership";
        Newrefcode: Code[20];
        Purchasespaybles: Record "Proc Number Setups";
        Noseriesmgt: Codeunit NoSeriesManagement;
        Hrmjobs: Record "HRM-Jobs";
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
        CommitteeMbr: Record "Proc-Committee Membership";
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
