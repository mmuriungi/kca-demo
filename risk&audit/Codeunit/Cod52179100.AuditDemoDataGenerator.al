codeunit 52179100 "Audit Demo Data Generator"
{
    trigger OnRun()
    begin
        if not Confirm('This will delete all existing audit data and generate fresh demo data for the Internal Audit module. Do you want to continue?', false) then
            exit;

        // Delete existing data first
        DeleteExistingData();

        GenerateAuditSetup();
        GenerateAuditPeriods();
        GenerateAuditors();
        GenerateAuditUniverse();
        GenerateAuditPlans();
        GenerateAudits();
        GenerateAuditProjects();
        GenerateAuditTasks();
        GenerateWorkingPapers();
        GenerateAuditFindings();
        GenerateActionTracking();
        GeneratePerformanceMetrics();
        GenerateAuditSchedule();
        GenerateResourceAllocation();
        GenerateAuditNotifications();
        GenerateComplianceMonitoring();
        GenerateRiskAssessments();
        GenerateEnhancedRiskAssessments();
        GenerateRiskHeaders();
        GenerateRiskLines();
        GenerateRiskCategories();
        GenerateAuditLines();
        GenerateAuditRecommendations();
        GenerateInternalAuditChampions();
        GenerateAuditeeTeams();

        Message('Comprehensive demo data generation completed successfully! Generated:\n' +
                'Audit Universe: 10 entries\n' +
                'Audit Plans: 3 comprehensive plans\n' +
                'Audits: 4 sample audits\n' +
                'Audit Projects: 6 project entries\n' +
                'Tasks: 20 audit tasks\n' +
                'Working Papers: 40 documents\n' +
                'Findings: 12 audit findings\n' +
                'Actions: 24 corrective actions\n' +
                'Performance Metrics: 12 months\n' +
                'Schedule Entries: 50 calendar items\n' +
                'Resource Allocations: 20 assignments\n' +
                'Risk Headers: 15 risk entries\n' +
                'Risk Lines: 75 risk components\n' +
                'Risk Assessments: 30 assessments\n' +
                'Risk Categories: 8 categories\n' +
                'Audit Lines: 60 plan items\n' +
                'Audit Recommendations: 15 recommendations\n' +
                'Audit Champions: 10 champions\n' +
                'Auditee Teams: 8 teams');
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
            AuditPeriod."Period Start" := CalcDate('<-' + Format((4 - i) * 3) + 'M>', DMY2Date(1, 1, Date2DMY(Today, 3)));
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
        i: Integer;
    begin
        // Generate multiple audit plans for different periods and types
        for i := 1 to 3 do begin
            AuditHeader.Init();
            AuditHeader.Type := AuditHeader.Type::"Audit Plan";
            AuditHeader."No." := 'AUDPLAN00' + Format(i);
            AuditHeader.Date := CalcDate('<-' + Format((i - 1) * 120) + 'D>', Today);
            AuditHeader."Created By" := UserId;
            AuditHeader.Description := GetAuditPlanDescription(i);
            AuditHeader."Audit Period" := GetAuditPlanPeriod(i);
            AuditHeader.Status := GetAuditPlanStatus(i);
            AuditHeader."Employee No." := 'AUD' + Format(i);
            AuditHeader."Employee Name" := GetRandomEmployeeName(i);
            AuditHeader."Cut Off Start Date" := CalcDate('<-1Y>', Today);
            AuditHeader."Cut Off End Date" := Today;
            if not AuditHeader.Insert() then;
        end;
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

    local procedure GenerateAuditProjects()
    var
        Project: Record Projects;
        i: Integer;
    begin
        for i := 1 to 6 do begin
            Project.Init();
            Project."Project Code" := 'PROJ' + Format(i);
            Project."Project Description" := GetProjectDescription(i);
            Project."Project Manager" := 'EMP' + Format(Random(10) + 1);
            Project."Project Manager Name" := GetRandomEmployeeName(Random(10) + 1);
            Project."Project Manager E-Mail" := LowerCase(DelChr(Project."Project Manager Name", '=', ' ')) + '@university.edu';
            Project."Shortcut Dimension 1 Code" := GetRandomDepartment((Random(5) mod 5) + 1);
            Project."Shortcut Dimension 2 Code" := GetRandomDepartment((Random(5) mod 5) + 1);
            Project."Department Name" := 'Department for ' + Project."Project Description";
            Project."Created By" := UserId;
            Project."Date Time Created" := CreateDateTime(CalcDate('<-' + Format(Random(60)) + 'D>', Today), Time);
            if not Project.Insert() then;
        end;
    end;

    local procedure GetProjectDescription(Index: Integer): Text[250]
    begin
        case Index of
            1:
                exit('Financial System Audit Implementation');
            2:
                exit('IT Security Framework Enhancement');
            3:
                exit('Student Records Management Review');
            4:
                exit('Procurement Process Optimization');
            5:
                exit('Risk Management Framework Development');
            6:
                exit('Compliance Monitoring System');
            else
                exit('General Audit Project');
        end;
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
            1:
                exit('Planning and risk assessment');
            2:
                exit('Fieldwork and testing procedures');
            3:
                exit('Review and quality assurance');
            4:
                exit('Report writing and finalization');
            5:
                exit('Follow-up on recommendations');
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
            1:
                exit('Audit planning memorandum');
            2:
                exit('Risk assessment documentation');
            3:
                exit('Internal control evaluation');
            4:
                exit('Test of controls results');
            5:
                exit('Substantive testing procedures');
            6:
                exit('Sample selection documentation');
            7:
                exit('Management representation letter');
            8:
                exit('Communication with management');
            9:
                exit('Audit adjustments schedule');
            10:
                exit('Final review checklist');
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
            1:
                exit('Segregation of duties issue');
            2:
                exit('Missing approval documentation');
            3:
                exit('Non-compliance with policy');
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

    local procedure GenerateAuditSchedule()
    var
        ScheduleEntry: Record "Audit Schedule";
        i: Integer;
        StartDate: Date;
    begin
        StartDate := DMY2Date(1, 1, Date2DMY(Today, 3));

        for i := 1 to 50 do begin
            ScheduleEntry.Init();
            ScheduleEntry."Entry No." := i;
            ScheduleEntry."Audit No." := 'AUD00' + Format(Random(4) + 1);
            ScheduleEntry."Task Description" := GetScheduleTaskDescription(1 + (Random(100) mod 8));
            ScheduleEntry."Start Date" := CalcDate('<' + Format(Random(365)) + 'D>', StartDate);
            ScheduleEntry."End Date" := CalcDate('<' + Format(Random(20) + 1) + 'D>', ScheduleEntry."Start Date");
            ScheduleEntry."Assigned To" := 'AUD' + Format(Random(10) + 1);
            ScheduleEntry."Status" := Random(4);
            ScheduleEntry."Priority" := Random(4);
            ScheduleEntry."Estimated Hours" := 8 + Random(40);
            ScheduleEntry."Location" := GetRandomLocation();
            ScheduleEntry."Task Type" := Random(6);
            if not ScheduleEntry.Insert() then;
        end;
    end;

    local procedure GetScheduleTaskDescription(TaskType: Integer): Text[250]
    begin
        case TaskType of
            1:
                exit('Opening meeting with auditee');
            2:
                exit('Document review and analysis');
            3:
                exit('Interviews with key personnel');
            4:
                exit('Testing of internal controls');
            5:
                exit('Substantive testing procedures');
            6:
                exit('Follow-up on prior findings');
            7:
                exit('Closing meeting and draft report');
            8:
                exit('Final report presentation');
            else
                exit('General audit task');
        end;
    end;

    local procedure GetRandomLocation(): Text[100]
    var
        Locations: array[8] of Text[100];
        Index: Integer;
    begin
        Locations[1] := 'Finance Department';
        Locations[2] := 'IT Department';
        Locations[3] := 'Human Resources';
        Locations[4] := 'Registrar Office';
        Locations[5] := 'Procurement Office';
        Locations[6] := 'Board Room';
        Locations[7] := 'Audit Conference Room';
        Locations[8] := 'Dean Office';

        Index := 1 + (Random(100) mod 8);
        exit(Locations[Index]);
    end;

    local procedure GenerateResourceAllocation()
    var
        Resource: Record "Audit Resource Allocation";
        i: Integer;
    begin
        for i := 1 to 20 do begin
            Resource.Init();
            Resource."Allocation No." := 'RES' + Format(i);
            Resource."Audit No." := 'AUD00' + Format(Random(4) + 1);
            Resource."Resource Type" := Random(4);
            Resource."Resource Code" := 'AUD' + Format(Random(10) + 1);
            Resource."Allocation Start Date" := CalcDate('<-' + Format(Random(30)) + 'D>', Today);
            Resource."Allocation End Date" := CalcDate('<' + Format(Random(60)) + 'D>', Resource."Allocation Start Date");
            Resource."Allocated Hours" := 40 + Random(120);
            Resource."Utilization %" := 60 + Random(40);
            Resource."Cost Rate" := 25 + Random(75);
            Resource."Total Cost" := Resource."Allocated Hours" * Resource."Cost Rate";
            if not Resource.Insert() then;
        end;
    end;

    local procedure GenerateAuditNotifications()
    var
        Notification: Record "Audit Notifications";
        i: Integer;
    begin
        for i := 1 to 15 do begin
            Notification.Init();
            Notification."Notification No." := 'NOT' + Format(i);
            Notification."Audit No." := 'AUD00' + Format(Random(4) + 1);
            Notification."Notification Type" := Random(6);
            Notification.Subject := GetNotificationSubject(Notification."Notification Type");
            Notification."Message Text" := 'This is a system-generated notification regarding your audit assignment.';
            Notification."Recipient Email" := 'user' + Format(Random(10)) + '@university.edu';
            Notification."Notification Date" := CalcDate('<-' + Format(Random(30)) + 'D>', Today);
            Notification."Due Date" := CalcDate('<' + Format(Random(14)) + 'D>', Notification."Notification Date");
            Notification."Delivery Status" := Random(3);
            Notification.Priority := Random(3);
            if not Notification.Insert() then;
        end;
    end;

    local procedure GetNotificationSubject(NotificationType: Integer): Text[250]
    begin
        case NotificationType of
            0:
                exit('Audit Assignment Notification');
            1:
                exit('Task Due Date Reminder');
            2:
                exit('Document Request');
            3:
                exit('Meeting Schedule');
            4:
                exit('Finding Response Required');
            5:
                exit('Audit Completion Notice');
            else
                exit('General Audit Notification');
        end;
    end;

    local procedure GenerateComplianceMonitoring()
    var
        Compliance: Record "Compliance Monitoring";
        i: Integer;
    begin
        for i := 1 to 10 do begin
            Compliance.Init();
            Compliance."Monitoring No." := 'COMP' + Format(i);
            Compliance."Compliance Area" := GetComplianceArea(i);
            Compliance."Monitoring Date" := CalcDate('<-' + Format(Random(90)) + 'D>', Today);
            Compliance."Next Review Date" := CalcDate('<' + Format(Random(180) + 90) + 'D>', Compliance."Monitoring Date");
            Compliance."Compliance Status" := Random(3);
            Compliance."Risk Level" := Random(4);
            Compliance."Responsible Person" := 'EMP' + Format(Random(10) + 1);
            Compliance."Compliance Score" := 60 + Random(40);
            Compliance."Action Required" := Random(2) = 1;
            if not Compliance.Insert() then;
        end;
    end;

    local procedure GetComplianceArea(Index: Integer): Text[100]
    begin
        case Index of
            1:
                exit('Financial Reporting Standards');
            2:
                exit('Data Protection Regulations');
            3:
                exit('Health and Safety Requirements');
            4:
                exit('Employment Law Compliance');
            5:
                exit('Environmental Regulations');
            6:
                exit('Student Privacy Laws');
            7:
                exit('Research Ethics Guidelines');
            8:
                exit('Procurement Regulations');
            9:
                exit('IT Security Standards');
            10:
                exit('Academic Standards Compliance');
            else
                exit('General Compliance');
        end;
    end;

    local procedure GenerateRiskAssessments()
    var
        RiskAssessment: Record "Risk Assessment Enhanced";
        i: Integer;
    begin
        for i := 1 to 15 do begin
            RiskAssessment.Init();
            RiskAssessment."Assessment No." := 'RASS' + Format(i);
            RiskAssessment."Audit Universe Code" := 'FIN-0' + Format(Random(3) + 1);
            RiskAssessment."Assessment Date" := CalcDate('<-' + Format(Random(60)) + 'D>', Today);
            RiskAssessment."Risk Category" := Random(5);
            RiskAssessment."Inherent Risk" := Random(5);
            RiskAssessment."Control Risk" := Random(5);
            RiskAssessment."Detection Risk" := Random(5);
            RiskAssessment."Overall Risk" := (RiskAssessment."Inherent Risk" + RiskAssessment."Control Risk" + RiskAssessment."Detection Risk") / 3;
            RiskAssessment."Risk Description" := 'Risk assessment for ' + RiskAssessment."Audit Universe Code";
            RiskAssessment."Mitigation Strategy" := 'Implement enhanced controls and monitoring procedures';
            RiskAssessment."Assessment Status" := Random(4);
            RiskAssessment."Assessed By" := 'AUD' + Format(Random(5) + 1);
            if not RiskAssessment.Insert() then;
        end;
    end;

    local procedure GenerateEnhancedRiskAssessments()
    var
        EnhancedRiskAssessment: Record "Risk Assessment Enhanced";
        i: Integer;
    begin
        for i := 16 to 30 do begin
            EnhancedRiskAssessment.Init();
            EnhancedRiskAssessment."Assessment No." := 'ERASS' + Format(i);
            EnhancedRiskAssessment."Audit Universe Code" := 'IT-0' + Format(Random(2) + 1);
            EnhancedRiskAssessment."Assessment Date" := CalcDate('<-' + Format(Random(30)) + 'D>', Today);
            EnhancedRiskAssessment."Risk Category" := Random(5);
            EnhancedRiskAssessment."Inherent Risk" := Random(5);
            EnhancedRiskAssessment."Control Risk" := Random(5);
            EnhancedRiskAssessment."Detection Risk" := Random(5);
            EnhancedRiskAssessment."Overall Risk" := (EnhancedRiskAssessment."Inherent Risk" + 
                                                    EnhancedRiskAssessment."Control Risk" + 
                                                    EnhancedRiskAssessment."Detection Risk") / 3;
            EnhancedRiskAssessment."Risk Description" := 'Enhanced risk assessment for ' + EnhancedRiskAssessment."Audit Universe Code";
            EnhancedRiskAssessment."Mitigation Strategy" := 'Advanced controls and automated monitoring systems';
            EnhancedRiskAssessment."Assessment Status" := Random(4);
            EnhancedRiskAssessment."Assessed By" := 'AUD' + Format(Random(5) + 1);
            if not EnhancedRiskAssessment.Insert() then;
        end;
    end;

    local procedure DeleteExistingData()
    var
        AuditUniverse: Record "Audit Universe";
        AuditHeader: Record "Audit Header";
        AuditLines: Record "Audit Lines";
        AuditTypes: Record "Audit Types";
        AuditorsList: Record "Auditors List";
        AuditTaskManagement: Record "Audit Task Management";
        WorkingPaper: Record "Working Paper Management";
        AuditFinding: Record "Audit Finding Enhanced";
        AuditAction: Record "Audit Action Tracking";
        AuditPerformanceMetrics: Record "Audit Performance Metrics";
        AuditSchedule: Record "Audit Schedule";
        AuditResourceAllocation: Record "Audit Resource Allocation";
        AuditNotifications: Record "Audit Notifications";
        ComplianceMonitoring: Record "Compliance Monitoring";
        RiskAssessmentEnhanced: Record "Risk Assessment Enhanced";
        AuditPeriod: Record "Audit Period";
        RiskHeader: Record "Risk Header";
        RiskLine: Record "Risk Line";
        RiskCategories: Record "Risk Categories";
        AuditRecommendations: Record "Audit Recommendations";
        InternalAuditChampions: Record "Internal Audit Champions";
        AuditeeTeam: Record "Auditee Team";
        Projects: Record Projects;
    begin
        Message('Deleting existing audit data...');

        // Delete in reverse dependency order to avoid foreign key issues
        Projects.DeleteAll();
        AuditeeTeam.DeleteAll();
        InternalAuditChampions.DeleteAll();
        AuditRecommendations.DeleteAll();
        RiskLine.DeleteAll();
        RiskHeader.DeleteAll();
        RiskCategories.DeleteAll();
        RiskAssessmentEnhanced.DeleteAll();
        ComplianceMonitoring.DeleteAll();
        AuditNotifications.DeleteAll();
        AuditResourceAllocation.DeleteAll();
        AuditSchedule.DeleteAll();
        AuditPerformanceMetrics.DeleteAll();
        AuditAction.DeleteAll();
        AuditFinding.DeleteAll();
        WorkingPaper.DeleteAll();
        AuditTaskManagement.DeleteAll();
        AuditLines.DeleteAll();
        AuditHeader.DeleteAll();
        AuditTypes.DeleteAll();
        AuditUniverse.DeleteAll();
        AuditorsList.DeleteAll();
        AuditPeriod.DeleteAll();

        Message('Existing audit data deleted successfully. Generating fresh demo data...');
    end;

    local procedure GenerateRiskHeaders()
    var
        RiskHeader: Record "Risk Header";
        i: Integer;
    begin
        for i := 1 to 15 do begin
            RiskHeader.Init();
            RiskHeader."No." := 'RISK' + Format(i);
            RiskHeader."Date Created" := CalcDate('<-' + Format(Random(60)) + 'D>', Today);
            RiskHeader."Created By" := UserId;
            RiskHeader."Employee No." := 'EMP' + Format(Random(10) + 1);
            RiskHeader."Employee Name" := GetRandomEmployeeName(Random(10) + 1);
            RiskHeader."Risk Description" := GetRiskDescription(i);
            RiskHeader."Document Status" := Random(7);
            RiskHeader."Date Identified" := CalcDate('<-' + Format(Random(90)) + 'D>', Today);
            RiskHeader."Risk Category" := 'CAT' + Format(Random(8) + 1);
            RiskHeader."Value at Risk" := Random(100000) + 10000;
            RiskHeader."Risk Likelihood Value" := Random(5) + 1;
            RiskHeader."Risk Impact Value" := Random(5) + 1;
            RiskHeader."Risk (L * I)" := RiskHeader."Risk Likelihood Value" * RiskHeader."Risk Impact Value";
            if not RiskHeader.Insert() then;
        end;
    end;

    local procedure GenerateRiskLines()
    var
        RiskLine: Record "Risk Line";
        RiskHeader: Record "Risk Header";
        LineNo: Integer;
        TypeIndex: Integer;
    begin
        RiskHeader.SetFilter("No.", 'RISK*');
        if RiskHeader.FindSet() then
            repeat
                LineNo := 0;
                // Generate different types of risk lines for each risk
                for TypeIndex := 1 to 5 do begin
                    LineNo += 10000;
                    RiskLine.Init();
                    RiskLine."Document No." := RiskHeader."No.";
                    RiskLine.Type := TypeIndex;
                    RiskLine."Line No." := LineNo;
                    RiskLine.Description := GetRiskLineDescription(TypeIndex, RiskHeader."Risk Description");
                    if not RiskLine.Insert() then;
                end;
            until RiskHeader.Next() = 0;
    end;

    local procedure GenerateRiskCategories()
    var
        RiskCategories: Record "Risk Categories";
        Categories: array[8] of Text[100];
        i: Integer;
    begin
        Categories[1] := 'Strategic Risk';
        Categories[2] := 'Operational Risk';
        Categories[3] := 'Financial Risk';
        Categories[4] := 'Compliance Risk';
        Categories[5] := 'Technology Risk';
        Categories[6] := 'Reputational Risk';
        Categories[7] := 'Environmental Risk';
        Categories[8] := 'Human Resources Risk';

        for i := 1 to 8 do begin
            RiskCategories.Init();
            RiskCategories.Code := 'CAT' + Format(i);
            RiskCategories.Description := Categories[i];
            RiskCategories.Type := RiskCategories.Type::Category;
            if not RiskCategories.Insert() then;
        end;
    end;

    local procedure GenerateAuditLines()
    var
        AuditLines: Record "Audit Lines";
        AuditHeader: Record "Audit Header";
        LineNo: Integer;
        i: Integer;
    begin
        AuditHeader.SetFilter(Type, Format(AuditHeader.Type::"Audit Plan"));
        AuditHeader.SetFilter("No.", 'AUDPLAN*');
        if AuditHeader.FindFirst() then begin
            for i := 1 to 20 do begin
                LineNo += 10000;
                AuditLines.Init();
                AuditLines."Document No." := AuditHeader."No.";
                AuditLines."Line No." := LineNo;
                AuditLines."Audit Code" := 'AUD00' + Format(Random(4) + 1);
                AuditLines.Description := GetAuditLineDescription(i);
                AuditLines."Scheduled Start Date" := CalcDate('<' + Format(Random(365)) + 'D>', DMY2Date(1, 1, Date2DMY(Today, 3)));
                AuditLines."Scheduled End Date" := CalcDate('<' + Format(Random(30) + 7) + 'D>', AuditLines."Scheduled Start Date");
                AuditLines."Risk Rating" := AuditLines."Risk Rating"::Medium;
                AuditLines.Auditor := 'EMP' + Format(Random(10) + 1);
                AuditLines."Audit Line Type" := AuditLines."Audit Line Type"::Objectives;
                if not AuditLines.Insert() then;
            end;
        end;
    end;

    local procedure GenerateAuditRecommendations()
    var
        AuditRecommendations: Record "Audit Recommendations";
        AuditFinding: Record "Audit Finding Enhanced";
        i: Integer;
    begin
        AuditFinding.SetFilter("Finding No.", 'FIND*');
        if AuditFinding.FindSet() then
            repeat
                AuditRecommendations.Init();
                AuditRecommendations."Entry No." := Random(1000000);
                AuditRecommendations."Document No." := AuditFinding."Audit No.";
                AuditRecommendations."Audit Observation" := CopyStr('Observation for ' + AuditFinding."Finding Title", 1, 250);
                AuditRecommendations."Audit Recommendation" := CopyStr('Management should implement ' + AuditFinding."Finding Title", 1, 250);
                AuditRecommendations."Management Response" := 'Agreed. Will implement by target date.';
                AuditRecommendations."Implementation Date" := CalcDate('<' + Format(Random(90) + 30) + 'D>', Today);
                AuditRecommendations."Department Responsible" := 'DEPT' + Format(Random(5) + 1);
                AuditRecommendations."Department Name" := 'Department ' + Format(Random(5) + 1);
                AuditRecommendations.Status := AuditRecommendations.Status::"Under Implementation";
                AuditRecommendations.Comments := 'Generated demo recommendation';
                if not AuditRecommendations.Insert() then;
            until AuditFinding.Next() = 0;
    end;

    local procedure GenerateInternalAuditChampions()
    var
        Champions: Record "Internal Audit Champions";
        ChampionNames: array[10] of Text[100];
        i: Integer;
    begin
        ChampionNames[1] := 'Alice Thompson';
        ChampionNames[2] := 'Bob Jackson';
        ChampionNames[3] := 'Carol White';
        ChampionNames[4] := 'David Harris';
        ChampionNames[5] := 'Eva Martin';
        ChampionNames[6] := 'Frank Garcia';
        ChampionNames[7] := 'Grace Rodriguez';
        ChampionNames[8] := 'Henry Lewis';
        ChampionNames[9] := 'Irene Walker';
        ChampionNames[10] := 'Jack Hall';

        for i := 1 to 10 do begin
            Champions.Init();
            Champions.Type := Champions.Type::"Risk Champion";
            Champions."Employee No." := 'EMP' + Format(i);
            Champions."Employee Name" := ChampionNames[i];
            Champions."Shortcut Dimension 1 Code" := GetRandomDepartment((Random(5) mod 5) + 1);
            Champions."E-Mail" := LowerCase(DelChr(ChampionNames[i], '=', ' ')) + '@university.edu';
            Champions."User ID" := 'USER' + Format(i);
            Champions."Escalator ID" := 'EMP' + Format(Random(10) + 1);
            Champions."Station Name" := 'Station ' + Format(i);
            if not Champions.Insert() then;
        end;
    end;

    local procedure GenerateAuditeeTeams()
    var
        AuditeeTeam: Record "Auditee Team";
        TeamNames: array[8] of Text[100];
        AuditHeader: Record "Audit Header";
        i: Integer;
        j: Integer;
        LineNo: Integer;
    begin
        TeamNames[1] := 'Finance Team';
        TeamNames[2] := 'IT Department';
        TeamNames[3] := 'Human Resources';
        TeamNames[4] := 'Student Services';
        TeamNames[5] := 'Procurement Team';
        TeamNames[6] := 'Academic Affairs';
        TeamNames[7] := 'Research Office';
        TeamNames[8] := 'Facilities Management';

        // Get an audit document number for team members
        AuditHeader.SetFilter(Type, Format(AuditHeader.Type::Audit));
        AuditHeader.SetFilter("No.", 'AUD*');
        if AuditHeader.FindFirst() then begin
            for i := 1 to 8 do begin
                for j := 1 to 3 do begin // Create 3 members per team
                    LineNo += 10000;
                    AuditeeTeam.Init();
                    AuditeeTeam."Document No." := AuditHeader."No.";
                    AuditeeTeam."Line No." := LineNo;
                    AuditeeTeam."Member ID" := 'EMP' + Format((i - 1) * 3 + j);
                    AuditeeTeam."Member Name" := 'Member ' + Format(j) + ' of ' + TeamNames[i];
                    AuditeeTeam.Position := 'Team Member';
                    AuditeeTeam.Department := GetRandomDepartment((Random(5) mod 5) + 1);
                    AuditeeTeam.Email := LowerCase(DelChr(AuditeeTeam."Member Name", '=', ' ')) + '@university.edu';
                    AuditeeTeam."Phone No." := '+1-555-' + Format(Random(900) + 100) + '-' + Format(Random(9000) + 1000);
                    if not AuditeeTeam.Insert() then;
                end;
            end;
        end;
    end;

    local procedure GetRiskDescription(Index: Integer): Text[250]
    begin
        case Index of
            1:
                exit('Inadequate financial controls and oversight procedures');
            2:
                exit('IT system vulnerabilities and cybersecurity threats');
            3:
                exit('Regulatory compliance gaps in academic standards');
            4:
                exit('Student data privacy and protection concerns');
            5:
                exit('Staff retention and recruitment challenges');
            6:
                exit('Infrastructure maintenance and safety risks');
            7:
                exit('Research funding and grant management issues');
            8:
                exit('Student fee collection and revenue recognition');
            9:
                exit('Third-party vendor and contract management');
            10:
                exit('Academic integrity and quality assurance');
            11:
                exit('Emergency preparedness and business continuity');
            12:
                exit('International student visa and compliance');
            13:
                exit('Faculty performance and evaluation processes');
            14:
                exit('Campus security and student safety measures');
            15:
                exit('Environmental sustainability and regulatory compliance');
            else
                exit('General operational risk requiring assessment');
        end;
    end;

    local procedure GetRiskLineDescription(LineType: Integer; RiskDesc: Text[250]): Text[250]
    begin
        case LineType of
            1:
                exit('Driver: ' + CopyStr(RiskDesc, 1, 200)); // Drivers
            2:
                exit('Mitigation: Implement enhanced controls and monitoring'); // Mitigation Proposal
            3:
                exit('Effect: Potential operational disruption and compliance issues'); // Effects
            4:
                exit('Control: Regular review and monitoring procedures in place'); // Existing Control
            5:
                exit('KRI: Monthly performance metrics and trend analysis'); // KRI(s)
            else
                exit('General risk component requiring attention');
        end;
    end;

    local procedure GetAuditLineDescription(Index: Integer): Text[250]
    begin
        case Index of
            1:
                exit('Review of financial statement preparation process');
            2:
                exit('Assessment of internal control effectiveness');
            3:
                exit('Evaluation of IT general controls');
            4:
                exit('Testing of student fee calculation accuracy');
            5:
                exit('Review of procurement and vendor management');
            6:
                exit('Assessment of payroll processing controls');
            7:
                exit('Evaluation of research grant management');
            8:
                exit('Review of student data privacy controls');
            9:
                exit('Testing of budget preparation and monitoring');
            10:
                exit('Assessment of facilities management processes');
            11:
                exit('Review of academic quality assurance');
            12:
                exit('Evaluation of student services delivery');
            13:
                exit('Testing of inventory management controls');
            14:
                exit('Assessment of HR policies and procedures');
            15:
                exit('Review of regulatory compliance monitoring');
            16:
                exit('Evaluation of risk management framework');
            17:
                exit('Testing of cash management procedures');
            18:
                exit('Assessment of contract management processes');
            19:
                exit('Review of performance measurement systems');
            20:
                exit('Evaluation of change management procedures');
            else
                exit('General audit procedure requiring execution');
        end;
    end;

    local procedure GetRandomEmployeeName(Index: Integer): Text[100]
    var
        Names: array[10] of Text[100];
        SafeIndex: Integer;
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

        // Ensure index is within valid range (1-10)
        SafeIndex := Index;
        if SafeIndex < 1 then
            SafeIndex := 1;
        if SafeIndex > 10 then
            SafeIndex := 10;

        exit(Names[SafeIndex]);
    end;

    local procedure GetRandomDepartment(Index: Integer): Code[20]
    var
        Departments: array[5] of Code[20];
        SafeIndex: Integer;
    begin
        Departments[1] := 'FIN';
        Departments[2] := 'IT';
        Departments[3] := 'HR';
        Departments[4] := 'ACAD';
        Departments[5] := 'ADMIN';

        // Ensure index is within valid range (1-5)
        SafeIndex := Index;
        if SafeIndex < 1 then
            SafeIndex := 1;
        if SafeIndex > 5 then
            SafeIndex := 5;

        exit(Departments[SafeIndex]);
    end;

    local procedure GetRiskRating(RiskScore: Integer): Text[20]
    begin
        case RiskScore of
            1 .. 5:
                exit('Low');
            6 .. 12:
                exit('Medium');
            13 .. 20:
                exit('High');
            21 .. 25:
                exit('Critical');
            else
                exit('Medium');
        end;
    end;

    local procedure GetAuditPlanDescription(Index: Integer): Text[250]
    begin
        case Index of
            1:
                exit('Annual Internal Audit Plan 2024');
            2:
                exit('Mid-Year Risk-Based Audit Plan');
            3:
                exit('Special Investigation Audit Plan');
            else
                exit('General Audit Plan');
        end;
    end;

    local procedure GetAuditPlanPeriod(Index: Integer): Code[20]
    begin
        case Index of
            1:
                exit('FY' + Format(Date2DMY(Today, 3)));
            2:
                exit('Q2-' + Format(Date2DMY(Today, 3)));
            3:
                exit('Q3-' + Format(Date2DMY(Today, 3)));
            else
                exit('Q1-' + Format(Date2DMY(Today, 3)));
        end;
    end;

    local procedure GetAuditPlanStatus(Index: Integer): Option
    begin
        case Index of
            1:
                exit(2); // Released
            2:
                exit(1); // Pending Approval
            3:
                exit(0); // Open
            else
                exit(0); // Open
        end;
    end;
}