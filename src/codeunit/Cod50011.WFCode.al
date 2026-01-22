codeunit 50011 WFCode
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

        SendPVSReq: TextConst ENU = 'Approval Request for PVS is requested', ENG = 'Approval Request for PVS is requested';
        AppReqPVS: TextConst ENU = 'Approval Request for PVS is approved', ENG = 'Approval Request for PVS is approved';
        RejReqPVS: TextConst ENU = 'Approval Request for PVS is rejected', ENG = 'Approval Request for PVS is rejected';
        CanReqPVS: TextConst ENU = 'Approval Request for PVS is cancelled', ENG = 'Approval Request for PVS is cancelled';

        DelReqPVS: TextConst ENU = 'Approval Request for PVS is delegated', ENG = 'Approval Request for PVS is delegated';
        SendForPendAppTxt: TextConst ENU = 'Status of PVS changed to Pending approval',
                                        ENG = 'Status of PVS changed to Pending approval';
        ReleasePVSTxt: TextConst ENU = 'Release PVS', ENG = 'Release PVS';
        ReOpenPVSTxt: TextConst ENU = 'ReOpen PVS', ENG = 'ReOpen PVS';

        //Imprest
        SendImprestReq: TextConst ENU = 'Approval Request for Imprest is requested', ENG = 'Approval Request for Imprest is requested';
        AppReqImprest: TextConst ENU = 'Approval Request for Imprest is approved', ENG = 'Approval Request for Imprest is approved';
        RejReqImprest: TextConst ENU = 'Approval Request for Imprest is rejected', ENG = 'Approval Request for Imprest is rejected';
        CanReqImprest: TextConst ENU = 'Approval Request for Imprest is cancelled', ENG = 'Approval Request for Imprest is cancelled';

        DelReqImprest: TextConst ENU = 'Approval Request for Imprest is delegated', ENG = 'Approval Request for Imprest is delegated';
        ImprestPendAppTxt: TextConst ENU = 'Status of Imprest changed to Pending approval',
                                        ENG = 'Status of Imprest changed to Pending approval';
        ReleaseImprestTxt: TextConst ENU = 'Release Imprest', ENG = 'Release Imprest';
        ReOpenImprestTxt: TextConst ENU = 'ReOpen Imprest', ENG = 'ReOpen Imprest';
        //End Imprest

        //Claims
        SendClaimReq: TextConst ENU = 'Approval Request for Claim is requested', ENG = 'Approval Request for Claim is requested';
        AppReqClaim: TextConst ENU = 'Approval Request for Claim is approved', ENG = 'Approval Request for Claim is approved';
        RejReqClaim: TextConst ENU = 'Approval Request for Claim is rejected', ENG = 'Approval Request for Claim is rejected';
        CanReqClaim: TextConst ENU = 'Approval Request for Claim is cancelled', ENG = 'Approval Request for Claim is cancelled';


        DelReqClaim: TextConst ENU = 'Approval Request for Claim is delegated', ENG = 'Approval Request for Claim is delegated';
        ClaimPendAppTxt: TextConst ENU = 'Status of Claim changed to Pending approval',
                                        ENG = 'Status of Claim changed to Pending approval';
        ReleaseClaimTxt: TextConst ENU = 'Release Claim', ENG = 'Release Claim';
        ReOpenClaimTxt: TextConst ENU = 'ReOpen Claim', ENG = 'ReOpen Claim';

        //Bank Transfers 
        SendInterBankReq: TextConst ENU = 'Approval Request for Inter-bank Transfer is requested', ENG = 'Approval Request for Inter-bank Transfer is requested';
        AppReqInterBank: TextConst ENU = 'Approval Request for Inter-bank Transfer is approved', ENG = 'Approval Request for Inter-bank Transfer is approved';
        RejReqInterBank: TextConst ENU = 'Approval Request for Inter-bank Transfer is rejected', ENG = 'Approval Request for Inter-bank Transfer is rejected';
        CanReqInterBank: TextConst ENU = 'Approval Request for Inter-bank Transfer is cancelled', ENG = 'Approval Request for Inter-bank Transfer is cancelled';
        DelReqInterBank: TextConst ENU = 'Approval Request for Inter-bank Transfer is delegated', ENG = 'Approval Request for Inter-bank Transfer is delegated';
        InterBankPendAppTxt: TextConst ENU = 'Status of Inter-bank Transfer changed to Pending approval',
                                        ENG = 'Status of Inter-bank Transfer changed to Pending approval';
        ReleaseInterBankTxt: TextConst ENU = 'Release Inter-bank Transfer', ENG = 'Release Inter-bank Transfer';
        ReOpenInterBankTxt: TextConst ENU = 'ReOpen Inter-bank Transfer', ENG = 'ReOpen Inter-bank Transfer';
        //End Bank Transfer

        //Purchase Quotes
        SendPurchQuoteReq: TextConst ENU = 'Approval Request for Purchase Quotes is requested', ENG = 'Approval Request for Purchase Quotes is requested';
        AppReqPurchQuote: TextConst ENU = 'Approval Request for Purchase Quotes is approved', ENG = 'Approval Request for Purchase Quotes is approved';
        RejReqPurchQuote: TextConst ENU = 'Approval Request for Purchase Quotes is rejected', ENG = 'Approval Request for Purchase Quotes is rejected';
        CanReqPurchQuote: TextConst ENU = 'Approval Request for Purchase Quotes is cancelled', ENG = 'Approval Request for Purchase Quotes is cancelled';
        DelReqPurchQuote: TextConst ENU = 'Approval Request for Purchase Quotes is delegated', ENG = 'Approval Request for Purchase Quotes is delegated';
        PurchQuotePendAppTxt: TextConst ENU = 'Status of Purchase Quotes changed to Pending approval',
                                        ENG = 'Status of Purchase Quotes changed to Pending approval';
        ReleasePurchQuoteTxt: TextConst ENU = 'Release Purchase Quotes', ENG = 'Release Purchase Quotes';
        ReOpenPurchQuoteTxt: TextConst ENU = 'ReOpen Purchase Quotes', ENG = 'ReOpen Purchase Quotes';
        //End Purchase QUOTES

        //User Cancellation of Requests
        UserCanReqPVS: TextConst ENU = 'Approval Request for PVS is cancelled by user', ENG = 'Approval Request for PVS is cancelled by user';
        UserCanReqImprest: TextConst ENU = 'Approval Request for Imprest is cancelled by user', ENG = 'Approval Request for Imprest is cancelled by user';
        UserCanReqClaim: TextConst ENU = 'Approval Request for Claim is cancelled by user', ENG = 'Approval Request for Claim is cancelled by user';
        UserCanReqInterBank: TextConst ENU = 'Approval Request for Inter-bank Transfer is cancelled by user', ENG = 'Approval Request for Inter-bank Transfer is cancelled by user';
        UserCanReqPurchQuote: TextConst ENU = 'Approval Request for Purchase Quotes is cancelled by user', ENG = 'Approval Request for Purchase Quotes is cancelled by user';
    //End User Cancellation of requests



    //PVS WF Code

    procedure RunWorkflowOnSendPVSApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPVSApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnSendPVSforApproval', '', false, false)]
    procedure RunWorkflowOnSendPVSApproval(var PVS: Record "FIN-Payments Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPVSApprovalCode(), PVS);

    end;

    procedure RunWorkflowOnApprovePVSApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePVSApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePVSApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePVSApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectPVSApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPVSApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPVSApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPVSApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledPVSApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPVSApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledPVSApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledPVSApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegatePVSApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePVSApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePVSApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePVSApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodePVS(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalPVS'));
    end;

    procedure SetStatusToPendingApprovalPVS(var Variant: Variant)
    var
        RecRef: RecordRef;
        PVS: Record "FIN-Payments Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"FIN-Payments Header":
                begin
                    RecRef.SetTable(PVS);
                    PVS.Validate(Status, PVS.Status::"Pending Approval");
                    PVS.Modify();
                    Variant := PVS;
                end;
        end;
    end;

    procedure ReleasePVSCode(): Code[128]
    begin
        exit(UpperCase('ReleasePVS'));
    end;

    procedure ReleasePVS(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PVS: Record "FIN-Payments Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleasePVS(Variant);
                end;
            DATABASE::"FIN-Payments Header":
                begin
                    RecRef.SetTable(PVS);
                    PVS.Validate(Status, PVS.Status::Approved);
                    PVS.Modify();
                    Variant := PVS;
                end;
        end;
    end;

    procedure ReOpenPVSCode(): Code[128]
    begin
        exit(UpperCase('ReOpenPVS'));
    end;

    procedure ReOpenPVS(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PVS: Record "FIN-Payments Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenPVS(Variant);
                end;
            DATABASE::"FIN-Payments Header":
                begin
                    RecRef.SetTable(PVS);
                    PVS.Validate(Status, PVS.Status::Pending);
                    PVS.Modify();
                    Message('Hi there');
                    Variant := PVS;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddPVSEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPVSApprovalCode(), Database::"FIN-Payments Header", SendPVSReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePVSApprovalCode(), Database::"Approval Entry", AppReqPVS, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPVSApprovalCode(), Database::"Approval Entry", RejReqPVS, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePVSApprovalCode(), Database::"Approval Entry", DelReqPVS, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledPVSApprovalCode(), Database::"Approval Entry", CanReqPVS, 0, false);
        //cancelling of douments
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPVSApprovalCode, Database::"FIN-Payments Header", UserCanReqPVS, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelClaimsApprovalCode, Database::"FIN-Staff Claims Header", UserCanReqClaim, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelInterBankApprovalCode, Database::"FIN-InterBank Transfers", UserCanReqInterBank, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPurchQuoteApprovalCode, Database::"PROC-Purchase Quote Header", UserCanReqPurchQuote, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddPVSRespToLibrary()
    begin

        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodePVS(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleasePVSCode(), 0, ReleasePVSTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenPVSCode(), 0, ReOpenPVSTxt, 'GROUP 0');
        // try me WorkflowResponseHandling.AddResponseToLibrary(ReOpenPVSCode(), 0, ReOpenPVSTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForPVS(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";

    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodePVS():
                    begin
                        SetStatusToPendingApprovalPVS(Variant);
                        ResponseExecuted := true;
                    end;
                ReleasePVSCode():
                    begin
                        ReleasePVS(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenPVSCode():
                    begin
                        ReOpenPVS(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Imprest WFCode

    procedure RunWorkflowOnSendImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnSendImprestforApproval', '', false, false)]
    procedure RunWorkflowOnSendImprestApproval(var Imprest: Record "FIN-Imprest Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendImprestApprovalCode(), Imprest);
    end;

    procedure RunWorkflowOnApproveImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeImprest(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalImprest'));
    end;

    procedure SetStatusToPendingApprovalImprest(var Variant: Variant)
    var
        RecRef: RecordRef;
        Imprest: Record "FIN-Imprest Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"FIN-Imprest Header":
                begin
                    RecRef.SetTable(Imprest);
                    Imprest.Validate(Status, Imprest.Status::"Pending Approval");
                    Imprest.Modify();
                    Variant := Imprest;
                end;
        end;
    end;

    procedure ReleaseImprestCode(): Code[128]
    begin
        exit(UpperCase('Release Imprest'));
    end;

    procedure ReleaseImprest(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Imprest: Record "FIN-Imprest Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseImprest(Variant);
                end;
            DATABASE::"FIN-Imprest Header":
                begin
                    RecRef.SetTable(Imprest);
                    Imprest.Validate(Status, Imprest.Status::Approved);
                    Imprest.Modify();
                    Variant := Imprest;
                end;
        end;
    end;

    procedure ReOpenImprestCode(): Code[128]
    begin
        exit(UpperCase('ReOpenImprest'));
    end;

    procedure ReOpenImprest(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Imprest: Record "FIN-Imprest Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenImprest(Variant);
                end;
            DATABASE::"FIN-Imprest Header":
                begin
                    RecRef.SetTable(Imprest);
                    Imprest.Validate(Status, Imprest.Status::Pending);
                    Imprest.Modify();
                    Variant := Imprest;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddImprestEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestApprovalCode(), Database::"FIN-Imprest Header", SendImprestReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveImprestApprovalCode(), Database::"Approval Entry", AppReqImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectImprestApprovalCode(), Database::"Approval Entry", RejReqImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateImprestApprovalCode(), Database::"Approval Entry", DelReqImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledImprestApprovalCode(), Database::"Approval Entry", CanReqImprest, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestApprovalCode, Database::"FIN-Imprest Header", UserCanReqImprest, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddImprestRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeImprest(), 0, ImprestPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseImprestCode(), 0, ReleaseImprestTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenImprestCode(), 0, ReOpenImprestTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForImprest(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeImprest():
                    begin
                        SetStatusToPendingApprovalImprest(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseImprestCode():
                    begin
                        ReleaseImprest(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenImprestCode():
                    begin
                        ReOpenImprest(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;

    //End of Imprest   

    //Claims WFCode

    procedure RunWorkflowOnSendClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnSendClaimforApproval', '', false, false)]
    procedure RunWorkflowOnSendClaimApproval(var Claims: Record "FIN-Staff Claims Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendClaimApprovalCode(), Claims);

    end;

    procedure RunWorkflowOnApproveClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeClaim(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalClaim'));
    end;

    procedure SetStatusToPendingApprovalClaim(var Variant: Variant)
    var
        RecRef: RecordRef;
        Claim: Record "FIN-Staff Claims Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"FIN-Staff Claims Header":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Validate(Status, Claim.Status::"Pending Approval");
                    Claim.Modify();
                    Variant := Claim;
                end;
        end;
    end;

    procedure ReleaseClaimCode(): Code[128]
    begin
        exit(UpperCase('Release Claim'));
    end;

    procedure ReleaseClaim(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Claim: Record "FIN-Staff Claims Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseClaim(Variant);
                end;
            DATABASE::"FIN-Staff Claims Header":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Validate(Status, Claim.Status::Approved);
                    Claim.Modify();
                    Variant := Claim;
                end;
        end;
    end;

    procedure ReOpenClaimCode(): Code[128]
    begin
        exit(UpperCase('ReOpenClaim'));
    end;

    procedure ReOpenClaim(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Claim: Record "FIN-Staff Claims Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenClaim(Variant);
                end;
            DATABASE::"FIN-Staff Claims Header":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Validate(Status, Claim.Status::Pending);
                    Claim.Modify();
                    Variant := Claim;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddClaimEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendClaimApprovalCode(), Database::"FIN-Staff Claims Header", SendClaimReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveClaimApprovalCode(), Database::"Approval Entry", AppReqClaim, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectClaimApprovalCode(), Database::"Approval Entry", RejReqClaim, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateClaimApprovalCode(), Database::"Approval Entry", DelReqClaim, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledClaimApprovalCode(), Database::"Approval Entry", CanReqClaim, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddClaimRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeClaim(), 0, ClaimPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseClaimCode(), 0, ReleaseClaimTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenClaimCode(), 0, ReOpenClaimTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForClaim(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeClaim():
                    begin
                        SetStatusToPendingApprovalClaim(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseClaimCode():
                    begin
                        ReleaseClaim(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenClaimCode():
                    begin
                        ReOpenClaim(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;
    //End of Claim workflow

    //Inter bank Transfers workflow
    procedure RunWorkflowOnSendInterBankApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendInterBankApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnSendInterBankforApproval', '', false, false)]
    procedure RunWorkflowOnSendInterBankApproval(var InterBank: Record "FIN-InterBank Transfers")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendInterBankApprovalCode(), InterBank);
    end;

    procedure RunWorkflowOnApproveInterBankApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveInterBankApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveInterBankApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveInterBankApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectInterBankApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectInterBankApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectInterBankApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectInterBankApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledInterBankApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectInterBankApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledInterBankApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledInterBankApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateInterBankApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateInterBankApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateInterBankApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateInterBankApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeInterBank(): Code[128]
    begin
        exit(UpperCase('Set Bank Transfers Status to pending Approval'));
    end;

    procedure SetStatusToPendingApprovalInterBank(var Variant: Variant)
    var
        RecRef: RecordRef;
        InterBank: Record "FIN-InterBank Transfers";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"FIN-InterBank Transfers":
                begin
                    RecRef.SetTable(InterBank);
                    InterBank.Validate(Status, InterBank.Status::"Pending Approval");
                    InterBank.Modify();
                    Variant := InterBank;
                end;
        end;
    end;

    procedure ReleaseInterBankCode(): Code[128]
    begin
        exit(UpperCase('Release Bank Transfers'));
    end;

    procedure ReleaseInterBank(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        InterBank: Record "FIN-InterBank Transfers";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseInterBank(Variant);
                end;
            DATABASE::"FIN-InterBank Transfers":
                begin
                    RecRef.SetTable(InterBank);
                    InterBank.Validate(Status, InterBank.Status::Approved);
                    InterBank.Modify();
                    Variant := InterBank;
                end;
        end;
    end;

    procedure ReOpenInterBankCode(): Code[128]
    begin
        exit(UpperCase('Re Open Bank Transfers'));
    end;

    procedure CancInterBankCode(): Code[128]
    begin
        exit(UpperCase('Cancel Bank Transfers'));
    end;


    procedure ReOpenInterBank(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        InterBank: Record "FIN-InterBank Transfers";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenInterBank(Variant);
                end;
            DATABASE::"FIN-InterBank Transfers":
                begin
                    RecRef.SetTable(InterBank);
                    InterBank.Validate(Status, InterBank.Status::Pending);
                    InterBank.Modify();
                    Variant := InterBank;
                end;
        end;
    end;

    //Added Functionallity to test

    procedure CancInterBank(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        InterBank: Record "FIN-InterBank Transfers";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenInterBank(Variant);
                end;
            DATABASE::"FIN-InterBank Transfers":
                begin
                    RecRef.SetTable(InterBank);
                    InterBank.Validate(Status, InterBank.Status::Cancelled);
                    InterBank.Modify();
                    Variant := InterBank;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddInterBankEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendInterBankApprovalCode(), Database::"FIN-InterBank Transfers", SendInterBankReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveInterBankApprovalCode(), Database::"Approval Entry", AppReqInterBank, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectInterBankApprovalCode(), Database::"Approval Entry", RejReqInterBank, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateInterBankApprovalCode(), Database::"Approval Entry", DelReqInterBank, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledInterBankApprovalCode(), Database::"Approval Entry", CanReqInterBank, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddInterBankRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeInterBank(), 0, InterBankPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseInterBankCode(), 0, ReleaseInterBankTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenInterBankCode(), 0, ReOpenInterBankTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(CancInterBankCode(), 0, CanReqInterBank, 'GROUP 0')
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForInterBank(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeInterBank():
                    begin
                        SetStatusToPendingApprovalInterBank(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseInterBankCode():
                    begin
                        ReleaseInterBank(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenInterBankCode():
                    begin
                        ReOpenInterBank(Variant);
                        ResponseExecuted := true;
                    end;
                CancInterBankCode():
                    begin
                        CancInterBank(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;

    //End of Inter bank Tranfers
    //Purchase Quotes 
    procedure RunWorkflowOnSendPurchQuoteApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchQuoteApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnSendPurchQuoteforApproval', '', false, false)]
    procedure RunWorkflowOnSendPurchQuoteApproval(var PurchQuote: Record "PROC-Purchase Quote Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPurchQuoteApprovalCode(), PurchQuote);
    end;

    procedure RunWorkflowOnApprovePurchQuoteApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePurchQuoteApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePurchQuoteApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePurchQuoteApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectPurchQuoteApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPurchQuoteApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPurchQuoteApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPurchQuoteApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledPurchQuoteApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPurchQuoteApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledPurchQuoteApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledPurchQuoteApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegatePurchQuoteApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePurchQuoteApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePurchQuoteApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePurchQuoteApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodePurchQuote(): Code[128]
    begin
        exit(UpperCase('Set PurchQuote Status to pending Approval'));
    end;

    procedure SetStatusToPendingApprovalPurchQuote(var Variant: Variant)
    var
        RecRef: RecordRef;
        PurchQuote: Record "PROC-Purchase Quote Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"PROC-Purchase Quote Header":
                begin
                    RecRef.SetTable(PurchQuote);
                    PurchQuote.Validate(Status, PurchQuote.Status::"Pending Approval");
                    PurchQuote.Modify();
                    Variant := PurchQuote;
                end;
        end;
    end;

    procedure ReleasePurchQuoteCode(): Code[128]
    begin
        exit(UpperCase('Release PurchQuote'));
    end;

    procedure ReleasePurchQuote(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PurchQuote: Record "PROC-Purchase Quote Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleasePurchQuote(Variant);
                end;
            DATABASE::"PROC-Purchase Quote Header":
                begin
                    RecRef.SetTable(PurchQuote);
                    PurchQuote.Validate(Status, PurchQuote.Status::Released);
                    PurchQuote.Modify();
                    Variant := PurchQuote;
                end;
        end;
    end;

    procedure ReOpenPurchQuoteCode(): Code[128]
    begin
        exit(UpperCase('Re Open PurchQuote'));
    end;

    procedure CancPurchQuoteCode(): Code[128]
    begin
        exit(UpperCase('Cancel PurchQuote'));
    end;


    procedure ReOpenPurchQuote(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PurchQuote: Record "PROC-Purchase Quote Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenPurchQuote(Variant);
                end;
            DATABASE::"PROC-Purchase Quote Header":
                begin
                    RecRef.SetTable(PurchQuote);
                    PurchQuote.Validate(Status, PurchQuote.Status::Open);
                    PurchQuote.Modify();
                    Variant := PurchQuote;
                end;
        end;
    end;

    //Added Functionallity to test

    procedure CancPurchQuote(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PurchQuote: Record "PROC-Purchase Quote Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenPurchQuote(Variant);
                end;
            DATABASE::"PROC-Purchase Quote Header":
                begin
                    RecRef.SetTable(PurchQuote);
                    PurchQuote.Validate(Status, PurchQuote.Status::Cancelled);
                    PurchQuote.Modify();
                    Variant := PurchQuote;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddPurchQuoteEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPurchQuoteApprovalCode(), Database::"PROC-Purchase Quote Header", SendPurchQuoteReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePurchQuoteApprovalCode(), Database::"Approval Entry", AppReqPurchQuote, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPurchQuoteApprovalCode(), Database::"Approval Entry", RejReqPurchQuote, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePurchQuoteApprovalCode(), Database::"Approval Entry", DelReqPurchQuote, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledPurchQuoteApprovalCode(), Database::"Approval Entry", CanReqPurchQuote, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddPurchQuoteRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodePurchQuote(), 0, PurchQuotePendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleasePurchQuoteCode(), 0, ReleasePurchQuoteTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenPurchQuoteCode(), 0, ReOpenPurchQuoteTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(CancPurchQuoteCode(), 0, CanReqPurchQuote, 'GROUP 0')
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForPurchQuote(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodePurchQuote():
                    begin
                        SetStatusToPendingApprovalPurchQuote(Variant);
                        ResponseExecuted := true;
                    end;
                ReleasePurchQuoteCode():
                    begin
                        ReleasePurchQuote(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenPurchQuoteCode():
                    begin
                        ReOpenPurchQuote(Variant);
                        ResponseExecuted := true;
                    end;
                CancPurchQuoteCode():
                    begin
                        CancPurchQuote(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    /// //////////////////************************CANCELLING OF PROCESSES**********************************/////////////////////
    /// 
    /// 
    /// 
    //Cancelling of PVS
    procedure RunWorkflowOnCancelPVSApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPVSApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnCancelPVSForApproval', '', false, false)]
    procedure RunWorkflowOnCancelPVSApproval(var PVS: Record "FIN-Payments Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelPVSApprovalCode(), PVS);

    end;
    //End cancelling PVS

    //Cancelling of Imprest
    procedure RunWorkflowOnCancelImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestApproval'));


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnCancelImprestForApproval', '', false, false)]
    procedure RunWorkflowOnCancelImprestApproval(var Imprest: Record "FIN-Imprest Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelImprestApprovalCode(), Imprest);


    end;
    //End cancelling Imprest

    //Cancelling of Claims
    procedure RunWorkflowOnCancelClaimsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelClaimsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnCancelClaimForApproval', '', false, false)]
    procedure RunWorkflowOnCancelClaimsApproval(VAR Claims: Record "FIN-Staff Claims Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelClaimsApprovalCode(), Claims);

    end;
    //End cancelling Claims    

    //Cancelling of InterBank
    procedure RunWorkflowOnCancelInterBankApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInterBankApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnCancelInterBankForApproval', '', false, false)]
    procedure RunWorkflowOnCancelInterBankApproval(VAR InterBank: Record "FIN-InterBank Transfers")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelInterBankApprovalCode(), InterBank);

    end;
    //End cancelling InterBank

    //Cancelling of PurchQuote
    procedure RunWorkflowOnCancelPurchQuoteApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchQuoteApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Code", 'OnCancelPurchQuoteForApproval', '', false, false)]
    procedure RunWorkflowOnCancelPurchQuoteApproval(VAR PurchQuote: Record "PROC-Purchase Quote Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelPurchQuoteApprovalCode(), PurchQuote);

    end;
    //End cancelling PurchQuote


    /// //////////////////************************CANCELLING OF PROCESSES**********************************/////////////////////
}