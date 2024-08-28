codeunit 50075 "Workflow Event Handling Ext."
{

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        /*Repair Request */
        RepairRequestSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Repair Request is Requested';
        RepairRequestRequestCancelEventDescTxt: TextConst ENU = 'Approval of Repair Request is Canceled';
        /* Maintence Schedule */
        MaintenceScheduleSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Maintence Schedule is Requested';
        MaintenceScheduleRequestCancelEventDescTxt: TextConst ENU = 'Approval of Maintence Schedule is Canceled';
        /* Maintenance Request */
        MaintenanceRequestSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Maintenance Request is Requested';
        MaintenanceRequestRequestCancelEventDescTxt: TextConst ENU = 'Approval of Maintenance Request is Canceled';
        /* Utility Bill */
        UtilityBillSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Utility Bill is Requested';
        UtilityBillRequestCancelEventDescTxt: TextConst ENU = 'Approval of Utility Bill is Canceled';
        //meeting Booking
        meetingBookingSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Meeting Booking is Requested';
        meetingBookingRequestCancelEventDescTxt: TextConst ENU = 'Approval of Meeting Booking is Canceled';
        //studentClearance
        studentClearanceForApprovalEventDescTxt: TextConst ENU = 'Approval of Student Clearance is Requested';
        studentclearanceRequestCancelEventDescTxt: TextConst ENU = 'Approval of Student Clearance is Canceled';


    /* *************************************************************************************************************************************/
    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        /*Repair Request */
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRepairRequestForApprovalCode, Database::"Repair Request", RepairRequestSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRepairRequestCode, Database::"Repair Request", RepairRequestRequestCancelEventDescTxt, 0, false);
        /* Maintence Schedule */
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendMaintenceScheduleForApprovalCode, Database::"Maintenance Schedule", MaintenceScheduleSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMaintenceScheduleCode, Database::"Maintenance Schedule", MaintenceScheduleRequestCancelEventDescTxt, 0, false);
        /* Maintenance Request */
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendMaintenanceRequestForApprovalCode, Database::"Maintenance Request", MaintenanceRequestSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMaintenanceRequestCode, Database::"Maintenance Request", MaintenanceRequestRequestCancelEventDescTxt, 0, false);
        /* Utility Bill */
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendUtilityBillForApprovalCode, Database::"Utility Bill", UtilityBillSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelUtilityBillCode, Database::"Utility Bill", UtilityBillRequestCancelEventDescTxt, 0, false);
        //meeting Booking
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendMeetingBookingForApprovalCode, Database::MeetingsInfo, meetingBookingSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMeetingCode, Database::MeetingsInfo, meetingBookingRequestCancelEventDescTxt, 0, false);
        //StudentClearance
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStudentClearanceForApprovalCode, Database::"Student Clerance", studentClearanceForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStudentClearanceCode, Database::"Student Clerance", studentclearanceRequestCancelEventDescTxt, 0, false);


    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        //meeting Booking
        case EventFunctionName of
            RunWorkflowOnCancelMeetingCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelMeetingCode, RunWorkflowOnSendMeetingBookingForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMeetingBookingForApprovalCode);
        end;
        /*Repair Request */
        case EventFunctionName of
            RunWorkflowOnCancelRepairRequestCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRepairRequestCode, RunWorkflowOnSendRepairRequestForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRepairRequestForApprovalCode);
        end;
        /* Maintence Schedule */
        case EventFunctionName of
            RunWorkflowOnCancelMaintenceScheduleCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelMaintenceScheduleCode, RunWorkflowOnSendMaintenceScheduleForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMaintenceScheduleForApprovalCode);
        end;
        /* Maintenance Request */
        case EventFunctionName of
            RunWorkflowOnCancelMaintenanceRequestCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelMaintenanceRequestCode, RunWorkflowOnSendMaintenanceRequestForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMaintenanceRequestForApprovalCode);
        end;
        /* Utility Bill */
        case EventFunctionName of
            RunWorkflowOnCancelUtilityBillCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelUtilityBillCode, RunWorkflowOnSendUtilityBillForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendUtilityBillForApprovalCode);
        end;
        //studentClearance
        case EventFunctionName of
            RunWorkflowOnCancelStudentClearanceCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelStudentClearanceCode, RunWorkflowOnSendStudentClearanceForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStudentClearanceForApprovalCode);
        end;

    end;

    /*************************************************************************************************************************** */
    //meetingBooking
    procedure RunWorkflowOnSendMeetingBookingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMeetingBookingForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendMeetingBookingForApproval', '', true, true)]
    local procedure RunWorkflowOnSendMeetingBookingForApproval(Var meetingBooking: Record MeetingsInfo)
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendMeetingBookingForApprovalCode, meetingBooking)
    end;

    procedure RunWorkflowOnCancelMeetingCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMeetingBookingForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelMeetingBookingForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelMeetingBooking(Var meetingBooking: Record MeetingsInfo)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMeetingCode, meetingBooking);
        meetingBooking.Reset();
        meetingBooking.SetRange("Meeting Code", meetingBooking."Meeting Code");
        if meetingBooking.FindFirst() then begin
            meetingBooking.Status := meetingBooking.Status::Open;
            meetingBooking.Modify()
        end;
    end;
    //Student clearance 
    procedure RunWorkflowOnSendStudentClearanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStudentClearanceForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendStudentClearanceForApproval', '', true, true)]
    local procedure RunWorkflowOnSendStudentClearanceForApproval(Var StudentClearance: Record "Student Clerance")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendStudentClearanceForApprovalCode, StudentClearance)
    end;

    procedure RunWorkflowOnCancelStudentClearanceCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStudentClearance'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelStudentClearanceForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelStudentClearance(Var StudentClearance: Record "Student Clerance")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelUtilityBillCode, StudentClearance);
        StudentClearance.Reset();
        StudentClearance.SetRange("Clearance No", StudentClearance."Clearance No");
        if StudentClearance.FindFirst() then begin
            StudentClearance.Status := StudentClearance.Status::Open;
            StudentClearance.Modify()
        end;
    end;
    /* Utility Bill */
    procedure RunWorkflowOnSendUtilityBillForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendUtilityBillForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendUtilityBillForApproval', '', true, true)]
    local procedure RunWorkflowOnSendUtilityBillForApproval(Var UtilityBill: Record "Utility Bill")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendUtilityBillForApprovalCode, UtilityBill)
    end;

    procedure RunWorkflowOnCancelUtilityBillCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelUtilityBill'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelUtilityBillForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelUtilityBill(Var UtilityBill: Record "Utility Bill")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelUtilityBillCode, UtilityBill);
        UtilityBill.Reset();
        UtilityBill.SetRange("No.", UtilityBill."No.");
        if UtilityBill.FindFirst() then begin
            UtilityBill.Status := UtilityBill.Status::Open;
            UtilityBill.Modify()
        end;
    end;
    /* Maintenance Request */
    procedure RunWorkflowOnSendMaintenanceRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMaintenanceRequestForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendMaintenanceRequestForApproval', '', true, true)]
    local procedure RunWorkflowOnSendMaintenanceRequestForApproval(Var MaintenanceRequestw: Record "project")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendMaintenanceRequestForApprovalCode, MaintenanceRequestw)
    end;

    procedure RunWorkflowOnCancelMaintenanceRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMaintenanceRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelMaintenanceRequestForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelMaintenanceRequest(Var MaintenanceRequest: Record "project")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMaintenanceRequestCode, MaintenanceRequest);
        MaintenanceRequest.Reset();
        MaintenanceRequest.SetRange("No.", MaintenanceRequest."No.");
        if MaintenanceRequest.FindFirst() then begin
            MaintenanceRequest.Status := MaintenanceRequest.Status::Open;
            MaintenanceRequest.Modify()
        end;
    end;
    /*Repair Request */
    procedure RunWorkflowOnSendRepairRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendRepairRequestForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendRepairRequestForApproval', '', true, true)]
    local procedure RunWorkflowOnSendRepairRequestForApproval(Var RepairRequest: Record "Repair Request")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendRepairRequestForApprovalCode, RepairRequest)
    end;

    procedure RunWorkflowOnCancelRepairRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelRepairRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelRepairRequestForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelRepairRequest(Var RepairRequest: Record "Repair Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRepairRequestCode, RepairRequest);
        RepairRequest.Reset();
        RepairRequest.SetRange("No.", RepairRequest."No.");
        if RepairRequest.FindFirst() then begin
            RepairRequest.Status := RepairRequest.Status::Open;
            RepairRequest.Modify()
        end;
    end;

    /* Maintence Schedule */
    procedure RunWorkflowOnSendMaintenceScheduleForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMaintenceScheduleForApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendMaintenceScheduleForApproval', '', true, true)]
    local procedure RunWorkflowOnSendMaintenceScheduleForApproval(Var MaintenceSchedule: Record "Maintenance Schedule")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendMaintenceScheduleForApprovalCode, MaintenceSchedule)
    end;

    procedure RunWorkflowOnCancelMaintenceScheduleCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMaintenceSchedule'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelMaintenceScheduleForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelMaintenceSchedule(Var MaintenceSchedule: Record "Maintenance Schedule")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMaintenceScheduleCode, MaintenceSchedule);
        MaintenceSchedule.Reset();
        MaintenceSchedule.SetRange("No.", MaintenceSchedule."No.");
        if MaintenceSchedule.FindFirst() then begin
            MaintenceSchedule.Status := MaintenceSchedule.Status::Open;
            MaintenceSchedule.Modify()
        end;
    end;

    /*************************************************************************************************************************** */
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
