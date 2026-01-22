page 52160 "Risk Mitigation FactBox"
{
    Caption = 'Risk Mitigation';
    PageType = ListPart;
    SourceTable = "Risk Mitigation";
    ApplicationArea = All;
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                
                field("Mitigation Title"; Rec."Mitigation Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the risk mitigation action.';
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
                        ShowMitigationCard();
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
                ToolTip = 'View detailed information about the selected mitigation action.';
                
                trigger OnAction()
                begin
                    ShowMitigationCard();
                end;
            }
            action(NewMitigation)
            {
                ApplicationArea = All;
                Caption = 'New Mitigation';
                Image = New;
                ToolTip = 'Create a new mitigation action for this risk.';
                
                trigger OnAction()
                var
                    RiskMitigation: Record "Risk Mitigation";
                    RiskMitigationCard: Page "Risk Mitigation Card";
                begin
                    RiskMitigation.Init();
                    if Rec.GetFilter("Risk ID") <> '' then
                        RiskMitigation."Risk ID" := Rec.GetRangeMin("Risk ID");
                    RiskMitigationCard.SetRecord(RiskMitigation);
                    RiskMitigationCard.SetTableView(RiskMitigation);
                    RiskMitigationCard.Run();
                end;
            }
        }
    }
    
    local procedure ShowMitigationCard()
    var
        RiskMitigationCard: Page "Risk Mitigation Card";
    begin
        RiskMitigationCard.SetRecord(Rec);
        RiskMitigationCard.SetTableView(Rec);
        RiskMitigationCard.Run();
    end;
}
