page 50676 "HR Leave Planner Card"
{
    PageType = Card;
    SourceTable = "HR Leave Planner Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Year; Rec.Year)
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            part("HrLeavePlannerLines"; "Hr Leave Planner Lines")
            {
                SubPageLink = "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                              "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
                              "Shortcut Dimension 3 Code" = FIELD("Shortcut Dimension 3 Code"),
                              "Shortcut Dimension 4 Code" = FIELD("Shortcut Dimension 4 Code"),
                              Year = FIELD(Year),
                              "Document Number" = FIELD(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
            }
            action("&Approvals")
            {
                Caption = '&Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*
                    DocumentType:=DocumentType::LeavePlanner;
                    ApprovalEntries.Setfilters(DATABASE::"HR Leave Planner Header",DocumentType,No);
                    ApprovalEntries.RUN;
                    */

                    approvalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID);

                end;
            }
            action("&Send Approval Request")
            {
                Caption = '&Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    IF CONFIRM('Send this Leave schedule for Approval?', TRUE) = FALSE THEN EXIT;
                    Rec."User ID" := USERID;
                    //ApprovalMgt.SendLeavePlannerAppApprovalReq(Rec);
                    /*
                    IF appvmgt.CheckleavePlannerReqApprovalsWorkflowEnabled(Rec) THEN
                      appvmgt.OnSendleavePlannerReqForApproval(Rec);
                    */
                    VarVariant := Rec;
                    // IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                    //   CustomApprovals.OnSendDocForApproval(VarVariant);

                end;
            }
            action("&Cancel Approval Request")
            {
                Caption = '&Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*//ApprovalMgt.CancelLeavePlannerAppRequest(Rec,TRUE,TRUE);
                    appvmgt.OnCancelleavePlannerReqApprovalRequest(Rec);*/
                    VarVariant := Rec;
                    //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Category4;
            }
            action("Get Employees")
            {
                Caption = 'Get Employees';
                Image = GetActionMessages;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    planner.RESET;
                    planner.SETRANGE(planner."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    planner.SETRANGE(planner."Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    IF planner.FINDSET THEN
                        planner.DELETEALL;

                    HREmp.RESET;
                    HREmp.SETRANGE(HREmp.Campus, rec."Global Dimension 1 Code");
                    HREmp.SETRANGE(HREmp."Department Code", Rec."Shortcut Dimension 2 Code");
                    //HREmp.SETRANGE(HREmp."Department Code",

                    IF HREmp.FIND('-') THEN BEGIN
                        REPEAT
                            //insert into this Leave Planner
                            planner.INIT;
                            planner."Document Number" := Rec.No;
                            planner."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            planner."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            planner."Staff No." := HREmp."No.";
                            planner."Staff Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                            planner.Year := Rec.Year;
                            planner.INSERT;
                        //planner
                        UNTIL HREmp.NEXT = 0;
                    END;
                end;
            }
        }
    }

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs",EmpTransfer,LeavePlanner;
        ApprovalEntries: Page 658;
        HREmp: Record "HRM-Employee C";
        planner: Record "HR Leave Planner Lines";
        appvmgt: Codeunit 1535;
        CustomApprovals: Codeunit "Work Flow Code";
        VarVariant: Variant;
        approvalsMgmt: Codeunit 1535;
}

