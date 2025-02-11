page 50971 "Parttime Claims Header"
{
    PageType = Card;
    SourceTable = "Parttime Claim Header";

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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field(payee; Rec.payee)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the payee field.';
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Amount field.';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Expense AC"; Rec."Expense AC")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense AC field.';
                }
                field("Expense Ac Name"; Rec."Expense Ac Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Ac Name field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                group("Session Details")
                {
                    field(Semester; Rec.Semester)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Semester field.';
                    }
                    field("Academic Year"; Rec."Academic Year")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Academic Year field.';
                    }
                    field("Semester Start Date"; Rec."Semester Start Date")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Semester Start Date field.';
                    }
                    field("Semester End Date"; Rec."Semester End Date")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Semester End Date field.';
                    }
                }
            }
            part("Lines"; "Parttime Claim Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Academic Year" = field("Academic Year"), Semester = field(Semester), "Lecture No." = field("Account No.");

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Request Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;

                Visible = not Rec.Posted;
                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        Rec.CommitBudget();
                    ApprovMgmt.OnSendDocForApproval(variant);

                end;
            }
            action("Approvals")
            {
                ApplicationArea = All;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("No.");
            }
            action("Cancel Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = not Rec.Posted;
                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        Rec.CancelCommitment();
                    ApprovMgmt.OnCancelDocApprovalRequest(variant);
                end;
            }
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                RunObject = Page "Document Attachment Details";
                RunPageLink = "No." = field("No.");
            }

            action("Post Claim")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = PostBatch;
                Visible = not Rec.Posted;

                trigger OnAction()
                var
                    ParttimerMgmt: Codeunit "PartTimer Management";
                begin
                    if not confirm('Are you sure you want to post this claim? This will create a new purchase invoice.') then
                        exit;
                    ParttimerMgmt.createPurchaseInvoice(Rec);
                    ParttimerMgmt.createPaymentVoucher(Rec);
                    Rec.Posted := true;
                    Rec.Modify();
                    // Rec.PostClaim();
                end;

            }
        }
    }

}