page 50215 "Risk Survey"
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
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                }
                field("Sender E-Mail"; Rec."Sender E-Mail")
                {
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    enabled = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                    Enabled = false;
                }
                field("Notification Sent"; Rec."Notification Sent")
                {
                    Enabled = false;
                }
            }
            part(OperationRisk; "Operations Risk")
            {
                Caption = 'Risk Category';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Internal Risk");
            }
            part(ExternalRisk; "External Risks")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("External Risk");
            }
            part(RiskMitigationProposal; "Risk Mitigation Proposal")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Mitigation");
                Visible = false;
            }
            part(RiskOpportunities; "Risk Opportunities")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Opportunities");
                Visible = false;
            }
        }
        area(factboxes)
        {
            systempart(Control23; Links)
            {
            }
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Survey Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHead.RESET;
                    AuditHead.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Risk Survey", TRUE, FALSE, AuditHead);
                end;
            }
            action("Send Survey")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //AuditMgt.MailRiskSurvey(Rec."No.");
                    // AuditMgt.InsertRiskRegister(Rec);
                    //"Notification Sent" := true;
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Risk Survey";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Risk Survey";
    end;

    var
        AuditHead: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForPayment: Boolean;
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;

    local procedure SetControlApperance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Released) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForPayment := App2.CanCancelApprovalForRecord(Rec.RecordId);

        //Get Doc count
    end;

}

