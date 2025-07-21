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
