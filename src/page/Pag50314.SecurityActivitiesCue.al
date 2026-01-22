// Page: Security Activities Cue
page 50314 "Security Activities Cue"
{
    PageType = CardPart;
    SourceTable = "Security Cue";
    Caption = 'Activities';

    layout
    {
        area(content)
        {
            cuegroup(Registrations)
            {
                Caption = 'Registrations';
                field(TodaysRegistrations; Rec."Today's Registrations")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Guest Registration List";
                }
                field(WeeklyRegistrations; Rec."Weekly Registrations")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Guest Registration List";
                }
            }
            cuegroup(Incidents)
            {
                Caption = 'Incidents';
                field(OpenIncidents; Rec."Open Incidents")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Report List";
                }
                field(IncidentsThisWeek; Rec."Incidents This Week")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Incident Report List";
                }
            }
            usercontrol(IncidentChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    UpdateIncidentChart();
                end;

                trigger Refresh()
                begin
                    UpdateIncidentChart();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    local procedure UpdateIncidentChart()
    var
        IncidentReport: Record "Incident Report";
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
    begin

    end;
}