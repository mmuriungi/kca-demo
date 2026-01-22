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
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Enabled = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Sender E-Mail"; Rec."Sender E-Mail")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    enabled = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Notification Sent"; Rec."Notification Sent")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part(OperationRisk; "Operations Risk")
            {
                ApplicationArea = All;
                Caption = 'Risk Category';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Internal Risk");
            }
            part(ExternalRisk; "External Risks")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("External Risk");
            }
            part(RiskMitigationProposal; "Risk Mitigation Proposal")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Mitigation");
                Visible = false;
            }
            part(RiskOpportunities; "Risk Opportunities")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Risk Opportunities");
                Visible = false;
            }
        }
        area(factboxes)
        {
            systempart(Control23; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Survey Report")
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
                    REPORT.RUN(Report::"Risk Survey", TRUE, FALSE, AuditHead);
                end;
            }
            action("Send Survey")
            {
                ApplicationArea = All;
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
        ApprovalMgt: Codeunit "Approval Workflows V1";

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

