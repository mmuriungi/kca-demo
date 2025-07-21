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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Audit Program No."; Rec."Audit Program No.")
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field("Audit WorkPaper No."; Rec."Audit WorkPaper No.")
                {
                    ApplicationArea = All;
                    Caption = 'Select Workpaper(s)';
                    Editable = NOT AuditeeReport;
                    Enabled = NOT AuditeeReport;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.SelectMultipleWorkpapers;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Audit Firm"; Rec."Audit Firm")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label("Auditee:")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Auditee; Rec.Auditee)
                {
                    ApplicationArea = All;
                    Editable = NOT AuditeeReport;
                }
                field("Name of Auditee"; Rec."Name of Auditee")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Auditee User ID"; Rec."Auditee User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User Reviewed"; Rec."User Reviewed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label("Report Workpapers:")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                part(Control37; "Audit Report Workpapers")
                {
                    ApplicationArea = All;
                    Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                    SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Workpapers");
                }
            }
            part("Report Background"; "Audit Report Background")
            {
                ApplicationArea = All;
                Caption = 'Report Background';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Background");
            }
            part("Report Objectives"; "Audit Report Objectives")
            {
                ApplicationArea = All;
                Caption = 'Report Objectives';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Objectives");
            }
            part("Favourable Observation"; "Audit Report Fav Observation")
            {
                ApplicationArea = All;
                Caption = 'Favourable Observation';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Observation");
            }
            part("Unfavourable Observation"; "Audit Report UnFav Observation")
            {
                ApplicationArea = All;
                Caption = 'Unfavourable Observation';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Recommendation");
            }
            part(Conclusion; "Audit Report Opinion")
            {
                ApplicationArea = All;
                Caption = 'Conclusion';
                Editable = (Rec."Report Status" <> Rec."Report Status"::Auditee);
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Opinion");
            }
        }
        area(factboxes)
        {
            systempart(Control21; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control18; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Audit Report")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHead.RESET;
                    AuditHead.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Internal Audit Report", TRUE, FALSE, AuditHead);
                end;
            }
            action("Dispatch Report")
            {
                ApplicationArea = All;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec."Report Status" <> Rec."Report Status"::Auditee);

                trigger OnAction()
                begin
                    AuditMgt.MailAuditReport(Rec);
                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send For Review';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec."Report Status" <> Rec."Report Status"::Auditee);

                trigger OnAction()
                var
                    Variant: Variant;
                begin
                    Variant := Rec;
                    if ApprovalsMgmt.CheckApprovalsWorkflowEnabled(Variant) then
                        ApprovalsMgmt.OnSendDocForApproval(Variant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Cancel Review';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec."Report Status" <> Rec."Report Status"::Auditee);

                trigger OnAction()
                var
                    Variant: Variant;
                begin
                    Variant := Rec;
                    ApprovalsMgmt.OnCancelDocApprovalRequest(Variant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec."Report Status" <> Rec."Report Status"::Auditee);

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program";
                begin

                end;
            }
            action("Close Report")
            {
                ApplicationArea = All;
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec."Report Status" <> Rec."Report Status"::Auditee);

                trigger OnAction()
                begin
                    IF NOT CONFIRM(ConfirmCLose, FALSE, Rec."No.") THEN
                        EXIT
                    ELSE BEGIN
                        AuditMgt.InsertAuditRecommendation(Rec);
                        Rec.Archived := TRUE;
                        Rec.MODIFY;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(NotifyAuditor)
            {
                ApplicationArea = All;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Send To Auditee")
            {
                ApplicationArea = All;
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Report Status" <> Rec."Report Status"::Auditee;

                trigger OnAction()
                begin
                    AuditMgt.MailAuditeeReport(Rec);
                end;
            }
            action("Send To Auditor")
            {
                ApplicationArea = All;
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Report Status" = Rec."Report Status"::Auditee;

                trigger OnAction()
                begin
                    AuditMgt.MailAuditorReport(Rec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Report";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Report";
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        AuditHead: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalsMgt: Codeunit "Approval Workflows V1";
        ConfirmCLose: Label 'Do you want to close the Audit Report %1?';
        ConfrimSendtoAuditee: Label 'Do you want to send the Audit Report %1 to the Auditee %2 - %3?';
        AuditeeReport: Boolean;
        ApprovalMgtExt: Codeunit "Approval Workflows V1";
        ApprovalsMgmt: Codeunit "Approval Workflows V1";

    local procedure SetControlAppearance()
    begin
        AuditeeReport := (Rec."Report Status" = Rec."Report Status"::Auditee);
    end;
}

