page 54358 "Pharmacy Requests Header"
{
    PageType = Card;
    SourceTable = "Pharmacy Requests Header";
    RefreshOnActivate = true;
    // SourceTableView = where(Posted = filter(false));

    layout
    {
        area(Content)
        {
            group(general)
            {


                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    Editable = false;

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date and Time field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
            part("Request Lines"; "Pharmacy Requests Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Request Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;

                trigger OnAction()
                begin
                    if ApprovalMgt.IsPharmRequestsEnabled(Rec) = true then
                        ApprovalMgt.OnSendPharmRequestsforApproval(Rec)
                    else
                        Error('Check Your workflow');
                end;
            }

            action("Cancel Approval")
            {
                Visible = false;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;

                trigger OnAction()
                begin
                    if ApprovalMgt.IsPharmRequestsEnabled(Rec) = true then
                        ApprovalMgt.OnCancelPharmRequestsforApproval(Rec)
                    else
                        Error('Check Your workflow');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = ProductionSetup;
                RunObject = Page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("No.");
            }

            action("Post Requisition")
            {
                Visible = false;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = NewItemNonStock;
                trigger OnAction()
                begin

                    Rec.postRequisition();
                end;
            }
        }
    }

    var
        ApprovalMgt: Codeunit "Init CodeUnit";
}