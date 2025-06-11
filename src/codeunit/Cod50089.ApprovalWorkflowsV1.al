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
        //Employee Requisition
        OnSendEmployeeRequisitionRequestTxt: Label 'An Approval request for Employee Requisition is requested';
        OnCancelEmployeeRequisitionRequestTxt: Label 'An Approval request for Employee Requisition is Cancelled';
        RunWorkflowOnSendEmployeeRequisitionForApprovalCode: Label 'RUNWORKFLOWONSENDEMPLOYEEREQUISITIONFORAPPROVAL';
        RunWorkflowOnCancelEmployeeRequisitionForApprovalCode: Label 'RUNWORKFLOWONCANCELEMPLOYEEREQUISITIONFORAPPROVAL';
        //Special Exams
        OnSendSpecialExamsRequestTxt: Label 'Approval request for Special Exams is requested';
        OnCancelSpecialExamsRequestTxt: Label 'An Approval request for Special Exams is Cancelled';
        RunWorkflowOnSendSpecialExamsForApprovalCode: Label 'RUNWORKFLOWONSENDSPECIALSEXAMSFORAPPROVAL';
        RunWorkflowOnCancelSpecialExamsForApprovalCode: Label 'RUNWORKFLOWONCANCELSPECIALSEXAMSFORAPPROVAL';
        //Item Disposal
        OnSendItemDisposalRequestTxt: Label 'Approval request for Item Disposal is requested';
        OnCancelItemDisposalRequestTxt: Label 'An Approval request for Item Disposal is Cancelled';
        RunWorkflowOnSendItemDisposalForApprovalCode: Label 'RUNWORKFLOWONSENDITEMDISPOSALFORAPPROVAL';
        RunWorkflowOnCancelItemDisposalForApprovalCode: Label 'RUNWORKFLOWONCANCELITEMDISPOSALFORAPPROVAL';
        //Student Deferment/Withdrawal
        OnSendDefermentWithdrawalRequestTxt: Label 'Approval request for Student Deferment/Withdrawal is requested';
        OnCancelDefermentWithdrawalRequestTxt: Label 'An Approval request for Student Deferment/Withdrawal is Cancelled';
        RunWorkflowOnSendDefermentWithdrawalForApprovalCode: Label 'RUNWORKFLOWONSENDDEFERMENTWITHDRAWALFORAPPROVAL';
        RunWorkflowOnCancelDefermentWithdrawalForApprovalCode: Label 'RUNWORKFLOWONCANCELDEFERMENTWITHDRAWALFORAPPROVAL';
        //Supervision Tracking
        OnSendSupervisionTrackingRequestTxt: Label 'Approval request for Supervision Tracking is requested';
        OnCancelSupervisionTrackingRequestTxt: Label 'An Approval request for Supervision Tracking is Cancelled';
        RunWorkflowOnSendSupervisionTrackingForApprovalCode: Label 'RUNWORKFLOWONSENDSUPERVISIONTRACKINGFORAPPROVAL';
        RunWorkflowOnCancelSupervisionTrackingForApprovalCode: Label 'RUNWORKFLOWONCANCELSUPERVISIONTRACKINGFORAPPROVAL';
        //Venue Booking
        OnSendVenueBookingRequestTxt: Label 'Approval request for Venue Booking is requested';
        OnCancelVenueBookingRequestTxt: Label 'An Approval request for Venue Booking is Cancelled';
        RunWorkflowOnSendVenueBookingForApprovalCode: Label 'RUNWORKFLOWONSENDVENUEBOOKINGFORAPPROVAL';
        RunWorkflowOnCancelVenueBookingForApprovalCode: Label 'RUNWORKFLOWONCANCELVENUEBOOKINGFORAPPROVAL';
        //Audit Header
        OnSendAuditHeaderRequestTxt: Label 'Approval request for Audit Header is requested';
        OnCancelAuditHeaderRequestTxt: Label 'An Approval request for Audit Header is Cancelled';
        RunWorkflowOnSendAuditHeaderForApprovalCode: Label 'RUNWORKFLOWONSENDAUDITHEADERFORAPPROVAL';
        RunWorkflowOnCancelAuditHeaderForApprovalCode: Label 'RUNWORKFLOWONCANCELAUDITHEADERFORAPPROVAL';
        //Store Requisition
        OnSendStoreRequisitionRequestTxt: Label 'Approval request for SRN is requested';
        OnCancelStoreRequisitionRequestTxt: Label 'An Approval request for SRN is Cancelled';
        RunWorkflowOnSendStoreRequisitionForApprovalCode: Label 'RUNWORKFLOWONSENDSRNFORAPPROVAL';
        RunWorkflowOnCancelStoreRequisitionForApprovalCode: Label 'RUNWORKFLOWONCANCELSRNFORAPPROVAL';
        //Item Transfer Header
        OnSendItemTransferRequestTxt: Label 'Approval request for Item Transfer is requested';
        OnCancelItemTransferRequestTxt: Label 'An Approval request for Item Transfer is Cancelled';
        RunWorkflowOnSendItemTransferForApprovalCode: Label 'RUNWORKFLOWONSENDITEMTRANSFERFORAPPROVAL';
        RunWorkflowOnCancelItemTransferForApprovalCode: Label 'RUNWORKFLOWONCANCELITEMTRANSFERFORAPPROVAL';
        //Mileage Claim
        OnSendMileageClaimRequestTxt: Label 'Approval request for Mileage Claim is requested';
        OnCancelMileageClaimRequestTxt: Label 'An Approval request for Mileage Claim is Cancelled';
        RunWorkflowOnSendMileageClaimForApprovalCode: Label 'RUNWORKFLOWONSENDMILEAGECLAIMFORAPPROVAL';
        RunWorkflowOnCancelMileageClaimForApprovalCode: Label 'RUNWORKFLOWONCANCELMILEAGECLAIMFORAPPROVAL';
        //Transport Requisition
        OnSendTransportReqforApprovalTxt: Label 'Approval request for Transport is requested';
        OnCancelTransportReqforApprovalTxt: Label 'An Approval request for Transport is Cancelled';
        RunWorkflowOnSendTransportReqforApprovalCode: Label 'RUNWORKFLOWONSENDTRANSPORTREQFORAPPROVAL';
        RunWorkflowOnCancelTransportReqforApprovalCode: Label 'RUNWORKFLOWONCANCELTRANSPORTREQFORAPPROVAL';
        //Fuel & Maintenance Request
        OnSendFuelReqforApprovalTxt: Label 'Approval request for Fuel & Maintenance is requested';
        OnCancelFuelReqforApprovalTxt: Label 'An Approval request for Fuel & Maintenance is Cancelled';
        RunWorkflowOnSendFuelReqforApprovalCode: Label 'RUNWORKFLOWONSENDFUELREQFORAPPROVAL';
        RunWorkflowOnCancelFuelReqforApprovalCode: Label 'RUNWORKFLOWONCANCELFUELREQFORAPPROVAL';


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
            Database::"HRM-Employee Requisitions":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendEmployeeRequisitionForApprovalCode));
            Database::"Aca-Special Exams Details":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendSpecialExamsForApprovalCode));
            Database::"Item Disposal Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendItemDisposalForApprovalCode));
            Database::"Student Deferment/Withdrawal":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendDefermentWithdrawalForApprovalCode));
            Database::"Supervision Tracking":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendSupervisionTrackingForApprovalCode));
            Database::"Gen-Venue Booking":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendVenueBookingForApprovalCode));
            Database::"Audit Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendAuditHeaderForApprovalCode));
            Database::"PROC-Store Requistion Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendStoreRequisitionForApprovalCode));
            Database::"Item Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendItemTransferForApprovalCode));
            Database::"FLT-Mileage Claim Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendMileageClaimForApprovalCode));
            Database::"FLT-Transport Requisition":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendTransportReqforApprovalCode));
            Database::"FLT-Fuel & Maintenance Req.":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendFuelReqforApprovalCode));
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
        //Employee Requisition
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendEmployeeRequisitionForApprovalCode, Database::"HRM-Employee Requisitions", OnSendEmployeeRequisitionRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelEmployeeRequisitionForApprovalCode, Database::"HRM-Employee Requisitions", OnCancelEmployeeRequisitionRequestTxt, 0, false);
        //Special Exams
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendSpecialExamsForApprovalCode, Database::"Aca-Special Exams Details", OnSendSpecialExamsRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSpecialExamsForApprovalCode, Database::"Aca-Special Exams Details", OnCancelSpecialExamsRequestTxt, 0, false);
        //Item Disposal
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendItemDisposalForApprovalCode, Database::"Item Disposal Header", OnSendItemDisposalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelItemDisposalForApprovalCode, Database::"Item Disposal Header", OnCancelItemDisposalRequestTxt, 0, false);
        //Student Deferment/Withdrawal
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDefermentWithdrawalForApprovalCode, Database::"Student Deferment/Withdrawal", OnSendDefermentWithdrawalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDefermentWithdrawalForApprovalCode, Database::"Student Deferment/Withdrawal", OnCancelDefermentWithdrawalRequestTxt, 0, false);
        //Supervision Tracking
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendSupervisionTrackingForApprovalCode, Database::"Supervision Tracking", OnSendSupervisionTrackingRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSupervisionTrackingForApprovalCode, Database::"Supervision Tracking", OnCancelSupervisionTrackingRequestTxt, 0, false);
        //Venue Booking
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendVenueBookingForApprovalCode, Database::"Gen-Venue Booking", OnSendVenueBookingRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVenueBookingForApprovalCode, Database::"Gen-Venue Booking", OnCancelVenueBookingRequestTxt, 0, false);
        //Audit Header
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendAuditHeaderForApprovalCode, Database::"Audit Header", OnSendAuditHeaderRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAuditHeaderForApprovalCode, Database::"Audit Header", OnCancelAuditHeaderRequestTxt, 0, false);
        //Store Requisition
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendStoreRequisitionForApprovalCode, Database::"PROC-Store Requistion Header", OnSendStoreRequisitionRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStoreRequisitionForApprovalCode, Database::"PROC-Store Requistion Header", OnCancelStoreRequisitionRequestTxt, 0, false);
        //Item Transfer
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendItemTransferForApprovalCode, Database::"Item Transfer Header", OnSendItemTransferRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelItemTransferForApprovalCode, Database::"Item Transfer Header", OnCancelItemTransferRequestTxt, 0, false);
        //Mileage Claim
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendMileageClaimForApprovalCode, Database::"FLT-Mileage Claim Header", OnSendMileageClaimRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMileageClaimForApprovalCode, Database::"FLT-Mileage Claim Header", OnCancelMileageClaimRequestTxt, 0, false);
        //Transport Requisition
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendTransportReqforApprovalCode, Database::"FLT-Transport Requisition", OnSendTransportReqforApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTransportReqforApprovalCode, Database::"FLT-Transport Requisition", OnCancelTransportReqforApprovalTxt, 0, false);
        //Fuel & Maintenance Request
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendFuelReqforApprovalCode, Database::"FLT-Fuel & Maintenance Req.", OnSendFuelReqforApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFuelReqforApprovalCode, Database::"FLT-Fuel & Maintenance Req.", OnCancelFuelReqforApprovalTxt, 0, false);
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
            Database::"HRM-Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmployeeRequisitionForApprovalCode, Variant);
            Database::"Aca-Special Exams Details":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSpecialExamsForApprovalCode, Variant);
            Database::"Item Disposal Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendItemDisposalForApprovalCode, Variant);
            Database::"Student Deferment/Withdrawal":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDefermentWithdrawalForApprovalCode, Variant);
            Database::"Supervision Tracking":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSupervisionTrackingForApprovalCode, Variant);
            Database::"Gen-Venue Booking":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVenueBookingForApprovalCode, Variant);
            Database::"Audit Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAuditHeaderForApprovalCode, Variant);
            Database::"PROC-Store Requistion Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreRequisitionForApprovalCode, Variant);
            Database::"Item Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendItemTransferForApprovalCode, Variant);
            Database::"FLT-Mileage Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMileageClaimForApprovalCode, Variant);
            Database::"FLT-Transport Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportReqforApprovalCode, Variant);
            Database::"FLT-Fuel & Maintenance Req.":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendFuelReqforApprovalCode, Variant);
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
            Database::"HRM-Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmployeeRequisitionForApprovalCode, Variant);
            Database::"Aca-Special Exams Details":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSpecialExamsForApprovalCode, Variant);
            Database::"Item Disposal Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelItemDisposalForApprovalCode, Variant);
            Database::"Student Deferment/Withdrawal":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDefermentWithdrawalForApprovalCode, Variant);
            Database::"Supervision Tracking":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSupervisionTrackingForApprovalCode, Variant);
            Database::"Gen-Venue Booking":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVenueBookingForApprovalCode, Variant);
            Database::"Audit Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAuditHeaderForApprovalCode, Variant);
            Database::"PROC-Store Requistion Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStoreRequisitionForApprovalCode, Variant);
            Database::"Item Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelItemTransferForApprovalCode, Variant);
            Database::"FLT-Mileage Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMileageClaimForApprovalCode, Variant);
            Database::"FLT-Transport Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportReqforApprovalCode, Variant);
            Database::"FLT-Fuel & Maintenance Req.":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelFuelReqforApprovalCode, Variant);
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
        EmployeeRequisition: Record "HRM-Employee Requisitions";
        SpecialExams: Record "Aca-Special Exams Details";
        ItemDisposal: Record "Item Disposal Header";
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        SupervisionTracking: Record "Supervision Tracking";
        VenueBooking: Record "Gen-Venue Booking";
        AuditHeader: Record "Audit Header";
        StoreRequisition: Record "PROC-Store Requistion Header";
        ItemTransferHeader: Record "Item Transfer Header";
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
        TransportReq: Record "FLT-Transport Requisition";
        FuelReq: Record "FLT-Fuel & Maintenance Req.";
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
            Database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(EmployeeRequisition);
                    EmployeeRequisition.Validate("Status", EmployeeRequisition.Status::New);
                    EmployeeRequisition.Modify();
                    Handled := true;
                end;
            Database::"Aca-Special Exams Details":
                begin
                    RecRef.SetTable(SpecialExams);
                    SpecialExams.Validate("Status", SpecialExams.Status::New);
                    SpecialExams.Modify();
                    Handled := true;
                end;
            Database::"Item Disposal Header":
                begin
                    RecRef.SetTable(ItemDisposal);
                    ItemDisposal.Validate("Status", ItemDisposal.Status::Open);
                    ItemDisposal.Modify();
                    Handled := true;
                end;
            Database::"Student Deferment/Withdrawal":
                begin
                    RecRef.SetTable(StudentDefermentWithdrawal);
                    StudentDefermentWithdrawal.Validate(Status, StudentDefermentWithdrawal.Status::Open);
                    StudentDefermentWithdrawal.Modify();
                    Handled := true;
                end;
            Database::"Supervision Tracking":
                begin
                    RecRef.SetTable(SupervisionTracking);
                    SupervisionTracking.Validate(Status, SupervisionTracking.Status::Open);
                    SupervisionTracking.Modify();
                    Handled := true;
                end;
            Database::"Gen-Venue Booking":
                begin
                    RecRef.SetTable(VenueBooking);
                    VenueBooking.Validate(Status, VenueBooking.Status::"Pending Approval");
                    VenueBooking.Modify();
                    Handled := true;
                end;
            Database::"Audit Header":
                begin
                    RecRef.SetTable(AuditHeader);
                    AuditHeader.Validate("Status", AuditHeader.Status::"Pending Approval");
                    AuditHeader.Modify();
                    Handled := true;
                end;
            Database::"PROC-Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.Validate("Status", StoreRequisition.Status::"Pending Approval");
                    StoreRequisition.Modify();
                    Handled := true;
                end;
            Database::"Item Transfer Header":
                begin
                    RecRef.SetTable(ItemTransferHeader);
                    ItemTransferHeader.Validate("Approval Status", ItemTransferHeader."Approval Status"::Open);
                    ItemTransferHeader.Modify();
                    Handled := true;
                end;
            Database::"FLT-Mileage Claim Header":
                begin
                    RecRef.SetTable(MileageClaimHeader);
                    MileageClaimHeader.Validate("Status", MileageClaimHeader.Status::Open);
                    MileageClaimHeader.Modify();
                    Handled := true;
                end;
            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(TransportReq);
                    TransportReq.Validate("Status", TransportReq.Status::Open);
                    TransportReq.Modify();
                    Handled := true;
                end;
            Database::"FLT-Fuel & Maintenance Req.":
                begin
                    RecRef.SetTable(FuelReq);
                    FuelReq.Validate("Status", FuelReq.Status::Open);
                    FuelReq.Modify();
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
        Emprequisition: Record "HRM-Employee Requisitions";
        SpecialExams: Record "Aca-Special Exams Details";
        ItemDisposalHeader: Record "Item Disposal Header";
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        SupervisionTracking: Record "Supervision Tracking";
        VenueBooking: Record "Gen-Venue Booking";
        AuditHeader: Record "Audit Header";
        StoreRequisition: Record "PROC-Store Requistion Header";
        ItemTransferHeader: Record "Item Transfer Header";
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
        TransportReq: Record "FLT-Transport Requisition";
        FuelReq: Record "FLT-Fuel & Maintenance Req.";
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
            Database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(Emprequisition);
                    Emprequisition.Validate("Status", Emprequisition.Status::"Pending Approval");
                    Emprequisition.Modify();
                    IsHandled := true;
                end;
            Database::"Aca-Special Exams Details":
                begin
                    RecRef.SetTable(SpecialExams);
                    SpecialExams.Validate("Status", SpecialExams.Status::"Pending Approval");
                    SpecialExams.Modify();
                    IsHandled := true;
                end;
            Database::"Item Disposal Header":
                begin
                    RecRef.SetTable(ItemDisposalHeader);
                    ItemDisposalHeader.Validate("Status", ItemDisposalHeader.Status::"Pending Approval");
                    ItemDisposalHeader.Modify();
                    IsHandled := true;
                end;
            Database::"Student Deferment/Withdrawal":
                begin
                    RecRef.SetTable(StudentDefermentWithdrawal);
                    StudentDefermentWithdrawal.Validate(Status, StudentDefermentWithdrawal.Status::Pending);
                    StudentDefermentWithdrawal.Modify();
                    IsHandled := true;
                end;
            Database::"Supervision Tracking":
                begin
                    RecRef.SetTable(SupervisionTracking);
                    SupervisionTracking.Validate(Status, SupervisionTracking.Status::"Pending Approval");
                    SupervisionTracking.Modify();
                    IsHandled := true;
                end;
            Database::"Gen-Venue Booking":
                begin
                    RecRef.SetTable(VenueBooking);
                    VenueBooking.Validate(Status, VenueBooking.Status::"Pending Approval");
                    VenueBooking.Modify();
                    IsHandled := true;
                end;
            Database::"Audit Header":
                begin
                    RecRef.SetTable(AuditHeader);
                    AuditHeader.Validate(Status, AuditHeader.Status::"Pending Approval");
                    AuditHeader.Modify();
                    IsHandled := true;
                end;
            Database::"PROC-Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.Validate(Status, StoreRequisition.Status::"Pending Approval");
                    StoreRequisition.Modify();
                    IsHandled := true;
                end;
            Database::"Item Transfer Header":
                begin
                    RecRef.SetTable(ItemTransferHeader);
                    ItemTransferHeader.Validate("Approval Status", ItemTransferHeader."Approval Status"::"Pending");
                    ItemTransferHeader.Modify();
                    IsHandled := true;
                end;
            Database::"FLT-Mileage Claim Header":
                begin
                    RecRef.SetTable(MileageClaimHeader);
                    MileageClaimHeader.Validate("Status", MileageClaimHeader.Status::"Pending Approval");
                    MileageClaimHeader.Modify();
                    IsHandled := true;
                end;
            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(TransportReq);
                    TransportReq.Validate("Status", TransportReq.Status::"Pending Approval");
                    TransportReq.Modify();
                    IsHandled := true;
                end;
            Database::"FLT-Fuel & Maintenance Req.":
                begin
                    RecRef.SetTable(FuelReq);
                    FuelReq.Validate("Status", FuelReq.Status::Submitted);
                    FuelReq.Modify();
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
        EmployeeRequisition: Record "HRM-Employee Requisitions";
        SpecialExams: Record "Aca-Special Exams Details";
        ItemDisposalHeader: Record "Item Disposal Header";
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        SupervisionTracking: Record "Supervision Tracking";
        VenueBooking: Record "Gen-Venue Booking";
        AuditHeader: Record "Audit Header";
        StoreRequisition: Record "PROC-Store Requistion Header";
        ItemTransferHeader: Record "Item Transfer Header";
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
        TransportReq: Record "FLT-Transport Requisition";
        FuelReq: Record "FLT-Fuel & Maintenance Req.";
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
            Database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(EmployeeRequisition);
                    ApprovalEntryArgument."Document No." := EmployeeRequisition."Requisition No.";
                end;
            Database::"Aca-Special Exams Details":
                begin
                    RecRef.SetTable(SpecialExams);
                    ApprovalEntryArgument."Document No." := SpecialExams."Document No.";
                end;
            Database::"Item Disposal Header":
                begin
                    RecRef.SetTable(ItemDisposalHeader);
                    ApprovalEntryArgument."Document No." := ItemDisposalHeader."No.";
                end;
            Database::"Student Deferment/Withdrawal":
                begin
                    RecRef.SetTable(StudentDefermentWithdrawal);
                    ApprovalEntryArgument."Document No." := StudentDefermentWithdrawal."No.";
                end;
            Database::"Supervision Tracking":
                begin
                    RecRef.SetTable(SupervisionTracking);
                    ApprovalEntryArgument."Document No." := SupervisionTracking."Document No.";
                end;
            Database::"Gen-Venue Booking":
                begin
                    RecRef.SetTable(VenueBooking);
                    ApprovalEntryArgument."Document No." := VenueBooking."Booking Id";
                end;
            Database::"Audit Header":
                begin
                    RecRef.SetTable(AuditHeader);
                    ApprovalEntryArgument."Document No." := AuditHeader."No.";
                end;
            Database::"PROC-Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    ApprovalEntryArgument."Document No." := StoreRequisition."No.";
                end;
            Database::"Item Transfer Header":
                begin
                    RecRef.SetTable(ItemTransferHeader);
                    ApprovalEntryArgument."Document No." := ItemTransferHeader."No.";
                end;
            Database::"FLT-Mileage Claim Header":
                begin
                    RecRef.SetTable(MileageClaimHeader);
                    ApprovalEntryArgument."Document No." := MileageClaimHeader."No.";
                    ApprovalEntryArgument.Amount := MileageClaimHeader."Total Estimated Cost";
                end;
            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(TransportReq);
                    ApprovalEntryArgument."Document No." := TransportReq."Transport Requisition No";
                end;
            Database::"FLT-Fuel & Maintenance Req.":
                begin
                    RecRef.SetTable(FuelReq);
                    ApprovalEntryArgument."Document No." := FuelReq."Requisition No";
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
        Emprequisition: Record "HRM-Employee Requisitions";
        SpecialExams: Record "Aca-Special Exams Details";
        ItemDisposalHeader: Record "Item Disposal Header";
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        DefermentWithdrawalMgmt: Codeunit "Student Def_Withdrawal Mgmt";
        SupervisionTracking: Record "Supervision Tracking";
        VenueBooking: Record "Gen-Venue Booking";
        AuditHeader: Record "Audit Header";
        StoreRequisition: Record "PROC-Store Requistion Header";
        ItemTransferHeader: Record "Item Transfer Header";
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
        TransportReq: Record "FLT-Transport Requisition";
        FuelReq: Record "FLT-Fuel & Maintenance Req.";
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
            Database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(Emprequisition);
                    Emprequisition.Validate("Status", Emprequisition.Status::Approved);
                    Emprequisition.Modify();
                    Handled := true;
                end;
            Database::"Aca-Special Exams Details":
                begin
                    RecRef.SetTable(SpecialExams);
                    SpecialExams.Validate("Status", SpecialExams.Status::Approved);
                    SpecialExams.Modify();
                    Handled := true;
                end;
            Database::"Item Disposal Header":
                begin
                    RecRef.SetTable(ItemDisposalHeader);
                    ItemDisposalHeader.Validate("Status", ItemDisposalHeader.Status::Approved);
                    ItemDisposalHeader.Modify();
                    Handled := true;
                end;
            Database::"Student Deferment/Withdrawal":
                begin
                    RecRef.SetTable(StudentDefermentWithdrawal);
                    StudentDefermentWithdrawal.Validate(Status, StudentDefermentWithdrawal.Status::Approved);
                    StudentDefermentWithdrawal.Modify();
                    DefermentWithdrawalMgmt.HandleApprovedDefermentWithdrawal(StudentDefermentWithdrawal);
                    Handled := true;
                end;
            Database::"Supervision Tracking":
                begin
                    RecRef.SetTable(SupervisionTracking);
                    SupervisionTracking.Validate(Status, SupervisionTracking.Status::Approved);
                    SupervisionTracking.Modify();
                    Handled := true;
                end;
            Database::"Gen-Venue Booking":
                begin
                    RecRef.SetTable(VenueBooking);
                    VenueBooking.Validate(Status, VenueBooking.Status::Approved);
                    VenueBooking.Modify();
                    Handled := true;
                end;
            Database::"Audit Header":
                begin
                    RecRef.SetTable(AuditHeader);
                    AuditHeader.Validate(Status, AuditHeader.Status::Released);
                    AuditHeader.Modify();
                    Handled := true;
                end;
            Database::"PROC-Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequisition);
                    StoreRequisition.Validate(Status, StoreRequisition.Status::Released);
                    StoreRequisition.Modify();
                    Handled := true;
                end;
            Database::"Item Transfer Header":
                begin
                    RecRef.SetTable(ItemTransferHeader);
                    ItemTransferHeader.Validate("Approval Status", ItemTransferHeader."Approval Status"::Approved);
                    ItemTransferHeader.Validate(Status, ItemTransferHeader.Status::Released);
                    ItemTransferHeader.Modify();
                    Handled := true;
                end;
            Database::"FLT-Mileage Claim Header":
                begin
                    RecRef.SetTable(MileageClaimHeader);
                    MileageClaimHeader.Validate(Status, MileageClaimHeader.Status::Approved);
                    MileageClaimHeader.Modify();
                    Handled := true;
                end;
            Database::"FLT-Transport Requisition":
                begin
                    RecRef.SetTable(TransportReq);
                    TransportReq.Validate(Status, TransportReq.Status::Approved);
                    TransportReq.Modify();
                    Handled := true;
                end;
            Database::"FLT-Fuel & Maintenance Req.":
                begin
                    RecRef.SetTable(FuelReq);
                    FuelReq.Validate(Status, FuelReq.Status::Approved);
                    FuelReq.Modify();
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
        Emprequisition: Record "HRM-Employee Requisitions";
        SpecialExams: Record "Aca-Special Exams Details";
        ItemDisposalHeader: Record "Item Disposal Header";
        StudentDefermentWithdrawal: Record "Student Deferment/Withdrawal";
        SupervisionTracking: Record "Supervision Tracking";
        VenueBooking: Record "Gen-Venue Booking";
        AuditHeader: Record "Audit Header";
        StoreRequisition: Record "PROC-Store Requistion Header";
        ItemTransferHeader: Record "Item Transfer Header";
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
        TransportReq: Record "FLT-Transport Requisition";
        FuelReq: Record "FLT-Fuel & Maintenance Req.";
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
            Database::"HRM-Employee Requisitions":
                begin
                    if Emprequisition.Get(ApprovalEntry."Document No.") then begin
                        Emprequisition.Status := Emprequisition.Status::Rejected;
                        Emprequisition.Modify(true);
                    end;
                end;
            Database::"Aca-Special Exams Details":
                begin
                    SpecialExams.Reset();
                    SpecialExams.SetRange("Document No.", ApprovalEntry."Document No.");
                    if SpecialExams.FindFirst() then begin
                        SpecialExams.Status := SpecialExams.Status::Rejected;
                        SpecialExams.Modify(true);

                    end;
                end;
            Database::"Item Disposal Header":
                begin
                    if ItemDisposalHeader.Get(ApprovalEntry."Document No.") then begin
                        ItemDisposalHeader.Status := ItemDisposalHeader.Status::Open;
                        ItemDisposalHeader.Modify(true);
                    end;
                end;
            Database::"Student Deferment/Withdrawal":
                begin
                    if StudentDefermentWithdrawal.Get(ApprovalEntry."Document No.") then begin
                        StudentDefermentWithdrawal.Status := StudentDefermentWithdrawal.Status::Rejected;
                        StudentDefermentWithdrawal.Modify(true);
                    end;
                end;
            Database::"Supervision Tracking":
                begin
                    if SupervisionTracking.Get(ApprovalEntry."Document No.") then begin
                        SupervisionTracking.Status := SupervisionTracking.Status::Rejected;
                        SupervisionTracking.Modify(true);
                    end;
                end;
            Database::"Gen-Venue Booking":
                begin
                    if VenueBooking.Get(ApprovalEntry."Document No.") then begin
                        VenueBooking.Status := VenueBooking.Status::Rejected;
                        VenueBooking.Modify(true);
                    end;
                end;
            Database::"Audit Header":
                begin
                    if AuditHeader.Get(ApprovalEntry."Document No.") then begin
                        AuditHeader.Status := AuditHeader.Status::Open;
                        AuditHeader.Modify(true);
                    end;
                end;
            Database::"PROC-Store Requistion Header":
                begin
                    if StoreRequisition.Get(ApprovalEntry."Document No.") then begin
                        StoreRequisition.Status := StoreRequisition.Status::Open;
                        StoreRequisition.Modify(true);
                    end;
                end;
            Database::"Item Transfer Header":
                begin
                    if ItemTransferHeader.Get(ApprovalEntry."Document No.") then begin
                        ItemTransferHeader."Approval Status" := ItemTransferHeader."Approval Status"::Rejected;
                        ItemTransferHeader.Modify(true);
                    end;
                end;
            Database::"FLT-Mileage Claim Header":
                begin
                    if MileageClaimHeader.Get(ApprovalEntry."Document No.") then begin
                        MileageClaimHeader.Status := MileageClaimHeader.Status::Rejected;
                        MileageClaimHeader.Modify(true);
                    end;
                end;
            Database::"FLT-Transport Requisition":
                begin
                    if TransportReq.Get(ApprovalEntry."Document No.") then begin
                        TransportReq."Approval Stage" := TransportReq."Approval Stage"::New;
                        TransportReq.Status := TransportReq.Status::Open;
                        TransportReq.Modify(true);
                    end;
                end;
            Database::"FLT-Fuel & Maintenance Req.":
                begin
                    if FuelReq.Get(ApprovalEntry."Document No.") then begin
                        FuelReq.Status := FuelReq.Status::Open;
                        FuelReq.Modify(true);
                    end;
                end;
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
            // Database::"Student Leave":
            //     begin
            //         RecRef.SetTable(StudentLeave);
            //         if not (StudentLeave."Approval Status" = StudentLeave."Approval Status"::Open) then
            //             exit(false);
            //         if GuiAllowed then
            //             if not checkDocumentAttachmentExists(Variant) then
            //                 exit(false);
            //         exit(true);
            //     end;
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
