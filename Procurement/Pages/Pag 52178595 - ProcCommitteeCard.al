page 52178595 "Proc-Committee Card"
{
    Caption = 'Committee Card';
    PageType = Card;
    SourceTable = "Proc-Committee Appointment H";
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
            action("Update Committee")
            {
                ApplicationArea=all;
                trigger OnAction()
                begin
                    rec.UpdateCommitteeMembership();
                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::open;

                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnSendDocForApproval(variant);
                end;
            }
            //cancelapproval
            action(CancelApproval)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval';
                Image = CancelApproval;
                Visible = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnCancelDocApprovalRequest(variant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                RunObject = page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("Ref No");
            }
            action(Email)
            {
                ApplicationArea = all;
                Image = SendEmailPDF;
                Visible = ACtionVisi;
                trigger OnAction()
                begin

                    rec.SendLettersAttachemnt();
                end;
            }
            action("Opening Appointment")
            {
                ApplicationArea = all;
                Image = Report;
                trigger OnAction()
                begin

                    Appointedmbrs.Reset();
                    Appointedmbrs.SetRange("Ref No", rec."Ref No");
                    if Appointedmbrs.Find('-') then
                        report.Run(report::"Opening Appointment", true, false, Appointedmbrs);
                end;
            }
            action("Evaluation Appointment")
            {
                ApplicationArea = all;
                Image = Report;
                trigger OnAction()
                begin
                    Appointedmbrs.Reset();
                    Appointedmbrs.SetRange("Ref No", rec."Ref No");
                    if Appointedmbrs.Find('-') then
                        report.Run(report::"Evaluation Appointment", true, false, Appointedmbrs);

                end;
            }

        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Update Committee_Promoted"; "Update Committee")
                {
                }
                actionref(Email_Promoted; Email)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("Opening Appointment_Promoted"; "Opening Appointment")
                {
                }
                actionref("Evaluation Appointment_Promoted"; "Evaluation Appointment")
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approvals', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Approvals_Promoted; Approvals)
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if rec.Status <> rec.Status::Open then Fieldseditable := false else Fieldseditable := true;
        if UserId = 'JEFFER' then ACtionVisi := true else ACtionVisi := false;

    end;



    var
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
        ACtionVisi: Boolean;
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
