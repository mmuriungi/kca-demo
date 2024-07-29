codeunit 51817 "Workflow Processing"
{
    trigger OnRun()
    begin

    end;

    var

        // meal Booking
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        // AppMgmt: Codeunit "Approvals Management 2";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendMealBookingReq: TextConst ENU = 'Approval Request for MealBooking is requested', ENG = 'Approval Request for MealBooking is requested';
        AppReqMealBooking: TextConst ENU = 'Approval Request for MealBooking is approved', ENG = 'Approval Request for MealBooking is approved';
        RejReqMealBooking: TextConst ENU = 'Approval Request for MealBooking is rejected', ENG = 'Approval Request for MealBooking is rejected';
        CanReqMealBooking: TextConst ENU = 'Approval Request for MealBooking is cancelled', ENG = 'Approval Request for MealBooking is cancelled';
        UserCanReqMealBooking: TextConst ENU = 'Approval Request for MealBooking is cancelled by User', ENG = 'Approval Request for MealBooking is cancelled by User';
        DelReqMealBooking: TextConst ENU = 'Approval Request for MealBooking is delegated', ENG = 'Approval Request for MealBooking is delegated';
        MealBookingPendAppTxt: TextConst ENU = 'Status of MealBooking changed to Pending approval', ENG = 'Status of MealBooking changed to Pending approval';
        ReleaseMealBookingTxt: TextConst ENU = 'Release MealBooking', ENG = 'Release MealBooking';
        ReOpenMealBookingTxt: TextConst ENU = 'ReOpen MealBooking', ENG = 'ReOpen MealBooking';
        //END MealBookingS
        //End MealBooking Responses 
        //ParttimeClaim REssponses
        //ParttimeClaimS
        SendParttimeClaimReq: TextConst ENU = 'Approval Request for ParttimeClaim is requested', ENG = 'Approval Request for ParttimeClaim is requested';
        AppReqParttimeClaim: TextConst ENU = 'Approval Request for ParttimeClaim is approved', ENG = 'Approval Request for ParttimeClaim is approved';
        RejReqParttimeClaim: TextConst ENU = 'Approval Request for ParttimeClaim is rejected', ENG = 'Approval Request for ParttimeClaim is rejected';
        CanReqParttimeClaim: TextConst ENU = 'Approval Request for ParttimeClaim is cancelled', ENG = 'Approval Request for ParttimeClaim is cancelled';
        UserCanReqParttimeClaim: TextConst ENU = 'Approval Request for ParttimeClaim is cancelled by User', ENG = 'Approval Request for ParttimeClaim is cancelled by User';
        DelReqParttimeClaim: TextConst ENU = 'Approval Request for ParttimeClaim is delegated', ENG = 'Approval Request for ParttimeClaim is delegated';
        ParttimeClaimPendAppTxt: TextConst ENU = 'Status of ParttimeClaim changed to Pending approval', ENG = 'Status of ParttimeClaim changed to Pending approval';
        ReleaseParttimeClaimTxt: TextConst ENU = 'Release ParttimeClaim', ENG = 'Release ParttimeClaim';
        ReOpenParttimeClaimTxt: TextConst ENU = 'ReOpen ParttimeClaim', ENG = 'ReOpen ParttimeClaim';
    //END ParttimeClaimS
    //End ParttimeClaim Responses 


    //Start MealBooking Workflow
    procedure RunWorkflowOnSendMealBookingApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMealBookingApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Initialization", 'OnSendMealBookingforApproval', '', false, false)]
    procedure RunWorkflowOnSendMealBookingApproval(var MealBooking: Record "CAT-Meal Booking Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendMealBookingApprovalCode(), MealBooking);
    end;

    procedure RunWorkflowOnApproveMealBookingApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveMealBookingApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveMealBookingApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveMealBookingApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectMealBookingApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectMealBookingApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectMealBookingApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectMealBookingApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledMealBookingApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectMealBookingApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledMealBookingApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledMealBookingApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateMealBookingApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateMealBookingApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateMealBookingApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateMealBookingApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeMealBooking(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalMealBooking'));
    end;

    procedure SetStatusToPendingApprovalMealBooking(var Variant: Variant)
    var
        RecRef: RecordRef;
        MealBooking: Record "CAT-Meal Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate(Status, MealBooking.Status::"Pending Approval");
                    MealBooking.Modify();
                    Variant := MealBooking;
                end;
        end;
    end;

    procedure ReleaseMealBookingCode(): Code[128]
    begin
        exit(UpperCase('Release MealBooking'));
    end;

    procedure ReleaseMealBooking(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        MealBooking: Record "CAT-Meal Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseMealBooking(Variant);
                end;
            DATABASE::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate(Status, MealBooking.Status::Approved);
                    MealBooking.Modify();
                    Variant := MealBooking;
                end;
        end;
    end;

    procedure ReOpenMealBookingCode(): Code[128]
    begin
        exit(UpperCase('ReOpenMealBooking'));
    end;

    procedure ReOpenMealBooking(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        MealBooking: Record "CAT-Meal Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenMealBooking(Variant);
                end;
            DATABASE::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate(Status, MealBooking.Status::New);
                    MealBooking.Modify();
                    Variant := MealBooking;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddMealBookingEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendMealBookingApprovalCode(), Database::"CAT-Meal Booking Header", SendMealBookingReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveMealBookingApprovalCode(), Database::"Approval Entry", AppReqMealBooking, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectMealBookingApprovalCode(), Database::"Approval Entry", RejReqMealBooking, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateMealBookingApprovalCode(), Database::"Approval Entry", DelReqMealBooking, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledMealBookingApprovalCode(), Database::"Approval Entry", CanReqMealBooking, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMealBookingApprovalCode, Database::"CAT-Meal Booking Header", UserCanReqMealBooking, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddMealBookingRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeMealBooking(), 0, MealBookingPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseMealBookingCode(), 0, ReleaseMealBookingTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenMealBookingCode(), 0, ReOpenMealBookingTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForMealBooking(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeMealBooking():
                    begin
                        SetStatusToPendingApprovalMealBooking(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseMealBookingCode():
                    begin
                        ReleaseMealBooking(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenMealBookingCode():
                    begin
                        ReOpenMealBooking(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Cancelling of MealBooking Code
    procedure RunWorkflowOnCancelMealBookingApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMealBookingApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Initialization", 'OnCancelMealBookingForApproval', '', false, false)]
    procedure RunWorkflowOnCancelMealBookingApproval(VAR MealBooking: Record "CAT-Meal Booking Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelMealBookingApprovalCode(), MealBooking);

    end;
    //End Cancelling MealBooking Code
    //WCODE Code Unit

    //Start ParttimeClaim Workflow
    procedure RunWorkflowOnSendParttimeClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendParttimeClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Initialization", 'OnSendParttimeClaimforApproval', '', false, false)]
    procedure RunWorkflowOnSendParttimeClaimApproval(var ParttimeClaim: Record "Parttime Claim Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendParttimeClaimApprovalCode(), ParttimeClaim);
    end;

    procedure RunWorkflowOnApproveParttimeClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveParttimeClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveParttimeClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveParttimeClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectParttimeClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectParttimeClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectParttimeClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectParttimeClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledParttimeClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectParttimeClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledParttimeClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledParttimeClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateParttimeClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateParttimeClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateParttimeClaimApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateParttimeClaimApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeParttimeClaim(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalParttimeClaim'));
    end;

    procedure SetStatusToPendingApprovalParttimeClaim(var Variant: Variant)
    var
        RecRef: RecordRef;
        ParttimeClaim: Record "Parttime Claim Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Parttime Claim Header":
                begin
                    RecRef.SetTable(ParttimeClaim);
                    ParttimeClaim.Validate(Status, ParttimeClaim.Status::"Pending Approval");
                    ParttimeClaim.Modify();
                    Variant := ParttimeClaim;
                end;
        end;
    end;

    procedure ReleaseParttimeClaimCode(): Code[128]
    begin
        exit(UpperCase('Release ParttimeClaim'));
    end;

    procedure ReleaseParttimeClaim(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ParttimeClaim: Record "Parttime Claim Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseParttimeClaim(Variant);
                end;
            DATABASE::"Parttime Claim Header":
                begin
                    RecRef.SetTable(ParttimeClaim);
                    ParttimeClaim.Validate(Status, ParttimeClaim.Status::Approved);
                    ParttimeClaim.Modify();
                    Variant := ParttimeClaim;
                end;
        end;
    end;

    procedure ReOpenParttimeClaimCode(): Code[128]
    begin
        exit(UpperCase('ReOpenParttimeClaim'));
    end;

    procedure ReOpenParttimeClaim(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ParttimeClaim: Record "Parttime Claim Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenParttimeClaim(Variant);
                end;
            DATABASE::"Parttime Claim Header":
                begin
                    RecRef.SetTable(ParttimeClaim);
                    ParttimeClaim.Validate(Status, ParttimeClaim.Status::Pending);
                    ParttimeClaim.Modify();
                    Variant := ParttimeClaim;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddParttimeClaimEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendParttimeClaimApprovalCode(), Database::"Parttime Claim Header", SendParttimeClaimReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveParttimeClaimApprovalCode(), Database::"Approval Entry", AppReqParttimeClaim, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectParttimeClaimApprovalCode(), Database::"Approval Entry", RejReqParttimeClaim, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateParttimeClaimApprovalCode(), Database::"Approval Entry", DelReqParttimeClaim, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledParttimeClaimApprovalCode(), Database::"Approval Entry", CanReqParttimeClaim, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelParttimeClaimApprovalCode, Database::"Parttime Claim Header", UserCanReqParttimeClaim, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddParttimeClaimRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeParttimeClaim(), 0, ParttimeClaimPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseParttimeClaimCode(), 0, ReleaseParttimeClaimTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenParttimeClaimCode(), 0, ReOpenParttimeClaimTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForParttimeClaim(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeParttimeClaim():
                    begin
                        SetStatusToPendingApprovalParttimeClaim(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseParttimeClaimCode():
                    begin
                        ReleaseParttimeClaim(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenParttimeClaimCode():
                    begin
                        ReOpenParttimeClaim(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Cancelling of ParttimeClaim Code
    procedure RunWorkflowOnCancelParttimeClaimApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelParttimeClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Initialization", 'OnCancelParttimeClaimForApproval', '', false, false)]
    procedure RunWorkflowOnCancelParttimeClaimApproval(VAR ParttimeClaim: Record "Parttime Claim Header")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelParttimeClaimApprovalCode(), ParttimeClaim);

    end;
    //End Cancelling ParttimeClaim Code

    //End ParttimeClaim Workflow

}