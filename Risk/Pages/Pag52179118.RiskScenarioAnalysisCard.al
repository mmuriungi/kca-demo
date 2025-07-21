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
                begin
                    Message('Scenario analysis functionality would be implemented here.');
                end;
            }
            action(ExportResults)
            {
                Caption = 'Export Results';
                Image = Export;
                ApplicationArea = All;
                ToolTip = 'Export the scenario analysis results.';
                
                trigger OnAction()
                begin
                    Message('Export functionality would be implemented here.');
                end;
            }
            action(CopyScenario)
            {
                Caption = 'Copy Scenario';
                Image = Copy;
                ApplicationArea = All;
                ToolTip = 'Create a copy of this scenario analysis.';
                
                trigger OnAction()
                begin
                    Message('Copy scenario functionality would be implemented here.');
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
