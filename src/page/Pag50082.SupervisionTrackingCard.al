page 50082 "Supervision Tracking Card"
{
    PageType = Card;
    SourceTable = "Supervision Tracking";
    Caption = 'Supervision Tracking Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number for approval workflow';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status of the supervision tracking record';
                    StyleExpr = StatusStyleTxt;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student number';
                }
                field("Supervisor Code"; Rec."Supervisor Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supervisor code';
                }
                field("Date Work Submitted"; Rec."Date Work Submitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date work was submitted';
                }
                field("Date Met With Supervisor"; Rec."Date Met With Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date student met with supervisor';
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the semester code';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year';
                }
            }
            group(Details)
            {
                Caption = 'Supervision Details';

                field("Stage of Work"; Rec."Stage of Work")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the stage of work discussed';
                    MultiLine = true;
                }
                field("Nature of Feedback"; Rec."Nature of Feedback")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the nature of feedback given';
                    MultiLine = true;
                }
                field("Remarks"; Rec."Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any additional remarks';
                    MultiLine = true;
                }
            }
            group(Signatures)
            {
                Caption = 'Signatures';

                field("Student Signed"; Rec."Student Signed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the student has signed the record';
                }
                field("Supervisor Signed"; Rec."Supervisor Signed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the supervisor has signed the record';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SignAsStudent)
            {
                ApplicationArea = All;
                Caption = 'Sign as Student';
                Image = Signature;
                ToolTip = 'Sign this tracking record as a student';
                Enabled = (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                begin
                    Rec."Student Signed" := true;
                    Rec.Modify();
                end;
            }

            action(SignAsSupervisor)
            {
                ApplicationArea = All;
                Caption = 'Sign as Supervisor';
                Image = Signature;
                ToolTip = 'Sign this tracking record as a supervisor';
                Enabled = (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                begin
                    Rec."Supervisor Signed" := true;
                    Rec.Modify();
                end;
            }

            group(Approval)
            {
                Caption = 'Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Send this supervision tracking record for approval';
                    Enabled = (Rec.Status = Rec.Status::Open) and EnabledApprovalButtons;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ApprovalWorkflowV1: Codeunit "Approval Workflows V1";
                        variant: Variant;
                    begin
                        variant := Rec;
                        if ApprovalWorkflowV1.CheckApprovalsWorkflowEnabled(variant) then
                            ApprovalWorkflowV1.OnSendDocForApproval(variant);
                    end;
                }

                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request';
                    Enabled = (Rec.Status = Rec.Status::"Pending Approval") and EnabledApprovalButtons;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ApprovalWorkflowV1: Codeunit "Approval Workflows V1";
                        variant: Variant;
                    begin
                        variant := Rec;
                        if ApprovalWorkflowV1.CheckApprovalsWorkflowEnabled(variant) then
                            ApprovalWorkflowV1.OnCancelDocApprovalRequest(variant);
                    end;
                }
            }

            action(PrintTrackingForm)
            {
                ApplicationArea = All;
                Caption = 'Print Form';
                Image = Print;
                ToolTip = 'Print this supervision tracking form';

                trigger OnAction()
                var
                    SuperTrackingRecord: Record "Supervision Tracking";
                    TrackingReport: Report "Postgrad Supervision Form";
                begin
                    SuperTrackingRecord.Reset();
                    SuperTrackingRecord.SetRange("Document No.", Rec."Document No.");
                    TrackingReport.SetTableView(SuperTrackingRecord);
                    TrackingReport.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        SetStatusStyle();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    var
        EnabledApprovalButtons: Boolean;
        StatusStyleTxt: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        EnabledApprovalButtons := true;
    end;

    local procedure SetStatusStyle()
    begin
        StatusStyleTxt := 'Standard';

        case Rec.Status of
            Rec.Status::Open:
                StatusStyleTxt := 'Standard';
            Rec.Status::"Pending Approval":
                StatusStyleTxt := 'Attention';
            Rec.Status::Released:
                StatusStyleTxt := 'Favorable';
            Rec.Status::Approved:
                StatusStyleTxt := 'Favorable';
            Rec.Status::Rejected:
                StatusStyleTxt := 'Unfavorable';
        end;
    end;
}