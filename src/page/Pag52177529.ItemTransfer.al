page 52115 "Item Transfer"
{
    Caption = 'Item Transfer';
    PageType = Document;
    SourceTable = "Item Transfer Header";
    PromotedActionCategories = 'New,Process,Report,Approvals,Posting';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin

                    end;
                }

                field("Transfer Date"; Rec."Transfer Date")
                {
                    ApplicationArea = All;
                }

                field("Location From Code"; Rec."Location From Code")
                {
                    ApplicationArea = All;
                }

                field("Location To Code"; Rec."Location To Code")
                {
                    ApplicationArea = All;
                }

                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }

            part(Lines; "Item Transfer Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Transfer No." = field("No.");
                UpdatePropagation = Both;
            }

            group("Posting Information")
            {
                Caption = 'Posting Information';
                Visible = Rec.Posted;

                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Release")
            {
                Caption = 'Release';
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Released;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approval Workflows V1";
                    Variant: Variant;
                begin
                    Variant := Rec;
                    if ApprovalsMgmt.CheckApprovalsWorkflowEnabled(Variant) then
                        ApprovalsMgmt.OnSendDocForApproval(Variant);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                ApplicationArea = All;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = Rec."Approval Status" = Rec."Approval Status"::Pending;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approval Workflows V1";
                    Variant: Variant;
                begin
                    Variant := Rec;
                    ApprovalsMgmt.OnCancelDocApprovalRequest(Variant);
                end;
            }
            action("Approvals")
            {
                Caption = 'Approvals';
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = field("No.");
            }
            action("Post Transfer")
            {
                Caption = 'Post Transfer';
                ApplicationArea = All;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category5;
                Enabled = (Rec.Status = Rec.Status::Released) and not Rec.Posted;

                trigger OnAction()
                var
                    ItemTransferMgt: Codeunit "Item Transfer Management";
                begin
                    if Confirm('Do you want to post this transfer?') then begin
                        ItemTransferMgt.PostTransfer(Rec);
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
}