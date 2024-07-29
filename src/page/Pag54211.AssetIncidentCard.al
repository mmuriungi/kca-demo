page 54211 "Asset Incident Card"
{
    PageType = Card;
    SourceTable = "Asset Incident";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Incident No."; Rec."Incident No.")
                {
                    ShowMandatory = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Incident Type"; Rec."Incident Type")
                {
                    ApplicationArea = All;
                }
                field("Reported By"; Rec."Reported By")
                {
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Date Reported"; Rec."Date Reported")
                {
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Recommendations; Rec.Recommendations)
                {
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part(Lines; "Asset Incident Lines")
            {
                SubPageLink = "Incident No." = FIELD("Incident No.");
                UpdatePropagation = Both;
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

                    IF CONFIRM('Send this Maintenance for Approval?', TRUE) = FALSE THEN EXIT;

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
                    IF CONFIRM('Cancel Approval Request for this Maintenance?', TRUE) = FALSE THEN EXIT;

                    //ApprovalMgt.CancelAssetTransAppRequest(Rec,TRUE,TRUE);
                end;
            }
        }
    }
}

