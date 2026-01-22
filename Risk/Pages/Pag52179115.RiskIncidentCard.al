page 52179115 "Risk Incident Card"
{
    PageType = Card;
    SourceTable = "Risk Incident";
    Caption = 'Risk Incident Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("Incident ID"; Rec."Incident ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Incident Title"; Rec."Incident Title")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Related Risk ID"; Rec."Related Risk ID")
                {
                    ApplicationArea = All;
                }
                field("Incident Type"; Rec."Incident Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Occurrence Date"; Rec."Occurrence Date")
                {
                    ApplicationArea = All;
                }
                field("Reported By"; Rec."Reported By")
                {
                    ApplicationArea = All;
                }
                field("Detection Date"; Rec."Detection Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Classification)
            {
                Caption = 'Classification & Impact';
                
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Financial Impact"; Rec."Financial Impact")
                {
                    ApplicationArea = All;
                }
                field("Operational Impact Hours"; Rec."Operational Impact Hours")
                {
                    ApplicationArea = All;
                }
                field("Customer Impact"; Rec."Customer Impact")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Details)
            {
                Caption = 'Incident Details';
                
                field("Incident Description"; Rec."Incident Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Root Cause"; Rec."Root Cause")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Response Actions"; Rec."Response Actions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Resolution)
            {
                Caption = 'Resolution & Follow-up';
                
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
                field("Target Resolution Date"; Rec."Target Resolution Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Resolution Date"; Rec."Actual Resolution Date")
                {
                    ApplicationArea = All;
                }
                field("Lessons Learned"; Rec."Lessons Learned")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                
                action(InvestigateIncident)
                {
                    ApplicationArea = All;
                    Caption = 'Start Investigation';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Open;
                    
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::In_Progress;
                        Rec.Modify();
                        Message('Investigation started for incident.');
                    end;
                }
                
                action(ResolveIncident)
                {
                    ApplicationArea = All;
                    Caption = 'Resolve Incident';
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
                            Message('Incident has been resolved.');
                        end;
                    end;
                }
                
                action(EscalateIncident)
                {
                    ApplicationArea = All;
                    Caption = 'Escalate Incident';
                    Image = Escalate;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status <> Rec.Status::Closed;
                    
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Escalated;
                        Rec.Modify();
                        Message('Incident has been escalated.');
                    end;
                }
            }
        }
        
        area(Navigation)
        {
            action(ViewRisk)
            {
                ApplicationArea = All;
                Caption = 'View Related Risk';
                Image = View;
                RunObject = page "Risk Register Card";
                RunPageLink = "Risk ID" = field("Related Risk ID");
                Enabled = Rec."Related Risk ID" <> '';
            }
        }
        
        area(Reporting)
        {
            action(PrintIncident)
            {
                ApplicationArea = All;
                Caption = 'Print Incident Report';
                Image = Print;
                
                trigger OnAction()
                begin
                    Message('Incident Details:\n\nID: %1\nTitle: %2\nType: %3\nSeverity: %4\nStatus: %5\nReported By: %6\nDate: %7', 
                        Rec."Incident ID", Rec."Incident Title", Rec."Incident Type", 
                        Rec.Severity, Rec.Status, Rec."Reported By", Rec."Occurrence Date");
                end;
            }
        }
    }
}