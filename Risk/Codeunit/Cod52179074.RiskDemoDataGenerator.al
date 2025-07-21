codeunit 52179074 "Risk Demo Data Generator"
{
    procedure GenerateAllDemoData()
    begin
        CreateRiskManagementSetup();
        CreateRiskRegisterDemoData();
        CreateRiskMitigationDemoData();
        CreateRiskIncidentDemoData();
        CreateKeyRiskIndicatorsDemoData();
        CreateComplianceRiskDemoData();
        CreateScenarioAnalysisDemoData();
    end;
    
    local procedure CreateRiskManagementSetup()
    var
        RiskSetup: Record "Risk Management Setup";
    begin
        if not RiskSetup.Get() then begin
            RiskSetup.Init();
            RiskSetup."Primary Key" := '';
            Evaluate(RiskSetup."Default Review Period", '<6M>');
            RiskSetup."Alert Days Before Review" := 30;
            RiskSetup."Risk Manager" := UserId;
            RiskSetup."Risk Committee Chair" := UserId;
            RiskSetup."Enable Notifications" := true;
            RiskSetup."Auto Calculate Ratings" := true;
            RiskSetup.Insert();
        end;
    end;
    
    local procedure CreateRiskRegisterDemoData()
    var
        RiskRegister: Record "Risk Register";
        Counter: Integer;
    begin
        for Counter := 1 to 20 do begin
            RiskRegister.Init();
            RiskRegister."Risk ID" := 'DEMO-RISK-' + Format(Counter);
            RiskRegister."Risk Title" := GetDemoRiskTitle(Counter);
            RiskRegister."Risk Description" := GetDemoRiskDescription(Counter);
            RiskRegister."Risk Cause" := GetDemoRiskCause(Counter);
            RiskRegister."Risk Effects" := GetDemoRiskEffects(Counter);
            RiskRegister."Risk Category" := GetDemoRiskCategory(Counter);
            RiskRegister."Risk Type" := GetDemoRiskType(Counter);
            RiskRegister."Department Code" := GetDemoDepartment(Counter);
            RiskRegister."Function Code" := GetDemoFunction(Counter);
            RiskRegister."Strategic Pillar" := GetDemoStrategicPillar(Counter);
            RiskRegister."Inherent Likelihood" := GetDemoLikelihood(Counter);
            RiskRegister."Inherent Impact" := GetDemoImpact(Counter);
            RiskRegister.Validate("Inherent Likelihood");
           // RiskRegister.Validate("Inherent Impact");
            RiskRegister."Residual Likelihood" := GetDemoResidualLikelihood(Counter);
            RiskRegister."Residual Impact" := GetDemoResidualImpact(Counter);
            RiskRegister.Validate("Residual Likelihood");
            //RiskRegister.Validate("Residual Impact");
            RiskRegister."Treatment Strategy" := GetDemoTreatmentStrategy(Counter);
            RiskRegister."Risk Owner" := UserId;
            RiskRegister.Status := GetDemoRiskStatus(Counter);
            RiskRegister."Risk Appetite" := GetDemoRiskAppetite(Counter);
            RiskRegister."Risk Tolerance" := GetDemoRiskTolerance(Counter);
            Evaluate(RiskRegister."Review Period", '<6M>');
            RiskRegister."Last Review Date" := CalcDate('<-1M>', Today);
            RiskRegister."Next Review Date" := CalcDate('<5M>', Today);
            RiskRegister.Insert();
        end;
    end;
    
    local procedure CreateRiskMitigationDemoData()
    var
        RiskMitigation: Record "Risk Mitigation";
        RiskRegister: Record "Risk Register";
        Counter: Integer;
        MitigationCounter: Integer;
    begin
        if RiskRegister.FindSet() then
            repeat
                Counter += 1;
                for MitigationCounter := 1 to 2 do begin
                    RiskMitigation.Init();
                    RiskMitigation."Mitigation ID" := 'DEMO-MIT-' + Format(Counter) + '-' + Format(MitigationCounter);
                    RiskMitigation."Risk ID" := RiskRegister."Risk ID";
                    RiskMitigation."Mitigation Title" := GetDemoMitigationTitle(Counter, MitigationCounter);
                    RiskMitigation."Mitigation Description" := GetDemoMitigationDescription(Counter, MitigationCounter);
                    RiskMitigation."Action Required" := GetDemoActionRequired(Counter, MitigationCounter);
                    RiskMitigation."Responsible Person" := UserId;
                    RiskMitigation."Department Code" := RiskRegister."Department Code";
                    RiskMitigation."Start Date" := CalcDate('<-2M>', Today);
                    RiskMitigation."Target Date" := CalcDate('<+' + Format(Random(6)) + 'M>', Today);
                    RiskMitigation.Status := GetDemoMitigationStatus(MitigationCounter);
                    RiskMitigation."Progress %" := Random(100);
                    RiskMitigation."Budget Required" := (Random(10) > 5);
                    if RiskMitigation."Budget Required" then
                        RiskMitigation."Budget Amount" := Random(100000);
                    RiskMitigation."Control Effectiveness" := Random(4);
                    RiskMitigation.Insert();
                end;
            until RiskRegister.Next() = 0;
    end;
    
    local procedure CreateRiskIncidentDemoData()
    var
        RiskIncident: Record "Risk Incident";
        RiskRegister: Record "Risk Register";
        Counter: Integer;
    begin
        Counter := 0;
        if RiskRegister.FindSet() then
            repeat
                Counter += 1;
                if Random(3) = 1 then begin // Create incidents for 1/3 of risks
                    RiskIncident.Init();
                    RiskIncident."Incident ID" := 'DEMO-INC-' + Format(Counter);
                    RiskIncident."Related Risk ID" := RiskRegister."Risk ID";
                    RiskIncident."Incident Title" := GetDemoIncidentTitle(Counter);
                    RiskIncident."Incident Description" := GetDemoIncidentDescription(Counter);
                    RiskIncident."Root Cause" := GetDemoIncidentRootCause(Counter);
                    RiskIncident."Impact Assessment" := GetDemoIncidentImpact(Counter);
                    RiskIncident."Incident Type" := GetDemoIncidentType(Counter);
                    RiskIncident.Severity := GetDemoIncidentSeverity(Counter);
                    RiskIncident."Department Code" := RiskRegister."Department Code";
                    RiskIncident."Occurrence Date" := CalcDate('<-' + Format(Random(30)) + 'D>', Today);
                    RiskIncident."Detection Date" := CalcDate('<+' + Format(Random(7)) + 'D>', RiskIncident."Occurrence Date");
                    RiskIncident."Reported By" := UserId;
                    RiskIncident."Assigned To" := UserId;
                    RiskIncident.Status := GetDemoIncidentStatus(Counter);
                    RiskIncident."Priority" := Random(4);
                    RiskIncident."Financial Impact" := Random(50000);
                    RiskIncident."Target Resolution Date" := CalcDate('<+' + Format(Random(30)) + 'D>', Today);
                    RiskIncident.Insert();
                end;
            until RiskRegister.Next() = 0;
    end;
    
    local procedure CreateKeyRiskIndicatorsDemoData()
    var
        KRI: Record "Key Risk Indicators";
        RiskRegister: Record "Risk Register";
        Counter: Integer;
    begin
        Counter := 0;
        if RiskRegister.FindSet() then
            repeat
                Counter += 1;
                if Random(2) = 1 then begin // Create KRIs for 50% of risks
                    KRI.Init();
                    KRI."KRI ID" := 'DEMO-KRI-' + Format(Counter);
                    KRI."Related Risk ID" := RiskRegister."Risk ID";
                    KRI."KRI Name" := GetDemoKRIName(Counter);
                    KRI.Description := GetDemoKRIDescription(Counter);
                    KRI."Measurement Method" := GetDemoKRIMeasurementMethod(Counter);
                    KRI."Current Value" := Random(100);
                    KRI."Target Value" := Random(50);
                    KRI."Threshold - Green" := Random(25);
                    KRI."Threshold - Yellow" := Random(50) + 25;
                    KRI."Threshold - Red" := Random(25) + 75;
                    KRI.Validate("Current Value");
                    KRI."Monitoring Frequency" := Random(5);
                    KRI."Last Measured Date" := Today;
                    KRI."Data Source" := GetDemoKRIDataSource(Counter);
                    KRI."Responsible Person" := UserId;
                    KRI.Active := true;
                    KRI."Department Code" := RiskRegister."Department Code";
                    KRI.Insert();
                end;
            until RiskRegister.Next() = 0;
    end;
    
    local procedure CreateComplianceRiskDemoData()
    var
        ComplianceRisk: Record "Compliance Risk";
        RiskRegister: Record "Risk Register";
        Counter: Integer;
    begin
        Counter := 0;
        if RiskRegister.FindSet() then
            repeat
                Counter += 1;
                if (Counter mod 4) = 1 then begin // Create compliance risks for 25% of risks
                    ComplianceRisk.Init();
                    ComplianceRisk."Compliance ID" := 'DEMO-COMP-' + Format(Counter);
                    ComplianceRisk."Related Risk ID" := RiskRegister."Risk ID";
                    ComplianceRisk."Regulation/Standard" := GetDemoRegulation(Counter);
                    ComplianceRisk."Requirement Description" := GetDemoRequirementDescription(Counter);
                    ComplianceRisk."Regulatory Body" := GetDemoRegulatoryBody(Counter);
                    ComplianceRisk."Compliance Status" := Random(4);
                    ComplianceRisk."Risk Level" := RiskRegister."Residual Risk Level";
                    ComplianceRisk."Last Assessment Date" := CalcDate('<-' + Format(Random(90)) + 'D>', Today);
                    Evaluate(ComplianceRisk."Assessment Frequency", '<3M>');
                    ComplianceRisk.Validate("Assessment Frequency");
                    ComplianceRisk."Responsible Officer" := UserId;
                    ComplianceRisk."Department Code" := RiskRegister."Department Code";
                    ComplianceRisk."Action Plan" := GetDemoActionPlan(Counter);
                    ComplianceRisk."Target Completion Date" := CalcDate('<+' + Format(Random(180)) + 'D>', Today);
                    ComplianceRisk.Insert();
                end;
            until RiskRegister.Next() = 0;
    end;
    
    local procedure CreateScenarioAnalysisDemoData()
    var
        ScenarioAnalysis: Record "Risk Scenario Analysis";
        RiskRegister: Record "Risk Register";
        Counter: Integer;
        ScenarioCounter: Integer;
    begin
        Counter := 0;
        if RiskRegister.FindSet() then
            repeat
                Counter += 1;
                if (Counter mod 5) = 1 then begin // Create scenario analysis for 20% of risks
                    for ScenarioCounter := 1 to 3 do begin
                        ScenarioAnalysis.Init();
                        ScenarioAnalysis."Scenario ID" := 'DEMO-SCEN-' + Format(Counter) + '-' + Format(ScenarioCounter);
                        ScenarioAnalysis."Related Risk ID" := RiskRegister."Risk ID";
                        ScenarioAnalysis."Scenario Name" := GetDemoScenarioName(Counter, ScenarioCounter);
                        ScenarioAnalysis."Scenario Description" := GetDemoScenarioDescription(Counter, ScenarioCounter);
                        ScenarioAnalysis."Scenario Type" := ScenarioCounter;
                        ScenarioAnalysis."Probability %" := GetDemoScenarioProbability(ScenarioCounter);
                        ScenarioAnalysis."Financial Impact" := Random(1000000);
                        ScenarioAnalysis."Operational Impact" := GetDemoOperationalImpact(ScenarioCounter);
                        ScenarioAnalysis."Reputational Impact" := GetDemoReputationalImpact(ScenarioCounter);
                        ScenarioAnalysis."Analysis Date" := Today;
                        ScenarioAnalysis.Analyst := UserId;
                        ScenarioAnalysis."Review Date" := CalcDate('<+1Y>', Today);
                        ScenarioAnalysis.Insert();
                    end;
                end;
            until RiskRegister.Next() = 0;
    end;
    
    // Helper functions for demo data
    local procedure GetDemoRiskTitle(Counter: Integer): Text[100]
    var
        Titles: array[10] of Text[100];
    begin
        Titles[1] := 'Cybersecurity Breach Risk';
        Titles[2] := 'Financial Liquidity Risk';
        Titles[3] := 'Student Enrollment Decline';
        Titles[4] := 'Faculty Retention Risk';
        Titles[5] := 'Infrastructure Failure Risk';
        Titles[6] := 'Regulatory Compliance Risk';
        Titles[7] := 'Reputation Management Risk';
        Titles[8] := 'Technology Obsolescence Risk';
        Titles[9] := 'Research Funding Risk';
        Titles[10] := 'Health & Safety Risk';
        
        exit(Titles[((Counter - 1) mod 10) + 1]);
    end;
    
    local procedure GetDemoRiskDescription(Counter: Integer): Text[250]
    var
        Descriptions: array[10] of Text[250];
    begin
        Descriptions[1] := 'Risk of cyber attacks compromising university data and systems';
        Descriptions[2] := 'Risk of insufficient cash flow to meet operational obligations';
        Descriptions[3] := 'Risk of declining student applications and enrollment numbers';
        Descriptions[4] := 'Risk of losing qualified faculty members to competitor institutions';
        Descriptions[5] := 'Risk of critical infrastructure systems failing or becoming unreliable';
        Descriptions[6] := 'Risk of non-compliance with education regulations and standards';
        Descriptions[7] := 'Risk of negative publicity affecting university reputation';
        Descriptions[8] := 'Risk of technology becoming outdated and requiring major updates';
        Descriptions[9] := 'Risk of reduced availability of research grants and funding';
        Descriptions[10] := 'Risk of accidents or safety incidents on campus';
        
        exit(Descriptions[((Counter - 1) mod 10) + 1]);
    end;
    
    local procedure GetDemoRiskCategory(Counter: Integer): Enum "Risk Category"
    var
        Categories: array[10] of Enum "Risk Category";
    begin
        Categories[1] := "Risk Category"::Technology;
        Categories[2] := "Risk Category"::Financial;
        Categories[3] := "Risk Category"::Academic;
        Categories[4] := "Risk Category"::Human_Resources;
        Categories[5] := "Risk Category"::Infrastructure;
        Categories[6] := "Risk Category"::Compliance;
        Categories[7] := "Risk Category"::Reputational;
        Categories[8] := "Risk Category"::Technology;
        Categories[9] := "Risk Category"::Research;
        Categories[10] := "Risk Category"::Health_Safety;
        
        exit(Categories[((Counter - 1) mod 10) + 1]);
    end;
    
    local procedure GetDemoRiskType(Counter: Integer): Enum "Risk Type"
    begin
        case (Counter mod 4) of
            0: exit("Risk Type"::Inherent);
            1: exit("Risk Type"::Residual);
            2: exit("Risk Type"::Emerging);
            else exit("Risk Type"::Opportunity);
        end;
    end;
    
    local procedure GetDemoLikelihood(Counter: Integer): Enum "Risk Likelihood"
    begin
        exit("Risk Likelihood".FromInteger(Random(5)));
    end;
    
    local procedure GetDemoImpact(Counter: Integer): Enum "Risk Impact Level"
    begin
        exit("Risk Impact Level".FromInteger(Random(5)));
    end;
    
    local procedure GetDemoResidualLikelihood(Counter: Integer): Enum "Risk Likelihood"
    var
        InherentValue: Integer;
        ResidualValue: Integer;
    begin
        InherentValue := Random(5);
        ResidualValue := InherentValue - Random(2); // Usually lower than inherent
        if ResidualValue < 1 then ResidualValue := 1;
        exit("Risk Likelihood".FromInteger(ResidualValue));
    end;
    
    local procedure GetDemoResidualImpact(Counter: Integer): Enum "Risk Impact Level"
    var
        InherentValue: Integer;
        ResidualValue: Integer;
    begin
        InherentValue := Random(5);
        ResidualValue := InherentValue - Random(2); // Usually lower than inherent
        if ResidualValue < 1 then ResidualValue := 1;
        exit("Risk Impact Level".FromInteger(ResidualValue));
    end;
    
    // Additional helper functions would continue here...
    // Due to length constraints, I'm including key functions only
    
    local procedure GetDemoRiskCause(Counter: Integer): Text[250]
    begin
        exit('Sample risk cause for demonstration purposes - Risk ' + Format(Counter));
    end;
    
    local procedure GetDemoRiskEffects(Counter: Integer): Text[250]
    begin
        exit('Sample risk effects/consequences for demonstration - Risk ' + Format(Counter));
    end;
    
    local procedure GetDemoDepartment(Counter: Integer): Code[20]
    var
        Departments: array[5] of Code[20];
    begin
        Departments[1] := 'ACADEMIC';
        Departments[2] := 'FINANCE';
        Departments[3] := 'IT';
        Departments[4] := 'HR';
        Departments[5] := 'ADMIN';
        
        exit(Departments[((Counter - 1) mod 5) + 1]);
    end;
    
    local procedure GetDemoFunction(Counter: Integer): Code[20]
    begin
        exit('FUNC-' + Format(Counter));
    end;
    
    local procedure GetDemoStrategicPillar(Counter: Integer): Code[20]
    begin
        exit('PILLAR-' + Format(((Counter - 1) mod 3) + 1));
    end;
    
    local procedure GetDemoTreatmentStrategy(Counter: Integer): Enum "Risk Treatment Strategy"
    begin
        exit("Risk Treatment Strategy".FromInteger(Random(5)));
    end;
    
    local procedure GetDemoRiskStatus(Counter: Integer): Enum "Risk Status"
    begin
        exit("Risk Status".FromInteger(Random(8)));
    end;
    
    local procedure GetDemoRiskAppetite(Counter: Integer): Text[100]
    begin
        exit('Demo risk appetite statement for Risk ' + Format(Counter));
    end;
    
    local procedure GetDemoRiskTolerance(Counter: Integer): Text[100]
    begin
        exit('Demo risk tolerance statement for Risk ' + Format(Counter));
    end;
    
    local procedure GetDemoMitigationTitle(RiskCounter: Integer; MitigationCounter: Integer): Text[100]
    begin
        exit('Mitigation Action ' + Format(MitigationCounter) + ' for Risk ' + Format(RiskCounter));
    end;
    
    local procedure GetDemoMitigationDescription(RiskCounter: Integer; MitigationCounter: Integer): Text[250]
    begin
        exit('Detailed description of mitigation action ' + Format(MitigationCounter) + ' for risk ' + Format(RiskCounter));
    end;
    
    local procedure GetDemoActionRequired(RiskCounter: Integer; MitigationCounter: Integer): Text[250]
    begin
        exit('Specific action required for mitigation ' + Format(MitigationCounter) + ' of risk ' + Format(RiskCounter));
    end;
    
    local procedure GetDemoMitigationStatus(Counter: Integer): Enum "Mitigation Status"
    begin
        exit("Mitigation Status".FromInteger(Random(7)));
    end;
    
    local procedure GetDemoIncidentTitle(Counter: Integer): Text[100]
    begin
        exit('Risk Incident ' + Format(Counter) + ' - Sample Event');
    end;
    
    local procedure GetDemoIncidentDescription(Counter: Integer): Text[250]
    begin
        exit('Description of risk incident ' + Format(Counter) + ' for demonstration purposes');
    end;
    
    local procedure GetDemoIncidentRootCause(Counter: Integer): Text[250]
    begin
        exit('Root cause analysis for incident ' + Format(Counter));
    end;
    
    local procedure GetDemoIncidentImpact(Counter: Integer): Text[250]
    begin
        exit('Impact assessment for incident ' + Format(Counter));
    end;
    
    local procedure GetDemoIncidentType(Counter: Integer): Enum "Incident Type"
    begin
        exit("Incident Type".FromInteger(Random(8)));
    end;
    
    local procedure GetDemoIncidentSeverity(Counter: Integer): Enum "Incident Severity"
    begin
        exit("Incident Severity".FromInteger(Random(4)));
    end;
    
    local procedure GetDemoIncidentStatus(Counter: Integer): Enum "Risk Status"
    begin
        exit("Risk Status".FromInteger(Random(8)));
    end;
    
    local procedure GetDemoKRIName(Counter: Integer): Text[100]
    begin
        exit('Key Risk Indicator ' + Format(Counter));
    end;
    
    local procedure GetDemoKRIDescription(Counter: Integer): Text[250]
    begin
        exit('Description of KRI ' + Format(Counter) + ' for monitoring risk levels');
    end;
    
    local procedure GetDemoKRIMeasurementMethod(Counter: Integer): Text[100]
    begin
        exit('Measurement method for KRI ' + Format(Counter));
    end;
    
    local procedure GetDemoKRIDataSource(Counter: Integer): Text[100]
    begin
        exit('Data source for KRI ' + Format(Counter));
    end;
    
    local procedure GetDemoRegulation(Counter: Integer): Text[100]
    begin
        exit('Regulation/Standard ' + Format(Counter));
    end;
    
    local procedure GetDemoRequirementDescription(Counter: Integer): Text[250]
    begin
        exit('Compliance requirement description for regulation ' + Format(Counter));
    end;
    
    local procedure GetDemoRegulatoryBody(Counter: Integer): Text[50]
    begin
        exit('Regulatory Body ' + Format(Counter));
    end;
    
    local procedure GetDemoActionPlan(Counter: Integer): Text[250]
    begin
        exit('Action plan for compliance requirement ' + Format(Counter));
    end;
    
    local procedure GetDemoScenarioName(RiskCounter: Integer; ScenarioCounter: Integer): Text[100]
    var
        ScenarioTypes: array[3] of Text[50];
    begin
        ScenarioTypes[1] := 'Best Case';
        ScenarioTypes[2] := 'Most Likely';
        ScenarioTypes[3] := 'Worst Case';
        
        exit(ScenarioTypes[ScenarioCounter] + ' Scenario for Risk ' + Format(RiskCounter));
    end;
    
    local procedure GetDemoScenarioDescription(RiskCounter: Integer; ScenarioCounter: Integer): Text[250]
    begin
        exit('Scenario analysis description for risk ' + Format(RiskCounter) + ', scenario ' + Format(ScenarioCounter));
    end;
    
    local procedure GetDemoScenarioProbability(ScenarioCounter: Integer): Decimal
    begin
        case ScenarioCounter of
            1: exit(10 + Random(20)); // Best case: 10-30%
            2: exit(40 + Random(30)); // Most likely: 40-70%
            3: exit(5 + Random(15));  // Worst case: 5-20%
        end;
    end;
    
    local procedure GetDemoOperationalImpact(ScenarioCounter: Integer): Text[100]
    begin
        exit('Operational impact description for scenario ' + Format(ScenarioCounter));
    end;
    
    local procedure GetDemoReputationalImpact(ScenarioCounter: Integer): Text[100]
    begin
        exit('Reputational impact description for scenario ' + Format(ScenarioCounter));
    end;
}