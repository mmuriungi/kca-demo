report 52179083 "Compliance Status Report"
{
    Caption = 'Compliance Status Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/ComplianceStatusReport.rdlc';

    dataset
    {
        dataitem("Legal Compliance Task"; "Legal Compliance Task")
        {
            RequestFilterFields = "Task No.", "Compliance Type", Status, Priority, "Department Code", "Due Date";
            
            column(TaskNo; "Task No.")
            {
                IncludeCaption = true;
            }
            column(ComplianceType; "Compliance Type")
            {
                IncludeCaption = true;
            }
            column(TaskDescription; "Task Description")
            {
                IncludeCaption = true;
            }
            column(RegulationLaw; "Regulation/Law")
            {
                IncludeCaption = true;
            }
            column(DueDate; "Due Date")
            {
                IncludeCaption = true;
            }
            column(AssignedTo; "Assigned To")
            {
                IncludeCaption = true;
            }
            column(Status; Status)
            {
                IncludeCaption = true;
            }
            column(Priority; Priority)
            {
                IncludeCaption = true;
            }
            column(CompletionDate; "Completion Date")
            {
                IncludeCaption = true;
            }
            column(DepartmentCode; "Department Code")
            {
                IncludeCaption = true;
            }
            column(RiskLevel; "Risk Level")
            {
                IncludeCaption = true;
            }
            column(PenaltyAmount; "Penalty Amount")
            {
                IncludeCaption = true;
            }
            column(Frequency; Frequency)
            {
                IncludeCaption = true;
            }
            column(NextReviewDate; "Next Review Date")
            {
                IncludeCaption = true;
            }
            column(EvidenceRequired; "Evidence Required")
            {
                IncludeCaption = true;
            }
            column(DaysOverdue; DaysOverdue)
            {
            }
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(ReportDate; Format(Today, 0, 4))
            {
            }
            column(FilterString; FilterString)
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                Clear(DaysOverdue);
                
                if (Status = Status::Overdue) or ((Status in [Status::Open, Status::"In Progress"]) and ("Due Date" < Today)) then begin
                    DaysOverdue := Today - "Due Date";
                    if Status <> Status::Overdue then
                        Status := Status::Overdue;
                end;
                
                // Count by status
                case Status of
                    Status::Open:
                        OpenCount += 1;
                    Status::"In Progress":
                        InProgressCount += 1;
                    Status::Completed:
                        CompletedCount += 1;
                    Status::Overdue:
                        OverdueCount += 1;
                    Status::"Non-Compliant":
                        NonCompliantCount += 1;
                end;
                
                // Count by risk level
                case "Risk Level" of
                    "Risk Level"::Low:
                        LowRiskCount += 1;
                    "Risk Level"::Medium:
                        MediumRiskCount += 1;
                    "Risk Level"::High:
                        HighRiskCount += 1;
                    "Risk Level"::Critical:
                        CriticalRiskCount += 1;
                end;
                
                TotalTasks += 1;
                TotalPenalty += "Penalty Amount";
            end;
        }
        
        dataitem(Summary; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            
            column(TotalTasks; TotalTasks)
            {
            }
            column(OpenCount; OpenCount)
            {
            }
            column(InProgressCount; InProgressCount)
            {
            }
            column(CompletedCount; CompletedCount)
            {
            }
            column(OverdueCount; OverdueCount)
            {
            }
            column(NonCompliantCount; NonCompliantCount)
            {
            }
            column(LowRiskCount; LowRiskCount)
            {
            }
            column(MediumRiskCount; MediumRiskCount)
            {
            }
            column(HighRiskCount; HighRiskCount)
            {
            }
            column(CriticalRiskCount; CriticalRiskCount)
            {
            }
            column(TotalPenalty; TotalPenalty)
            {
            }
            column(ComplianceRate; ComplianceRate)
            {
            }
        }
    }
    
    requestpage
    {
        SaveValues = true;
        
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    
                    field(ShowOverdueOnly; ShowOverdueOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Overdue Only';
                        ToolTip = 'Specifies whether to show only overdue compliance tasks.';
                    }
                    field(ShowHighRiskOnly; ShowHighRiskOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Show High Risk Only';
                        ToolTip = 'Specifies whether to show only high and critical risk tasks.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Compliance Status Report';
        FilterString := "Legal Compliance Task".GetFilters();
        
        if ShowOverdueOnly then
            "Legal Compliance Task".SetRange(Status, "Legal Compliance Task".Status::Overdue);
            
        if ShowHighRiskOnly then
            "Legal Compliance Task".SetFilter("Risk Level", '%1|%2', 
                "Legal Compliance Task"."Risk Level"::High, 
                "Legal Compliance Task"."Risk Level"::Critical);
                
        // Initialize counters
        Clear(TotalTasks);
        Clear(OpenCount);
        Clear(InProgressCount);
        Clear(CompletedCount);
        Clear(OverdueCount);
        Clear(NonCompliantCount);
        Clear(LowRiskCount);
        Clear(MediumRiskCount);
        Clear(HighRiskCount);
        Clear(CriticalRiskCount);
        Clear(TotalPenalty);
    end;
    
    trigger OnPostReport()
    begin
        if TotalTasks > 0 then
            ComplianceRate := Round((CompletedCount / TotalTasks) * 100, 0.01);
    end;
    
    var
        ReportTitle: Text[100];
        FilterString: Text;
        ShowOverdueOnly: Boolean;
        ShowHighRiskOnly: Boolean;
        DaysOverdue: Integer;
        TotalTasks: Integer;
        OpenCount: Integer;
        InProgressCount: Integer;
        CompletedCount: Integer;
        OverdueCount: Integer;
        NonCompliantCount: Integer;
        LowRiskCount: Integer;
        MediumRiskCount: Integer;
        HighRiskCount: Integer;
        CriticalRiskCount: Integer;
        TotalPenalty: Decimal;
        ComplianceRate: Decimal;
}