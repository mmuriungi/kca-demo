page 51529 "Meeting Card"
{
    Caption = 'Meeting Card';
    PageType = Card;
    SourceTable = MeetingsInfo;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Meeting Code"; Rec."Meeting Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Meeting Start Time"; Rec."Meeting Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Start Time field.';
                }
                field("Meeting End Time"; Rec."Meeting End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting End Time field.';
                }
                field("Meeting Title"; Rec."Meeting Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Title field.';
                }
                field("Meeting Type"; Rec."Meeting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Type field.';
                }
                field("Venue Type"; Rec."Venue Type")
                {
                    ApplicationArea = All;
                }
                field("Meeting Venue"; Rec."Meeting Venue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Venue field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }


            }
            part("Meeting Agenda Lines"; "Meeting Agenda Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Meeting Code" = field("Meeting Code");
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
            action("Meeting Attendees")
            {
                ApplicationArea = All;
                RunObject = Page "Meeting Atendees";
                RunPageLink = "Meeting Code" = field("Meeting Code");
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
                    If ApprovalsMgmt.CheckmeetingBookingWorkflowEnable(Rec) then
                        ApprovalsMgmt.OnSendMeetingBookingForApproval(Rec);
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
                    ApprovalsMgmt.OnCancelMeetingBookingForApproval(Rec);
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
            action("Send Email Notification")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    EmailSend.Send(Rec."Meeting Code");
                    Rec."Invite Sent" := true;
                    Rec.Modify();
                end;

            }
            action("Cancel Booking")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    EmailSend.CancelMeeting(Rec."Meeting Code");
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;

            }
        }
    }
    var
        EmailSend: Codeunit Mailsendmgt;
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
}
