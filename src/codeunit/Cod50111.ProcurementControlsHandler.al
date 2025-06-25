codeunit 50111 "Procurement Controls Handler"
{
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnAfterSetControlAppearance, '', false, false)]
    local procedure SetControlAppearance()
    begin
        
    end;
}
