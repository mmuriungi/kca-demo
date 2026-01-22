page 52179112 "Risk Mitigation List"
{
    PageType = List;
    SourceTable = "Risk Mitigation";
    Caption = 'Risk Mitigation List';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = 52179101;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Mitigation ID"; Rec."Mitigation ID")
                {
                    ApplicationArea = All;
                }
                field("Risk ID"; Rec."Risk ID")
                {
                    ApplicationArea = All;
                }
                field("Mitigation Title"; Rec."Mitigation Title")
                {
                    ApplicationArea = All;
                }
                field("Mitigation Description"; Rec."Mitigation Description")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Completion Date"; Rec."Actual Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Progress %"; Rec."Progress %")
                {
                    ApplicationArea = All;
                }
                field("Control Effectiveness"; Rec."Control Effectiveness")
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
            action(NewMitigation)
            {
                ApplicationArea = All;
                Caption = 'New Mitigation';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                
                trigger OnAction()
                var
                    RiskMitigation: Record "Risk Mitigation";
                    MitigationCard: Page "Risk Mitigation Card";
                begin
                    RiskMitigation.Init();
                    MitigationCard.SetRecord(RiskMitigation);
                    MitigationCard.Run();
                end;
            }
            action(MarkComplete)
            {
                ApplicationArea = All;
                Caption = 'Mark as Complete';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Completed;
                    Rec."Actual Completion Date" := WorkDate();
                    Rec."Progress %" := 100;
                    Rec.Modify();
                end;
            }
        }
        
        area(Reporting)
        {
            action(MitigationProgress)
            {
                ApplicationArea = All;
                Caption = 'Mitigation Progress Report';
                Image = Report;
                RunObject = report "Risk Mitigation Progress";
            }
        }
    }
}