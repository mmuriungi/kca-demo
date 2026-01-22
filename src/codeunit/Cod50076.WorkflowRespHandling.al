codeunit 50076 "Workflow Resp. Handling"
{
    var
        RepairRequest: Record "Repair Request";
        MaintenceSchedule: Record "Maintenance Schedule";
        MaintenanceRequest: Record "Maintenance Request";
        UtilityBill: Record "Utility Bill";
        MeettingsInfo: Record MeetingsInfo;
        StudentClearance: Record "Student Clerance";


    /*******************************************************************************************************************************************************/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        case RecRef.Number of
            /*Repair Request  */
            Database::"Repair Request":
                begin
                    RecRef.SetTable(RepairRequest);
                    RepairRequest.Status := RepairRequest.Status::Open;
                    RepairRequest.Modify;
                    Handled := true;
                end;
            /* Maintence Schedule */
            Database::"Maintenance Schedule":
                begin
                    RecRef.SetTable(MaintenceSchedule);
                    MaintenceSchedule.Status := MaintenceSchedule.Status::Open;
                    MaintenceSchedule.Modify;
                    Handled := true;
                end;
            /* Maintenance Request */
            Database::"Maintenance Request":
                begin
                    RecRef.SetTable(MaintenanceRequest);
                    MaintenanceRequest.Status := MaintenanceRequest.Status::Open;
                    MaintenanceRequest.Modify;
                    Handled := true;
                end;
            /* Utility Bill */
            Database::"Utility Bill":
                begin
                    RecRef.SetTable(UtilityBill);
                    UtilityBill.Status := UtilityBill.Status::Open;
                    UtilityBill.Modify;
                    Handled := true;
                end;
            //meetingBooking
            Database::MeetingsInfo:
                begin
                    RecRef.SetTable(MeettingsInfo);
                    MeettingsInfo.Status := MeettingsInfo.Status::Open;
                    MeettingsInfo.Modify;
                    Handled := true;
                end;
            //studentClearance
            Database::"Student Clerance":
                begin
                    RecRef.SetTable(StudentClearance);
                    StudentClearance.Status := StudentClearance.Status::Open;
                    StudentClearance.Modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]

    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        case RecRef.Number of
            /*Repair Request */
            Database::"Repair Request":
                begin
                    RecRef.setTable(RepairRequest);
                    RepairRequest.Status := RepairRequest.Status::Approved;
                    RepairRequest.Modify();
                    Handled := true;
                end;
            /* Maintence Schedule */
            Database::"Maintenance Schedule":
                begin
                    RecRef.setTable(MaintenceSchedule);
                    MaintenceSchedule.Status := MaintenceSchedule.Status::Approved;
                    MaintenceSchedule.Modify();
                    Handled := true;
                end;
            /* Maintenance Request */
            Database::"Maintenance Request":
                begin
                    RecRef.setTable(MaintenanceRequest);
                    MaintenanceRequest.Status := MaintenanceRequest.Status::Approved;
                    MaintenanceRequest.Modify();
                    Handled := true;
                end;
            /* Utility Bill */
            Database::"Utility Bill":
                begin
                    RecRef.setTable(UtilityBill);
                    UtilityBill.Status := UtilityBill.Status::Approved;
                    UtilityBill.Modify();
                    Handled := true;
                end;
            //meeting
            Database::MeetingsInfo:
                begin
                    RecRef.SetTable(MeettingsInfo);
                    MeettingsInfo.Status := MeettingsInfo.Status::Approved;
                    MeettingsInfo.Modify;
                    Handled := true;
                end;
            //StudentClearance
            Database::"Student Clerance":
                begin
                    RecRef.SetTable(StudentClearance);
                    StudentClearance.Status := StudentClearance.Status::Approved;
                    StudentClearance.Modify;
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', true, true)]

    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean)
    begin
        case RecRef.Number of
            /*Repair Request */
            Database::"Repair Request":
                begin
                    RecRef.setTable(RepairRequest);
                    RepairRequest.Status := RepairRequest.Status::Pending;
                    RepairRequest.Modify();
                    IsHandled := true;
                end;
            /* Maintence Schedule */
            Database::"Maintenance Schedule":
                begin
                    RecRef.setTable(MaintenceSchedule);
                    MaintenceSchedule.Status := MaintenceSchedule.Status::Pending;
                    MaintenceSchedule.Modify();
                    IsHandled := true;
                end;
            /* Maintenance Request */
            Database::"Maintenance Request":
                begin
                    RecRef.setTable(MaintenanceRequest);
                    MaintenanceRequest.Status := MaintenanceRequest.Status::Pending;
                    MaintenanceRequest.Modify();
                    IsHandled := true;
                end;
            /* Utility Bill */
            Database::"Utility Bill":
                begin
                    RecRef.setTable(UtilityBill);
                    UtilityBill.Status := UtilityBill.Status::Pending;
                    UtilityBill.Modify();
                    IsHandled := true;
                end;
            //meeting
            Database::MeetingsInfo:
                begin
                    RecRef.SetTable(MeettingsInfo);
                    MeettingsInfo.Status := MeettingsInfo.Status::Pending;
                    MeettingsInfo.Modify;
                    IsHandled := true;
                end;
            //Student Clearance
            Database::"Student Clerance":
                begin
                    RecRef.SetTable(StudentClearance);
                    StudentClearance.Status := StudentClearance.Status::Pending;
                    StudentClearance.Modify;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]

    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])

    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext.";
    begin
        /*Repair Request */
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelRepairRequestCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRepairRequestCode);
        END;
        /* Maintence Schedule */
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMaintenceScheduleForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMaintenceScheduleForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelMaintenceScheduleCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelMaintenceScheduleCode);
        END;
        /* Maintenance Request */
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMaintenanceRequestForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMaintenanceRequestForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelMaintenanceRequestCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelMaintenanceRequestCode);
        END;
        /* Utility Bill */
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendUtilityBillForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendUtilityBillForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelUtilityBillCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelUtilityBillCode);
        END;
        //meetingInfo
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMeetingBookingForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMeetingBookingForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelMeetingCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelMeetingCode);
        END;
        //StudentClearance
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelStudentClearanceCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelStudentClearanceCode);
        END;
    end;
}
