page 52163 "Risk Activities"
{
    Caption = 'Risk Activities';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Risk Mitigation";
    CardPageId = "Risk Mitigation Card";
    
    layout
    {
        area(Content)
        {
            repeater(Activities)
            {
                field("Mitigation ID"; Rec."Mitigation ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the mitigation action.';
                }
                field("Risk ID"; Rec."Risk ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk this mitigation is associated with.';
                }
                field("Mitigation Title"; Rec."Mitigation Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the mitigation action.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the mitigation action.';
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target completion date for the mitigation action.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the person responsible for implementing the mitigation action.';
                }
                field("Progress %"; Rec."Progress %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion percentage of the mitigation action.';
                    
                    trigger OnDrillDown()
                    begin
                        // Allow drill down to see progress details
                        Page.RunModal(Page::"Risk Mitigation Card", Rec);
                    end;
                }
                field("Priority"; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level of the mitigation action.';
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated cost of implementing the mitigation action.';
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual cost incurred for the mitigation action.';
                }
                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the mitigation action was last reviewed.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(NewMitigation)
            {
                ApplicationArea = All;
                Caption = 'New Mitigation';
                Image = New;
                ToolTip = 'Create a new risk mitigation action.';
                
                trigger OnAction()
                var
                    RiskMitigation: Record "Risk Mitigation";
                begin
                    RiskMitigation.Init();
                    Page.RunModal(Page::"Risk Mitigation Card", RiskMitigation);
                end;
            }
            action(ViewRisk)
            {
                ApplicationArea = All;
                Caption = 'View Related Risk';
                Image = View;
                ToolTip = 'View the risk record associated with this mitigation action.';
                
                trigger OnAction()
                var
                    RiskRegister: Record "Risk Register";
                begin
                    if RiskRegister.Get(Rec."Risk ID") then
                        Page.RunModal(Page::"Risk Register Card", RiskRegister);
                end;
            }
            action(UpdateProgress)
            {
                ApplicationArea = All;
                Caption = 'Update Progress';
                Image = Progress;
                ToolTip = 'Update the progress of the selected mitigation action.';
                
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Risk Mitigation Card", Rec);
                    CurrPage.Update();
                end;
            }
            action(RiskIncidents)
            {
                ApplicationArea = All;
                Caption = 'Risk Incidents';
                Image = ErrorLog;
                ToolTip = 'View incidents related to this risk.';
                RunObject = page "Risk Incident List";
                RunPageLink = "Related Risk ID" = field("Risk ID");
            }
            action(RiskRegister)
            {
                ApplicationArea = All;
                Caption = 'Risk Register';
                Image = Register;
                ToolTip = 'View the complete risk register.';
                RunObject = page "Risk Register List";
            }
       
            action(MitigationProgressReport)
            {
                ApplicationArea = All;
                Caption = 'Mitigation Progress Report';
                Image = Report;
                ToolTip = 'Generate a report showing mitigation progress.';
                RunObject = report "Risk Mitigation Progress";
            }
        }
    }
}
