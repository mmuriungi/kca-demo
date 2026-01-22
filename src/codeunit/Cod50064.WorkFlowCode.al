codeunit 50064 "WorkFlow Code"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        // AppMgmt: Codeunit "Approvals Management 2";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";

        //PVS

        // //Start Transport Requisition
        // SendTransportReq: TextConst ENU = 'Approval Request for Transport is requested', ENG = 'Approval Request for Transport is requested';
        // AppTransportReq: TextConst ENU = 'Approval Request for Transport is approved', ENG = 'Approval Request for Transport is approved';
        // RejTransportReq: TextConst ENU = 'Approval Request for Transport is rejected', ENG = 'Approval Request for Transport is rejected';
        // CancelTransportReq: TextConst ENU = 'Approval Request for Transport is cancelled', ENG = 'Approval Request for Transport is cancelled';

        // DelTransportReq: TextConst ENU = 'Approval Request for Transport is delegated', ENG = 'Approval Request for Transport is delegated';
        // SendForPendingTransTxt: TextConst ENU = 'Status of Transport changed to Pending approval',
        //                                 ENG = 'Status of Transport changed to Pending approval';
        // ReleaseTransportReqTxt: TextConst ENU = 'Release Transport', ENG = 'Release Transport';
        // ReOpenTransportReqTxt: TextConst ENU = 'ReOpen Transport', ENG = 'ReOpen Transport';
        // UserCancelTransportReq: TextConst ENU = 'Approval Request for Transport is cancelled by user', ENG = 'Approval Request for Transport is cancelled by user';

        //PharmRequests REssponses

        //PharmRequestsS
        SendPharmRequestsReq: TextConst ENU = 'Approval Request for PharmRequests is requested', ENG = 'Approval Request for PharmRequests is requested';
        AppReqPharmRequests: TextConst ENU = 'Approval Request for PharmRequests is approved', ENG = 'Approval Request for PharmRequests is approved';
        RejReqPharmRequests: TextConst ENU = 'Approval Request for PharmRequests is rejected', ENG = 'Approval Request for PharmRequests is rejected';
        CanReqPharmRequests: TextConst ENU = 'Approval Request for PharmRequests is cancelled', ENG = 'Approval Request for PharmRequests is cancelled';
        UserCanReqPharmRequests: TextConst ENU = 'Approval Request for PharmRequests is cancelled by User', ENG = 'Approval Request for PharmRequests is cancelled by User';
        DelReqPharmRequests: TextConst ENU = 'Approval Request for PharmRequests is delegated', ENG = 'Approval Request for PharmRequests is delegated';
        PharmRequestsPendAppTxt: TextConst ENU = 'Status of PharmRequests changed to Pending approval', ENG = 'Status of PharmRequests changed to Pending approval';
        ReleasePharmRequestsTxt: TextConst ENU = 'Release PharmRequests', ENG = 'Release PharmRequests';
        ReOpenPharmRequestsTxt: TextConst ENU = 'ReOpen PharmRequests', ENG = 'ReOpen PharmRequests';
    //END PharmRequestsS
    //End PharmRequests Responses 

    //PVS WF Code

    // procedure RunWorkflowOnSendTransportReqApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendTransportReqApproval'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init CodeUnit", 'OnSendTransportReqforApproval', '', false, false)]
    // procedure RunWorkflowOnSendTransportReqApproval(var TransportReq: Record "FLT-Transport Requisition")
    // begin
    //     WFMngt.HandleEvent(RunWorkflowOnSendTransportReqApprovalCode(), TransportReq);

    // end;

    // procedure RunWorkflowOnApproveTransportReqApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnApproveTransportReqApproval'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnApproveTransportReqApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveTransportReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnRejectTransportReqApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnRejectTransportReqApproval'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnRejectTransportReqApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectTransportReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnCancelledTransportReqApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnRejectTransportReqApproval'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnCancelledTransportReqApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledTransportReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure RunWorkflowOnDelegateTransportReqApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnDelegateTransportReqApproval'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnDelegateTransportReqApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateTransportReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;

    // procedure SetStatusToPendingApprovalCodeTransportReq(): Code[128]
    // begin
    //     exit(UpperCase('SetStatusToPendingApprovalTransportReq'));
    // end;

    // procedure SetStatusToPendingApprovalTransportReq(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     TransportReq: Record "FLT-Transport Requisition";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"FLT-Transport Requisition":
    //             begin
    //                 RecRef.SetTable(TransportReq);
    //                 TransportReq.Validate(Status, TransportReq.Status::"Pending Approval");
    //                 TransportReq.Modify();
    //                 Variant := TransportReq;
    //             end;
    //     end;
    // end;

    // procedure ReleaseTransportReqCode(): Code[128]
    // begin
    //     exit(UpperCase('ReleaseTransportReq'));
    // end;

    // procedure ReleaseTransportReq(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     TargetRecRef: RecordRef;
    //     ApprovalEntry: Record "Approval Entry";
    //     TransportReq: Record "FLT-Transport Requisition";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"Approval Entry":
    //             begin
    //                 ApprovalEntry := Variant;
    //                 TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
    //                 Variant := TargetRecRef;
    //                 ReleaseTransportReq(Variant);
    //             end;
    //         DATABASE::"FLT-Transport Requisition":
    //             begin
    //                 RecRef.SetTable(TransportReq);
    //                 TransportReq.Validate(Status, TransportReq.Status::Approved);
    //                 TransportReq.Modify();
    //                 Variant := TransportReq;
    //             end;
    //     end;
    // end;

    // procedure ReOpenTransportReqCode(): Code[128]
    // begin
    //     exit(UpperCase('ReOpenTransportReq'));
    // end;

    // procedure ReOpenTransportReq(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     TargetRecRef: RecordRef;
    //     ApprovalEntry: Record "Approval Entry";
    //     TransportReq: Record "FLT-Transport Requisition";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"Approval Entry":
    //             begin
    //                 ApprovalEntry := Variant;
    //                 TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
    //                 Variant := TargetRecRef;
    //                 ReOpenTransportReq(Variant);
    //             end;
    //         DATABASE::"FLT-Transport Requisition":
    //             begin
    //                 RecRef.SetTable(TransportReq);
    //                 TransportReq.Validate(Status, TransportReq.Status::Open);
    //                 TransportReq.Modify();
    //                 Message('Hi there');
    //                 Variant := TransportReq;
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    // procedure AddTransportReqEventToLibrary()
    // begin
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTransportReqApprovalCode(), Database::"FLT-Transport Requisition", SendTransportReq, 0, false);
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveTransportReqApprovalCode(), Database::"Approval Entry", AppTransportReq, 0, false);
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectTransportReqApprovalCode(), Database::"Approval Entry", RejTransportReq, 0, false);
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateTransportReqApprovalCode(), Database::"Approval Entry", DelTransportReq, 0, false);
    //     WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledTransportReqApprovalCode(), Database::"Approval Entry", CancelTransportReq, 0, false);
    //     //cancelling of douments
    //     WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTransportReqApprovalCode, Database::"FLT-Transport Requisition", UserCancelTransportReq, 0, false);


    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    // procedure AddTransportReqRespToLibrary()
    // begin

    //     WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeTransportReq(), 0, SendForPendingTransTxt, 'GROUP 0');
    //     WorkflowResponseHandling.AddResponseToLibrary(ReleaseTransportReqCode(), 0, ReleaseTransportReqTxt, 'GROUP 0');
    //     WorkflowResponseHandling.AddResponseToLibrary(ReOpenTransportReqCode(), 0, ReOpenTransportReqTxt, 'GROUP 0');
    //     // try me WorkflowResponseHandling.AddResponseToLibrary(ReOpenPVSCode(), 0, ReOpenPVSTxt, 'GROUP 0');
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    // procedure ExeRespForTransportReq(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    // var
    //     WorkflowResponse: Record "Workflow Response";

    // begin
    //     IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
    //         case WorkflowResponse."Function Name" of
    //             SetStatusToPendingApprovalCodeTransportReq():
    //                 begin
    //                     SetStatusToPendingApprovalTransportReq(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //             ReleaseTransportReqCode():
    //                 begin
    //                     ReleaseTransportReq(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //             ReOpenTransportReqCode():
    //                 begin
    //                     ReOpenTransportReq(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //         end;
    // end;




    /// //////////////////************************CANCELLING OF PROCESSES**********************************/////////////////////
    /// 
    /// 
    /// 
    //Cancelling of Transport
    // procedure RunWorkflowOnCancelTransportReqApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelTransportReqApproval'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init CodeUnit", 'OnCancelTransportReqForApproval', '', false, false)]
    // procedure RunWorkflowOnCancelTransportReqApproval(var TransportReq: Record "FLT-Transport Requisition")
    // begin

    //     WFMngt.HandleEvent(RunWorkflowOnCancelTransportReqApprovalCode(), TransportReq);

    // end;
    //End cancelling Transport


    //Start PharmRequests Workflow
    procedure RunWorkflowOnSendPharmRequestsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPharmRequestsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init CodeUnit", 'OnSendPharmRequestsforApproval', '', false, false)]
    procedure RunWorkflowOnSendPharmRequestsApproval(var PharmRequests: Record "Pharmacy Requests Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPharmRequestsApprovalCode(), PharmRequests);
    end;

    procedure RunWorkflowOnApprovePharmRequestsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePharmRequestsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePharmRequestsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePharmRequestsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectPharmRequestsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPharmRequestsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPharmRequestsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPharmRequestsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledPharmRequestsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPharmRequestsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledPharmRequestsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledPharmRequestsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegatePharmRequestsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePharmRequestsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePharmRequestsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePharmRequestsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodePharmRequests(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalPharmRequests'));
    end;

    procedure SetStatusToPendingApprovalPharmRequests(var Variant: Variant)
    var
        RecRef: RecordRef;
        PharmRequests: Record "Pharmacy Requests Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PharmRequests);
                    PharmRequests.Validate(Status, PharmRequests.Status::"Pending Approval");
                    PharmRequests.Modify();
                    Variant := PharmRequests;
                end;
        end;
    end;

    procedure ReleasePharmRequestsCode(): Code[128]
    begin
        exit(UpperCase('Release PharmRequests'));
    end;

    procedure ReleasePharmRequests(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PharmRequests: Record "Pharmacy Requests Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleasePharmRequests(Variant);
                end;
            DATABASE::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PharmRequests);
                    PharmRequests.Validate(Status, PharmRequests.Status::Approved);
                    PharmRequests.postRequisition();
                    //PharmRequests.Modify();
                    Variant := PharmRequests;
                end;
        end;
    end;

    procedure ReOpenPharmRequestsCode(): Code[128]
    begin
        exit(UpperCase('ReOpenPharmRequests'));
    end;

    procedure ReOpenPharmRequests(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PharmRequests: Record "Pharmacy Requests Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenPharmRequests(Variant);
                end;
            DATABASE::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PharmRequests);
                    PharmRequests.Validate(Status, PharmRequests.Status::Pending);
                    PharmRequests.Modify();
                    Variant := PharmRequests;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddPharmRequestsEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPharmRequestsApprovalCode(), Database::"Pharmacy Requests Header", SendPharmRequestsReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePharmRequestsApprovalCode(), Database::"Approval Entry", AppReqPharmRequests, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPharmRequestsApprovalCode(), Database::"Approval Entry", RejReqPharmRequests, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePharmRequestsApprovalCode(), Database::"Approval Entry", DelReqPharmRequests, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledPharmRequestsApprovalCode(), Database::"Approval Entry", CanReqPharmRequests, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPharmRequestsApprovalCode, Database::"Pharmacy Requests Header", UserCanReqPharmRequests, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddPharmRequestsRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodePharmRequests(), 0, PharmRequestsPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleasePharmRequestsCode(), 0, ReleasePharmRequestsTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenPharmRequestsCode(), 0, ReOpenPharmRequestsTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForPharmRequests(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodePharmRequests():
                    begin
                        SetStatusToPendingApprovalPharmRequests(Variant);
                        ResponseExecuted := true;
                    end;
                ReleasePharmRequestsCode():
                    begin
                        ReleasePharmRequests(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenPharmRequestsCode():
                    begin
                        ReOpenPharmRequests(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Cancelling of PharmRequests Code
    procedure RunWorkflowOnCancelPharmRequestsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPharmRequestsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init CodeUnit", 'OnCancelPharmRequestsForApproval', '', false, false)]
    procedure RunWorkflowOnCancelPharmRequestsApproval(VAR PharmRequests: Record "Pharmacy Requests Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelPharmRequestsApprovalCode(), PharmRequests);

    end;
    //End Cancelling PharmRequests Code

    //End PharmRequests Workflow

}
