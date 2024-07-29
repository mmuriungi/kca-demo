page 54222 "Approved Gate Pass Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Gate Pass";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ApplicationArea = All;
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Asset Transfer No"; Rec."Asset Transfer No")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                }
                field("Asset From Location"; Rec."Asset From Location")
                {
                    ApplicationArea = All;
                }
                field("Asset To Location"; Rec."Asset To Location")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Send this Asset Transfer for Approval?', TRUE) = FALSE THEN EXIT;
                    Rec.Status := Rec.Status::Approved

                    //ApprovalMgt.SendAssetTransApprovalReq(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
                begin

                    DocumentType := DocumentType::"Asset Transfer";
                    //ApprovalEntries.Setfilters(DATABASE::"HR Asset Transfer Header",DocumentType,"No.");
                    //ApprovalEntries.RUN;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Cancel Approval Request for this Asset Transfer?', TRUE) = FALSE THEN EXIT;
                    //Status:=Status::Cancelled


                    //ApprovalMgt.CancelAssetTransAppRequest(Rec,TRUE,TRUE);
                end;
            }
            action("Conformation Of Work")
            {
                RunObject = Page "Casual Employees.";
                ApplicationArea = All;
            }
        }
    }
}

