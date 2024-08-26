codeunit 50037 "Work Flow Code"
{
   trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendLeaveReq: TextConst ENU = 'Approval Request for Leave  is requested', ENG = 'Approval Request for Leave  is requested';
        AppReqLeave: TextConst ENU = 'Approval Request for Leave  is approved', ENG = 'Approval Request for Leave  is approved';
        RejReqLeave: TextConst ENU = 'Approval Request for Leave  is rejected', ENG = 'Approval Request for Leave  is rejected';
        UserCanReqLeave: TextConst ENU = 'Approval Request for Leave  is canceled by the user', ENG = 'Approval Request for Leave  is canceled by the user';
        DelReqLeave: TextConst ENU = 'Approval Request for Leave  is delegated', ENG = 'Approval Request for Leave  is delegated';
        SendLeaveForPendAppTxt: TextConst ENU = 'Status of Leave changed to Pending approval', ENG = 'Status of Leave changed to Pending approval';
        ReleaseLeaveTxt: TextConst ENU = 'Release Leave', ENG = 'Release Leave';
        ReOpenLeaveTxt: TextConst ENU = 'ReOpen Leave', ENG = 'ReOpen Leave';
        //DisCases
        SendDisCasesReq: TextConst ENU = 'Approval Request for Displinary Cases is requested', ENG = 'Approval Request for Displinary Cases is requested';
        AppReqDisCases: TextConst ENU = 'Approval Request for Displinary Cases is approved', ENG = 'Approval Request for Displinary Cases is approved';
        RejReqDisCases: TextConst ENU = 'Approval Request for Displinary Cases is rejected', ENG = 'Approval Request for Displinary Cases is rejected';
        CanReqDisCases: TextConst ENU = 'Approval Request for Displinary Cases is cancelled', ENG = 'Approval Request for Displinary Cases is cancelled';
        DelReqDisCases: TextConst ENU = 'Approval Request for Displinary Cases is delegated', ENG = 'Approval Request for Displinary Cases is delegated';
        DisCasesPendAppTxt: TextConst ENU = 'Status of Displinary Cases changed to Pending approval',
                                        ENG = 'Status of Displinary Cases changed to Pending approval';
        ReleaseDisCasesTxt: TextConst ENU = 'Release  Displinary Cases', ENG = 'Release  Displinary Cases';
        ReOpenDisCasesTxt: TextConst ENU = 'ReOpen  Displinary Cases', ENG = 'ReOpen  Displinary Cases';
        //End DisCases


        //Training
        SendTrainingsReq: TextConst ENU = 'Approval Request for Trainings is requested', ENG = 'Approval Request for Trainings is requested';
        AppReqTrainings: TextConst ENU = 'Approval Request for Trainings is approved', ENG = 'Approval Request for Trainings is approved';
        RejReqTrainings: TextConst ENU = 'Approval Request for Trainings is rejected', ENG = 'Approval Request for Trainings is rejected';
        CanReqTrainings: TextConst ENU = 'Approval Request for Trainings is cancelled', ENG = 'Approval Request for Trainings is cancelled';
        DelReqTrainings: TextConst ENU = 'Approval Request for Trainings is delegated', ENG = 'Approval Request for Trainings is delegated';
        TrainingsPendAppTxt: TextConst ENU = 'Status of Trainings changed to Pending approval', ENG = 'Status of Trainings changed to Pending approval';
        ReleaseTrainingsTxt: TextConst ENU = 'Release  Trainings', ENG = 'Release  Trainings';
        ReOpenTrainingsTxt: TextConst ENU = 'ReOpen  Trainings', ENG = 'ReOpen  Trainings';
        //End Training


        //RecruitReqs REssponses

        //RecruitReqsS
        SendRecruitReqsReq: TextConst ENU = 'Approval Request for RecruitReqs is requested', ENG = 'Approval Request for RecruitReqs is requested';
        AppReqRecruitReqs: TextConst ENU = 'Approval Request for RecruitReqs is approved', ENG = 'Approval Request for RecruitReqs is approved';
        RejReqRecruitReqs: TextConst ENU = 'Approval Request for RecruitReqs is rejected', ENG = 'Approval Request for RecruitReqs is rejected';
        CanReqRecruitReqs: TextConst ENU = 'Approval Request for RecruitReqs is cancelled', ENG = 'Approval Request for RecruitReqs is cancelled';
        UserCanReqRecruitReqs: TextConst ENU = 'Approval Request for RecruitReqs is cancelled by User', ENG = 'Approval Request for RecruitReqs is cancelled by User';
        DelReqRecruitReqs: TextConst ENU = 'Approval Request for RecruitReqs is delegated', ENG = 'Approval Request for RecruitReqs is delegated';
        RecruitReqsPendAppTxt: TextConst ENU = 'Status of RecruitReqs changed to Pending approval', ENG = 'Status of RecruitReqs changed to Pending approval';
        ReleaseRecruitReqsTxt: TextConst ENU = 'Release RecruitReqs', ENG = 'Release RecruitReqs';
        ReOpenRecruitReqsTxt: TextConst ENU = 'ReOpen RecruitReqs', ENG = 'ReOpen RecruitReqs';
        //END RecruitReqsS
        //End RecruitReqs Responses 


        //PrlApproval REssponses

        //PrlApprovalS
        SendPrlApprovalReq: TextConst ENU = 'Approval Request for PrlApproval is requested', ENG = 'Approval Request for PrlApproval is requested';
        AppReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is approved', ENG = 'Approval Request for PrlApproval is approved';
        RejReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is rejected', ENG = 'Approval Request for PrlApproval is rejected';
        CanReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is cancelled', ENG = 'Approval Request for PrlApproval is cancelled';
        UserCanReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is cancelled by User', ENG = 'Approval Request for PrlApproval is cancelled by User';
        DelReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is delegated', ENG = 'Approval Request for PrlApproval is delegated';
        PrlApprovalPendAppTxt: TextConst ENU = 'Status of PrlApproval changed to Pending approval', ENG = 'Status of PrlApproval changed to Pending approval';
        ReleasePrlApprovalTxt: TextConst ENU = 'Release PrlApproval', ENG = 'Release PrlApproval';
        ReOpenPrlApprovalTxt: TextConst ENU = 'ReOpen PrlApproval', ENG = 'ReOpen PrlApproval';
    //END PrlApprovalS
    //End PrlApproval Responses 

    //Leave Workflow
    procedure RunWorkflowOnSendLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendLeavesforApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveApproval(var Leave: Record "HRM-Leave Requisition")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendLeaveApprovalCode(), Leave);
    end;

    procedure RunWorkflowOnApproveLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveLeaveApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveLeaveApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectLeaveApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectLeaveApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateLeaveApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateLeaveApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeLeave(): Code[128]
    begin
        exit(UpperCase('Set Status To PendingApproval on Leave'));
    end;

    procedure SetStatusToPendingApprovalLeave(var Variant: Variant)
    var
        RecRef: RecordRef;
        Leave: Record "HRM-Leave Requisition";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::"Pending Approval");
                    Leave.Modify();
                    Variant := Leave;
                end;
        end;
    end;

    procedure ReleaseLeaveCode(): Code[128]
    begin
        exit(UpperCase('Release Leave'));
    end;

    procedure ReleaseLeave(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Leave: Record "HRM-Leave Requisition";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseLeave(Variant);
                end;
            DATABASE::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Released);
                    //  Leave.PostLeaveApplications();
                    Leave.Modify();
                    Variant := Leave;
                end;
        end;
    end;

    procedure ReOpenLeaveCode(): Code[128]
    begin
        exit(UpperCase('ReOpen Leave'));
    end;

    procedure ReOpenLeave(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Leave: Record "HRM-Leave Requisition";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenLeave(Variant);
                end;
            DATABASE::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Open);
                    Leave.Modify();
                    Variant := Leave;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddLeaveEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveApprovalCode(), Database::"HRM-Leave Requisition", SendLeaveReq, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveLeaveApprovalCode(), Database::"Approval Entry", AppReqLeave, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectLeaveApprovalCode(), Database::"Approval Entry", RejReqLeave, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateLeaveApprovalCode(), Database::"Approval Entry", DelReqLeave, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeaveApprovalCode, Database::"HRM-Leave Requisition", UserCanReqLeave, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddLeaveRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeLeave(), 0, SendLeaveForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseLeaveCode(), 0, ReleaseLeaveTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenLeaveCode(), 0, ReOpenLeaveTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForLeave(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeLeave():
                    begin
                        SetStatusToPendingApprovalLeave(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseLeaveCode():
                    begin
                        ReleaseLeave(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenLeaveCode():
                    begin
                        ReOpenLeave(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;
    //Cancelling of Leave Code
    procedure RunWorkflowOnCancelLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnCancelLeaveForApproval', '', false, false)]
    procedure RunWorkflowOnCancelLeaveApproval(VAR Leave: Record "HRM-Leave Requisition")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelLeaveApprovalCode(), Leave);

    end;
    //End Cancelling Leave Code



    //Training
    procedure RunWorkflowOnSendTrainingsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTrainingsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendTrainingsforApproval', '', false, false)]
    procedure RunWorkflowOnSendTrainingsApproval(var Trainings: Record "HRM-Training Applications")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendTrainingsApprovalCode(), Trainings);
    end;

    procedure RunWorkflowOnApproveTrainingsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveTrainingsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveTrainingsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveTrainingsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectTrainingsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectTrainingsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectTrainingsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectTrainingsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateTrainingsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateTrainingsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateTrainingsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateTrainingsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeTrainings(): Code[128]
    begin
        exit(UpperCase('Set Status To PendingApproval on Trainings'));
    end;

    procedure SetStatusToPendingApprovalTrainings(var Variant: Variant)
    var
        RecRef: RecordRef;
        Trainings: Record "HRM-Training Applications";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"HRM-Training Applications":
                begin
                    RecRef.SetTable(Trainings);
                    Trainings.Validate(Status, Trainings.Status::"Pending Approval");
                    Trainings.Modify();
                    Variant := Trainings;
                end;
        end;
    end;

    procedure ReleaseTrainingsCode(): Code[128]
    begin
        exit(UpperCase('Release Trainings'));
    end;

    procedure ReleaseTrainings(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Trainings: Record "HRM-Training Applications";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseTrainings(Variant);
                end;
            DATABASE::"HRM-Training Applications":
                begin
                    RecRef.SetTable(Trainings);
                    Trainings.Validate(Status, Trainings.Status::Approved);
                    Trainings.Modify();
                    Variant := Trainings;
                end;
        end;
    end;

    procedure ReOpenTrainingsCode(): Code[128]
    begin
        exit(UpperCase('ReOpen Trainings'));
    end;

    procedure ReOpenTrainings(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Trainings: Record "HRM-Training Applications";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenTrainings(Variant);
                end;
            DATABASE::"HRM-Training Applications":
                begin
                    RecRef.SetTable(Trainings);
                    Trainings.Validate(Status, Trainings.Status::New);
                    Trainings.Modify();
                    Variant := Trainings;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddTrainingsEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTrainingsApprovalCode(), Database::"HRM-Training Applications", SendTrainingsReq, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveTrainingsApprovalCode(), Database::"Approval Entry", AppReqTrainings, 0, false);
        //  WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveTrainingsApprovalCode(), Database::"Approval Entry", ReOpenTrainingsTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectTrainingsApprovalCode(), Database::"Approval Entry", RejReqTrainings, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateTrainingsApprovalCode(), Database::"Approval Entry", DelReqTrainings, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddTrainingsRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeTrainings(), 0, TrainingsPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseTrainingsCode(), 0, ReleaseTrainingsTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenTrainingsCode(), 0, ReOpenTrainingsTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForTrainings(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeTrainings():
                    begin
                        SetStatusToPendingApprovalTrainings(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseTrainingsCode():
                    begin
                        ReleaseTrainings(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenTrainingsCode():
                    begin
                        ReOpenTrainings(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;

    //End Training


    //"HRM-Disciplinary Cases (B)"

    //DisCases
    procedure RunWorkflowOnSendDisCasesApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendDisCasesApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendDisCasesforApproval', '', false, false)]
    procedure RunWorkflowOnSendDisCasesApproval(var DisCases: Record "HRM-Disciplinary Cases (B)")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendDisCasesApprovalCode(), DisCases);
    end;

    procedure RunWorkflowOnApproveDisCasesApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveDisCasesApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveDisCasesApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveDisCasesApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectDisCasesApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectDisCasesApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectDisCasesApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectDisCasesApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledDisCasesApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectDisCasesApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledDisCasesApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledDisCasesApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateDisCasesApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateDisCasesApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateDisCasesApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateDisCasesApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeDisCases(): Code[128]
    begin
        exit(UpperCase('Set Status to pending Approval'));
    end;

    procedure SetStatusToPendingApprovalDisCases(var Variant: Variant)
    var
        RecRef: RecordRef;
        DisCases: Record "HRM-Disciplinary Cases (B)";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"HRM-Disciplinary Cases (B)":
                begin
                    RecRef.SetTable(DisCases);
                    DisCases.Validate("Status", DisCases."Status"::"Pending Approval");
                    DisCases.Modify();
                    Variant := DisCases;
                end;
        end;
    end;

    procedure ReleaseDisCasesCode(): Code[128]
    begin
        exit(UpperCase('Release DisCases'));
    end;

    procedure ReleaseDisCases(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DisCases: Record "HRM-Disciplinary Cases (B)";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseDisCases(Variant);
                end;
            DATABASE::"HRM-Disciplinary Cases (B)":
                begin
                    RecRef.SetTable(DisCases);
                    DisCases.Validate("Status", DisCases."Status"::Approved);
                    DisCases.Modify();
                    Variant := DisCases;
                end;
        end;
    end;

    procedure ReOpenDisCasesCode(): Code[128]
    begin
        exit(UpperCase('Re Open Displinary Cases'));
    end;

    procedure CancDisCasesCode(): Code[128]
    begin
        exit(UpperCase('Cancel DisCases'));
    end;


    procedure ReOpenDisCases(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DisCases: Record "HRM-Disciplinary Cases (B)";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenDisCases(Variant);
                end;
            DATABASE::"HRM-Disciplinary Cases (B)":
                begin
                    RecRef.SetTable(DisCases);
                    DisCases.Validate("Status", DisCases."Status"::New);
                    DisCases.Modify();
                    Variant := DisCases;
                end;
        end;
    end;

    //Added Functionallity to test

    procedure CancDisCases(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DisCases: Record "HRM-Disciplinary Cases (B)";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenDisCases(Variant);
                end;
            DATABASE::"HRM-Disciplinary Cases (B)":
                begin
                    /*  RecRef.SetTable(DisCases);
                     DisCases.Validate("Status", DisCases."Status"::Approved);
                     DisCases.Modify();
                     Variant := DisCases; */
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddDisCasesEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendDisCasesApprovalCode(), Database::"HRM-Disciplinary Cases (B)", SendDisCasesReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveDisCasesApprovalCode(), Database::"Approval Entry", AppReqDisCases, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectDisCasesApprovalCode(), Database::"Approval Entry", RejReqDisCases, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateDisCasesApprovalCode(), Database::"Approval Entry", DelReqDisCases, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledDisCasesApprovalCode(), Database::"Approval Entry", CanReqDisCases, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddDisCasesRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeDisCases(), 0, DisCasesPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseDisCasesCode(), 0, ReleaseDisCasesTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenDisCasesCode(), 0, ReOpenDisCasesTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(CancDisCasesCode(), 0, CanReqDisCases, 'GROUP 0')
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForDisCases(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeDisCases():
                    begin
                        SetStatusToPendingApprovalDisCases(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseDisCasesCode():
                    begin
                        ReleaseDisCases(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenDisCasesCode():
                    begin
                        ReOpenDisCases(Variant);
                        ResponseExecuted := true;
                    end;
                CancDisCasesCode():
                    begin
                        CancDisCases(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Start RecruitReqs Workflow
    procedure RunWorkflowOnSendRecruitReqsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendRecruitReqsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendRecruitReqsforApproval', '', false, false)]
    procedure RunWorkflowOnSendRecruitReqsApproval(var RecruitReqs: Record "HRM-Employee Requisitions")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendRecruitReqsApprovalCode(), RecruitReqs);
    end;

    procedure RunWorkflowOnApproveRecruitReqsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveRecruitReqsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveRecruitReqsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveRecruitReqsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectRecruitReqsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectRecruitReqsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectRecruitReqsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectRecruitReqsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledRecruitReqsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectRecruitReqsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledRecruitReqsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledRecruitReqsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateRecruitReqsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateRecruitReqsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateRecruitReqsApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateRecruitReqsApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeRecruitReqs(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalRecruitReqs'));
    end;

    procedure SetStatusToPendingApprovalRecruitReqs(var Variant: Variant)
    var
        RecRef: RecordRef;
        RecruitReqs: Record "HRM-Employee Requisitions";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"HRM-Employee Requisitions":
            
                begin
                    RecRef.SetTable(RecruitReqs);
                    RecruitReqs.Validate(Status, RecruitReqs.Status::"Pending Approval");
                    RecruitReqs.Modify();
                    Variant := RecruitReqs;
                end;
        end;
    end;

    procedure ReleaseRecruitReqsCode(): Code[128]
    begin
        exit(UpperCase('Release RecruitReqs'));
    end;

    procedure ReleaseRecruitReqs(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        RecruitReqs: Record "HRM-Employee Requisitions";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseRecruitReqs(Variant);
                end;
            DATABASE::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(RecruitReqs);
                    RecruitReqs.Validate(Status, RecruitReqs.Status::Approved);
                    RecruitReqs.Modify();
                    Variant := RecruitReqs;
                end;
        end;
    end;

    procedure ReOpenRecruitReqsCode(): Code[128]
    begin
        exit(UpperCase('ReOpenRecruitReqs'));
    end;

    procedure ReOpenRecruitReqs(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        RecruitReqs: Record "HRM-Employee Requisitions";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenRecruitReqs(Variant);
                end;
            DATABASE::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(RecruitReqs);
                    RecruitReqs.Validate(Status, RecruitReqs.Status::"Pending Approval");
                    RecruitReqs.Modify();
                    Variant := RecruitReqs;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddRecruitReqsEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRecruitReqsApprovalCode(), Database::"HRM-Training Applications", SendRecruitReqsReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveRecruitReqsApprovalCode(), Database::"Approval Entry", AppReqRecruitReqs, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectRecruitReqsApprovalCode(), Database::"Approval Entry", RejReqRecruitReqs, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateRecruitReqsApprovalCode(), Database::"Approval Entry", DelReqRecruitReqs, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledRecruitReqsApprovalCode(), Database::"Approval Entry", CanReqRecruitReqs, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRecruitReqsApprovalCode, Database::"HRM-Training Applications", UserCanReqRecruitReqs, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddRecruitReqsRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeRecruitReqs(), 0, RecruitReqsPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseRecruitReqsCode(), 0, ReleaseRecruitReqsTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenRecruitReqsCode(), 0, ReOpenRecruitReqsTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForRecruitReqs(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeRecruitReqs():
                    begin
                        SetStatusToPendingApprovalRecruitReqs(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseRecruitReqsCode():
                    begin
                        ReleaseRecruitReqs(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenRecruitReqsCode():
                    begin
                        ReOpenRecruitReqs(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Cancelling of RecruitReqs Code
    procedure RunWorkflowOnCancelRecruitReqsApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelRecruitReqsApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnCancelRecruitReqsForApproval', '', false, false)]
    procedure RunWorkflowOnCancelRecruitReqsApproval(VAR RecruitReqs: Record "HRM-Employee Requisitions")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelRecruitReqsApprovalCode(), RecruitReqs);

    end;
    //End Cancelling RecruitReqs Code

    //End RecruitReqs Workflow


    //Start PrlApproval Workflow
    procedure RunWorkflowOnSendPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendPrlApprovalforApproval', '', false, false)]
    procedure RunWorkflowOnSendPrlApprovalApproval(var PrlApproval: Record "Prl-Approval")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPrlApprovalApprovalCode(), PrlApproval);
    end;

    procedure RunWorkflowOnApprovePrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledPrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledPrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegatePrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodePrlApproval(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalPrlApproval'));
    end;

    procedure SetStatusToPendingApprovalPrlApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        PrlApproval: Record "Prl-Approval";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    PrlApproval.Validate(Status, PrlApproval.Status::"Pending Approval");
                    PrlApproval.Modify();
                    Variant := PrlApproval;
                end;
        end;
    end;

    procedure ReleasePrlApprovalCode(): Code[128]
    begin
        exit(UpperCase('Release PrlApproval'));
    end;

    procedure ReleasePrlApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PrlApproval: Record "Prl-Approval";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleasePrlApproval(Variant);
                end;
            DATABASE::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    PrlApproval.Validate(Status, PrlApproval.Status::Approved);
                    PrlApproval.Modify();
                    Variant := PrlApproval;
                end;
        end;
    end;

    procedure ReOpenPrlApprovalCode(): Code[128]
    begin
        exit(UpperCase('ReOpenPrlApproval'));
    end;

    procedure ReOpenPrlApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PrlApproval: Record "Prl-Approval";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenPrlApproval(Variant);
                end;
            DATABASE::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    PrlApproval.Validate(Status, PrlApproval.Status::Pending);
                    PrlApproval.Modify();
                    Variant := PrlApproval;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddPrlApprovalEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPrlApprovalApprovalCode(), Database::"Prl-Approval", SendPrlApprovalReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePrlApprovalApprovalCode(), Database::"Approval Entry", AppReqPrlApproval, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPrlApprovalApprovalCode(), Database::"Approval Entry", RejReqPrlApproval, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePrlApprovalApprovalCode(), Database::"Approval Entry", DelReqPrlApproval, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledPrlApprovalApprovalCode(), Database::"Approval Entry", CanReqPrlApproval, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPrlApprovalApprovalCode, Database::"Prl-Approval", UserCanReqPrlApproval, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddPrlApprovalRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodePrlApproval(), 0, PrlApprovalPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleasePrlApprovalCode(), 0, ReleasePrlApprovalTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenPrlApprovalCode(), 0, ReOpenPrlApprovalTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForPrlApproval(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodePrlApproval():
                    begin
                        SetStatusToPendingApprovalPrlApproval(Variant);
                        ResponseExecuted := true;
                    end;
                ReleasePrlApprovalCode():
                    begin
                        ReleasePrlApproval(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenPrlApprovalCode():
                    begin
                        ReOpenPrlApproval(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Cancelling of PrlApproval Code
    procedure RunWorkflowOnCancelPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnCancelPrlApprovalForApproval', '', false, false)]
    procedure RunWorkflowOnCancelPrlApprovalApproval(VAR PrlApproval: Record "Prl-Approval")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelPrlApprovalApprovalCode(), PrlApproval);

    end;
    //End Cancelling PrlApproval Code

    //End PrlApproval Workflow

    //End Wcode codeunit


}
