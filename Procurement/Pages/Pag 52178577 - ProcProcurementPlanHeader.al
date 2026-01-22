page 52178577 "Proc-Procurement Plan Header"
{
    PageType = Card;
    SourceTable = "PROC-Procurement Plan Header";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    layout
    {

        area(content)
        {

            group(General)
            {
                Caption = 'General';
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
            part(part; "PROC-Procurement Plan Lines")
            {
                SubPageLink = "Budget Name" = FIELD("Budget Name"), "Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Global Dimension 2 Code" = field("Global Dimension 2 Code");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::open;

                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnSendDocForApproval(variant);
                end;
            }
            //cancelapproval
            action(CancelApproval)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval';
                Image = CancelApproval;
                Visible = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnCancelDocApprovalRequest(variant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = category4;
                RunObject = page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("Budget Name");
            }
            action(Print)
            {
                Caption = 'Print Plan';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = report "Procurement Plan";
            }


        }
    }

    var
        DptName: Text[50];
        Dim: Record "Dimension Value";
        ApprovalMgt: Codeunit "Init Code";
        ApprovalEntry: Page "Fin-Approval Entries";
}

