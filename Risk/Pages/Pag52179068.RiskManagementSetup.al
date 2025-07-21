page 52179068 "Risk Management Setup"
{
    Caption = 'Risk Management Setup';
    PageType = Card;
    SourceTable = "Risk Management Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            group(NumberSeries)
            {
                Caption = 'Number Series';
                field("Risk Nos."; Rec."Risk Nos.")
                {
                    ApplicationArea = All;
                }
                field("Mitigation Nos."; Rec."Mitigation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Incident Nos."; Rec."Incident Nos.")
                {
                    ApplicationArea = All;
                }
                field("KRI Nos."; Rec."KRI Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(DefaultSettings)
            {
                Caption = 'Default Settings';
                field("Default Review Period"; Rec."Default Review Period")
                {
                    ApplicationArea = All;
                }
                field("Alert Days Before Review"; Rec."Alert Days Before Review")
                {
                    ApplicationArea = All;
                }
            }
            group(RiskManagement)
            {
                Caption = 'Risk Management Team';
                field("Risk Manager"; Rec."Risk Manager")
                {
                    ApplicationArea = All;
                }
                field("Risk Committee Chair"; Rec."Risk Committee Chair")
                {
                    ApplicationArea = All;
                }
            }
            group(SystemSettings)
            {
                Caption = 'System Settings';
                field("Enable Notifications"; Rec."Enable Notifications")
                {
                    ApplicationArea = All;
                }
                field("Auto Calculate Ratings"; Rec."Auto Calculate Ratings")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(CreateDemoData)
            {
                Caption = 'Create Demo Data';
                Image = CreateDocument;
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    RiskDemoDataGenerator: Codeunit "Risk Demo Data Generator";
                    ConfirmMsg: Text;
                begin
                    ConfirmMsg := 'This will create demo data for the Risk Management module. Continue?';
                    if Confirm(ConfirmMsg, false) then begin
                        RiskDemoDataGenerator.GenerateAllDemoData();
                        Message('Demo data has been created successfully.');
                    end;
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}