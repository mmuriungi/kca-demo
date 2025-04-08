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
                field("No."; "No.")
                {
                    Enabled = false;
                }
                field(Date; Date)
                {
                }
                field("Created By"; "Created By")
                {
                    Enabled = false;
                }
                field("Employee No."; "Employee No.")
                {
                    Enabled = true;
                }
                field("Employee Name"; "Employee Name")
                {
                    Enabled = false;
                }
                field("Sender E-Mail"; "Sender E-Mail")
                {
                    Enabled = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Document Status"; "Document Status")
                {
                    enabled = false;
                }
                field(Description; Description)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Department Name"; "Department Name")
                {
                    Enabled = false;
                }
                field("Notification Sent"; "Notification Sent")
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
                    AuditHead.SETRANGE("No.", "No.");
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
        Type := Type::"Risk Survey";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Risk Survey";
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
        if ("Status" = "Status"::Released) or ("Status" = "Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(RecordId);

        CanCancelApprovalForPayment := App2.CanCancelApprovalForRecord(RecordId);

        //Get Doc count
    end;

}

