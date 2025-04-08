page 50208 "Audit Report Card"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Date; Date)
                {
                    Editable = NOT AuditeeReport;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                }
                field("Audit Program No."; "Audit Program No.")
                {
                    Editable = NOT AuditeeReport;
                }
                field("Audit WorkPaper No."; "Audit WorkPaper No.")
                {
                    Caption = 'Select Workpaper(s)';
                    Editable = NOT AuditeeReport;
                    Enabled = NOT AuditeeReport;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectMultipleWorkpapers;
                    end;
                }
                field(Description; Description)
                {
                    Editable = NOT AuditeeReport;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = NOT AuditeeReport;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = NOT AuditeeReport;
                }
                field("Department Name"; "Department Name")
                {
                    Editable = false;
                }
                field("Audit Period"; "Audit Period")
                {
                    Editable = NOT AuditeeReport;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Audit Firm"; "Audit Firm")
                {
                    Visible = false;
                }
                field("Audit Manager"; "Audit Manager")
                {
                    Editable = false;
                }
                label("Auditee:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Auditee; Auditee)
                {
                    Editable = NOT AuditeeReport;
                }
                field("Name of Auditee"; "Name of Auditee")
                {
                    Editable = false;
                }
                field("Auditee User ID"; "Auditee User ID")
                {
                    Editable = false;
                }
                field("User Reviewed"; "User Reviewed")
                {
                    Editable = false;
                }
                label("Report Workpapers:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                part(Control37; "Audit Report Workpapers")
                {
                    Editable = ("Report Status" <> "Report Status"::Auditee);
                    SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Workpapers");
                }
            }
            part("Report Background"; "Audit Report Background")
            {
                Caption = 'Report Background';
                Editable = ("Report Status" <> "Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Background");
            }
            part("Report Objectives"; "Audit Report Objectives")
            {
                Caption = 'Report Objectives';
                Editable = ("Report Status" <> "Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Objectives");
            }
            part("Favourable Observation"; "Audit Report Fav Observation")
            {
                Caption = 'Favourable Observation';
                Editable = ("Report Status" <> "Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Observation");
            }
            part("Unfavourable Observation"; "Audit Report UnFav Observation")
            {
                Caption = 'Unfavourable Observation';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Recommendation");
            }
            part(Conclusion; "Audit Report Opinion")
            {
                Caption = 'Conclusion';
                Editable = ("Report Status" <> "Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Opinion");
            }
        }
        area(factboxes)
        {
            systempart(Control21; Links)
            {
            }
            systempart(Control18; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Audit Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHead.RESET;
                    AuditHead.SETRANGE("No.", "No.");
                    REPORT.RUN(Report::"Internal Audit Report", TRUE, FALSE, AuditHead);
                end;
            }
            action("Dispatch Report")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ("Report Status" <> "Report Status"::Auditee);

                trigger OnAction()
                begin
                    AuditMgt.MailAuditReport(Rec);
                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send For Review';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ("Report Status" <> "Report Status"::Auditee);

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckAuditWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendAuditForApproval(Rec);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Review';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ("Report Status" <> "Report Status"::Auditee);

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelAuditApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ("Report Status" <> "Report Status"::Auditee);

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program";
                begin
                    DocumentType := DocumentType::"Audit Report";
                    ApprovalEntries.Setfilters(DATABASE::"Audit Header", DocumentType, "No.");
                    ApprovalEntries.RUN;
                end;
            }
            action("Close Report")
            {
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ("Report Status" <> "Report Status"::Auditee);

                trigger OnAction()
                begin
                    IF NOT CONFIRM(ConfirmCLose, FALSE, "No.") THEN
                        EXIT
                    ELSE BEGIN
                        AuditMgt.InsertAuditRecommendation(Rec);
                        Archived := TRUE;
                        MODIFY;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(NotifyAuditor)
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Send To Auditee")
            {
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = "Report Status" <> "Report Status"::Auditee;

                trigger OnAction()
                begin
                    AuditMgt.MailAuditeeReport(Rec);
                end;
            }
            action("Send To Auditor")
            {
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = "Report Status" = "Report Status"::Auditee;

                trigger OnAction()
                begin
                    AuditMgt.MailAuditorReport(Rec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::"Audit Report";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Report";
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        AuditHead: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalsMgt: Codeunit ApprovalMgtCuExtension;
        ConfirmCLose: Label 'Do you want to close the Audit Report %1?';
        ConfrimSendtoAuditee: Label 'Do you want to send the Audit Report %1 to the Auditee %2 - %3?';
        AuditeeReport: Boolean;
        ApprovalMgtExt: Codeunit ApprovalMgtCuExtension;
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;

    local procedure SetControlAppearance()
    begin
        AuditeeReport := ("Report Status" = "Report Status"::Auditee);
    end;
}

