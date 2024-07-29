page 56004 "CA-CSR Req. Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CA-CSR Requisition";

    layout
    {
        area(Content)
        {
            Group(General)
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
                field("CSR Stage"; Rec."CSR Stage")
                {
                    Editable = true;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            Group("&Functions")
            {
                action("Send for Approval")
                {
                    Caption = 'Send for Approval';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //check the status of the requisition
                        //SendForApproval();
                    end;
                }
                action("Upload Attachment")
                {
                    Caption = 'Upload Attachment';
                    ApplicationArea = All;
                    Image = Attachments;
                    RunObject = Page "Document Attachments";
                    RunPageLink = "Document No" = FIELD(Code);
                }
                action("Submit to Communication Officer")
                {
                    Caption = 'Submit to Communication Officer';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Are you sure you want to send to Communication Officer?') THEN BEGIN
                            Rec."CSR Stage" := Rec."CSR Stage"::CO;
                            Rec.MODIFY;
                            MESSAGE('Appraisal  Number %1 has been Sent to Communication Officer', Rec."Code");
                        END;
                    end;
                }

                action("Submit to Director")
                {
                    Caption = 'Submit to Director';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Are you sure you want to send to Director?') THEN BEGIN
                            Rec."CSR Stage" := Rec."CSR Stage"::Director;
                            Rec.MODIFY;
                            MESSAGE('Appraisal  Number %1 has been Sent to Director', Rec."Code");
                        END;
                    end;
                }
                action("Submit to SCM")
                {
                    Caption = 'Submit to SCM';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Are you sure you want to send to SCM?') THEN BEGIN
                            Rec."CSR Stage" := Rec."CSR Stage"::SCM;
                            Rec.MODIFY;
                            MESSAGE('Appraisal  Number %1 has been Sent to SCM', Rec."Code");
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
                            MESSAGE('CSR requisition Successfully posted');
                        end else
                            MESSAGE('This requisition has not been approved');
                    end;
                }
            }
        }
    }
    var
        myInt: Integer;

}