page 52062 "Certificate Application List"
{
    ApplicationArea = All;
    Caption = 'Certificate Application List';
    PageType = List;
    SourceTable = "Certificate Application";
    CardPageId = "Certificate Application Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ToolTip = 'Specifies the value of the Application Type field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Clearance Status"; Rec."Clearance Status")
                {
                    ToolTip = 'Specifies the value of the Clearance Status field.', Comment = '%';
                }
                field("Fee Paid"; Rec."Fee Paid")
                {
                    ToolTip = 'Specifies the value of the Fee Paid field.', Comment = '%';
                }
                field("Gown Returned"; Rec."Gown Returned")
                {
                    ToolTip = 'Specifies the value of the Gown Returned field.', Comment = '%';
                }
                field("National ID Provided"; Rec."National ID Provided")
                {
                    ToolTip = 'Specifies the value of the National ID Provided field.', Comment = '%';
                }
                field("Police Abstract Provided"; Rec."Police Abstract Provided")
                {
                    ToolTip = 'Specifies the value of the Police Abstract Provided field.', Comment = '%';
                }
                field("Special Exam Reason"; Rec."Special Exam Reason")
                {
                    ToolTip = 'Specifies the value of the Special Exam Reason field.', Comment = '%';
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
                begin

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
                begin

                end;
            }
        }
        area(Navigation)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                Image = PrintAttachment;

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
}
