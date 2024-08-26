page 51491 "Pharmacy Request List"
{
    PageType = List;
    SourceTable = "Pharmacy Requests Header";
    CardPageId = "Pharmacy Requests Header";
    //SourceTableView = where(Posted = filter(false));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
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

            action("Post Requisition")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = NewItemNonStock;
                Enabled = false;
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