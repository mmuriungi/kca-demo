page 52158 "Risk Scenario Analysis List"
{
    Caption = 'Risk Scenario Analysis List';
    PageType = List;
    SourceTable = "Risk Scenario Analysis";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Risk Scenario Analysis Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Scenario ID"; Rec."Scenario ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the risk scenario.';
                }
                field("Related Risk ID"; Rec."Related Risk ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related risk register entry.';
                }
                field("Scenario Name"; Rec."Scenario Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the risk scenario.';
                }
                field("Scenario Type"; Rec."Scenario Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of scenario analysis.';
                }
                field("Probability %"; Rec."Probability %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the probability percentage of the scenario occurring.';
                }
                field("Financial Impact"; Rec."Financial Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the financial impact of the scenario.';
                }
                field("Operational Impact"; Rec."Operational Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the operational impact of the scenario.';
                }
                field("Analysis Date"; Rec."Analysis Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the scenario analysis was performed.';
                }
                field("Analyst"; Rec."Analyst")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the analyst responsible for the scenario analysis.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(RunAnalysis)
            {
                Caption = 'Run Analysis';
                Image = Calculate;
                ApplicationArea = All;
                ToolTip = 'Run the scenario analysis calculations.';
                
                trigger OnAction()
                begin
                    Rec."Analysis Date" := Today;
                    Rec."Analyst" := UserId;
                    Rec.Modify(true);
                    
                    Message('Scenario analysis completed for scenario: %1\nAnalysis date: %2\nAnalyst: %3', 
                            Rec."Scenario Name", 
                            Rec."Analysis Date",
                            Rec."Analyst");
                    
                    CurrPage.Update(false);
                end;
            }
            action(ExportResults)
            {
                Caption = 'Export Results';
                Image = Export;
                ApplicationArea = All;
                ToolTip = 'Export the scenario analysis results.';
                
                trigger OnAction()
                var
                    RiskScenario: Record "Risk Scenario Analysis";
                    TempBlob: Codeunit "Temp Blob";
                    OutStream: OutStream;
                    FileName: Text;
                    ExportText: Text;
                    Counter: Integer;
                begin
                    RiskScenario.CopyFilters(Rec);
                    if not RiskScenario.FindSet() then begin
                        Message('No records found to export.');
                        exit;
                    end;
                    
                    TempBlob.CreateOutStream(OutStream);
                    ExportText := 'Risk Scenario Analysis Summary Export\n';
                    ExportText += '=====================================\n\n';
                    
                    repeat
                        Counter += 1;
                        ExportText += Format(Counter) + '. ' + RiskScenario."Scenario Name" + '\n';
                        ExportText += '   ID: ' + RiskScenario."Scenario ID" + '\n';
                        ExportText += '   Type: ' + Format(RiskScenario."Scenario Type") + '\n';
                        ExportText += '   Probability: ' + Format(RiskScenario."Probability %") + '%\n';
                        ExportText += '   Financial Impact: ' + Format(RiskScenario."Financial Impact") + '\n';
                        ExportText += '   Analysis Date: ' + Format(RiskScenario."Analysis Date") + '\n';
                        ExportText += '   Analyst: ' + RiskScenario."Analyst" + '\n\n';
                    until RiskScenario.Next() = 0;
                    
                    ExportText += 'Export Date: ' + Format(CurrentDateTime) + '\n';
                    ExportText += 'Total Records: ' + Format(Counter) + '\n';
                    
                    OutStream.WriteText(ExportText);
                    
                    FileName := 'Risk_Scenario_Summary_' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '.txt';
                    DownloadFromStream(TempBlob.CreateInStream(), 'Export Scenario Summary', '', 'Text Files (*.txt)|*.txt', FileName);
                    
                    Message('Exported %1 scenario records to file: %2', Counter, FileName);
                end;
            }
        }
        area(navigation)
        {
            action(RelatedRisk)
            {
                Caption = 'Related Risk';
                Image = Risk;
                ApplicationArea = All;
                ToolTip = 'View the related risk register entry.';
                RunObject = page "Risk Register Card";
                RunPageLink = "Risk ID" = field("Related Risk ID");
            }
        }
    }
}
