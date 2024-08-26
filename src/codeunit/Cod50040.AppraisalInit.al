/// <summary>
/// Codeunit Appraisal Init (ID 50006).
/// </summary>
codeunit 50040 "Appraisal Init"
{
    trigger OnRun()
    begin

    end;

    //Leave
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendAppraisalforApproval(VAR Appraisal: Record Appraisal);
    begin
    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelAppraisalforApproval(VAR Appraisal: Record Appraisal);
    begin
    end;


    /// <summary>
    /// IsAppraisalEnabled.
    /// </summary>
    /// <param name="Appraisal">VAR Record Appraisal.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsAppraisalEnabled(var Appraisal: Record Appraisal): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Appraisal Workflow";
    begin
        exit(WFMngt.CanExecuteWorkflow(Appraisal, WFCode.RunWorkflowOnSendAppraisalApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        Appraisal: Record Appraisal;
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
         ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsAppraisalEnabled(Appraisal) then
            Error(NoWorkflowEnb);
    end;


    //Added modifications
    local procedure ShowAppraisalApprovalStatus(Appraisal: Record Appraisal)
    begin
        Appraisal.Find;

        case Appraisal.Status of
            Appraisal.Status::Approved:
                Message(DocStatusChangedMsg, '', Appraisal."Appraisal No", Appraisal.Status);
            Appraisal.Status::"Pending Approval":
                if HasOpenOrPendingApprovalEntries(Appraisal.RecordId) then
                    Message(PendingApprovalMsg);

        end;
    end;



    ///////////////////////**************************POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry";
        WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Appraisal: Record Appraisal;
        PayChangeAdvice: Record "prBasic pay PCA";


    begin
        case
            RecRef.Number of
            Database::Appraisal:
                begin
                    RecRef.SetTable(Appraisal);
                    ApprovalEntryArgument."Document No." := Appraisal."Appraisal No";

                end;



        end;
    end;

    /// <summary>
    /// HasOpenOrPendingApprovalEntries.
    /// </summary>
    /// <param name="RecordID">RecordID.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure HasOpenOrPendingApprovalEntries(RecordID: RecordID): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
        ApprovalEntry.SetRange("Related to Change", false);
        exit(not ApprovalEntry.IsEmpty);
    end;

    var
        myInt: Integer;
        DocStatusChangedMsg: Label '%1 %2 has been automatically approved. The status has been changed to %3.',
          Comment = 'Order 1001 has been automatically approved. The status has been changed to Released.';
        PendingApprovalMsg: Label 'An approval request has been sent.';
}
