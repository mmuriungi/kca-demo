page 54207 "Actual Maintenance Card"
{
    PageType = Card;
    SourceTable = "Actual Maintenance ";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Maintenance No."; Rec."Maintenance No.")
                {
                    ShowMandatory = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Planned Date"; Rec."Planned Date")
                {
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
                field("Plan No."; Rec."Plan No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Actual Maintenance Lines")
            {
                SubPageLink = "Maintenance No." = FIELD("Maintenance No.");
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
                    // IF ApprovalsMgmt.CheckActualMaintenanceApprovalsWorkflowEnabled(Rec) THEN
                    //     ApprovalsMgmt.OnSendActualMaintenanceForApproval(Rec);
                end;
            }
            action(Approval)
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

                    //ApprovalsMgmt.OnCancelActualMaintenanceForApproval(Rec);
                end;
            }
            action(Print)
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.SETFILTER("Maintenance No.", Rec."Maintenance No.");
                    // REPORT.RUN(REPORT::"Asset Maintenance", TRUE, TRUE, Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntries: Page 658;
                    ApprovalsMgmt: Codeunit 1535;
                begin

                    // ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID)
                end;
            }
            action("Confirmation of Work")
            {
                Caption = 'Confirmation of Work';
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Casual Employees.";
                ApplicationArea = All;
                // RunPageLink = "Gate Pass No." = FIELD("Maintenance No.");
            }
        }
    }

    var
        ApprovalsMgmt: Codeunit 1535;
}

