codeunit 50034 IntCodeunit
{
    trigger OnRun()
    begin

    end;

    //Leave Applications
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendLeavesforApproval(VAR Leave: Record "HRM-Leave Requisition");
    begin
    end;

    procedure UpdateLeaveWorkflow(var Leave: Record "HRM-Leave Requisition")
    var
        WrkflUserGroup: Record "Workflow User Group";
        WrkflUsrGrpMember: Record "Workflow User Group Member";
        WrkflUsrGrpMemberII: Record "Workflow User Group Member";
        Emp: Record "HRM-Employee C";
        UsersID: Code[50];
        Sequence: Integer;
    begin
        WrkflUserGroup.Reset();
        WrkflUserGroup.SetRange("Department Code", Leave."Department Code");
        if WrkflUserGroup.FindFirst() then begin
            Emp.Reset();
            Emp.SetRange("No.", Leave."Reliever No.");
            if Emp.FindFirst() then begin
                UsersID := Emp."User ID";
            end;
            WrkflUsrGrpMemberII.Init();
            WrkflUsrGrpMemberII."Workflow User Group Code" := WrkflUserGroup.Code;
            WrkflUsrGrpMemberII."User Name" := UsersID;
            WrkflUsrGrpMemberII."Sequence No." := 1;
            WrkflUsrGrpMemberII.Insert();
            WrkflUsrGrpMember.Reset();
            WrkflUsrGrpMember.SetRange("Workflow User Group Code", WrkflUserGroup.Code);
            WrkflUsrGrpMember.SetCurrentKey("Sequence No.");
            WrkflUsrGrpMember.SetAscending("Sequence No.", true);
            if WrkflUsrGrpMember.Find('-') then begin
                repeat
                    Sequence := Sequence + 1;
                    WrkflUsrGrpMember."Sequence No." := Sequence;
                    WrkflUsrGrpMember.Modify();
                until WrkflUsrGrpMember.Next() = 0;
            end;
        end;

    end;

    procedure IsLeaveEnabled(var Leave: Record "HRM-Leave Requisition"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Work Flow Code";
    begin
        exit(WFMngt.CanExecuteWorkflow(Leave, WFCode.RunWorkflowOnSendLeaveApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        Leave: Record "HRM-Leave Requisition";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
         ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsLeaveEnabled(Leave) then
            Error(NoWorkflowEnb);
    end;
    //Cancel "HRM-Leave Requisition"
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelLeaveforApproval(VAR Leave: Record "HRM-Leave Requisition");
    begin
    end;
    //End Cancel "HRM-Leave Requisition"
    //"HRM-Leave Requisition"

    //End Leave Applications
    //Displinary Cases
    //"HRM-Disciplinary Cases (B)"
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendDisCasesforApproval(VAR DisCases: Record "HRM-Disciplinary Cases (B)");
    begin
    end;

    procedure IsDisCasesEnabled(var DisCases: Record "HRM-Disciplinary Cases (B)"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Work Flow Code";
    begin
        exit(WFMngt.CanExecuteWorkflow(DisCases, WFCode.RunWorkflowOnSendDisCasesApprovalCode()))
    end;

    local procedure CheckDisCasesWorkflowEnabled(): Boolean
    var
        DisCases: Record "HRM-Disciplinary Cases (B)";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsDisCasesEnabled(DisCases) then
            Error(NoWorkflowEnb);
    end;
    //"HRM-Disciplinary Cases (B)"

    //Training
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendTrainingsforApproval(VAR Trainings: Record "HRM-Training Applications");
    begin
    end;

    procedure IsTrainingsEnabled(var Trainings: Record "HRM-Training Applications"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Work Flow Code";
    begin
        exit(WFMngt.CanExecuteWorkflow(Trainings, WFCode.RunWorkflowOnSendTrainingsApprovalCode()))
    end;

    local procedure CheckTrainingsWorkflowEnabled(): Boolean
    var
        Trainings: Record "HRM-Training Applications";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
         ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsTrainingsEnabled(Trainings) then
            Error(NoWorkflowEnb);
    end;


    //"Prl-Approval"
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendPrlApprovalforApproval(VAR PrlApproval: Record "Prl-Approval");
    begin
    end;

    procedure IsPrlApprovalEnabled(var PrlApproval: Record "Prl-Approval"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Work Flow Code";
    begin
        exit(WFMngt.CanExecuteWorkflow(PrlApproval, WFCode.RunWorkflowOnSendPrlApprovalApprovalCode()))
    end;

    local procedure CheckPrlApprovalWorkflowEnabled(): Boolean
    var
        PrlApproval: Record "Prl-Approval";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsPrlApprovalEnabled(PrlApproval) then
            Error(NoWorkflowEnb);
    end;
    //Cancel "Prl-Approval"
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelPrlApprovalforApproval(VAR PrlApproval: Record "Prl-Approval");
    begin
    end;
    //End Cancel "Prl-Approval"
    //"Prl-Approval"

    //End Training

    ///////////////////////**************************POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry";
    WorkflowStepInstance: Record "Workflow Step Instance")
    var

        Leave: Record "HRM-Leave Requisition";
        PrlApproval: Record "Prl-Approval";
    begin
        case
            RecRef.Number of
            Database::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    ApprovalEntryArgument."Document No." := Leave."No.";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Leave Application";
                end;
            Database::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    ApprovalEntryArgument."Document No." := format(PrlApproval."Payroll Period");
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Main Payroll";
                end;

        end;
    end;
    //////////////////************************End Populate  Approval Entry**********************////////////////////////

}