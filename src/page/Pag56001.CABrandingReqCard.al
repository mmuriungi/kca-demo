page 56001 "CA-Branding Req. Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CA-Branding Requisition";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;

                }
                field("Region Name"; Rec."Region Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;

                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;

                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Brand Stage"; Rec."Brand Stage")
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
            action("Send for Approval")
            {
                Caption = 'Send for Approval';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //check the status of the requisition
                    //SendForApproval();
                end;
            }
            action("Submit to CO")
            {
                Caption = 'Submit to Communication Off';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to Communication Officer?') THEN BEGIN
                        Rec."Brand Stage" := Rec."Brand Stage"::CO;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to Communication Officer', Rec."Code");
                    END;
                end;
            }
            action("Submit to DD")
            {
                Caption = 'Submit to Deputy Director';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to Deputy Director?') THEN BEGIN
                        Rec."Brand Stage" := Rec."Brand Stage"::DD;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to Deputy Director', Rec."Code");
                    END;
                end;
            }
            action("Submit to DDCAQA")
            {
                Caption = 'Submit to DDCAQA';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to DDCAQA?') THEN BEGIN
                        Rec."Brand Stage" := Rec."Brand Stage"::DDCAQA;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to DDCAQA', Rec."Code");
                    END;
                end;
            }
            action("Post")
            {
                ApplicationArea = All;
                Caption = '&Post';
                Image = PostDocument;

                trigger OnAction()
                begin
                    IF xRec.Status = Rec.Status::Approved THEN begin
                        Rec."Status" := Rec.Status::Released;
                        Rec.Modify();
                        MESSAGE('Branding Successfully posted');
                    end else
                        MESSAGE('Branding has not been approved');
                end;
            }

            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                ApplicationArea = All;
                RunObject = Page "Document Attachments";
                RunPageLink = "Document No" = FIELD("Code");
            }
        }
    }

}
