page 52061 "Certificate Application Card"
{
    PageType = Card;
    SourceTable = "Certificate Application";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Requirements)
            {
                field("Clearance Status"; Rec."Clearance Status")
                {
                    ApplicationArea = All;
                }
                field("Gown Returned"; Rec."Gown Returned")
                {
                    ApplicationArea = All;
                }
                field("National ID Provided"; Rec."National ID Provided")
                {
                    ApplicationArea = All;
                }
                field("Police Abstract Provided"; Rec."Police Abstract Provided")
                {
                    ApplicationArea = All;
                    Visible = Rec."Application Type" = Rec."Application Type"::"Copy of Certificate";
                }
                field("Fee Paid"; Rec."Fee Paid")
                {
                    ApplicationArea = All;
                }
            }
            group("Special Examination")
            {
                Visible = Rec."Application Type" = Rec."Application Type"::"Special Examination";

                field("Special Exam Reason"; Rec."Special Exam Reason")
                {
                    ApplicationArea = All;
                    MultiLine = true;
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
                Caption = 'Attachments';
                ToolTip = 'View and manage attachments for the selected certificate application.';
                Image = Attachments;
            }
        }
    }

    var
        CertificateMgmt: Codeunit "Student Certificate Management";
}
