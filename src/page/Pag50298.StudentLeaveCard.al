page 50298 "Student Leave Card"
{
    PageType = Card;
    SourceTable = "Student Leave";


    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = Rec."Approval Status" = Rec."Approval Status"::Open;
                field("Leave No."; Rec."Leave No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec."Approval Status")
                {
                    ApplicationArea = All;
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
                Visible = Rec."Approval Status" = Rec."Approval Status"::open;

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
            //cancelapproval
            action(CancelApproval)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval';
                Image = CancelApproval;
                Visible = Rec."Approval Status" = Rec."Approval Status"::open;

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
