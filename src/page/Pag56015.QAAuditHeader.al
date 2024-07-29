page 56015 "QA  Audit Header"
{
    Caption = 'QA  Audit Header';
    PageType = Card;
    SourceTable = "QA Audit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Audit Header No."; Rec."Audit Header No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                    ApplicationArea = All;
                }
                field("Audit Criteria"; Rec."Audit Criteria")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                    ApplicationArea = All;
                }
                field("Audit Summary"; Rec."Audit Summary")
                {
                    ToolTip = 'Specifies the value of the Audit Summary field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Audit team leader"; Rec."Audit team leader")
                {
                    ToolTip = 'Specifies the value of the Audit Team Leader field.';
                    ApplicationArea = All;
                }
                field("Audit team leader Name"; Rec."Audit team leader Name")
                {
                    ToolTip = 'Specifies the value of the Audit team leader Name field.';
                    ApplicationArea = All;
                }
                field("Centre to be Audited"; Rec."Centre to be Audited")
                {
                    ToolTip = 'Specifies the value of the Center to be Audited field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    Caption = 'Region Name';
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field("Audit Status"; Rec."Audit Status")
                {
                    Caption = 'Audit Status';
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
            }
            part("Audit Lines"; "Audit Finding Lines")

            {
                SubPageLink = "No." = FIELD("Audit Header No.");
                UpdatePropagation = Both;
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = false;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin

                    IF CONFIRM('Send this Maintenance Plan for Approval?', TRUE) = FALSE THEN EXIT;

                    //ApprovalMgt.SendAssetTransApprovalReq(Rec);
                end;
            }
            action("Submit Notification")
            {
                Caption = 'Submit Notification';
                Image = Approval;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to Submit Audit Notification?') THEN BEGIN
                        Rec."Audit Status" := Rec."Audit Status"::Ongoing;
                        Rec.MODIFY;
                        MESSAGE('QA Audit No %1 Notification has been Submitted', Rec."Audit No.");
                    END;
                end;
            }
            action("QA-Audit Team")
            {
                Caption = 'QA Audit Team';
                Image = List;
                ApplicationArea = All;
                RunObject = Page "QA Audit Team";
                RunPageLink = "Audit No." = FIELD("Audit No.");
            }
        }
    }

}
