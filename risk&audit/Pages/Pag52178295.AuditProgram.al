page 50192 "Audit Program"
{
    Caption = 'Audit Program';
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" <> Rec."Status"::Released;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Audit Plan No."; Rec."Audit Plan No.")
                {
                    ApplicationArea = All;
                }
                field("Audit Notification No."; Rec."Audit Notification No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Audit Manager"; "Audit Manager")
                // {
                // }
                field("Send Attachment"; Rec."Send Attachment")
                {
                    ApplicationArea = All;
                    Visible = false;

                }


            }
            field(Adhoc; Rec.Adhoc)
            {
                ApplicationArea = All;

            }
            group("Risk")
            {
                Visible = Rec.Adhoc = true;
                field("Risk Decsriptions"; Rec."Risk Decsriptions")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Width = 200;

                    trigger OnValidate()
                    begin
                        // SetJobDescriptionBlobAsText("Risk Decsriptions");
                    end;
                }
            }
            group(Introductions)
            {
                field(Introduction; Rec.Introduction)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(BackGrounds)
            {
                field(BackGround; Rec.BackGround)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group("Audits Approach")
            {
                field("Audit Approach"; Rec."Audit Approach")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part("Risk Details"; "Program Risk List")
            {
                ApplicationArea = All;
                SubPageLink = "Program No" = field("No.");
            }
            part("Risk Exposure"; "Risk Exposure")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part("Activities & Deliverables"; "Activities & Deliverables")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(Control17; "Auditor(s)")
            {
                ApplicationArea = All;
                Caption = 'Audit Allocation Team';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Auditor);
            }
            part(Scope; "Audit Scope")
            {
                ApplicationArea = All;
                Caption = 'Scope';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Scope);
            }

            part(Objectives; Objectives)
            {
                ApplicationArea = All;
                Caption = 'Objectives';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Objectives);
            }

            part("Planning Procedures"; "Audit Planning Procedures")
            {
                ApplicationArea = All;
                Caption = 'Planning Procedures';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = FILTER(Planning);
            }
            part("Review Procedures"; "Audit Review")
            {
                ApplicationArea = All;
                Caption = 'Review Procedures';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Review);
            }
            part("Post-Review"; "Audit Post-Review Procedures")
            {
                ApplicationArea = All;
                Caption = 'Post-Review';
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Post Reveiw");
            }
            part(Recommendation; "Audit Report UnFav Observation")
            {
                ApplicationArea = All;
                Caption = 'Unfavourable Observation';
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Report Recommendation");
            }
        }
        area(factboxes)
        {
            systempart(Control33; Links)
            {
            }
            systempart(Control32; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                action("Upload Documents")
                {
                    ApplicationArea = all;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = Rec."No." <> '';

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        PgDocumentAttachment: Page "Document Attachment Custom";
                    begin
                        Clear(PgDocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        PgDocumentAttachment.OpenForRecReference(RecRef);
                        if Rec.Status = Rec.Status::Released then
                            PgDocumentAttachment.Editable(false);
                        PgDocumentAttachment.RUNMODAL;
                    end;
                }
            }
            action(Plan)
            {
                ApplicationArea = All;
                Caption = 'Program';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ADHeader.RESET;
                    ADHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Audit Program", TRUE, FALSE, ADHeader);
                end;
            }
            action("Audit Plan")
            {
                ApplicationArea = All;
                Caption = 'Audit Plan';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ObjAuditHeader: Record "Audit Header";
                begin
                    ObjAuditHeader.Reset();
                    ObjAuditHeader.SetRange(ObjAuditHeader."No.", Rec."Audit Plan No.");
                    if ObjAuditHeader.Find('-') then begin
                        Page.Run(50020, ObjAuditHeader);
                    end;
                end;
            }
            action("Send Audit Plan")
            {
                ApplicationArea = All;
                Caption = 'Send Audit Program';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    AuditMgt.SendAuditPlanNotice(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
                Caption = 'Cancel Approval';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run;
                end;
            }
            action(ReOpen)
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" <> Rec."Status"::Open;

                trigger OnAction()
                begin
                    IF NOT CONFIRM(ReOpeConfirm, FALSE, Rec."No.") THEN
                        EXIT
                    ELSE BEGIN
                        Rec.Status := Rec.Status::Open;
                    END;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        // "Risk Decsriptions" := GetJobDescriptionBlobAsText();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Workflows V1";
        ADHeader: Record "Audit Header";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalsMgt: Codeunit "Approvals Mgmt.";
        ReOpeConfirm: Label 'Do you want to ReOpen the Document %1?';
}

