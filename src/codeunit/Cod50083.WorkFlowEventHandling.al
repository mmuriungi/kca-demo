codeunit 50083 WorkFlowEventHandling
{
    /* ====================================================== Global =============================================================== */

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        MemoImprestSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Memo Imprest is Requested';

        MemoImprestApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Memo Imprest is Canceled';
        /* Internal Audit Workplan */
        InternalAuditWorkplanSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Internal Audit Workplan Document is requested';
        InternalAuditWorkplanApprovalRequestCncelEventDescTxt: TextConst ENU = 'Approval of a Internal Audit Workplan Document is canceled';
        /* Incoming Mail */
        IncomingMailSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Incoming Mail is requested';
        IncomingMailApprovalRequestCncelEventDescTxt: TextConst ENU = 'Approval of a Incoming Mail is canceled';
        /* Transport Requisition */
        TransportRequisitionSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Transport Requisition Document is requested';
        TransportRequisitionApprovalRequestCncelEventDescTxt: TextConst ENU = 'Approval of a Transport Requisition Document is canceled';
        /* Risk Register */
        RiskRegisterSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Risk Register Document is requested';
        RiskRegisterApprovalRequestCncelEventDescTxt: TextConst ENU = 'Approval of a Risk Register Document is canceled';
        /* Scholarship Application */
        ScholarshipApplicationSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Scholarship Application is Requested';
        ScholarshipApplicationRequestCncelEventDescTxt: TextConst ENU = 'Approval of Scholarship Application is Canceled';

        /* MTI Score */
        MTIScoreSendForApprovalEventDescTxt: TextConst ENU = 'Approval of MTI Score is Requested';
        MTIScoreRequestCncelEventDescTxt: TextConst ENU = 'Approval of MTI Score is Canceled';

        /* Institution Return */
        InstitutionReturnSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Institution Return is Requested';
        InstitutionReturnRequestCncelEventDescTxt: TextConst ENU = 'Approval of Institution Return is Canceled';
        /* Scholarship Disbursement */
        ScholarshipDisbursementSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Scholarship Disbursement is Requested';
        ScholarshipDisbursementRequestCancelEventDescTxt: TextConst ENU = 'Approval of Scholarship Disbursement is Canceled';
        /* ICT Support Desk */
        ICTSupportSendForApprovalEventDescTxt: TextConst ENU = 'Approval of ICT Support is Requested';
        ICTSupportRequestCancelEventDescTxt: TextConst ENU = 'Approval of ICT Support is Canceled';


    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelMemoImprestForApprovalCode(), Database::"FIN-Memo Header", MemoImprestApprovalRequestCancelEventDescTxt, 0, false);
        //WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendMemoImprestForApprovalCode, Database::"FIN-Memo Header", MemoImprestSentForApprovalEventDescTxt, 0, false);
        /*Internal Audit Workplan*/


    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]

    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        /* Memo Imprest */
        case EventFunctionName of
            RunWorkflowOnCancelMemoImprestForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelMemoImprestForApprovalCode, RunWorkflowOnSendMemoImprestForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemoImprestForApprovalCode);
        end;
        /* Internal Audit Workplan */
        case EventFunctionName of
            RunWorkflowOnCancelInternalAuditWorkplanApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelInternalAuditWorkplanApprovalCode, RunWorkflowOnSendInternalAuditWorkplanForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInternalAuditWorkplanForApprovalCode);
        end;
        /* Incoming Mail */
        case EventFunctionName of
            RunWorkflowOnCancelIncomingMailApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelIncomingMailApprovalCode, RunWorkflowOnSendIncomingMailForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendIncomingMailForApprovalCode);
        end;
        /* Transport Requisition */
        case EventFunctionName of
            RunWorkflowOnCancelTransportRequisitionApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelTransportRequisitionApprovalCode, RunWorkflowOnSendTransportRequisitionForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTransportRequisitionForApprovalCode);
        end;
        /* Risk Register */
        case EventFunctionName of
            RunWorkflowOnCancelRiskRegisterApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRiskRegisterApprovalCode, RunWorkflowOnSendRiskRegisterForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRiskRegisterForApprovalCode);
        end;
        /* Scholarship Application */
        case EventFunctionName of
            RunWorkflowOnCancelScholarshipApplicationCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelScholarshipApplicationCode, RunWorkflowOnSendScholarshipApplicationForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendScholarshipApplicationForApprovalCode);
        end;
        /* MTI Score */
        case EventFunctionName of
            RunWorkflowOnCancelMTIScoreCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelMTIScoreCode, RunWorkflowOnSendMTIScoreForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMTIScoreForApprovalCode);
        end;
        /* Institution Return */
        case EventFunctionName of
            RunWorkflowOnCancelInstitutionReturnCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelInstitutionReturnCode, RunWorkflowOnSendInstitutionReturnForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInstitutionReturnForApprovalCode);
        end;
        /* Scholarship Disbursement */
        case EventFunctionName of
            RunWorkflowOnCancelScholarshipDisbursementCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelScholarshipDisbursementCode, RunWorkflowOnSendScholarshipDisbursementForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendScholarshipDisbursementForApprovalCode);
        end;
        /* ICT Support Desk */
        case EventFunctionName of
            RunWorkflowOnCancelICTSupportCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelICTSupportCode, RunWorkflowOnSendICTSupportForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendICTSupportForApprovalCode);
        end;

    end;

    /* ICT Support Desk */
    procedure RunWorkflowOnSendICTSupportForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendICTSupportForApproval'));
    end;



    procedure RunWorkflowOnCancelICTSupportCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelICTSupport'));
    end;



    /* Memo Imprest */
    procedure RunWorkFlowOnSendMemoImprestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendSendMemoImprestForApproval'))
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendMemoImprestForApproval', '', true, true)]
    // local procedure RunWorkflowOnSendMemoImprestForApproval(Var MemoImprest: Record "FIN-Memo Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendMemoImprestForApprovalCode, MemoImprest)
    // end;

    procedure RunWorkFlowOnCancelMemoImprestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelMemoImprestForApproval'))
    end;
    /* Incoming Mail */
    procedure RunWorkflowOnSendIncomingMailForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendIncomingMailForApproval'));
    end;

    local procedure RunWorkflowOnSendIncomingMailForApproval(Var IncomingMail: Record "Incoming Mail")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendIncomingMailForApprovalCode, IncomingMail)
    end;

    procedure RunWorkflowOnCancelIncomingMailApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelIncomingMailApproval'));
    end;




    local procedure RunWorkflowOnCancelIncomingMailApproval(Var IncomingMail: Record "Incoming Mail")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelIncomingMailApprovalCode, IncomingMail);
        IncomingMail.Reset();
        IncomingMail.SetRange("Ref No", IncomingMail."Ref No");
        if IncomingMail.FindFirst() then begin
            IncomingMail.Status := IncomingMail.Status::Open;
            IncomingMail.Modify()
        end;
    end;

    /* Internal Audit Workplan */
    procedure RunWorkflowOnSendInternalAuditWorkplanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendInternalAuditWorkplanForApproval'));
    end;



    procedure RunWorkflowOnCancelInternalAuditWorkplanApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInternalAuditWorkplanApproval'));
    end;


    /* Transport Requisition */
    procedure RunWorkflowOnSendTransportRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTransportRequisitionForApproval'));
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendTransportRequisitionForApproval', '', true, true)]
    local procedure RunWorkflowOnSendTransportRequisitionForApproval(Var TransportRequisition: Record "FLT-Transport Requisition")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportRequisitionForApprovalCode, TransportRequisition)
    end;

    procedure RunWorkflowOnCancelTransportRequisitionApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTransportRequisitionApproval'));
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelTransportRequisitionForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelTransportRequisitionApproval(Var TransportRequisition: Record "FLT-Transport Requisition")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportRequisitionApprovalCode, TransportRequisition);
        TransportRequisition.Reset();
        TransportRequisition.SetRange("Transport Requisition No", TransportRequisition."Transport Requisition No");
        if TransportRequisition.FindFirst() then begin
            TransportRequisition.Status := TransportRequisition.Status::Open;
            TransportRequisition.Modify()
        end;
    end;
    /* Risk Register */
    procedure RunWorkflowOnSendRiskRegisterForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendRiskRegisterForApproval'));
    end;



    procedure RunWorkflowOnCancelRiskRegisterApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelRiskRegisterApproval'));
    end;



    /* Scholarship Application */
    procedure RunWorkflowOnSendScholarshipApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendScholarshipApplicationForApproval'));
    end;



    procedure RunWorkflowOnCancelScholarshipApplicationCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelScholarshipApplication'));
    end;



    /* MTI Score */
    procedure RunWorkflowOnSendMTIScoreForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMTIScoreForApproval'));
    end;



    procedure RunWorkflowOnCancelMTIScoreCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMTIScore'));
    end;




    /* Institution Return */
    procedure RunWorkflowOnSendInstitutionReturnForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendInstitutionReturnForApproval'));
    end;



    procedure RunWorkflowOnCancelInstitutionReturnCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInstitutionReturn'));
    end;


    /* Scholarship Disbursement */
    procedure RunWorkflowOnSendScholarshipDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendScholarshipDisbursementForApproval'));
    end;



    procedure RunWorkflowOnCancelScholarshipDisbursementCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelScholarshipDisbursement'));
    end;




    /* ********************************************************************************************************************************************* */

    procedure RunWorkflowOnSendBContrForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendBContrForApproval'));
    end;

    procedure RunWorkflowOnCancelBContrApprovalRequestCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelBContrApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseBContrCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseBContr'));
    end;

}
