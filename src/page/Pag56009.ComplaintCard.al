page 56009 "Complaint Card"
{
    Caption = 'Complaint Card';
    PageType = Card;
    SourceTable = "CA-Complaints";
    //SourceTableView = WHERE(Status = FILTER(''));


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Complaint Description"; Rec."Complaint Description")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Complain Type"; Rec."Complain Type")
                {
                    ToolTip = 'Specifies the value of the Complain Type field.';
                    ApplicationArea = All;
                }
                field(Department; Rec."Cost Center Code")
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Region; Rec."Region Code")
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }

                field("Status"; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)


        {
            action(Committee)
            {
                Caption = 'Committee';
                Image = List;
                ApplicationArea = All;
                RunObject = Page "Complaints Committee";
                RunPageLink = Code = FIELD(Code);
            }
            action("Upload Attachment")
            {
                Caption = 'Upload Attachment';
                ApplicationArea = All;
                Image = Attachments;
                RunObject = Page "Document Attachments";
                RunPageLink = "Document No" = FIELD(Code);
            }
            action(Report)
            {
                Caption = 'Complaints Report';
                Image = PrintReport;
                ApplicationArea = All;
                RunObject = report "Complaints Report";
                //RunPageLink = Code = FIELD(Code);
            }
            action("Submit to CC")
            {
                Caption = 'Submit to Complaint committee';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to Complaint Committee?') THEN BEGIN
                        Rec.Status := Rec.Status::InCommittee;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to Complaint Committee', Rec."Code");
                    END;
                end;
            }
            action("Submit to HOD")
            {
                Caption = 'Submit to HOD for Appeal';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to HOD for appeal?') THEN BEGIN
                        Rec.Status := Rec.Status::OutofCommittee;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to HOD for appeal', Rec."Code");
                    END;
                end;
            }
        }

    }

}
