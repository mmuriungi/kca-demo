page 50056 "Item Disposal Card"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Item Disposal Header";

    LAYOUT
    {
        AREA(Content)
        {
            GROUP(General)
            {
                Caption = 'General';

                FIELD("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the disposal document number.';
                    Editable = (Rec.Status = Rec.Status::Open);

                    TRIGGER OnAssistEdit()
                    BEGIN
                        // IF Rec.AssistEdit(xRec) THEN
                        //     CurrPage.UPDATE;
                    END;
                }
                FIELD("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the disposal document was created.';
                    Editable = (Rec.Status = Rec.Status::Open);
                }
                FIELD("Disposal Date"; Rec."Disposal Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the items were disposed.';
                    Editable = (Rec.Status = Rec.Status::Open);
                }
                FIELD("Disposal Method"; Rec."Disposal Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the method used for disposal.';
                    Editable = (Rec.Status = Rec.Status::Open);
                }
                FIELD("Disposal Reason Code"; Rec."Disposal Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason code for the disposal.';
                    Editable = (Rec.Status = Rec.Status::Open);
                }
                FIELD("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location from which items are being disposed.';
                    Editable = (Rec.Status = Rec.Status::Open);
                }
                FIELD("Disposal Account"; Rec."Disposal Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account to post the disposal cost.';
                    Editable = (Rec.Status = Rec.Status::Open);
                }
                FIELD(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the disposal document.';
                    Editable = false;
                }
            }
            PART(Lines; "Item Disposal Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Editable = (Rec.Status = Rec.Status::Open);
            }
            GROUP(Approval)
            {
                Caption = 'Approval';
                Visible = (Rec.Status <> Rec.Status::Open);

                FIELD("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the disposal.';
                    Editable = false;
                }
                FIELD("Approval DateTime"; Rec."Approval DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the disposal was approved.';
                    Editable = false;
                }
            }
        }
        AREA(FactBoxes)
        {
            SYSTEMPART(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            SYSTEMPART(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    ACTIONS
    {
        AREA(Processing)
        {
            ACTION(RequestApproval)
            {
                ApplicationArea = All;
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Request approval of the disposal document.';
                Enabled = (Rec.Status = Rec.Status::Open);

                TRIGGER OnAction()
                VAR
                    ItemDisposalMgt: Codeunit "Item Disposal Management";
                BEGIN
                    ItemDisposalMgt.RequestApproval(Rec);
                END;
            }
            ACTION("Cancel Approval")
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel approval of the disposal document.';
                Enabled = (Rec.Status = Rec.Status::"Pending Approval");

                TRIGGER OnAction()
                VAR
                    ItemDisposalMgt: Codeunit "Item Disposal Management";
                BEGIN
                    ItemDisposalMgt.CancelRequest(Rec);
                END;
            }
            ACTION(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'F9';
                ToolTip = 'Post the disposal and reduce inventory.';
                Enabled = (Rec.Status = Rec.Status::Approved);

                TRIGGER OnAction()
                VAR
                    ItemDisposalMgt: Codeunit "Item Disposal Management";
                BEGIN
                    ItemDisposalMgt.PostDisposal(Rec);
                END;
            }
        }
    }
}
