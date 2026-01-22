page 52179114 "Risk Incident List"
{
    PageType = List;
    SourceTable = "Risk Incident";
    Caption = 'Risk Incident List';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Risk Incident Card";
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Incident ID"; Rec."Incident ID")
                {
                    ApplicationArea = All;
                }
                field("Incident Title"; Rec."Incident Title")
                {
                    ApplicationArea = All;
                }
                field("Related Risk ID"; Rec."Related Risk ID")
                {
                    ApplicationArea = All;
                }
                field("Incident Type"; Rec."Incident Type")
                {
                    ApplicationArea = All;
                }
                field("Occurrence Date"; Rec."Occurrence Date")
                {
                    ApplicationArea = All;
                }
                field("Reported By"; Rec."Reported By")
                {
                    ApplicationArea = All;
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Financial Impact"; Rec."Financial Impact")
                {
                    ApplicationArea = All;
                }
                field("Actual Resolution Date"; Rec."Actual Resolution Date")
                {
                    ApplicationArea = All;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
            }
        }
        
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(NewIncident)
            {
                ApplicationArea = All;
                Caption = 'New Incident';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                
                trigger OnAction()
                var
                    RiskIncident: Record "Risk Incident";
                    IncidentCard: Page "Risk Incident Card";
                begin
                    RiskIncident.Init();
                    IncidentCard.SetRecord(RiskIncident);
                    IncidentCard.Run();
                end;
            }
            action(ResolveIncident)
            {
                ApplicationArea = All;
                Caption = 'Mark as Resolved';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status <> Rec.Status::Closed;
                
                trigger OnAction()
                begin
                    if Confirm('Mark this incident as resolved?') then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec."Actual Resolution Date" := WorkDate();
                        Rec.Modify();
                        Message('Incident marked as resolved.');
                    end;
                end;
            }
        }
        
        area(Reporting)
        {
            action(IncidentReport)
            {
                ApplicationArea = All;
                Caption = 'Incident Report';
                Image = Report;
                RunObject = report "Risk Register Report";
            }
        }
    }
}