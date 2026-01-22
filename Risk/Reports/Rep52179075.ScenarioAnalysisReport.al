// report 52179075 "Scenario Analysis Report"
// {
//     Caption = 'Scenario Analysis Report';
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Rep52179075.ScenarioAnalysisReport.rdl';

//     dataset
//     {
//         dataitem(ScenarioAnalysis; "Risk Scenario Analysis")
//         {
//             RequestFilterFields = "Related Risk ID", "Scenario Type", "Analysis Date", "Analyst";
//             column(CompanyName; CompanyProperty.DisplayName())
//             {
//             }
//             column(ReportTitle; 'Risk Scenario Analysis Report')
//             {
//             }
//             column(FilterString; FilterString)
//             {
//             }
//             column(Scenario_ID; "Scenario ID")
//             {
//             }
//             column(Related_Risk_ID; "Related Risk ID")
//             {
//             }
//             column(Scenario_Name; "Scenario Name")
//             {
//             }
//             column(Scenario_Type; "Scenario Type")
//             {
//             }
//             column(Scenario_Description; "Scenario Description")
//             {
//             }
//             column(Probability_Percentage; "Probability %")
//             {
//             }
//             column(Financial_Impact; "Financial Impact")
//             {
//             }
//             column(Operational_Impact; "Operational Impact")
//             {
//             }
//             column(Reputational_Impact; "Reputational Impact")
//             {
//             }
//             column(Analysis_Date; "Analysis Date")
//             {
//             }
//             column(Analyst; Analyst)
//             {
//             }
//             column(Sensitivity_Factor; "Sensitivity Factor")
//             {
//             }
//             column(Mitigation_Strategy; "Mitigation Strategies")
//             {
//             }
//             column(Contingency_Plan; "Contingency Plans")
//             {
//             }
//             column(Review_Date; "Review Date")
//             {
//             }
//             column(Scenario_Type_Display; "Scenario Type")
//             {
//             }
//             column(Key_Variables; "Key Variables")
//             {
//             }

//             dataitem(RelatedRisk; "Risk Register")
//             {
//                 DataItemLink = "Risk ID" = field("Related Risk ID");
//                 column(Risk_Title; "Risk Title")
//                 {
//                 }
//                 column(Risk_Category; "Risk Category")
//                 {
//                 }
//                 column(Risk_Owner; "Risk Owner")
//                 {
//                 }
//                 column(Current_Risk_Level; "Residual Risk Level")
//                 {
//                 }
//                 column(Risk_Status; "Risk Status")
//                 {
//                 }
//             }

//             trigger OnPreDataItem()
//             begin
//                 FilterString := ScenarioAnalysis.GetFilters();
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(IncludeRiskDetails; IncludeRiskDetails)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Include Risk Details';
//                         ToolTip = 'Include details about the related risks in the report.';
//                     }
//                     field(ShowOnlyHighImpact; ShowOnlyHighImpact)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Show Only High Impact Scenarios';
//                         ToolTip = 'Show only scenarios with high financial or operational impact.';
//                     }
//                 }
//             }
//         }

//         trigger OnOpenPage()
//         begin
//             IncludeRiskDetails := true;
//         end;
//     }

//     var
//         FilterString: Text;
//         IncludeRiskDetails: Boolean;
//         ShowOnlyHighImpact: Boolean;

//     trigger OnPreReport()
//     begin
//         if ShowOnlyHighImpact then
//             ScenarioAnalysis.SetFilter("Financial Impact", '>=%1', 100000); // High impact threshold
//     end;
// }
