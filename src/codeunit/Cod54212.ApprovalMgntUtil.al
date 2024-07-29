codeunit 54212 "Approval Mgnt. Util."
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext.";
        NoWorkflowEnableErr: TextConst ENU = 'No approval worklow for this record type is enabled.';
        NothingToApproveErr: TextConst ENU = 'Lines Must Contain Record(s)';
        /*Repair Request */
        RepairRequest: Record "Repair Request";
        /* Maintence Schedule */
        MaintenceSchedule: Record "Maintenance Schedule";
        /* Maintenance Request */
        MaintenanceRequest: Record Project;
        /* Utility Bill */
        UtilityBill: Record "Utility Bill";
        //meeting Booking
        meetingBooking: Record MeetingsInfo;
        //studClearance
        studentClearance: Record "Student Clerance";
    /* ****************************************************************************************************************************************** */
    // StudentClearance
    [IntegrationEvent(false, false)]

    procedure OnSendstudentClearanceForApproval(var studentClearance: Record "Student Clerance")
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelstudentClearanceForApproval(var studentClearance: Record "Student Clerance")
    begin

    end;

    procedure CheckstudentClearanceWorkflowEnable(var studentClearance: Record "Student Clerance"): Boolean
    begin
        IF NOT IsstudentClearanceApplicationApprovalsWorkflowEnable(studentClearance) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsstudentClearanceApplicationApprovalsWorkflowEnable(var studentClearance: Record "Student Clerance"): Boolean

    begin
        IF studentClearance."Status" <> studentClearance."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(studentClearance, WorkflowEventHandling.RunWorkflowOnSendUtilityBillForApprovalCode));
    end;

    //Meeting   Booking
    [IntegrationEvent(false, false)]

    procedure OnSendMeetingBookingForApproval(var meetingBooking: Record MeetingsInfo)
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelMeetingBookingForApproval(var meetingBooking: Record MeetingsInfo)
    begin

    end;

    procedure CheckmeetingBookingWorkflowEnable(var meetingBooking: Record MeetingsInfo): Boolean
    begin
        IF NOT IsmeetingBookingApplicationApprovalsWorkflowEnable(meetingBooking) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsmeetingBookingApplicationApprovalsWorkflowEnable(var meetingBooking: Record MeetingsInfo): Boolean

    begin
        IF meetingBooking."Status" <> meetingBooking."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(meetingBooking, WorkflowEventHandling.RunWorkflowOnSendMeetingBookingForApprovalCode));
    end;
    /* Utility Bill */
    [IntegrationEvent(false, false)]

    procedure OnSendUtilityBillForApproval(var UtilityBill: Record "Utility Bill")
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelUtilityBillForApproval(var UtilityBill: Record "Utility Bill")
    begin

    end;

    procedure CheckUtilityBillsWorkflowEnable(var UtilityBill: Record "Utility Bill"): Boolean
    begin
        IF NOT IsUtilityBillApplicationApprovalsWorkflowEnable(UtilityBill) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsUtilityBillApplicationApprovalsWorkflowEnable(var UtilityBill: Record "Utility Bill"): Boolean

    begin
        IF UtilityBill."Status" <> UtilityBill."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(UtilityBill, WorkflowEventHandling.RunWorkflowOnSendUtilityBillForApprovalCode));
    end;

    /* Maintenance Request */
    [IntegrationEvent(false, false)]

    procedure OnSendMaintenanceRequestForApproval(var MaintenanceRequestw: Record "project")
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelMaintenanceRequestForApproval(var MaintenanceRequest: Record "project")
    begin

    end;

    procedure CheckMaintenanceRequestsWorkflowEnable(var MaintenanceRequestw: Record "project"): Boolean
    begin
        IF NOT IsMaintenanceRequestApplicationApprovalsWorkflowEnable(MaintenanceRequest) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsMaintenanceRequestApplicationApprovalsWorkflowEnable(var MaintenanceRequest: Record "Project"): Boolean

    begin
        IF MaintenanceRequest."Status" <> MaintenanceRequest."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(MaintenanceRequest, WorkflowEventHandling.RunWorkflowOnSendMaintenanceRequestForApprovalCode));
    end;

    /* Maintence Schedule */
    [IntegrationEvent(false, false)]

    procedure OnSendMaintenceScheduleForApproval(var MaintenceSchedule: Record "Maintenance Schedule")
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelMaintenceScheduleForApproval(var MaintenceSchedule: Record "Maintenance Schedule")
    begin

    end;

    procedure CheckMaintenceSchedulesWorkflowEnable(var MaintenceSchedule: Record "Maintenance Schedule"): Boolean
    begin
        IF NOT IsMaintenceScheduleApplicationApprovalsWorkflowEnable(MaintenceSchedule) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsMaintenceScheduleApplicationApprovalsWorkflowEnable(var MaintenceSchedule: Record "Maintenance Schedule"): Boolean

    begin
        IF MaintenceSchedule."Status" <> MaintenceSchedule."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(MaintenceSchedule, WorkflowEventHandling.RunWorkflowOnSendMaintenceScheduleForApprovalCode));
    end;

    /*Repair Request */
    [IntegrationEvent(false, false)]

    procedure OnSendRepairRequestForApproval(var RepairRequest: Record "Repair Request")
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelRepairRequestForApproval(var RepairRequest: Record "Repair Request")
    begin

    end;

    procedure CheckRepairRequestsWorkflowEnable(var RepairRequest: Record "Repair Request"): Boolean
    begin
        IF NOT IsRepairRequestApplicationApprovalsWorkflowEnable(RepairRequest) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsRepairRequestApplicationApprovalsWorkflowEnable(var RepairRequest: Record "Repair Request"): Boolean

    begin
        IF RepairRequest."Status" <> RepairRequest."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(RepairRequest, WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode));
    end;

    /* ****************************************************************************************************************************************** */

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    begin

        case RecRef.Number of
            /*Repair Request */
            Database::"Repair Request":
                begin
                    RecRef.SetTable(RepairRequest);
                    ApprovalEntryArgument."Document No." := RepairRequest."No.";
                end;
            /* Maintence Schedule */
            Database::"Maintenance Schedule":
                begin
                    RecRef.SetTable(MaintenceSchedule);
                    ApprovalEntryArgument."Document No." := MaintenceSchedule."No.";
                end;
            /* Maintenance Request */
            Database::"Maintenance Request":
                begin
                    RecRef.SetTable(MaintenanceRequest);
                    ApprovalEntryArgument."Document No." := MaintenanceRequest."No.";
                end;
            /* Utility Bill */
            Database::"Utility Bill":
                begin
                    RecRef.SetTable(UtilityBill);
                    ApprovalEntryArgument."Document No." := UtilityBill."No.";
                end;
            //MeetingBooking
            Database::MeetingsInfo:
                begin
                    RecRef.SetTable(meetingBooking);
                    ApprovalEntryArgument."Document No." := meetingBooking."Meeting Code";
                end;
        end;

    end;

}
