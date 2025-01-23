page 52081 "Medical Claims Card"
{
    SourceTable = "HRM-Medical Claims";
    Caption = 'Medical Claim Card';
    PromotedActionCategories = 'New,Process,Reports,Approval';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    // trigger OnAssistEdit()
                    // begin
                    //     // if Rec.AssistEdit(xRec) then
                    //     //     CurrPage.Update();
                    // end;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Document Ref"; Rec."Document Ref")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
            }

            group(MemberDetails)
            {
                Caption = 'Member Information';
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Member Names"; Rec."Member Names")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheme No"; Rec."Scheme No")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(PatientInfo)
            {
                Caption = 'Patient Information';
                Visible = Rec."Patient Type" = Rec."Patient Type"::Depedant;
                field(Dependants; Rec.Dependants)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
            }

            group(FacilityDetails)
            {
                Caption = 'Medical Facility';
                field("Facility Attended"; Rec."Facility Attended")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Facility Name"; Rec."Facility Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = All;
                }
            }

            group(ClaimAmount)
            {
                Caption = 'Claim Details';
                field("Claim Currency Code"; Rec."Claim Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheme Currency Code"; Rec."Scheme Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheme Amount Charged"; Rec."Scheme Amount Charged")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Other)
            {
                Caption = 'Additional Information';
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
                Visible = Rec."Status" = Rec."Status"::open;
                Promoted = true;
                PromotedCategory = Category4;
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
                Visible = Rec."Status" = Rec."Status"::open;
                Promoted = true;
                PromotedCategory = Category4;
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
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                ApplicationArea = All;
                Enabled = Rec."Status" = Rec."Status"::approved;
                Visible = not Rec."Posted";
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ClaimHandler: Codeunit "Claims Handler";
                begin
                    if not confirm('Are you sure you want to post this claim? This will create a new payment voucher.') then
                        exit;
                    Rec."Posted" := ClaimHandler.createPaymentVoucher(Rec);
                    Rec.Modify(true);
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
