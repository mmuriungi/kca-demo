page 52179109 "Legal Affairs Headline"
{
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(Control1)
            {
                ShowCaption = false;
                Visible = HeadlineVisible;
                
                field(Headline; HeadlineText)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    
                    trigger OnDrillDown()
                    begin
                        OnHeadlineClick();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        OnSetVisibility();
    end;

    local procedure OnSetVisibility()
    begin
        HeadlineVisible := true;
        ComputeHeadline();
    end;

    local procedure ComputeHeadline()
    var
        LegalCase: Record "Legal Case";
        ComplianceTask: Record "Legal Compliance Task";
        OverdueCases: Integer;
        OverdueCompliance: Integer;
    begin
        // Count overdue cases
        LegalCase.SetRange("Next Court Date", 0D, Today);
        LegalCase.SetFilter("Case Status", '<>%1&<>%2', LegalCase."Case Status"::Closed, LegalCase."Case Status"::Settled);
        OverdueCases := LegalCase.Count();

        // Count overdue compliance tasks
        ComplianceTask.SetRange("Due Date", 0D, Today);
        ComplianceTask.SetFilter(Status, '<>%1', ComplianceTask.Status::Completed);
        OverdueCompliance := ComplianceTask.Count();

        if (OverdueCases > 0) or (OverdueCompliance > 0) then begin
            if OverdueCases > 0 then
                HeadlineText := StrSubstNo('⚠️ %1 overdue court dates require immediate attention', OverdueCases)
            else
                HeadlineText := StrSubstNo('⚠️ %1 compliance tasks are overdue', OverdueCompliance);
        end else begin
            LegalCase.SetRange("Next Court Date", Today + 1, Today + 7);
            if LegalCase.Count() > 0 then
                HeadlineText := StrSubstNo('📅 %1 court hearings scheduled this week', LegalCase.Count())
            else
                HeadlineText := '✅ All legal matters are up to date';
        end;
    end;

    local procedure OnHeadlineClick()
    var
        LegalCase: Record "Legal Case";
        ComplianceTask: Record "Legal Compliance Task";
    begin
        // Navigate to appropriate page based on headline
        if HeadlineText.Contains('overdue court dates') then
            Page.Run(Page::"Legal Case List")
        else if HeadlineText.Contains('compliance tasks') then
            Page.Run(Page::"Legal Compliance Task List")
        else if HeadlineText.Contains('court hearings') then
            Page.Run(Page::"Legal Calendar Entry List");
    end;

    var
        HeadlineText: Text;
        HeadlineVisible: Boolean;
}