page 52046 "Supervisor Application"
{
    ApplicationArea = All;
    Caption = 'Supervisor Application';
    PageType = Card;
    SourceTable = "Postgrad Supervisor Applic.";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field("Assigned Supervisor Code"; Rec."Assigned Supervisor Code")
                {
                    ToolTip = 'Specifies the value of the Assigned Supervisor Code field.', Comment = '%';
                }
                field("Assigned Supervisor Name"; Rec."Assigned Supervisor Name")
                {
                    ToolTip = 'Specifies the value of the Assigned Supervisor Name field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ToolTip = 'Specifies the value of the Date Approved field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Send Approval Request';
                ToolTip = 'Send an approval request for the selected certificate application.';
                Image = ApprovalRequest;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnSendDocForApproval(variant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Cancel Approval Request';
                ToolTip = 'Cancel the approval request for the selected certificate application.';
                Image = CancelApprovalRequest;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnCancelDocApprovalRequest(variant);
                end;
            }
        }
    }
}
