page 52179116 "Key Risk Indicators List"
{
    PageType = List;
    SourceTable = "Key Risk Indicators";
    Caption = 'Key Risk Indicators List';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Key Risk Indicators Card";
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("KRI ID"; Rec."KRI ID")
                {
                    ApplicationArea = All;
                }
                field("KRI Name"; Rec."KRI Name")
                {
                    ApplicationArea = All;
                }
                field("Related Risk ID"; Rec."Related Risk ID")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Current Value"; Rec."Current Value")
                {
                    ApplicationArea = All;
                }
                field("Target Value"; Rec."Target Value")
                {
                    ApplicationArea = All;
                }
                field("Threshold - Red"; Rec."Threshold - Red")
                {
                    ApplicationArea = All;
                }
                field("Alert Status"; Rec."Alert Status")
                {
                    ApplicationArea = All;
                }
                field("Last Measured Date"; Rec."Last Measured Date")
                {
                    ApplicationArea = All;
                }
                field("Monitoring Frequency"; Rec."Monitoring Frequency")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
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
            action(NewKRI)
            {
                ApplicationArea = All;
                Caption = 'New KRI';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                
                trigger OnAction()
                var
                    KeyRiskInd: Record "Key Risk Indicators";
                    KRICard: Page "Key Risk Indicators Card";
                begin
                    KeyRiskInd.Init();
                    KRICard.SetRecord(KeyRiskInd);
                    KRICard.Run();
                end;
            }
            action(UpdateMeasurement)
            {
                ApplicationArea = All;
                Caption = 'Update Measurement';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec."Last Measured Date" := WorkDate();
                    Rec.Modify();
                    Message('Measurement date updated.');
                end;
            }
        }
        
        area(Reporting)
        {
            action(KRIReport)
            {
                ApplicationArea = All;
                Caption = 'KRI Performance Report';
                Image = Report;
                RunObject = report "Key Risk Indicators Report";
            }
        }
    }
}