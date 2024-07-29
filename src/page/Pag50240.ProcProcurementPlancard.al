page 50240 "Proc-Procurement Plan card"
{
    PageType = Card;
    caption = 'Departmental Procurement Plan';
    SourceTable = "PROC-Procurement Plan Header1";
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
            part(part; "PROC-Procurement Plan Lines1")
            {
                SubPageLink = "Budget Name" = FIELD("Budget Name"), "Global Dimension 1 Code" = field("Global Dimension 1 Code");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = category4;
                trigger OnAction()
                var
                    approvalmgt: Codeunit "Init Code";
                begin
                    // if approvalmgt.IsProcurementPlanEnabled(Rec) = true then
                    //     approvalmgt.OnSendProcurementPlanforApproval(Rec)
                    // else
                    Message('Check Your workflow if enabled');

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
            action("Cancel Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = category4;

                trigger OnAction()
                var
                    approvalmgt: Codeunit "Init Code";
                begin
                    // approvalmgt.OnCancelProcurementPlanForApproval(Rec);
                end;
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
        Dim: Record 349;
        ApprovalMgt: Codeunit "Init Code";
        ApprovalEntry: Page "Fin-Approval Entries";
}

