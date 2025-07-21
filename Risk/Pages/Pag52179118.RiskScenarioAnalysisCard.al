page 52159 "Risk Scenario Analysis Card"
{
    Caption = 'Risk Scenario Analysis Card';
    PageType = Card;
    SourceTable = "Risk Scenario Analysis";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Scenario Description"; Rec."Scenario Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the detailed description of the risk scenario.';
                    MultiLine = true;
                }
                field("Scenario Type"; Rec."Scenario Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of scenario analysis.';
                }
            }

            group(Impact)
            {
                Caption = 'Impact Assessment';

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
                field("Reputational Impact"; Rec."Reputational Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reputational impact of the scenario.';
                }
            }

            group(Analysis)
            {
                Caption = 'Analysis Details';

                field("Key Variables"; Rec."Key Variables")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the key variables considered in the analysis.';
                    MultiLine = true;
                }
                field("Assumptions"; Rec."Assumptions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the assumptions made during the analysis.';
                    MultiLine = true;
                }
                field("Sensitivity Factor"; Rec."Sensitivity Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sensitivity factor for the analysis.';
                }
                field("Monte Carlo Runs"; Rec."Monte Carlo Runs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of Monte Carlo simulation runs.';
                }
            }

            group(Response)
            {
                Caption = 'Response Planning';

                field("Mitigation Strategies"; Rec."Mitigation Strategies")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mitigation strategies for the scenario.';
                    MultiLine = true;
                }
                field("Contingency Plans"; Rec."Contingency Plans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contingency plans for the scenario.';
                    MultiLine = true;
                }
            }

            group(Tracking)
            {
                Caption = 'Tracking Information';

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
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the analysis should be reviewed.';
                }
            }

            group(Audit)
            {
                Caption = 'Audit Trail';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who last modified the record.';
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was last modified.';
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
                var
                    ScenarioAnalysisDialog: Dialog;
                    ProgressBar: Integer;
                    MaxRuns: Integer;
                    CurrentRun: Integer;
                    TotalRisk: Decimal;
                    AverageRisk: Decimal;
                    MinRisk: Decimal;
                    MaxRisk: Decimal;
                    StdDeviation: Decimal;
                begin
                    if Rec."Monte Carlo Runs" = 0 then
                        Rec."Monte Carlo Runs" := 1000;

                    ScenarioAnalysisDialog.Open('Running Scenario Analysis...\Progress: #1########## @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

                    MaxRuns := Rec."Monte Carlo Runs";
                    TotalRisk := 0;
                    MinRisk := 999999;
                    MaxRisk := 0;

                    for CurrentRun := 1 to MaxRuns do begin
                        ProgressBar := Round(CurrentRun / MaxRuns * 10000, 1);
                        ScenarioAnalysisDialog.Update(1, CurrentRun);
                        ScenarioAnalysisDialog.Update(2, ProgressBar);

                        // Simulate risk calculation with random variation
                        TotalRisk += CalculateScenarioRisk();

                        if CurrentRun mod 100 = 0 then
                            Sleep(10); // Brief pause for UI responsiveness
                    end;

                    ScenarioAnalysisDialog.Close();

                    AverageRisk := TotalRisk / MaxRuns;

                    // Update analysis results
                    Rec."Analysis Date" := Today;
                    Rec."Analyst" := UserId;
                    Rec.Modify(true);

                    Message('Scenario Analysis Completed\n\nRuns: %1\nAverage Risk Score: %2\nFinancial Impact Range: %3 - %4\n\nResults have been saved to the record.',
                            MaxRuns,
                            Round(AverageRisk, 0.01),
                            Round(Rec."Financial Impact" * 0.7, 1),
                            Round(Rec."Financial Impact" * 1.3, 1));

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
                    TempBlob: Codeunit "Temp Blob";
                    OutStream: OutStream;
                    InStream: InStream;
                    FileName: Text;
                    ExportText: Text;
                begin
                    TempBlob.CreateOutStream(OutStream);

                    // Create export content
                    ExportText := 'Risk Scenario Analysis Export' + '\n';
                    ExportText += '=============================' + '\n\n';
                    ExportText += 'Scenario ID: ' + Rec."Scenario ID" + '\n';
                    ExportText += 'Scenario Name: ' + Rec."Scenario Name" + '\n';
                    ExportText += 'Related Risk ID: ' + Rec."Related Risk ID" + '\n';
                    ExportText += 'Scenario Type: ' + Format(Rec."Scenario Type") + '\n';
                    ExportText += 'Description: ' + Rec."Scenario Description" + '\n\n';
                    ExportText += 'Analysis Parameters:' + '\n';
                    ExportText += '- Probability %: ' + Format(Rec."Probability %") + '\n';
                    ExportText += '- Financial Impact: ' + Format(Rec."Financial Impact") + '\n';
                    ExportText += '- Operational Impact: ' + Rec."Operational Impact" + '\n';
                    ExportText += '- Reputational Impact: ' + Rec."Reputational Impact" + '\n';
                    ExportText += '- Sensitivity Factor: ' + Format(Rec."Sensitivity Factor") + '\n';
                    ExportText += '- Monte Carlo Runs: ' + Format(Rec."Monte Carlo Runs") + '\n\n';
                    ExportText += 'Risk Management:' + '\n';
                    ExportText += '- Key Variables: ' + Rec."Key Variables" + '\n';
                    ExportText += '- Assumptions: ' + Rec."Assumptions" + '\n';
                    ExportText += '- Mitigation Strategies: ' + Rec."Mitigation Strategies" + '\n';
                    ExportText += '- Contingency Plans: ' + Rec."Contingency Plans" + '\n\n';
                    ExportText += 'Analysis Details:' + '\n';
                    ExportText += '- Analysis Date: ' + Format(Rec."Analysis Date") + '\n';
                    ExportText += '- Analyst: ' + Rec."Analyst" + '\n';
                    ExportText += '- Review Date: ' + Format(Rec."Review Date") + '\n\n';
                    ExportText += 'Export Date: ' + Format(CurrentDateTime) + '\n';

                    OutStream.WriteText(ExportText);

                    FileName := 'Risk_Scenario_Analysis_' + Rec."Scenario ID" + '_' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '.txt';
                    DownloadFromStream(TempBlob.CreateInStream(), 'Export Scenario Analysis', '', 'Text Files (*.txt)|*.txt', FileName);

                    Message('Scenario analysis exported to file: %1', FileName);
                end;
            }
            action(CopyScenario)
            {
                Caption = 'Copy Scenario';
                Image = Copy;
                ApplicationArea = All;
                ToolTip = 'Create a copy of this scenario analysis.';

                trigger OnAction()
                var
                    FromScenario: Record "Risk Scenario Analysis";
                    ToScenario: Record "Risk Scenario Analysis";
                    ScenarioCard: Page "Risk Scenario Analysis Card";
                    NewScenarioID: Code[20];
                begin
                    FromScenario.Get(Rec."Scenario ID");

                    ToScenario.Init();
                    ToScenario.TransferFields(FromScenario, false);

                    // Generate new ID
                    NewScenarioID := GetNextScenarioID();
                    ToScenario."Scenario ID" := NewScenarioID;
                    ToScenario."Scenario Name" := FromScenario."Scenario Name" + ' (Copy)';
                    ToScenario."Analysis Date" := 0D;
                    ToScenario."Analyst" := '';
                    ToScenario."Review Date" := 0D;

                    ToScenario.Insert(true);

                    ScenarioCard.SetRecord(ToScenario);
                    ScenarioCard.Run();

                    Message('Scenario copied successfully. New Scenario ID: %1', NewScenarioID);
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

    local procedure CalculateScenarioRisk(): Decimal
    var
        RandomValue: Decimal;
        BaseRisk: Decimal;
    begin
        // Simple Monte Carlo simulation
        RandomValue := Random(100) / 100; // 0 to 1
        BaseRisk := Rec."Probability %" * Rec."Sensitivity Factor" / 100;

        // Add random variation based on scenario type
        case Rec."Scenario Type" of
            Rec."Scenario Type"::Best_Case:
                BaseRisk := BaseRisk * (0.5 + RandomValue * 0.3);
            Rec."Scenario Type"::Most_Likely:
                BaseRisk := BaseRisk * (0.8 + RandomValue * 0.4);
            Rec."Scenario Type"::Worst_Case:
                BaseRisk := BaseRisk * (1.2 + RandomValue * 0.8);
            Rec."Scenario Type"::Stress_Test:
                BaseRisk := BaseRisk * (1.5 + RandomValue * 1.0);
        end;

        exit(BaseRisk);
    end;

    local procedure GetNextScenarioID(): Code[20]
    var
        RiskScenario: Record "Risk Scenario Analysis";
        NextNo: Integer;
    begin
        RiskScenario.SetCurrentKey("Scenario ID");
        if RiskScenario.FindLast() then
            NextNo := 1
        else
            NextNo := 1;

        repeat
            NextNo += 1;
        until not RiskScenario.Get('SCE' + Format(NextNo));

        exit('SCE' + Format(NextNo));
    end;
}
