report 52179085 "Legal Workload Report"
{
    Caption = 'Legal Workload Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/LegalWorkloadReport.rdlc';

    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {
            RequestFilterFields = "No.", "Department Code";
            
            column(EmployeeNo; "No.")
            {
                IncludeCaption = true;
            }
            column(EmployeeName; FullName)
            {
            }
            column(DepartmentCode; "Department Code")
            {
                IncludeCaption = true;
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
            column(AssignedCases; AssignedCases)
            {
            }
            column(ActiveCases; ActiveCases)
            {
            }
            column(OverdueTasks; OverdueTasks)
            {
            }
            column(TotalWorkload; TotalWorkload)
            {
            }
            
            trigger OnAfterGetRecord()
            var
                LegalCase: Record "Legal Case";
                ComplianceTask: Record "Legal Compliance Task";
                CalendarEntry: Record "Legal Calendar Entry";
            begin
                // Count assigned cases
                LegalCase.SetRange("Lead Counsel", "No.");
                AssignedCases := LegalCase.Count();
                
                LegalCase.SetFilter("Case Status", '%1|%2', LegalCase."Case Status"::Open, LegalCase."Case Status"::"In Progress");
                ActiveCases := LegalCase.Count();
                
                // Count compliance tasks
                ComplianceTask.SetRange("Assigned To", "No.");
                ComplianceTask.SetRange("Due Date", 0D, Today);
                ComplianceTask.SetFilter(Status, '<>%1', ComplianceTask.Status::Completed);
                OverdueTasks := ComplianceTask.Count();
                
                // Count upcoming events
                CalendarEntry.SetRange("Responsible Person", "No.");
                CalendarEntry.SetRange("Event Date", Today, Today + 30);
                CalendarEntry.SetFilter(Status, '<>%1', CalendarEntry.Status::Completed);
                UpcomingEvents := CalendarEntry.Count();
                
                // Calculate total workload score
                TotalWorkload := (ActiveCases * 3) + (OverdueTasks * 5) + UpcomingEvents;
                
                // Only include employees with legal workload
                if (AssignedCases = 0) and (OverdueTasks = 0) and (UpcomingEvents = 0) then
                    CurrReport.Skip();
            end;
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
                    
                    field(IncludeInactiveEmployees; IncludeInactiveEmployees)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Inactive Employees';
                        ToolTip = 'Specifies whether to include employees with no current legal workload.';
                    }
                    field(WorkloadPeriod; WorkloadPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Workload Period (Days)';
                        ToolTip = 'Specifies the number of days to consider for upcoming workload.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Legal Workload Report';
        
        if WorkloadPeriod = 0 then
            WorkloadPeriod := 30;
    end;
    
    var
        ReportTitle: Text[100];
        IncludeInactiveEmployees: Boolean;
        WorkloadPeriod: Integer;
        AssignedCases: Integer;
        ActiveCases: Integer;
        OverdueTasks: Integer;
        UpcomingEvents: Integer;
        TotalWorkload: Integer;
}