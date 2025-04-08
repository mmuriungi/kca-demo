page 50199 "Audit Working Paper"
{
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
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Audit Program No."; Rec."Audit Program No.")
                {

                    trigger OnValidate()
                    begin

                        IF AuditHeader.GET(Rec."Audit Program No.") AND (AuditHeader.Type = AuditHeader.Type::"Audit Program") THEN
                            AuditHeader.Archived := TRUE;
                        AuditHeader.MODIFY;
                    end;
                }
                field("Select Working Scope"; Rec."Working Paper Scope")
                {
                }
                label("Audit Program Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Done By"; Rec."Done By")
                {
                    Editable = false;
                }
                field("Done By Name"; Rec."Done By Name")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Audit Stage"; Rec."Audit Stage")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Date Completed"; Rec."Date Completed")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                part(Control36; "Audit Workpaper Scope")
                {
                    Visible = false;
                    SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Scope");
                }
                // field(Title; Title)
                // {
                // }
                // field("Audit Firm"; "Audit Firm")
                // {
                //     Visible = false;
                // }
                // field("Audit Manager"; "Audit Manager")
                // {
                // }
                // field("Cut-Off Period"; "Cut-Off Period")
                // {
                // }
                // label("Reviewed By:")
                // {
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Reviewed By"; "Reviewed By")
                // {
                //     // Editable = false;
                // }
                // field("Reviewed By Name"; "Reviewed By Name")
                // {
                //     // Editable = false;
                // }
                // field("Date Reviewed"; "Date Reviewed")
                // {
                //     // Editable = false;
                // }
                field(Reviewed; Rec.Reviewed)
                {

                }
            }

            part(Objectives; "WorkPaper Objectives")
            {
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Objectives");
            }
            part(Control13; "Workpaper Result")
            {
                Visible = false;
                SubPageLink = "Document No." = FIELD("No.");
            }
            part(Conclusion; "WorkPaper Conclusion")
            {
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Conclusion");
            }
        }
        area(factboxes)
        {
            systempart(Control35; Links)
            {
            }
            systempart(Control34; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Working Paper")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ADHeader.RESET;
                    ADHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Audit Working Paper", TRUE, FALSE, ADHeader);
                end;
            }
            action("Send For Recommendation")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Released;
                trigger OnAction()
                begin
                    IF Rec."Audit Stage" = Rec."Audit Stage"::New THEN begin
                        Rec."Audit Stage" := Rec."Audit Stage"::Council;
                        Rec.Modify(true);
                    end;
                end;
            }
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
            action(SendApprovalRequest)
            {
                Caption = 'Send For Review';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Open;

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
                Visible = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelAuditApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
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
            action("Audit Program")
            {
                Caption = 'Audit Program';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ObjAuditHeader: Record "Audit Header";
                begin
                    ObjAuditHeader.Reset();
                    ObjAuditHeader.SetRange(ObjAuditHeader."No.", Rec."Audit Program No.");
                    if ObjAuditHeader.Find('-') then begin
                        Page.Run(52178295, ObjAuditHeader);
                    end;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Work Paper";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Work Paper";
    end;

    var
        ADHeader: Record "Audit Header";
        AppprovalsMgt: Codeunit "Approvals Mgmt.";
        AuditHeader: Record "Audit Header";
        ScopeNotes: BigText;
        Instr: InStream;
        ScopeNotesText: Text;
        OutStr: OutStream;
        AuditLines: Record "Audit Lines";
        ConfirmSelectScope: Label 'Once a Scope is Selected will not appear again.\Confirm the Scope is correct.\Do you want to use the Selected Scope?';
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
}

