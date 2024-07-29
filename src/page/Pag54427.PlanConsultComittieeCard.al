page 54427 "Plan Consult Comittiee Card"
{
    Caption = 'Plan Consult Comittiee Card';
    PageType = Card;
    SourceTable = "DepartMent Work Plan";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Department; Rec.Department)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
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
                field(Incharge; Rec.Incharge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incharge field.';
                    Editable = false;
                }

            }
            part(Line; "WorkPlan Lines")
            {
                UpdatePropagation = Both;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52413),
                              "No." = FIELD("No.");
            }
            systempart(Link; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Note; Notes)
            {
                ApplicationArea = Notes;
            }
        }

    }


    actions
    {
        area(Processing)
        {
            action("Send for Appoval")
            {
                ApplicationArea = Suite;
                Caption = 'Send for Appoval';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Send for Appoval';
                trigger OnAction()
                begin
                    // if ApprovalsMgmtCut.CheckDepartMentWorkPlanApprovalsWorkflowEnable(Rec) then ApprovalsMgmtCut.OnSendDepartMentWorkPlanForApproval(Rec);
                end;
            }

            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Approve the requested changes.';
                trigger OnAction()
                begin
                    //  Rec.ApproveWorkplan();
                end;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Reject the requested changes.';
                trigger OnAction()
                begin
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Delegate the requested changes to the substitute approver.';
                trigger OnAction()
                begin
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    // ApprovalsMgmtCut.OnCancelDepartMentWorkPlanForApproval(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
        }
    }
    var
        // ApprovalsMgmtCut: Codeunit "DWP Approval Mgmt. Ext";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}
