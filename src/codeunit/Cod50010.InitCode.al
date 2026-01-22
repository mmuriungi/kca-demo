codeunit 50010 "Init Code"
{
    trigger OnRun()
    begin

    end;


    //Imprest 
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendImprestforApproval(VAR Imprest: Record "FIN-Imprest Header");
    begin
    end;

    procedure IsImprestEnabled(var Imprest: Record "FIN-Imprest Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(Imprest, WFCode.RunWorkflowOnSendImprestApprovalCode()))
    end;

    procedure CheckImprestWorkflowEnabled(): Boolean
    var
        Imprest: Record "FIN-Imprest Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
         ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsImprestEnabled(Imprest) then
            Error(NoWorkflowEnb);
    end;
    //End of Imprest


    //payment Vouchers Approvals
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendPVSforApproval(VAR PVS: Record "FIN-Payments Header");
    begin
    end;

    procedure IsPVSEnabled(var PVS: Record "FIN-Payments Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(PVS, WFCode.RunWorkflowOnSendPVSApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        PVS: Record "FIN-Payments Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsPVSEnabled(PVS) then
            Error(NoWorkflowEnb);
    end;




    //Claims Workflow
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendClaimforApproval(VAR Claims: Record "FIN-Staff Claims Header");
    begin
    end;

    procedure IsClaimsEnabled(var Claims: Record "FIN-Staff Claims Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(Claims, WFCode.RunWorkflowOnSendClaimApprovalCode()))
    end;

    local procedure CheckClaimsWorkflowEnabled(): Boolean
    var
        Claims: Record "FIN-Staff Claims Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsClaimsEnabled(Claims) then
            Error(NoWorkflowEnb);
    end;

    //Inter Bank Transfer
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendInterBankforApproval(VAR InterBank: Record "FIN-InterBank Transfers");
    begin
    end;

    procedure IsInterBankEnabled(var InterBank: Record "FIN-InterBank Transfers"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(InterBank, WFCode.RunWorkflowOnSendInterBankApprovalCode()))
    end;

    local procedure CheckInterBankWorkflowEnabled(): Boolean
    var
        InterBank: Record "FIN-InterBank Transfers";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
         ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsInterBankEnabled(InterBank) then
            Error(NoWorkflowEnb);
    end;

    //End Inter Bank Transfer

    //Purchase Quotes
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendPurchQuoteforApproval(VAR PurchQuote: Record "PROC-Purchase Quote Header");
    begin
    end;

    procedure IsPurchQuoteEnabled(var PurchQuote: Record "PROC-Purchase Quote Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(PurchQuote, WFCode.RunWorkflowOnSendPurchQuoteApprovalCode()))
    end;

    local procedure CheckPurchQuoteWorkflowEnabled(): Boolean
    var
        PurchQuote: Record "PROC-Purchase Quote Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
         ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsPurchQuoteEnabled(PurchQuote) then
            Error(NoWorkflowEnb);
    end;

    //End Purchase Quotes



    ///////////////////////**************************POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry");
    //WorkflowStepInstance: Record "Workflow Step Instance") commented
    var
        payHeader: Record "Fin-Payments Header";
        imprestHeader: Record "FIN-Imprest Header";
        InterBankTransfers: Record "FIN-InterBank Transfers";
        StaffClaims: Record "FIN-Staff Claims Header";
        PurchaseRequisition: Record "Purchase Header";
        PurchQuote: Record "PROC-Purchase Quote Header";

    begin
        case
            RecRef.Number of
            Database::"FIN-Payments Header":
                begin
                    RecRef.SetTable(payHeader);
                    ApprovalEntryArgument."Document No." := payHeader."No.";

                end;
            Database::"FIN-Imprest Header":
                begin
                    RecRef.SetTable(imprestHeader);
                    ApprovalEntryArgument."Document No." := imprestHeader."No.";
                end;
            Database::"FIN-InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTransfers);
                    ApprovalEntryArgument."Document No." := InterBankTransfers.No;
                end;
            Database::"FIN-Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    ApprovalEntryArgument."Document No." := StaffClaims."No.";
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseRequisition);
                    ApprovalEntryArgument."Document No." := PurchaseRequisition."No.";
                end;
            Database::"PROC-Purchase Quote Header":
                begin
                    RecRef.SetTable(PurchQuote);
                    ApprovalEntryArgument."Document No." := PurchQuote."No.";
                end;

        end;
    end;

    //////////////////////**************************END OF POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    /// 
    /// 
    /// 
    /// //////////////////************************CANCELLING OF PROCESSES**********************************/////////////////////


    //cancelling of payment vouchers
    [IntegrationEvent(false, false)]
    procedure OnCancelPVSForApproval(var PVS: Record "FIN-Payments Header")
    begin

    end;
    //End cancel of Payment vouchers

    //cancelling of Imprest
    [IntegrationEvent(false, false)]
    procedure OnCancelImprestForApproval(var Imprest: Record "FIN-Imprest Header")
    begin

    end;
    //End cancel of Imprest

    //cancelling of Cliam
    [IntegrationEvent(false, false)]
    procedure OnCancelClaimForApproval(VAR Claims: Record "FIN-Staff Claims Header")
    begin

    end;
    //End cancel of Claim

    //Cancel Inter Bank Transfer
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelInterBankforApproval(VAR InterBank: Record "FIN-InterBank Transfers");
    begin
    end;

    //End cancel interbank transfer

    //Cancel Purchase Quotes
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelPurchQuoteforApproval(VAR PurchQuote: Record "PROC-Purchase Quote Header");
    begin
    end;
    // End Cancel of purchase Quotes


}


