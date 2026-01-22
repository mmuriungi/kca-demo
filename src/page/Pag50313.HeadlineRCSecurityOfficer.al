// Page: Headline RC Security Officer
page 50313 "Headline RC Security Officer"
{
    PageType = HeadlinePart;
    Caption = 'Security Officer Headline';

    layout
    {
        area(content)
        {
            field(GreetingText; GetGreetingText())
            {
                ApplicationArea = All;
            }
            field(ActiveIncidents; GetActiveIncidentsText())
            {
                ApplicationArea = All;
                DrillDown = true;
                DrillDownPageId = "Incident Report List";
            }
        }
    }

    local procedure GetGreetingText(): Text
    var
    // UserGreeting: Codeunit "User Greeting";
    begin
        //  exit(UserGreeting.GetGreetingText());
    end;

    local procedure GetActiveIncidentsText(): Text
    var
        IncidentReport: Record "Incident Report";
        ActiveCount: Integer;
    begin
        IncidentReport.SetRange(Status, IncidentReport.Status::Open);
        ActiveCount := IncidentReport.Count;
        if ActiveCount = 0 then
            exit('No active incidents');
        if ActiveCount = 1 then
            exit('1 active incident requires attention');
        exit(Format(ActiveCount) + ' active incidents require attention');
    end;
}
