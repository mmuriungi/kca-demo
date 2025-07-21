page 52179070 "Risk Management Role Center"
{
    Caption = 'Risk Management Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    
    layout
    {
        area(rolecenter)
        {
            part(Headline; "Headline RC Project Manager")
            {
                ApplicationArea = All;
            }
            group(Control1900724808)
            {
                ShowCaption = false;
                part(RiskDashboard; "Risk Register List")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(RiskActivities; "Risk Activities")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(embedding)
        {
            action(RiskRegister)
            {
                Caption = 'Risk Register';
                RunObject = page "Risk Register List";
                ApplicationArea = All;
                Image = List;
            }
            action(RiskMitigations)
            {
                Caption = 'Risk Mitigations';
                RunObject = page "Risk Mitigation List";
                ApplicationArea = All;
                Image = Planning;
            }
            action(RiskIncidents)
            {
                Caption = 'Risk Incidents';
                RunObject = page "Risk Incident List";
                ApplicationArea = All;
                Image = ErrorLog;
            }
            action(KeyRiskIndicators)
            {
                Caption = 'Key Risk Indicators';
                RunObject = page "Key Risk Indicators List";
                ApplicationArea = All;
                Image = Statistics;
            }
            action(ComplianceRisks)
            {
                Caption = 'Compliance Risks';
                RunObject = page "Compliance Risk List";
                ApplicationArea = All;
                Image = Compliance;
            }
            action(ScenarioAnalysis)
            {
                Caption = 'Scenario Analysis';
                RunObject = page "Risk Scenario Analysis List";
                ApplicationArea = All;
                Image = Simulate;
            }
            action(RiskActivitiesNav)
            {
                Caption = 'Risk Activities';
                RunObject = page "Risk Activities";
                ApplicationArea = All;
                Image = TaskList;
            }
        }
        area(sections)
        {
            group(RiskManagement)
            {
                Caption = 'Risk Management';
                action(Risks)
                {
                    Caption = 'Risks';
                    RunObject = page "Risk Register List";
                    ApplicationArea = All;
                    Image = List;
                }
                action(Mitigations)
                {
                    Caption = 'Mitigations';
                    RunObject = page "Risk Mitigation List";
                    ApplicationArea = All;
                    Image = Planning;
                }
                action(Incidents)
                {
                    Caption = 'Incidents';
                    RunObject = page "Risk Incident List";
                    ApplicationArea = All;
                    Image = ErrorLog;
                }
                action(KRIs)
                {
                    Caption = 'KRIs';
                    RunObject = page "Key Risk Indicators List";
                    ApplicationArea = All;
                    Image = Statistics;
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                action(RiskHeatMap)
                {
                    Caption = 'Risk Heat Map';
                    RunObject = report "Risk Heat Map Report";
                    ApplicationArea = All;
                    Image = Matrix;
                }
                action(RiskRegisterReport)
                {
                    Caption = 'Risk Register Report';
                    RunObject = report "Risk Register Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(MitigationProgressReport)
                {
                    Caption = 'Mitigation Progress Report';
                    RunObject = report "Risk Mitigation Progress";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(IncidentReport)
                {
                    Caption = 'Incident Report';
                    RunObject = report "Risk Register Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(KRIReport)
                {
                    Caption = 'KRI Report';
                    RunObject = report "Key Risk Indicators Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(ComplianceRiskReport)
                {
                    Caption = 'Compliance Risk Report';
                    RunObject = report "Risk Register Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(ResidualRiskReport)
                {
                    Caption = 'Residual Risk Report';
                    RunObject = report "Risk Register Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(RiskTrendReport)
                {
                    Caption = 'Risk Trend Analysis Report';
                    RunObject = report "Key Risk Indicators Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(ScenarioAnalysisReport)
                {
                    Caption = 'Scenario Analysis Report';
                    RunObject = report "Scenario Analysis Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(RiskToleranceReport)
                {
                    Caption = 'Risk Tolerance Report';
                    RunObject = report "Key Risk Indicators Report";
                    ApplicationArea = All;
                    Image = Report;
                }
                action(AuditTrailReport)
                {
                    Caption = 'Audit Trail Report';
                    RunObject = report "Change Log Entries";
                    ApplicationArea = All;
                    Image = Report;
                }
            }
        }
        area(creation)
        {
            action(NewRisk)
            {
                Caption = 'Risk';
                RunObject = page "Risk Register Card";
                RunPageMode = Create;
                ApplicationArea = All;
                Image = New;
            }
            action(NewIncident)
            {
                Caption = 'Incident';
                RunObject = page "Risk Incident Card";
                RunPageMode = Create;
                ApplicationArea = All;
                Image = New;
            }
            action(NewKRI)
            {
                Caption = 'KRI';
                RunObject = page "Key Risk Indicators Card";
                RunPageMode = Create;
                ApplicationArea = All;
                Image = New;
            }
            action(NewMitigation)
            {
                Caption = 'Mitigation';
                RunObject = page "Risk Mitigation Card";
                RunPageMode = Create;
                ApplicationArea = All;
                Image = New;
            }
            action(NewScenario)
            {
                Caption = 'Scenario Analysis';
                RunObject = page "Risk Scenario Analysis Card";
                RunPageMode = Create;
                ApplicationArea = All;
                Image = New;
            }
            action(NewComplianceRisk)
            {
                Caption = 'Compliance Risk';
                RunObject = page "Compliance Risk Card";
                RunPageMode = Create;
                ApplicationArea = All;
                Image = New;
            }
        }
        area(processing)
        {
            action(Setup)
            {
                Caption = 'Risk Management Setup';
                RunObject = page "Risk Management Setup";
                ApplicationArea = All;
                Image = Setup;
            }
        }
    }
}