/// <summary>
/// Codeunit Appraisal Workflow (ID 50007).
/// </summary>
codeunit 51320 "Appraisal Workflow"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        //Appraisal Start
        SendAppraisalReq: TextConst ENU = 'Approval Request for Appraisal   is requested',
                                ENG = 'Approval Request for Appraisal is requested';
        AppReqAppraisal: TextConst ENU = 'Approval Request for Appraisal is approved',
                                ENG = 'Approval Request for Appraisal  is approved';
        RejReqAppraisal: TextConst ENU = 'Approval Request for Appraisal  is rejected',
                                ENG = 'Approval Request for Appraisal  is rejected';
        DelReqAppraisal: TextConst ENU = 'Approval Request for Appraisal is delegated',
                                ENG = 'Approval Request for Appraisal  is delegated';
        CancelAppraisal: TextConst ENU = 'Approval Request for Appraisal  is Cancelled By User',
                                ENG = 'Approval Request for Appraisal  is Cancelled By User';
        SendAppraisalForPendAppTxt: TextConst ENU = 'Status of Appraisal changed to Pending approval',
                                        ENG = 'Status of Appraisal changed to Pending approval';
        ReleaseAppraisalTxt: TextConst ENU = 'Release Appraisal', ENG = 'Release Appraisal';
        ReOpenAppraisalTxt: TextConst ENU = 'ReOpen Appraisal', ENG = 'ReOpen Appraisal';


    //Appraisal
    /// <summary>
    /// RunWorkflowOnSendAppraisalApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnSendAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendAppraisalApproval'))
    end;

    /// <summary>
    /// RunWorkflowOnSendAppraisalApproval.
    /// </summary>
    /// <param name="Appraisal">VAR Record Appraisal.</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Appraisal Init", 'OnSendAppraisalforApproval', '', false, false)]
    procedure RunWorkflowOnSendAppraisalApproval(var Appraisal: Record Appraisal)
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendAppraisalApprovalCode(), Appraisal);
    end;

    /// <summary>
    /// RunWorkflowOnApproveAppraisalApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnApproveAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveAppraisalApproval'))
    end;

    /// <summary>
    /// RunWorkflowOnApproveAppraisalApproval.
    /// </summary>
    /// <param name="ApprovalEntry">VAR Record "Approval Entry".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveAppraisalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveAppraisalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    /// <summary>
    /// RunWorkflowOnRejectAppraisalApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnRejectAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectAppraisalApproval'))
    end;

    /// <summary>
    /// RunWorkflowOnRejectAppraisalApproval.
    /// </summary>
    /// <param name="ApprovalEntry">VAR Record "Approval Entry".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectAppraisalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectAppraisalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    /// <summary>
    /// RunWorkflowOnDelegateAppraisalApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnDelegateAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateAppraisalApproval'))
    end;

    /// <summary>
    /// RunWorkflowOnDelegateAppraisalApproval.
    /// </summary>
    /// <param name="ApprovalEntry">VAR Record "Approval Entry".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateAppraisalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateAppraisalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    /// <summary>
    /// RunWorkflowOnCancelAppraisalApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelAppraisalApproval'))
    end;

    /// <summary>
    /// RunWorkflowOnCancelAppraisalApproval.
    /// </summary>
    /// <param name="HRMAppraisalReq">VAR Record Appraisal.</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Appraisal Init", 'OnCancelAppraisalforApproval', '', false, false)]
    procedure RunWorkflowOnCancelAppraisalApproval(var Appraisal: Record Appraisal)
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelAppraisalApprovalCode(), Appraisal);
    end;

    /// <summary>
    /// SetStatusToPendingApprovalCodeAppraisal.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure SetStatusToPendingApprovalCodeAppraisal(): Code[128]
    begin
        exit(UpperCase('Set Status To PendingApproval on Appraisal'));
    end;

    /// <summary>
    /// SetStatusToPendingApprovalAppraisal.
    /// </summary>
    /// <param name="Variant">VAR Variant.</param>
    procedure SetStatusToPendingApprovalAppraisal(var Variant: Variant)
    var
        RecRef: RecordRef;
        Appraisal: Record Appraisal;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::Appraisal:
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Validate(Status, Appraisal.Status::"Pending Approval");
                    Appraisal.Modify();
                    Variant := Appraisal;
                end;
        end;
    end;

    /// <summary>
    /// ReleaseAppraisalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure ReleaseAppraisalCode(): Code[128]
    begin
        exit(UpperCase('Release Appraisal Requisition'));
    end;

    /// <summary>
    /// ReleaseAppraisal.
    /// </summary>
    /// <param name="Variant">VAR Variant.</param>
    procedure ReleaseAppraisal(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Appraisal: Record Appraisal;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseAppraisal(Variant);
                end;
            DATABASE::Appraisal:
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Validate(Status, Appraisal.Status::Approved);
                    Appraisal.Modify();
                    Variant := Appraisal;
                end;
        end;
    end;

    /// <summary>
    /// ReOpenAppraisalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure ReOpenAppraisalCode(): Code[128]
    begin
        exit(UpperCase('ReOpen Appraisal'));
    end;

    /// <summary>
    /// ReOpenAppraisal.
    /// </summary>
    /// <param name="Variant">VAR Variant.</param>
    procedure ReOpenAppraisal(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Appraisal: Record Appraisal;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenAppraisal(Variant);
                end;
            DATABASE::Appraisal:
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Validate(Status, Appraisal.Status::open);
                    Appraisal.Modify();
                    Variant := Appraisal;
                end;
        end;
    end;

    /// <summary>
    /// AddAppraisalEventToLibrary.
    /// </summary>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddAppraisalEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendAppraisalApprovalCode(), Database::Appraisal, SendAppraisalReq, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveAppraisalApprovalCode(), Database::"Approval Entry", AppReqAppraisal, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveAppraisalApprovalCode(), Database::"Approval Entry", ReOpenAppraisalTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectAppraisalApprovalCode(), Database::"Approval Entry", RejReqAppraisal, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateAppraisalApprovalCode(), Database::"Approval Entry", DelReqAppraisal, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAppraisalApprovalCode(), Database::"Approval Entry", CancelAppraisal, 0, false);
    end;

    /// <summary>
    /// AddAppraisalRespToLibrary.
    /// </summary>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddAppraisalRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeAppraisal(), 0, SendAppraisalForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseAppraisalCode(), 0, ReleaseAppraisalTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenAppraisalCode(), 0, ReOpenAppraisalTxt, 'GROUP 0');
    end;

    /// <summary>
    /// ExeRespForAppraisal.
    /// </summary>
    /// <param name="ResponseExecuted">VAR Boolean.</param>
    /// <param name="Variant">Variant.</param>
    /// <param name="xVariant">Variant.</param>
    /// <param name="ResponseWorkflowStepInstance">Record "Workflow Step Instance".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForAppraisal(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeAppraisal():
                    begin
                        SetStatusToPendingApprovalAppraisal(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseAppraisalCode():
                    begin
                        ReleaseAppraisal(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenAppraisalCode():
                    begin
                        ReOpenAppraisal(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;




}
