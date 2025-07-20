codeunit 52179100 "Audit Demo Data Generator"
{
    trigger OnRun()
    begin
        if not Confirm('This will generate demo data for the Internal Audit module. Do you want to continue?', false) then
            exit;
            
        GenerateAuditSetup();
        GenerateAuditPeriods();
        GenerateAuditors();
        GenerateAuditUniverse();
        GenerateAuditPlans();
        GenerateAudits();
        GenerateAuditTasks();
        GenerateWorkingPapers();
        GenerateAuditFindings();
        GenerateActionTracking();
        GeneratePerformanceMetrics();
        
        Message('Demo data generation completed successfully!');
    end;
    
    local procedure GenerateAuditSetup()
    var
        AuditSetup: Record "Audit Setup";
    begin
        if not AuditSetup.Get() then begin
            AuditSetup.Init();
            AuditSetup."Primary Key" := '';
            AuditSetup."Audit Nos." := 'AUDIT';
            AuditSetup."Audit Plan Nos." := 'AUDPLAN';
            AuditSetup."Work Paper Nos." := 'WP';
            AuditSetup."Audit Report Nos." := 'AUDRPT';
            AuditSetup."Risk Nos." := 'RISK';
            AuditSetup."Audit Task Nos." := 'TASK';
            AuditSetup."Audit Universe Nos." := 'UNIV';
            AuditSetup."Audit Finding Nos." := 'FIND';
            AuditSetup."Audit Action Nos." := 'ACT';
            AuditSetup."Audit Program Nos." := 'PROG';
            AuditSetup."Audit Notification Nos." := 'NOTIF';
            AuditSetup."Risk Survey Nos." := 'SURVEY';
            AuditSetup."Audit Record Requisition Nos." := 'REQ';
            AuditSetup."Audit Workplan Nos." := 'WPLAN';
            Evaluate(AuditSetup."Report Deadline Reminder", '<7D>');
            AuditSetup."Workplan Frequency" := AuditSetup."Workplan Frequency"::Annual;
            AuditSetup.Insert();
        end;
    end;
    
    local procedure GenerateAuditPeriods()
    var
        AuditPeriod: Record "Audit Period";
        i: Integer;
    begin
        for i := 1 to 4 do begin
            AuditPeriod.Init();
            AuditPeriod.Period := 'Q' + Format(i) + '-' + Format(Date2DMY(Today, 3));
            AuditPeriod.Description := 'Quarter ' + Format(i) + ' ' + Format(Date2DMY(Today, 3));
            AuditPeriod."Period Start" := CalcDate('<-' + Format((4-i)*3) + 'M>', DMY2Date(1, 1, Date2DMY(Today, 3)));
            AuditPeriod."Period End" := CalcDate('<3M-1D>', AuditPeriod."Period Start");
            AuditPeriod.Closed := i < 3;
            if not AuditPeriod.Insert() then;
        end;
    end;
    
    local procedure GenerateAuditors()
    var
        AuditorsList: Record "Auditors List";
        Names: array[10] of Text[50];
        i: Integer;
    begin
        Names[1] := 'John Smith';
        Names[2] := 'Mary Johnson';
        Names[3] := 'David Williams';
        Names[4] := 'Sarah Brown';
        Names[5] := 'Michael Davis';
        Names[6] := 'Jennifer Miller';
        Names[7] := 'Robert Wilson';
        Names[8] := 'Linda Moore';
        Names[9] := 'James Taylor';
        Names[10] := 'Patricia Anderson';
        
        for i := 1 to 10 do begin
            AuditorsList.Init();
            AuditorsList."Auditors No" := 'AUD' + Format(i);
            AuditorsList."Auditor No" := 'EMP' + Format(i);
            AuditorsList."Auditor Name" := Names[i];
            AuditorsList."Auditor Email" := LowerCase(DelChr(Names[i], '=', ' ')) + '@university.edu';
            if i <= 3 then
                AuditorsList.Role := AuditorsList.Role::"Team Leader"
            else
                AuditorsList.Role := AuditorsList.Role::Member;
            if not AuditorsList.Insert() then;
        end;
    end;
    
    local procedure GenerateAuditUniverse()
    var
        AuditUniverse: Record "Audit Universe";
        i: Integer;
    begin
        CreateAuditUniverseEntry('FIN-01', 'Financial Reporting Process', 1, 1, 4, 3);
        CreateAuditUniverseEntry('FIN-02', 'Accounts Payable Process', 1, 1, 3, 2);
        CreateAuditUniverseEntry('FIN-03', 'Payroll Process', 1, 1, 4, 1);
        CreateAuditUniverseEntry('OPS-01', 'Student Registration Process', 2, 3, 3, 2);
        CreateAuditUniverseEntry('OPS-02', 'Procurement Process', 2, 1, 4, 1);
        CreateAuditUniverseEntry('IT-01', 'IT Security Controls', 4, 1, 5, 3);
        CreateAuditUniverseEntry('IT-02', 'System Access Management', 4, 2, 4, 2);
        CreateAuditUniverseEntry('COMP-01', 'Regulatory Compliance', 3, 1, 3, 1);
        CreateAuditUniverseEntry('COMP-02', 'Policy Compliance', 3, 2, 2, 2);
        CreateAuditUniverseEntry('HR-01', 'Recruitment Process', 2, 1, 3, 2);
    end;
    
    local procedure CreateAuditUniverseEntry(Code: Code[20]; Description: Text[100]; AuditArea: Integer; 
                                             Frequency: Integer; RiskLevel: Integer; Impact: Integer)
    var
        AuditUniverse: Record "Audit Universe";
    begin
        AuditUniverse.Init();
        AuditUniverse.Code := Code;
        AuditUniverse.Description := Description;
        AuditUniverse."Audit Area" := AuditArea;
        AuditUniverse."Audit Frequency" := Frequency;
        AuditUniverse."Risk Rating" := RiskLevel;
        AuditUniverse."Business Impact" := Impact;
        AuditUniverse."Risk Score" := RiskLevel * 20;
        AuditUniverse."Last Audit Date" := CalcDate('<-6M>', Today);
        AuditUniverse."Next Audit Date" := CalcDate('<3M>', Today);
        AuditUniverse."Primary Contact" := 'EMP1';
        AuditUniverse."Budget Amount" := 50000 + Random(50000);
        AuditUniverse."Budgeted Hours" := 80 + Random(120);
        AuditUniverse.Status := AuditUniverse.Status::Active;
        AuditUniverse."Process Description" := 'Process for ' + Description;
        AuditUniverse."Key Controls" := 'Key controls for ' + Description;
        if not AuditUniverse.Insert() then;
    end;
    
    local procedure GenerateAuditPlans()
    var
        AuditHeader: Record "Audit Header";
        AuditLines: Record "Audit Lines";
        i: Integer;
    begin
        AuditHeader.Init();
        AuditHeader.Type := AuditHeader.Type::"Audit Plan";
        AuditHeader."No." := 'AUDPLAN001';
        AuditHeader.Date := Today;
        AuditHeader."Created By" := UserId;
        AuditHeader.Description := 'Annual Audit Plan ' + Format(Date2DMY(Today, 3));
        AuditHeader."Audit Period" := 'Q1-' + Format(Date2DMY(Today, 3));
        AuditHeader.Status := AuditHeader.Status::Released;
        // AuditHeader."Approved By" := UserId;
        // AuditHeader."Date Approved" := Today;
        if not AuditHeader.Insert() then;
    end;
    
    local procedure GenerateAudits()
    var
        AuditHeader: Record "Audit Header";
        AuditTypes: Record "Audit Types";
        i: Integer;
    begin
        // Create audit types first
        CreateAuditType('FINANCIAL', 'Financial Audit');
        CreateAuditType('OPERATIONAL', 'Operational Audit');
        CreateAuditType('COMPLIANCE', 'Compliance Audit');
        CreateAuditType('IT', 'IT Audit');
        
        // Create sample audits
        CreateAudit('AUD001', 'Financial Reporting Audit Q1', 'FINANCIAL', 1);
        CreateAudit('AUD002', 'IT Security Assessment', 'IT', 2);
        CreateAudit('AUD003', 'Procurement Process Review', 'OPERATIONAL', 1);
        CreateAudit('AUD004', 'Regulatory Compliance Check', 'COMPLIANCE', 3);
    end;
    
    local procedure CreateAuditType(Code: Code[20]; Description: Text[100])
    var
        AuditTypes: Record "Audit Types";
    begin
        AuditTypes.Init();
        AuditTypes.Code := Code;
        AuditTypes.Name := Description;
        if not AuditTypes.Insert() then;
    end;
    
    local procedure CreateAudit(No: Code[20]; Description: Text[250]; TypeCode: Code[20]; Status: Integer)
    var
        AuditHeader: Record "Audit Header";
    begin
        AuditHeader.Init();
        AuditHeader.Type := AuditHeader.Type::Audit;
        AuditHeader."No." := No;
        AuditHeader.Date := Today;
        AuditHeader."Created By" := UserId;
        AuditHeader.Description := Description;
        // AuditHeader."Audit Type" := TypeCode;  // Field doesn't exist
        AuditHeader."Audit Period" := 'Q1-' + Format(Date2DMY(Today, 3));
        AuditHeader.Status := Status;
        AuditHeader."Employee No." := 'EMP1';
        AuditHeader."Employee Name" := 'John Smith';
        AuditHeader."Cut Off Start Date" := CalcDate('<-3M>', Today);
        AuditHeader."Cut Off End Date" := Today;
        if not AuditHeader.Insert() then;
    end;
    
    local procedure GenerateAuditTasks()
    var
        AuditTask: Record "Audit Task Management";
        i: Integer;
        j: Integer;
    begin
        for i := 1 to 4 do begin
            for j := 1 to 5 do begin
                AuditTask.Init();
                AuditTask."Task No." := 'TASK' + Format(i) + Format(j);
                AuditTask."Audit No." := 'AUD00' + Format(i);
                AuditTask."Task Description" := GetTaskDescription(j);
                AuditTask."Assigned To" := 'AUD' + Format(Random(10));
                AuditTask."Start Date" := CalcDate('<-' + Format(Random(30)) + 'D>', Today);
                AuditTask."Due Date" := CalcDate('<' + Format(Random(30)) + 'D>', AuditTask."Start Date");
                AuditTask.Status := Random(4);
                AuditTask.Priority := Random(4);
                AuditTask."Task Type" := j;
                AuditTask."Estimated Hours" := 8 + Random(32);
                AuditTask."Actual Hours" := Random(AuditTask."Estimated Hours");
                AuditTask."Completion %" := Random(100);
                if not AuditTask.Insert() then;
            end;
        end;
    end;
    
    local procedure GetTaskDescription(TaskType: Integer): Text[250]
    begin
        case TaskType of
            1: exit('Planning and risk assessment');
            2: exit('Fieldwork and testing procedures');
            3: exit('Review and quality assurance');
            4: exit('Report writing and finalization');
            5: exit('Follow-up on recommendations');
        end;
    end;
    
    local procedure GenerateWorkingPapers()
    var
        WorkingPaper: Record "Working Paper Management";
        i: Integer;
        j: Integer;
    begin
        for i := 1 to 4 do begin
            for j := 1 to 10 do begin
                WorkingPaper.Init();
                WorkingPaper."WP No." := 'WP' + Format(i) + Format(j);
                WorkingPaper."Index Code" := Format(i) + '.' + Format(j);
                WorkingPaper.Description := GetWorkingPaperDescription(j);
                WorkingPaper."Audit No." := 'AUD00' + Format(i);
                WorkingPaper.Phase := Random(6) - 1;
                WorkingPaper."Sub Item" := 'Sub Item ' + Format(j);
                WorkingPaper."Document Type" := Random(9) - 1;
                WorkingPaper."Prepared By" := 'AUD' + Format(Random(10));
                WorkingPaper."Prepared Date" := CalcDate('<-' + Format(Random(30)) + 'D>', Today);
                WorkingPaper."Review Status" := Random(4) - 1;
                WorkingPaper."Version No." := 1;
                WorkingPaper."Current Version" := true;
                if not WorkingPaper.Insert() then;
            end;
        end;
    end;
    
    local procedure GetWorkingPaperDescription(Index: Integer): Text[250]
    begin
        case Index of
            1: exit('Audit planning memorandum');
            2: exit('Risk assessment documentation');
            3: exit('Internal control evaluation');
            4: exit('Test of controls results');
            5: exit('Substantive testing procedures');
            6: exit('Sample selection documentation');
            7: exit('Management representation letter');
            8: exit('Communication with management');
            9: exit('Audit adjustments schedule');
            10: exit('Final review checklist');
        end;
    end;
    
    local procedure GenerateAuditFindings()
    var
        Finding: Record "Audit Finding Enhanced";
        i: Integer;
        j: Integer;
    begin
        for i := 1 to 4 do begin
            for j := 1 to 3 do begin
                Finding.Init();
                Finding."Finding No." := 'FIND' + Format(i) + Format(j);
                Finding."Audit No." := 'AUD00' + Format(i);
                Finding."Finding Type" := Random(5);
                Finding."Finding Category" := Random(7);
                Finding."Finding Title" := GetFindingTitle(j);
                Finding."Finding Description" := 'Description for ' + Finding."Finding Title";
                Finding."Risk Severity" := Random(4);
                Finding."Risk Impact" := Random(5);
                Finding."Risk Likelihood" := Random(5);
                Finding."Business Impact" := 'Potential impact on operations and controls';
                Finding."Root Cause" := 'Inadequate controls and procedures';
                Finding.Criteria := 'University policy requires...';
                Finding.Condition := 'We found that...';
                Finding.Cause := 'This occurred because...';
                Finding.Effect := 'As a result...';
                Finding.Recommendation := 'We recommend that management...';
                Finding."Management Response" := 'Management agrees and will...';
                Finding."Target Completion Date" := CalcDate('<' + Format(Random(90)) + 'D>', Today);
                Finding."Finding Status" := Random(6) - 1;
                Finding."Financial Impact" := Random(100000);
                if not Finding.Insert() then;
            end;
        end;
    end;
    
    local procedure GetFindingTitle(Index: Integer): Text[100]
    begin
        case Index of
            1: exit('Segregation of duties issue');
            2: exit('Missing approval documentation');
            3: exit('Non-compliance with policy');
        end;
    end;
    
    local procedure GenerateActionTracking()
    var
        Action: Record "Audit Action Tracking";
        Finding: Record "Audit Finding Enhanced";
        i: Integer;
    begin
        Finding.SetFilter("Finding No.", 'FIND*');
        if Finding.FindSet() then
            repeat
                for i := 1 to 2 do begin
                    Action.Init();
                    Action."Action No." := 'ACT' + CopyStr(Finding."Finding No.", 5) + Format(i);
                    Action."Finding No." := Finding."Finding No.";
                    Action."Action Description" := 'Action ' + Format(i) + ' for ' + Finding."Finding Title";
                    Action."Responsible Person" := 'EMP' + Format(Random(10));
                    Action."Target Date" := CalcDate('<' + Format(Random(60)) + 'D>', Today);
                    Action."Original Target Date" := Action."Target Date";
                    Action."Implementation Status" := Random(6) - 1;
                    Action."Completion %" := Random(100);
                    Action."Management Response" := 'Will implement by target date';
                    Action."Follow-up Status" := Random(5) - 1;
                    Action."Risk Rating" := Finding."Risk Severity";
                    Action.Priority := Random(4) - 1;
                    if not Action.Insert() then;
                end;
            until Finding.Next() = 0;
    end;
    
    local procedure GeneratePerformanceMetrics()
    var
        Metrics: Record "Audit Performance Metrics";
        i: Integer;
    begin
        for i := 1 to 12 do begin
            Metrics.Init();
            Metrics."Metric ID" := 'METRIC' + Format(i);
            Metrics."Period Type" := Metrics."Period Type"::Monthly;
            Metrics."Period Start Date" := DMY2Date(1, i, Date2DMY(Today, 3));
            Metrics."Period End Date" := CalcDate('<1M-1D>', Metrics."Period Start Date");
            
            Metrics."Total Audits Planned" := 5 + Random(5);
            Metrics."Total Audits Completed" := Random(Metrics."Total Audits Planned");
            Metrics."Audits In Progress" := Metrics."Total Audits Planned" - Metrics."Total Audits Completed";
            
            Metrics."Total Findings" := 10 + Random(20);
            Metrics."Critical Findings" := Random(3);
            Metrics."High Risk Findings" := Random(5);
            Metrics."Medium Risk Findings" := Random(10);
            Metrics."Low Risk Findings" := Metrics."Total Findings" - 
                                          Metrics."Critical Findings" - 
                                          Metrics."High Risk Findings" - 
                                          Metrics."Medium Risk Findings";
            
            Metrics."Total Recommendations" := Metrics."Total Findings";
            Metrics."Recommendations Accepted" := Metrics."Total Recommendations" - Random(3);
            Metrics."Recommendations Implemented" := Random(Metrics."Recommendations Accepted");
            
            Metrics."Total Actions" := Metrics."Total Recommendations" * 2;
            Metrics."Actions Completed" := Random(Metrics."Total Actions");
            Metrics."Actions Overdue" := Random(5);
            
            Metrics."Planned Hours" := 160 * 5;
            Metrics."Actual Hours" := 140 * 5 + Random(100);
            
            Metrics."Compliance Score %" := 70 + Random(30);
            Metrics."Risk Coverage %" := 60 + Random(40);
            Metrics."Audit Coverage %" := 50 + Random(50);
            
            Metrics."Client Satisfaction Score" := 3.5 + (Random(15) / 10);
            Metrics."Quality Review Score" := 70 + Random(30);
            
            if not Metrics.Insert() then;
        end;
    end;
}