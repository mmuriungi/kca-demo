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
        //Certificate Application
        OnSendCertApplicRequestTxt: Label 'Approval request for Certificate Application is requested';
        OnCancelCertApplicRequestTxt: Label 'An Approval request for Certificate Application is Cancelled';
        RunWorkflowOnSendCertApplicForApprovalCode: Label 'RUNWORKFLOWONSENDCERTAPPLICFORAPPROVAL';
        RunWorkflowOnCanceCertApplicForApprovalCode: Label 'RUNWORKFLOWONCANCECERTAPPLICFORAPPROVAL';
        //Phamacy Request
        OnSendPhamacyRequestTxt: Label 'Approval request for Phamacy items is requested';
        OnCancelPhamacyRequestTxt: Label 'An Approval request for Phamacy item is Cancelled';
        RunWorkflowOnSendPhamacyRequestForApprovalCode: Label 'RUNWORKFLOWONSENDPHAMACYFORAPPROVAL';
        RunWorkflowOnCancelPhamacyRequestForApprovalCode: Label 'RUNWORKFLOWONCANCEPHAMACYREQUESTFORAPPROVAL';
        //"HRM-Medical Claims"
        OnSendMedicalClaimsRequestTxt: Label 'Approval request for Medical Claims is requested';
        OnCancelMedicalClaimsRequestTxt: Label 'An Approval request for Medical Claims is Cancelled';
        RunWorkflowOnSendMedicalClaimsForApprovalCode: Label 'RUNWORKFLOWONSENDMEDICALCLAIMSFORAPPROVAL';
        RunWorkflowOnCancelMedicalClaimsForApprovalCode: Label 'RUNWORKFLOWONCANCELMEDICALCLAIMSFORAPPROVAL';
        //PROC-Procurement Plan Header
        OnSendProcurementPlanRequestTxt: Label 'Approval request for Procurement Plan is requested';
        OnCancelProcurementPlanRequestTxt: Label 'An Approval request for Procurement Plan is Cancelled';
        RunWorkflowOnSendProcurementPlanForApprovalCode: Label 'RUNWORKFLOWONSENDPROCUREMENTPLANFORAPPROVAL';
        RunWorkflowOnCancelProcurementPlanForApprovalCode: Label 'RUNWORKFLOWONCANCELPROCUREMENTPLANFORAPPROVAL';
        //Proc-Committee Appointment H
        OnSendCommitteeAppointmentRequestTxt: Label 'Approval request for Committee Appointment is requested';
        OnCancelCommitteeAppointmentRequestTxt: Label 'An Approval request for Committee Appointment is Cancelled';
        RunWorkflowOnSendCommitteeAppointmentForApprovalCode: Label 'RUNWORKFLOWONSENDCOMMITTEEAPPOINTMENTFORAPPROVAL';
        RunWorkflowOnCancelCommitteeAppointmentForApprovalCode: Label 'RUNWORKFLOWONCANCELCOMMITTEEAPPOINTMENTFORAPPROVAL';
        //"Tender Header"
        OnSendTenderRequestTxt: Label 'Approval request for Tender is requested';
        OnCancelTenderRequestTxt: Label 'An Approval request for Tender is Cancelled';
        RunWorkflowOnSendTenderForApprovalCode: Label 'RUNWORKFLOWONSENDTENDERFORAPPROVAL';
        RunWorkflowOnCancelTenderForApprovalCode: Label 'RUNWORKFLOWONCANCELTENDERFORAPPROVAL';
        //RFQ Workflow
        OnSendRFQRequestTxt: Label 'Approval request for RFQ is requested';
        OnCancelRFQRequestTxt: Label 'An Approval request for RFQ is Cancelled';
        RunWorkflowOnSendRFQForApprovalCode: Label 'RUNWORKFLOWONSENDRFQFORAPPROVAL';
        RunWorkflowOnCancelRFQForApprovalCode: Label 'RUNWORKFLOWONCANCELRFQFORAPPROVAL';
        //Part time claim
        OnSendPartTimeClaimRequestTxt: Label 'Approval request for Part Time Claim is requested';
        OnCancelPartTimeClaimRequestTxt: Label 'An Approval request for Part Time Claim is Cancelled';
        RunWorkflowOnSendPartTimeClaimForApprovalCode: Label 'RUNWORKFLOWONSENDPARTTIMECLAIMFORAPPROVAL';
        RunWorkflowOnCancelPartTimeClaimForApprovalCode: Label 'RUNWORKFLOWONCANCELPARTTIMECLAIMFORAPPROVAL';
        //meal booking
        OnsendMealBookingRequestTxt: Label 'Approval request for Meal Booking is requested';
        OnCancelMealBookingRequestTxt: Label 'An Approval request for Meal Booking is Cancelled';
        RunWorkflowOnSendMealBookingApprovalCode: Label 'RUNWORKFLOWONSENDMEALBOOKINGFORAPPROVAL';
        RunWorkflowOnCancelMealBookingApprovalCode: Label 'RUNWORKFLOWONCANCELMEALBOOKINGFORAPPROVAL';
        //Imprest Surrender
        OnSendImprestSurrenderRequestTxt: Label 'Approval request for Imprest Surrender is requested';
        OnCancelImprestSurrenderRequestTxt: Label 'An Approval request for Imprest Surrender is Cancelled';
        RunWorkflowOnSendImprestSurrenderForApprovalCode: Label 'RUNWORKFLOWONSENDIMPRESTSURRENDERFORAPPROVAL';
        RunWorkflowOnCancelImprestSurrenderForApprovalCode: Label 'RUNWORKFLOWONCANCELIMPRESTSURRENDERFORAPPROVAL';



    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            database::"Club":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendClubForApprovalCode));
            Database::"Student Leave":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendStudentLeaveForApprovalCode));
            Database::"Postgrad Supervisor Applic.":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendPostgradSupervisorApplicForApprovalCode));
            Database::"Certificate Application":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendCertApplicForApprovalCode));
            Database::"Pharmacy Requests Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendPhamacyRequestForApprovalCode));
            Database::"HRM-Medical Claims":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendMedicalClaimsForApprovalCode));
            Database::"PROC-Procurement Plan Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendProcurementPlanForApprovalCode));
            Database::"Proc-Committee Appointment H":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendCommitteeAppointmentForApprovalCode));
            Database::"Tender Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendTenderForApprovalCode));
            Database::"Proc-Purchase Quote Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendRFQForApprovalCode));
            Database::"Parttime Claim Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendPartTimeClaimForApprovalCode));
            Database::"CAT-Meal Booking Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendMealBookingApprovalCode));
            Database::"FIN-Imprest Surr. Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendImprestSurrenderForApprovalCode));
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
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
        //Certificate Application
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendCertApplicForApprovalCode, Database::"Certificate Application", OnSendCertApplicRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCanceCertApplicForApprovalCode, Database::"Certificate Application", OnCancelCertApplicRequestTxt, 0, false);
        //Phamacyrequest
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendPhamacyRequestForApprovalCode, Database::"Pharmacy Requests Header", OnSendPhamacyRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPhamacyRequestForApprovalCode, Database::"Pharmacy Requests Header", OnCancelPhamacyRequestTxt, 0, false);
        //"HRM-Medical Claims"
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendMedicalClaimsForApprovalCode, Database::"HRM-Medical Claims", OnSendMedicalClaimsRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMedicalClaimsForApprovalCode, Database::"HRM-Medical Claims", OnCancelMedicalClaimsRequestTxt, 0, false);
        //PROC-Procurement Plan Header
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendProcurementPlanForApprovalCode, Database::"PROC-Procurement Plan Header", OnSendProcurementPlanRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelProcurementPlanForApprovalCode, Database::"PROC-Procurement Plan Header", OnCancelProcurementPlanRequestTxt, 0, false);
        //Proc-Committee Appointment H
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendCommitteeAppointmentForApprovalCode, Database::"Proc-Committee Appointment H", OnSendCommitteeAppointmentRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCommitteeAppointmentForApprovalCode, Database::"Proc-Committee Appointment H", OnCancelCommitteeAppointmentRequestTxt, 0, false);
        //"Tender Header"
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendTenderForApprovalCode, Database::"Tender Header", OnSendTenderRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTenderForApprovalCode, Database::"Tender Header", OnCancelTenderRequestTxt, 0, false);
        //RFQ Workflow
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendRFQForApprovalCode, Database::"Proc-Purchase Quote Header", OnSendRFQRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRFQForApprovalCode, Database::"Proc-Purchase Quote Header", OnCancelRFQRequestTxt, 0, false);
        //Part time claim
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendPartTimeClaimForApprovalCode, Database::"Parttime Claim Header", OnSendPartTimeClaimRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPartTimeClaimForApprovalCode, Database::"Parttime Claim Header", OnCancelPartTimeClaimRequestTxt, 0, false);
        //meal booking
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendMealBookingApprovalCode, Database::"CAT-Meal Booking Header", OnsendMealBookingRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMealBookingApprovalCode, Database::"CAT-Meal Booking Header", OnCancelMealBookingRequestTxt, 0, false);
        //Imprest Surrender
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestSurrenderForApprovalCode, Database::"FIN-Imprest Surr. Header", OnSendImprestSurrenderRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestSurrenderForApprovalCode, Database::"FIN-Imprest Surr. Header", OnCancelImprestSurrenderRequestTxt, 0, false);
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
            Database::"Certificate Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCertApplicForApprovalCode, Variant);
            Database::"Pharmacy Requests Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPhamacyRequestForApprovalCode, Variant);
            Database::"HRM-Medical Claims":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMedicalClaimsForApprovalCode, Variant);
            Database::"PROC-Procurement Plan Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendProcurementPlanForApprovalCode, Variant);
            Database::"Proc-Committee Appointment H":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCommitteeAppointmentForApprovalCode, Variant);
            Database::"Tender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTenderForApprovalCode, Variant);
            Database::"Proc-Purchase Quote Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRFQForApprovalCode, Variant);
            Database::"Parttime Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPartTimeClaimForApprovalCode, Variant);
            Database::"CAT-Meal Booking Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMealBookingApprovalCode, Variant);
            Database::"FIN-Imprest Surr. Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderForApprovalCode, Variant);
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
            Database::"Certificate Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCanceCertApplicForApprovalCode, Variant);
            Database::"Pharmacy Requests Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPhamacyRequestForApprovalCode, Variant);
            Database::"HRM-Medical Claims":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMedicalClaimsForApprovalCode, Variant);
            Database::"PROC-Procurement Plan Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcurementPlanForApprovalCode, Variant);
            Database::"Proc-Committee Appointment H":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCommitteeAppointmentForApprovalCode, Variant);
            Database::"Tender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenderForApprovalCode, Variant);
            Database::"Proc-Purchase Quote Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRFQForApprovalCode, Variant);
            Database::"Parttime Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPartTimeClaimForApprovalCode, Variant);
            Database::"CAT-Meal Booking Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMealBookingApprovalCode, Variant);
            Database::"FIN-Imprest Surr. Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderForApprovalCode, Variant);
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
        CertApplic: Record "Certificate Application";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcPlanHeader: Record "PROC-Procurement Plan Header";
        CommiteeAppoint: Record "Proc-Committee Appointment H";
        TenderHeader: Record "Tender Header";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        ImpSurrHeader: Record "FIN-Imprest Surr. Header";
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
            Database::"Certificate Application":
                begin
                    RecRef.SetTable(CertApplic);
                    CertApplic.Validate("Status", CertApplic.Status::Open);
                    CertApplic.Modify();
                    Handled := true;
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PhamacyHeader);
                    PhamacyHeader.Validate("Status", PhamacyHeader.Status::Pending);
                    PhamacyHeader.Modify();
                    Handled := true;
                end;
            Database::"HRM-Medical Claims":
                begin
                    RecRef.SetTable(Medclaims);
                    Medclaims.Validate("Status", Medclaims.Status::Open);
                    Medclaims.Modify();
                    Handled := true;
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcPlanHeader);
                    ProcPlanHeader.Validate("Status", ProcPlanHeader.Status::Open);
                    ProcPlanHeader.Modify();
                    Handled := true;
                end;
            Database::"Proc-Committee Appointment H":
                begin
                    RecRef.SetTable(CommiteeAppoint);
                    CommiteeAppoint.Validate("Status", CommiteeAppoint.Status::Open);
                    CommiteeAppoint.Modify();
                    Handled := true;
                end;
            Database::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate("Status", TenderHeader.Status::Open);
                    TenderHeader.Modify();
                    Handled := true;
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate("Status", RFQHeader.Status::Open);
                    RFQHeader.Modify();
                    Handled := true;
                end;
            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(PartTimeClaim);
                    PartTimeClaim.Validate("Status", PartTimeClaim.Status::Pending);
                    PartTimeClaim.Modify();
                    Handled := true;
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate("Status", MealBooking.Status::New);
                    MealBooking.Modify();
                    Handled := true;
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    RecRef.SetTable(ImpSurrHeader);
                    ImpSurrHeader.Validate("Status", ImpSurrHeader.Status::Pending);
                    ImpSurrHeader.Modify();
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
        CertApplic: Record "Certificate Application";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcplanHeader: Record "PROC-Procurement Plan Header";
        CommitteAppointment: Record "Proc-Committee Appointment H";
        TenderHEader: Record "Tender Header";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        ImpsurHeader: Record "FIN-Imprest Surr. Header";
    begin
        case RecRef.Number of
            Database::club:
                begin
                    RecRef.SetTable(club);
                    club.Validate("Approval Status", club."Approval Status"::"Pending");
                    club.Modify();
                    Variant := club;
                    IsHandled := true;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::"Pending");
                    StudentLeave.Modify();
                    Variant := StudentLeave;
                    if not fnCheckApprovalRequirements(Variant) then
                        Error('Approval requirements are not met. Attach the required documents and try again.');
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
            Database::"Certificate Application":
                begin
                    RecRef.SetTable(CertApplic);
                    CertApplic.Validate("Status", CertApplic.Status::Pending);
                    CertApplic.Modify();
                    Variant := CertApplic;
                    IsHandled := true;
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PhamacyHeader);
                    PhamacyHeader.Validate("Status", PhamacyHeader.Status::Pending);
                    PhamacyHeader.Modify();
                    isHandled := true;
                end;
            Database::"HRM-Medical Claims":
                begin
                    RecRef.SetTable(Medclaims);
                    Medclaims.Validate("Status", Medclaims.Status::Pending);
                    Medclaims.Modify();
                    IsHandled := true;
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcplanHeader);
                    ProcplanHeader.Validate("Status", ProcplanHeader.Status::"Pending Approval");
                    ProcplanHeader.Modify();
                    IsHandled := true;
                end;
            Database::"Proc-Committee Appointment H":
                begin
                    RecRef.SetTable(CommitteAppointment);
                    CommitteAppointment.Validate("Status", CommitteAppointment.Status::"Pending Approval");
                    CommitteAppointment.Modify();
                    IsHandled := true;
                end;
            Database::"Tender Header":
                begin
                    RecRef.SetTable(TenderHEader);
                    TenderHEader.Validate("Status", TenderHEader.Status::"Pending Approval");
                    TenderHEader.Modify();
                    IsHandled := true;
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate("Status", RFQHeader.Status::"Pending Approval");
                    RFQHeader.Modify();
                    IsHandled := true;
                end;
            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(PartTimeClaim);
                    PartTimeClaim.Validate("Status", PartTimeClaim.Status::"Pending Approval");
                    PartTimeClaim.Modify();
                    IsHandled := true;
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate("Status", MealBooking.Status::"Pending Approval");
                    MealBooking.Modify();
                    IsHandled := true;
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    RecRef.SetTable(ImpsurHeader);
                    ImpsurHeader.Validate("Status", ImpsurHeader.Status::"Pending Approval");
                    ImpsurHeader.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; workflowstepInstance: Record "Workflow Step Instance")
    var
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PostGradSupervisorApplic: Record "Postgrad Supervisor Applic.";
        certApplic: Record "Certificate Application";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcplanHeader: Record "PROC-Procurement Plan Header";
        CommitteAppoint: Record "Proc-Committee Appointment H";
        TenderHeader: Record "Tender Header";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        impSurrHeader: Record "FIN-Imprest Surr. Header";
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
                    RecRef.SetTable(PostGradSupervisorApplic);
                    ApprovalEntryArgument."Document No." := PostGradSupervisorApplic."No.";
                end;
            Database::"Certificate Application":
                begin
                    RecRef.SetTable(certApplic);
                    ApprovalEntryArgument."Document No." := certApplic."No.";
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PhamacyHeader);
                    ApprovalEntryArgument."Document No." := PhamacyHeader."No.";
                end;
            Database::"HRM-Medical Claims":
                begin
                    RecRef.SetTable(Medclaims);
                    ApprovalEntryArgument."Document No." := Medclaims."Claim No";
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcplanHeader);
                    ApprovalEntryArgument."Document No." := ProcplanHeader."Budget Name";
                end;
            Database::"Proc-Committee Appointment H":
                begin
                    RecRef.SetTable(CommitteAppoint);
                    ApprovalEntryArgument."Document No." := CommitteAppoint."Ref No";
                end;
            Database::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    ApprovalEntryArgument."Document No." := TenderHeader."No.";
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    ApprovalEntryArgument."Document No." := RFQHeader."No.";
                end;
            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(PartTimeClaim);
                    ApprovalEntryArgument."Document No." := PartTimeClaim."No.";
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    ApprovalEntryArgument."Document No." := MealBooking."Booking Id";
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    RecRef.SetTable(impSurrHeader);
                    ApprovalEntryArgument."Document No." := impSurrHeader.No;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: boolean)
    var
        Clubmgmt: Codeunit "Student Affairs Management";
        StudHandler: Codeunit "Student Handler";
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        PostGradSupervisorApplic: Record "Postgrad Supervisor Applic.";
        certApplic: Record "Certificate Application";
        PgHandler: Codeunit "PostGraduate Handler";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcPlanHeader: Record "PROC-Procurement Plan Header";
        CommitteAppoint: Record "Proc-Committee Appointment H";
        TenderHeader: Record "Tender Header";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        impSurHeader: Record "FIN-Imprest Surr. Header";
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
                    PgHandler.SendNotificationToStudent(PostGradSupervisorApplic."Student No.", PostGradSupervisorApplic."Assigned Supervisor Code");
                end;
            Database::"Certificate Application":
                begin
                    RecRef.SetTable(certApplic);
                    certApplic.Validate("Status", certApplic.Status::Approved);
                    StudHandler.handleStudentCertificateApplicationBilling(certApplic);
                    certApplic.Modify();
                    Handled := true;
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PhamacyHeader);
                    PhamacyHeader.Validate("Status", PhamacyHeader.Status::Approved);
                    //StudHandler.handleStudentCertificateApplicationBilling(PhamacyHeader);
                    PhamacyHeader.Modify();
                    Handled := true;
                end;
            Database::"HRM-Medical Claims":
                begin
                    RecRef.SetTable(Medclaims);
                    Medclaims.Validate("Status", Medclaims.Status::Approved);
                    Medclaims.Modify();
                    Handled := true;
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcPlanHeader);
                    ProcPlanHeader.Validate("Status", ProcPlanHeader.Status::Approved);
                    ProcPlanHeader.Modify();
                    Handled := true;
                end;
            Database::"Proc-Committee Appointment H":
                begin
                    RecRef.SetTable(CommitteAppoint);
                    CommitteAppoint.Validate("Status", CommitteAppoint.Status::Approved);
                    CommitteAppoint.Modify();
                    Handled := true;
                end;
            Database::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate("Status", TenderHeader.Status::Released);
                    TenderHeader.Modify();
                    Handled := true;
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate("Status", RFQHeader.Status::Released);
                    RFQHeader.Modify();
                    Handled := true;
                end;
            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(PartTimeClaim);
                    PartTimeClaim.Validate("Status", PartTimeClaim.Status::Approved);
                    PartTimeClaim.Modify();
                    Handled := true;
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate("Status", MealBooking.Status::Approved);
                    MealBooking.Modify();
                    Handled := true;
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    RecRef.SetTable(impSurHeader);
                    impSurHeader.Validate("Status", impSurHeader.Status::Approved);
                    impSurHeader.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        club: Record "Club";
        StudentLeave: Record "Student Leave";
        postgradSupervisorApplic: Record "Postgrad Supervisor Applic.";
        CertApplic: Record "Certificate Application";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcPlanHeader: Record "PROC-Procurement Plan Header";
        CommitteAppoint: Record "Proc-Committee Appointment H";
        TenderHeader: Record "Tender Header";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        impsurHeader: Record "FIN-Imprest Surr. Header";
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
            Database::"Certificate Application":
                begin
                    if CertApplic.Get(ApprovalEntry."Document No.") then begin
                        CertApplic.Status := CertApplic.Status::Rejected;
                        CertApplic.Modify(true);
                    end;
                end;
            Database::"Pharmacy Requests Header":
                begin
                    if PhamacyHeader.Get(ApprovalEntry."Document No.") then begin
                        PhamacyHeader.Status := PhamacyHeader.Status::Pending;
                        PhamacyHeader.Modify(true);
                    end;
                end;
            Database::"HRM-Medical Claims":
                begin
                    if Medclaims.Get(ApprovalEntry."Document No.") then begin
                        Medclaims.Status := Medclaims.Status::Rejected;
                        Medclaims.Modify(true);
                    end;
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    if ProcPlanHeader.Get(ApprovalEntry."Document No.") then begin
                        ProcPlanHeader.Status := ProcPlanHeader.Status::Rejected;
                        ProcPlanHeader.Modify(true);
                    end;
                end;
            Database::"Proc-Committee Appointment H":
                begin
                    if CommitteAppoint.Get(ApprovalEntry."Document No.") then begin
                        CommitteAppoint.Status := CommitteAppoint.Status::Rejected;
                        CommitteAppoint.Modify(true);
                    end;
                end;
            Database::"Tender Header":
                begin
                    if TenderHeader.Get(ApprovalEntry."Document No.") then begin
                        TenderHeader.Status := TenderHeader.Status::Rejected;
                        TenderHeader.Modify(true);
                    end;
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    if RFQHeader.Get(ApprovalEntry."Document No.") then begin
                        RFQHeader.Status := RFQHeader.Status::Cancelled;
                        RFQHeader.Modify(true);
                    end;
                end;
            Database::"Parttime Claim Header":
                begin
                    if PartTimeClaim.Get(ApprovalEntry."Document No.") then begin
                        PartTimeClaim.Status := PartTimeClaim.Status::Cancelled;
                        PartTimeClaim.Modify(true);
                    end;
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    if MealBooking.Get(ApprovalEntry."Document No.") then begin
                        MealBooking.Status := MealBooking.Status::Cancelled;
                        MealBooking.Modify(true);
                    end;
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    if impsurHeader.Get(ApprovalEntry."Document No.") then begin
                        impsurHeader.Status := impsurHeader.Status::Cancelled;
                        impsurHeader.Modify(true);
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
        CertApplic: Record "Certificate Application";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcplanHeader: Record "PROC-Procurement Plan Header";
        TenderHeader: Record "Tender HEader";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        impSurHeader: Record "FIN-Imprest Surr. Header";
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
            Database::"Certificate Application":
                begin
                    RecRef.SetTable(CertApplic);
                    CertApplic.Validate("Status", CertApplic.Status::Open);
                    CertApplic.Modify();
                    Variant := CertApplic;
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PhamacyHeader);
                    PhamacyHeader.Validate("Status", PhamacyHeader.Status::Pending);
                    PhamacyHeader.Modify();
                    Variant := PhamacyHeader;
                end;
            Database::"HRM-Medical Claims":
                begin
                    RecRef.SetTable(Medclaims);
                    Medclaims.Validate("Status", Medclaims.Status::Open);
                    Medclaims.Modify();
                    Variant := Medclaims;
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcplanHeader);
                    ProcplanHeader.Validate("Status", ProcplanHeader.Status::Open);
                    ProcplanHeader.Modify();
                    Variant := ProcplanHeader;
                end;
            Database::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate("Status", TenderHeader.Status::Open);
                    TenderHeader.Modify();
                    Variant := TenderHeader;
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate("Status", RFQHeader.Status::Open);
                    RFQHeader.Modify();
                    Variant := RFQHeader;
                end;
            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(PartTimeClaim);
                    PartTimeClaim.Validate("Status", PartTimeClaim.Status::Pending);
                    PartTimeClaim.Modify();
                    Variant := PartTimeClaim;
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate("Status", MealBooking.Status::New);
                    MealBooking.Modify();
                    Variant := MealBooking;
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    RecRef.SetTable(impSurHeader);
                    impSurHeader.Validate("Status", impSurHeader.Status::Pending);
                    impSurHeader.Modify();
                    Variant := impSurHeader;
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
        CertApplic: Record "Certificate Application";
        PhamacyHeader: Record "Pharmacy Requests Header";
        Medclaims: Record "HRM-Medical Claims";
        ProcplanHeader: Record "PROC-Procurement Plan Header";
        TenderHeader: Record "Tender Header";
        RFQHeader: Record "Proc-Purchase Quote Header";
        PartTimeClaim: Record "Parttime Claim Header";
        MealBooking: Record "CAT-Meal Booking Header";
        impsurHeader: Record "FIN-Imprest Surr. Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::Club:
                begin
                    RecRef.SetTable(club);
                    club.validate("Approval Status", club."Approval Status"::"Pending");
                    club.Modify;
                    Variant := club;
                end;
            Database::"Student Leave":
                begin
                    RecRef.SetTable(StudentLeave);
                    StudentLeave.Validate("Approval Status", StudentLeave."Approval Status"::"Pending");
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
            Database::"Certificate Application":
                begin
                    RecRef.SetTable(CertApplic);
                    CertApplic.Validate("Status", CertApplic.Status::Pending);
                    CertApplic.Modify();
                    Variant := CertApplic;
                end;
            Database::"Pharmacy Requests Header":
                begin
                    RecRef.SetTable(PhamacyHeader);
                    PhamacyHeader.Validate("Status", PhamacyHeader.Status::Pending);
                    PhamacyHeader.Modify();
                    Variant := PhamacyHeader;
                end;
            Database::"HRM-Medical Claims":
                begin
                    RecRef.SetTable(Medclaims);
                    Medclaims.Validate("Status", Medclaims.Status::Pending);
                    Medclaims.Modify();
                    Variant := Medclaims;
                end;
            Database::"PROC-Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcplanHeader);
                    ProcplanHeader.Validate("Status", ProcplanHeader.Status::"Pending Approval");
                    ProcplanHeader.Modify();
                    Variant := ProcplanHeader;
                end;
            Database::"Tender Header":
                begin
                    RecRef.SetTable(TenderHeader);
                    TenderHeader.Validate("Status", TenderHeader.Status::"Pending Approval");
                    TenderHeader.Modify();
                    Variant := TenderHeader;
                end;
            Database::"Proc-Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate("Status", RFQHeader.Status::"Pending Approval");
                    RFQHeader.Modify();
                    Variant := RFQHeader;
                end;
            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(PartTimeClaim);
                    PartTimeClaim.Validate("Status", PartTimeClaim.Status::"Pending Approval");
                    PartTimeClaim.Modify();
                    Variant := PartTimeClaim;
                end;
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    MealBooking.Validate("Status", MealBooking.Status::"Pending Approval");
                    MealBooking.Modify();
                    Variant := MealBooking;
                end;
            Database::"FIN-Imprest Surr. Header":
                begin
                    RecRef.SetTable(impSurHeader);
                    impSurHeader.Validate("Status", impSurHeader.Status::"Pending Approval");
                    impSurHeader.Modify();
                    Variant := impSurHeader;
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
        CertApplic: Record "Certificate Application";
        DocAttachment: Record "Document Attachment";
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
                    if not (StudentLeave."Approval Status" = StudentLeave."Approval Status"::Open) then
                        exit(false);
                    if not checkDocumentAttachmentExists(Variant) then
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

    procedure checkDocumentAttachmentExists(var Variant: Variant): Boolean
    var
        DocAttachment: Record "Document Attachment";
        RecRef: RecordRef;
        LeaveRequest: Record "Student Leave";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Student Leave":
                begin
                    RecRef.SetTable(LeaveRequest);
                    DocAttachment.Reset();
                    DocAttachment.SetRange("No.", LeaveRequest."Leave No.");
                    DocAttachment.SetRange("Table ID", Database::"Student Leave");
                    if DocAttachment.FindFirst() then
                        exit(true);
                end;
        end;
    end;

}
