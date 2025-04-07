page 50073 "Student Deferment/Withdrawal"
{
    PageType = Card;
    SourceTable = "Student Deferment/Withdrawal";
    Caption = 'Student Deferment/Withdrawal Request';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the request number.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student number.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student name.';
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this is a deferment or withdrawal request.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the request was submitted.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year for the request.';
                }
                field("Semester"; Rec."Semester")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the semester for the request.';
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the programme code.';
                }
                field("Stage"; Rec."Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the stage of the programme.';
                }
            }
            group(Details)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the deferment or withdrawal.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date of the deferment. Leave blank for withdrawal.';
                    Visible = Rec."Request Type" = Rec."Request Type"::Deferment;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expected return date after deferment.';
                    Visible = Rec."Request Type" = Rec."Request Type"::Deferment;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for the deferment or withdrawal.';
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the request.';
                }
            }
            group(Approval)
            {
                Visible = Rec.Status <> Rec.Status::Open;
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the request.';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the request was approved.';
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
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;
                ToolTip = 'Sends the request for approval.';

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
            action(CancelApproval)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = CancelApproval;
                Visible = Rec.Status = Rec.Status::"Pending";
                ToolTip = 'Cancels the approval request.';

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
        area(Navigation)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
        }
    }
}
