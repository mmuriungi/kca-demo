codeunit 54213 "Workflow Setup Ext."
{
    var
        WorkflowSetup: CodeUnit "Workflow Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext.";
        /*Repair Request */
        RepairRequest: Record "Repair Request";
        RepairRequestWorkflowCategoryTxt: TextConst ENU = 'Repair Request';
        RepairRequestWorkflowCategoryDescTxt: TextConst ENU = 'Repair Request Document';
        RepairRequestWorkflowCodeTxt: TextConst ENU = 'SAAW';
        RepairRequestWorkfowDescTxt: TextConst ENU = 'Repair Request Approval Workflow';
        RepairRequestTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=RepairRequest>%1</DataItem></DataItems></ReportParameters>';
        /* Maintence Schedule */
        MaintenceSchedule: Record "Maintenance Schedule";
        MaintenceScheduleWorkflowCategoryTxt: TextConst ENU = 'Maintence Schedule';
        MaintenceScheduleWorkflowCategoryDescTxt: TextConst ENU = 'Maintence Schedule Document';
        MaintenceScheduleWorkflowCodeTxt: TextConst ENU = 'MCAW';
        MaintenceScheduleWorkfowDescTxt: TextConst ENU = 'Maintence Schedule Approval Workflow';
        MaintenceScheduleTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=MaintenceSchedule>%1</DataItem></DataItems></ReportParameters>';
        /* Maintenance Request */
        MaintenanceRequest: Record "Maintenance Request";
        MaintenanceRequestWorkflowCategoryTxt: TextConst ENU = 'Maintenance Request';
        MaintenanceRequestWorkflowCategoryDescTxt: TextConst ENU = 'Maintenance Request Document';
        MaintenanceRequestWorkflowCodeTxt: TextConst ENU = 'MRAW';
        MaintenanceRequestWorkfowDescTxt: TextConst ENU = 'Maintenance Request Approval Workflow';
        MaintenanceRequestTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=MaintenanceRequest>%1</DataItem></DataItems></ReportParameters>';
        /* Utility Bill */
        UtilityBill: Record "Utility Bill";
        UtilityBillWorkflowCategoryTxt: TextConst ENU = 'Utility Bill';
        UtilityBillWorkflowCategoryDescTxt: TextConst ENU = 'Utility Bill Document';
        UtilityBillWorkflowCodeTxt: TextConst ENU = 'UBAW';
        UtilityBillWorkfowDescTxt: TextConst ENU = 'Utility Bill Approval Workflow';
        UtilityBillTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=UtilityBill>%1</DataItem></DataItems></ReportParameters>';
        //meetingbooking
        meetingInfo: Record MeetingsInfo;
        MeetingBookingInfoWorkflowCategoryTxt: TextConst ENU = 'Meeting APR';
        MeetingBookingWorkflowCategoryDescTxt: TextConst ENU = 'Meeting Request Document';
        MeetingBookingWorkflowCodeTxt: TextConst ENU = 'MBAW';
        MeetingWorkfowDescTxt: TextConst ENU = 'Meeting Request Approval Workflow';
        meetingBookingTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=UtilityBill>%1</DataItem></DataItems></ReportParameters>';





    /* ************************************************************************************************************************************8 */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]

    local procedure OnAddWorkflowCategoriesToLibrary()

    begin
        /*Repair Request */
        WorkflowSetup.InsertWorkflowCategory(RepairRequestWorkflowCategoryTxt, RepairRequestWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(MaintenceScheduleWorkflowCategoryTxt, MaintenceScheduleWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(MaintenanceRequestWorkflowCategoryTxt, MaintenanceRequestWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(UtilityBillWorkflowCategoryTxt, UtilityBillWorkflowCategoryDescTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]

    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(Database::"Repair Request", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(Database::"Maintenance Schedule", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(Database::"Maintenance Request", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(Database::"Utility Bill", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]

    local procedure OnInsertWorkflowTemplates()
    begin
        InsertRepairRequestWorkflowTemplate();
        InsertMaintenceScheduleWorkflowTemplate();
        InsertMaintenanceRequestWorkflowTemplate();
        InsertUtilityBillWorkflowTemplate();
        InsertMeetingBookingWorkflowTemplate();
    end;

    /* ************************************************************************************************************************************8 */
    //MEETING BOOKING
    local procedure InsertMeetingBookingWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, MeetingBookingWorkflowCodeTxt, MeetingWorkfowDescTxt, MeetingBookingInfoWorkflowCategoryTxt);
        InsertUtilityBillWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertMeetingBookingWorkflowDetails(var Workflow: Record Workflow)
    begin
        WorkflowSetup.initWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildMeetingBookingTypeConditions(meetingInfo.Status::Open),
            WorkflowEventHandling.RunWorkflowOnSendMeetingBookingForApprovalCode,
            BuildMeetingBookingTypeConditions(meetingInfo.Status::Pending),
            WorkflowEventHandling.RunWorkflowOnCancelMeetingCode,
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildMeetingBookingTypeConditions(Status: Integer): Text
    begin
        meetingInfo.Reset;
        meetingInfo.SetRange(Status, Status);
        exit(StrSubstNo(meetingBookingTypeCondTxt, WorkflowSetup.Encode(meetingInfo.GetView(false))))
    end;
    /* Utility Bill */
    local procedure InsertUtilityBillWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, UtilityBillWorkflowCodeTxt, UtilityBillWorkfowDescTxt, UtilityBillWorkflowCategoryTxt);
        InsertUtilityBillWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertUtilityBillWorkflowDetails(var Workflow: Record Workflow)
    begin
        WorkflowSetup.initWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildUtilityBillTypeConditions(UtilityBill.Status::Open),
            WorkflowEventHandling.RunWorkflowOnSendUtilityBillForApprovalCode,
            BuildUtilityBillTypeConditions(UtilityBill.Status::Pending),
            WorkflowEventHandling.RunWorkflowOnCancelUtilityBillCode,
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildUtilityBillTypeConditions(Status: Integer): Text
    begin
        UtilityBill.Reset;
        UtilityBill.SetRange(Status, Status);
        exit(StrSubstNo(UtilityBillTypeCondTxt, WorkflowSetup.Encode(UtilityBill.GetView(false))))
    end;

    /* Maintenance Request */
    local procedure InsertMaintenanceRequestWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, MaintenanceRequestWorkflowCodeTxt, MaintenanceRequestWorkfowDescTxt, MaintenanceRequestWorkflowCategoryTxt);
        InsertMaintenanceRequestWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertMaintenanceRequestWorkflowDetails(var Workflow: Record Workflow)
    begin
        WorkflowSetup.initWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildMaintenanceRequestTypeConditions(MaintenanceRequest.Status::Open),
            WorkflowEventHandling.RunWorkflowOnSendMaintenanceRequestForApprovalCode,
            BuildMaintenanceRequestTypeConditions(MaintenanceRequest.Status::Pending),
            WorkflowEventHandling.RunWorkflowOnCancelMaintenanceRequestCode,
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildMaintenanceRequestTypeConditions(Status: Integer): Text
    begin
        MaintenanceRequest.Reset;
        MaintenanceRequest.SetRange(Status, Status);
        exit(StrSubstNo(MaintenanceRequestTypeCondTxt, WorkflowSetup.Encode(MaintenanceRequest.GetView(false))))
    end;
    /* Maintence Schedule */
    local procedure InsertMaintenceScheduleWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, MaintenceScheduleWorkflowCodeTxt, MaintenceScheduleWorkfowDescTxt, MaintenceScheduleWorkflowCategoryTxt);
        InsertMaintenceScheduleWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertMaintenceScheduleWorkflowDetails(var Workflow: Record Workflow)
    begin
        WorkflowSetup.initWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildMaintenceScheduleTypeConditions(MaintenceSchedule.Status::Open),
            WorkflowEventHandling.RunWorkflowOnSendMaintenceScheduleForApprovalCode,
            BuildMaintenceScheduleTypeConditions(MaintenceSchedule.Status::Pending),
            WorkflowEventHandling.RunWorkflowOnCancelMaintenceScheduleCode,
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildMaintenceScheduleTypeConditions(Status: Integer): Text
    begin
        MaintenceSchedule.Reset;
        MaintenceSchedule.SetRange(Status, Status);
        exit(StrSubstNo(MaintenceScheduleTypeCondTxt, WorkflowSetup.Encode(MaintenceSchedule.GetView(false))))
    end;

    /*Repair Request */
    local procedure InsertRepairRequestWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, RepairRequestWorkflowCodeTxt, RepairRequestWorkfowDescTxt, RepairRequestWorkflowCategoryTxt);
        InsertRepairRequestWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertRepairRequestWorkflowDetails(var Workflow: Record Workflow)
    begin
        WorkflowSetup.initWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildRepairRequestTypeConditions(RepairRequest.Status::Open),
            WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode,
            BuildRepairRequestTypeConditions(RepairRequest.Status::Pending),
            WorkflowEventHandling.RunWorkflowOnCancelRepairRequestCode,
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildRepairRequestTypeConditions(Status: Integer): Text
    begin
        RepairRequest.Reset;
        RepairRequest.SetRange(Status, Status);
        exit(StrSubstNo(RepairRequestTypeCondTxt, WorkflowSetup.Encode(RepairRequest.GetView(false))))
    end;
}
