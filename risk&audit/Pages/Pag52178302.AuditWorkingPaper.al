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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
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
                    Editable = false;
                }
                field("Audit Program No."; Rec."Audit Program No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin

                        IF AuditHeader.GET(Rec."Audit Program No.") AND (AuditHeader.Type = AuditHeader.Type::"Audit Program") THEN
                            AuditHeader.Archived := TRUE;
                        AuditHeader.MODIFY;
                    end;
                }
                field("Select Working Scope"; Rec."Working Paper Scope")
                {
                    ApplicationArea = All;
                }
                label("Audit Program Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Done By Name"; Rec."Done By Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Audit Stage"; Rec."Audit Stage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Date Completed"; Rec."Date Completed")
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
                part(Control36; "Audit Workpaper Scope")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;

                }
            }

            part(Objectives; "WorkPaper Objectives")
            {
                ApplicationArea = All;
                Editable = Rec."Status" <> Rec."Status"::Released;
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("WorkPaper Objectives");
            }
            part(Control13; "Workpaper Result")
            {
                ApplicationArea = All;
                Visible = false;
                SubPageLink = "Document No." = FIELD("No.");
            }
            part(Conclusion; "WorkPaper Conclusion")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Send For Review';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Open;

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
                Visible = Rec.Status = Rec.Status::"Pending Approval";

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
            action("Audit Program")
            {
                ApplicationArea = All;
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
        ApprovalsMgmt: Codeunit "Approval Workflows V1";
}

