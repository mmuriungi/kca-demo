page 52162 "Risk Incident FactBox"
{
    Caption = 'Risk Incidents';
    PageType = ListPart;
    SourceTable = "Risk Incident";
    ApplicationArea = All;
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                
                field("Incident Title"; Rec."Incident Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the risk incident.';
                }
                field("Incident Type"; Rec."Incident Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the incident.';
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the severity level of the incident.';
                }
                field("Occurrence Date"; Rec."Occurrence Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the incident occurred.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the incident.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the person assigned to handle the incident.';
                    
                    trigger OnDrillDown()
                    begin
                        ShowIncidentCard();
                    end;
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                Image = View;
                ToolTip = 'View detailed information about the selected incident.';
                
                trigger OnAction()
                begin
                    ShowIncidentCard();
                end;
            }
            action(NewIncident)
            {
                ApplicationArea = All;
                Caption = 'New Incident';
                Image = New;
                ToolTip = 'Create a new incident record for this risk.';
                
                trigger OnAction()
                var
                    RiskIncident: Record "Risk Incident";
                    RiskIncidentCard: Page "Risk Incident Card";
                begin
                    RiskIncident.Init();
                    if Rec.GetFilter("Related Risk ID") <> '' then
                        RiskIncident."Related Risk ID" := Rec.GetRangeMin("Related Risk ID");
                    RiskIncidentCard.SetRecord(RiskIncident);
                    RiskIncidentCard.SetTableView(RiskIncident);
                    RiskIncidentCard.Run();
                end;
            }
        }
    }
    
    local procedure ShowIncidentCard()
    var
        RiskIncidentCard: Page "Risk Incident Card";
    begin
        RiskIncidentCard.SetRecord(Rec);
        RiskIncidentCard.SetTableView(Rec);
        RiskIncidentCard.Run();
    end;
}
