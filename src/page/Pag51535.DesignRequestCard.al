page 51535 "Design Request Card"
{
    Caption = 'Design Request Card';
    PageType = Card;
    SourceTable = "Graphics Desing Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Desing Req Code"; Rec."Desing Req Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desing Req Code field.';
                }
                field("Requestor Name"; Rec."Requestor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requestor Name field.';
                }
                field("Requestor Staff ID"; Rec."Requestor Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requestor Staff ID field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Desinger Allocated"; Rec."Desinger Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desinger Allocated field.';
                }
                field("Desinger Names"; Rec."Desinger Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desinger Names field.';
                }
            }
            part("Meeting Agenda Lines"; "Design Request Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Desing Req Code" = field("Desing Req Code");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Attachments1)
            {
                ApplicationArea = All;
                Caption = 'Meeting Minutes(Other Attachments)';

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }

            action("Request Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    // If ApprovalsMgmt.CheckmeetingBookingWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMeetingBookingForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    //ApprovalsMgmt.OnCancelMeetingBookingForApproval(Rec);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = (Rec.Status = Rec.Status::Cancelled);

                trigger OnAction()
                var
                    SuccessMsg: Label 'The Document has been re-openned successfully';
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    Message(SuccessMsg);
                    CurrPage.Update();
                end;
            }
        }
    }
    var
        EmailSend: Codeunit Mailsendmgt;
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
}