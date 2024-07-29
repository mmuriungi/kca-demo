page 54201 "Asset Transfer Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "Asset Transfer";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FieldEditable;
                field("No."; Rec."No.")
                {
                    ShowMandatory = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Asset to Transfer"; Rec."Asset to Transfer")
                {
                    ApplicationArea = All;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
            group("Transfer From")
            {
                Caption = 'Transfer From';
                Editable = FieldEditable;
                field("From Location"; Rec."From Location")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("From Responsible Employee"; Rec."From Responsible Employee")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("From Employee Name"; Rec."From Employee Name")
                {
                    Editable = false;
                    ShowCaption = false;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("From Dimension 1 Code"; Rec."From Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("From Dimension 2 Code"; Rec."From Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Transfer To")
            {
                Caption = 'Transfer To';
                Editable = FieldEditable;
                field("To Location"; Rec."To Location")
                {
                    ShowMandatory = false;
                    ApplicationArea = All;
                }
                field("Destination/Location"; Rec."Destination/Location")
                {
                    ApplicationArea = All;
                }
                field("To Responsible Employee"; Rec."To Responsible Employee")
                {
                    ShowMandatory = false;
                    ApplicationArea = All;
                }
                field("To Employee Name"; Rec."To Employee Name")
                {
                    Editable = false;
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field("To Dimension 1 Code"; Rec."To Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("To Dimension 2 Code"; Rec."To Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Approval Request")
            {
                Caption = 'Approval Request';
                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Transfer Type");

                        IF Rec."Transfer Type" = Rec."Transfer Type"::External THEN BEGIN
                            IF Rec."Destination/Location" = '' THEN
                                ERROR('You must specify Destination/Location where item is going To');
                        END;

                        //     IF ApprovalsMgmt.CheckAssetTransferApprovalsWorkflowEnabled(Rec) THEN
                        //       ApprovalsMgmt.OnSendAssetTransferForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // ApprovalsMgmt.OnCancelAssetTransferForApproval(Rec);
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
                    //ApprovalsMgmt: Codeunit 1535;
                    begin

                        //ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID)
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit 1535;
                    begin
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
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
                        Rec.SETFILTER("No.", Rec."No.");
                        // REPORT.RUN(REPORT::"Asset Transfer",TRUE,TRUE,Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        UpdateControls;
        UpdateControlsTwo;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        Txt001: Label 'Do you want to effect the transfer';
        Txt002: Label 'Asset %1 Successfully Transferred';
        FA: Record 5600;
        FieldEditable: Boolean;
        ActionVisible: Boolean;
        //ApprovalsMgmt: Codeunit 1535;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        TolocationEditable: Boolean;
        ToResponsibleEmployee: Boolean;

    local procedure UpdateControls()
    begin
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            FieldEditable := FALSE;
            ActionVisible := FALSE;
        END ELSE BEGIN
            FieldEditable := TRUE;
            ActionVisible := TRUE;
        END;
    end;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    end;

    local procedure UpdateControlsTwo()
    begin
        IF Rec."Transfer Type" = Rec."Transfer Type"::External THEN BEGIN
            TolocationEditable := TRUE;
            ToResponsibleEmployee := TRUE;
            CurrPage.UPDATE;
        END ELSE BEGIN
            TolocationEditable := FALSE;
            ToResponsibleEmployee := FALSE;
            CurrPage.UPDATE;
        END;
    end;
}

