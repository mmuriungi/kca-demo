codeunit 54202 "Init CodeUnit"

{
    trigger OnRun()
    begin

    end;


    //Imprest 


    [IntegrationEvent(false, false)]
    PROCEDURE OnSendTransportReqforApproval(VAR TransportReq: Record "FLT-Transport Requisition");
    begin
    end;

    procedure IsTransportReqEnabled(var TransportReq: Record "FLT-Transport Requisition"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "WorkFlow Code";
    begin
        exit(WFMngt.CanExecuteWorkflow(TransportReq, WFCode.RunWorkflowOnSendTransportReqApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        TransportReq: Record "FLT-Transport Requisition";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsTransportReqEnabled(TransportReq) then
            Error(NoWorkflowEnb);
    end;


    //Claims Workflow

    //"Pharmacy Requests Header"
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendPharmRequestsforApproval(VAR PharmRequests: Record "Pharmacy Requests Header");
    begin
    end;

    procedure IsPharmRequestsEnabled(var PharmRequests: Record "Pharmacy Requests Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Workflow Code";
    begin
        exit(WFMngt.CanExecuteWorkflow(PharmRequests, WFCode.RunWorkflowOnSendPharmRequestsApprovalCode()))
    end;

    local procedure CheckPharmRequestsWorkflowEnabled(): Boolean
    var
        PharmRequests: Record "Pharmacy Requests Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsPharmRequestsEnabled(PharmRequests) then
            Error(NoWorkflowEnb);
    end;
    //Cancel "Pharmacy Requests Header"
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelPharmRequestsforApproval(VAR PharmRequests: Record "Pharmacy Requests Header");
    begin
    end;
    //End Cancel "Pharmacy Requests Header"
    //"Pharmacy Requests Header"




    ///////////////////////**************************POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry");
    //WorkflowStepInstance: Record "Workflow Step Instance") commented
    var

        TransportReq: Record "FLT-Transport Requisition";
        PharmRequests: Record "Pharmacy Requests Header";
    begin
        case
            RecRef.Number of

            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(TransportReq);
                    ApprovalEntryArgument."Document No." := TransportReq."Transport Requisition No";
                    //  ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PharmRequests);
                    ApprovalEntryArgument."Document No." := PharmRequests."No.";
                end;
        end;
    end;

    //////////////////////**************************END OF POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    /// 
    /// 
    /// 
    /// //////////////////************************CANCELLING OF PROCESSES**********************************/////////////////////


    //cancelling of Transport
    [IntegrationEvent(false, false)]
    procedure OnCancelTransportReqForApproval(var TransportReq: Record "FLT-Transport Requisition")
    begin

    end;
    //End cancel of Transport



}



