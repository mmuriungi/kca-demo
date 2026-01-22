codeunit 50111 "Procurement Controls Handler"
{
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnAfterSetControlAppearance, '', false, false)]
    local procedure SetControlAppearance()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", OnBeforeMarkAllWhereUserisApproverOrSender, '', false, false)]
    local procedure SkipFilter(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}
