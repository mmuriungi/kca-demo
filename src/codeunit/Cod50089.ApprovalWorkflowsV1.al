codeunit 50089 "Approval Workflows V1"
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No Approval workflows enabled for the this record type';
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.';
        //Club
        OnSendClubRequestTxt: Label 'Approval request for Club is requested';
        OnCancelClubRequestTxt: Label 'An Approval request for Club is Cancelled';
        RunWorkflowOnSendClubForApprovalCode: Label 'RUNWORKFLOWONSENDCLUBFORAPPROVAL';
        RunWorkflowOnCanceClubForApprovalCode: Label 'RUNWORKFLOWONCANCELCLUBFORAPPROVAL';
        //Student Leave
        OnSendStudentLeaveRequestTxt: Label 'Approval request for Student Leave is requested';
        OnCancelStudentLeaveRequestTxt: Label 'An Approval request for Student Leave is Cancelled';
        RunWorkflowOnSendStudentLeaveForApprovalCode: Label 'RUNWORKFLOWONSENDSTUDENTLEAVEFORAPPROVAL';
        RunWorkflowOnCanceStudentLeaveForApprovalCode: Label 'RUNWORKFLOWONCANCELSTUDENTLEAVEFORAPPROVAL';
        //Postgrad Supervisor Applic.
        OnSendPostgradSupervisorApplicRequestTxt: Label 'Approval request for Postgraduate Supervisor Application is requested';
        OnCancelPostgradSupervisorApplicRequestTxt: Label 'An Approval request for Postgraduate Supervisor Application is Cancelled';
        RunWorkflowOnSendPostgradSupervisorApplicForApprovalCode: Label 'RUNWORKFLOWONSENDPOSTGRADSUPERVISORAPPLICFORAPPROVAL';
        RunWorkflowOnCancePostgradSupervisorApplicForApprovalCode: Label 'RUNWORKFLOWONCANCELPOSTGRADSUPERVISORAPPLICFORAPPROVAL';






    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            database::"Club":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendClubForApprovalCode));
        end;
    end;

    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
                Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        //club
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendClubForApprovalCode, Database::"Club", OnSendClubRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCanceClubForApprovalCode, Database::"Club", OnCancelClubRequestTxt, 0, false);
        //Student Leave
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendStudentLeaveForApprovalCode, Database::"Student Leave", OnSendStudentLeaveRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCanceStudentLeaveForApprovalCode, Database::"Student Leave", OnCancelStudentLeaveRequestTxt, 0, false);
        //Postgrad Supervisor Applic.
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendPostgradSupervisorApplicForApprovalCode, Database::"Postgrad Supervisor Applic.", OnSendPostgradSupervisorApplicRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancePostgradSupervisorApplicForApprovalCode, Database::"Postgrad Supervisor Applic.", OnCancelPostgradSupervisorApplicRequestTxt, 0, false);
    end;

    local procedure RunWorkflowOnSendApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Workflows V1", 'OnSendDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            database::Club:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendClubForApprovalCode, Variant);
            Database::"Student Leave":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStudentLeaveForApprovalCode, Variant);
            Database::"Postgrad Supervisor Applic.":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPostgradSupervisorApplicForApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Workflows V1", 'OnCancelDocApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::Club:
                WorkflowManagement.HandleEvent(RunWorkflowOnCanceClubForApprovalCode, Variant);
            Database::"Student Leave":
                WorkflowManagement.HandleEvent(RunWorkflowOnCanceStudentLeaveForApprovalCode, Variant);
            Database::"Postgrad Supervisor Applic.":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancePostgradSupervisorApplicForApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpendocument(RecRef: RecordRef; var Handled: Boolean)

    var
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PosGradSupervisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        case RecRef.Number of
            Database::club:
                begin
                    RecRef.SetTable(club);
                    club.Validate("Approval Status", club."Approval Status"::open);
                    club.Modify();
                    Handled := true;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::open);
                    StudentLeave.Modify();
                    Handled := true;
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(PosGradSupervisorApplic);
                    PosGradSupervisorApplic.Validate("Status", PosGradSupervisorApplic."Status"::open);
                    PosGradSupervisorApplic.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'onSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PosGradSupervisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        case RecRef.Number of
            Database::club:
                begin
                    RecRef.SetTable(club);
                    club.Validate("Approval Status", club."Approval Status"::"Pending Approval");
                    club.Modify();
                    Variant := club;
                    IsHandled := true;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::"Pending Approval");
                    StudentLeave.Modify();
                    Variant := StudentLeave;
                    IsHandled := true;
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(PosGradSupervisorApplic);
                    PosGradSupervisorApplic.Validate("Status", PosGradSupervisorApplic."Status"::"Pending");
                    PosGradSupervisorApplic.Modify();
                    Variant := PosGradSupervisorApplic;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; workflowstepInstance: Record "Workflow Step Instance")
    var
        club: Record "Club";
        StudentLeave: Record "Student Leave";
    begin
        case RecRef.number of
            Database::Club:
                begin
                    RecRef.SetTable(club);
                    ApprovalEntryArgument."Document No." := club."Code";
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    ApprovalEntryArgument."Document No." := StudentLeave."Leave No.";
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(StudentLeave);
                    ApprovalEntryArgument."Document No." := StudentLeave."Leave No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: boolean)
    var
        Clubmgmt: Codeunit "Student Affairs Management";
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PostGradSupervisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        case RecRef.Number of
            Database::Club:
                begin
                    RecRef.SetTable(club);
                    Clubmgmt.ApproveClub(club);
                    Handled := true;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::Approved);
                    StudentLeave.Modify();
                    Handled := true;
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(PostGradSupervisorApplic);
                    PostGradSupervisorApplic.Validate("Status", PostGradSupervisorApplic."Status"::Approved);
                    PostGradSupervisorApplic.Modify();
                    Handled := true;
                    //Send Mail

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        postgradSupervisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        case ApprovalEntry."Table ID" of
            Database::club:
                begin
                    if club.Get(ApprovalEntry."Document No.") then begin
                        club.validate("Approval Status", club."Approval Status"::Rejected);
                        club.Modify(true);
                    end;
                end;
            Database::"Student Leave":
                begin
                    if StudentLeave.Get(ApprovalEntry."Document No.") then begin
                        StudentLeave."Approval Status" := StudentLeave."Approval Status"::Rejected;
                        StudentLeave.Modify(true);
                    end;
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    if postgradSupervisorApplic.Get(ApprovalEntry."Document No.") then begin
                        postgradSupervisorApplic."Status" := postgradSupervisorApplic."Status"::Rejected;
                        postgradSupervisorApplic.Modify(true);
                    end;
                end;
        end;
    end;

    procedure ReOpen(var Variant: Variant)
    var
        club: Record "Club";
        RecRef: RecordRef;
        StudentLeave: Record "Student Leave";
        PostgradSupervisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::club:
                begin
                    RecRef.SetTable(club);
                    club.validate("Approval Status", club."Approval Status"::Open);
                    club.Modify;
                    Variant := club;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::Open);
                    StudentLeave.Modify();
                    Variant := StudentLeave;
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(PostgradSupervisorApplic);
                    PostgradSupervisorApplic.Validate("Status", PostgradSupervisorApplic."Status"::Open);
                    PostgradSupervisorApplic.Modify();
                    Variant := PostgradSupervisorApplic;
                end;
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    procedure SetStatusToPending(var Variant: Variant)
    var
        RecRef: RecordRef;
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PostgradSupervisorApplic: Record "Postgrad Supervisor Applic.";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::Club:
                begin
                    RecRef.SetTable(club);
                    club.validate("Approval Status", club."Approval Status"::"Pending Approval");
                    club.Modify;
                    Variant := club;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::"Pending Approval");
                    StudentLeave.Modify();
                    Variant := StudentLeave;
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(PostgradSupervisorApplic);
                    PostgradSupervisorApplic.Validate("Status", PostgradSupervisorApplic."Status"::"Pending");
                    PostgradSupervisorApplic.Modify();
                    Variant := PostgradSupervisorApplic;
                end;

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    procedure fnCheckApprovalRequirements(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PostgradSupervisorApplic: Record "Postgrad Supervisor Applic.";
        Cust: Record "Customer";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::club:
                begin
                    RecRef.SetTable(club);
                    if club."Approval Status" = club."Approval Status"::Open then
                        exit(false);
                    exit(true);
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    if StudentLeave."Approval Status" = StudentLeave."Approval Status"::Open then
                        exit(false);
                    exit(true);
                end;
            Database::"Postgrad Supervisor Applic.":
                begin
                    RecRef.SetTable(PostgradSupervisorApplic);
                    if PostgradSupervisorApplic."Status" = PostgradSupervisorApplic."Status"::Open then
                        exit(false);
                    exit(true);
                end;
        end;
    end;
}
