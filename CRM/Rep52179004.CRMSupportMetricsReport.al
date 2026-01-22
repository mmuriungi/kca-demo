report 52179004 "CRM Support Metrics Report"
{
    Caption = 'Support Metrics Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    RDLCLayout = './Rep52179004.CRMSupportMetricsReport.rdl';

    dataset
    {
        dataitem(SupportTicket; "CRM Support Ticket")
        {
            RequestFilterFields = Category, Priority, Status, "Assigned To", "Created Date";
            
            column(Ticket_No; "Ticket No.")
            {
            }
            column(Customer_No; "Customer No.")
            {
            }
            column(Subject; Subject)
            {
            }
            column(Ticket_Category; Category)
            {
            }
            column(Priority; Priority)
            {
            }
            column(Status; Status)
            {
            }
            column(Assigned_To; "Assigned To")
            {
            }
            column(Created_Date; "Created Date")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Resolution_Date; "Resolution Date")
            {
            }
            column(Closed_Date; "Closed Date")
            {
            }
            column(Resolution_Time_Hours; "Resolution Time (Hours)")
            {
            }
            column(Response_Time_Hours; "Response Time (Hours)")
            {
            }
            column(SLA_Breached; "SLA Breached")
            {
            }
            column(Escalated; Escalated)
            {
            }
            column(Satisfaction_Score; "Customer Satisfaction")
            {
            }
            column(First_Contact_Resolution; FirstContactResolution)
            {
            }
            
            dataitem(TicketResponse; "CRM Ticket Response")
            {
                DataItemLink = "Ticket No." = field("Ticket No.");
                DataItemTableView = sorting("Ticket No.", "Response Date");
                
                column(Entry_No; "Entry No.")
                {
                }
                column(Response_Date; "Response Date")
                {
                }
                column(Response_From; "Response From")
                {
                }
                column(Response_Type; "Response Type")
                {
                }
                column(Time_Spent_Minutes; "Time Spent (Minutes)")
                {
                }
                column(Internal_Response; "Internal Response")
                {
                }
            }
            
            trigger OnAfterGetRecord()
            begin
                CalculateTicketMetrics();
                UpdateGlobalMetrics();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Analysis Period")
                {
                    Caption = 'Analysis Period';
                    
                    field(FromDate; FromDate)
                    {
                        Caption = 'From Date';
                        ToolTip = 'Specify the start date for the analysis period.';
                        ApplicationArea = All;
                    }
                    
                    field(ToDate; ToDate)
                    {
                        Caption = 'To Date';
                        ToolTip = 'Specify the end date for the analysis period.';
                        ApplicationArea = All;
                    }
                }
                
                group("Report Options")
                {
                    Caption = 'Report Options';
                    
                    field(IncludeResponses; IncludeResponses)
                    {
                        Caption = 'Include Response Details';
                        ToolTip = 'Include detailed response information for each ticket.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowSLAAnalysis; ShowSLAAnalysis)
                    {
                        Caption = 'Show SLA Analysis';
                        ToolTip = 'Include SLA compliance analysis in the report.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupByCategory; GroupByCategory)
                    {
                        Caption = 'Group by Category';
                        ToolTip = 'Group tickets by their category.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupByAgent; GroupByAgent)
                    {
                        Caption = 'Group by Agent';
                        ToolTip = 'Group tickets by assigned agent.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowOnlyOpen; ShowOnlyOpen)
                    {
                        Caption = 'Show Only Open Tickets';
                        ToolTip = 'Include only tickets that are currently open.';
                        ApplicationArea = All;
                    }
                }
                
                group("Metrics")
                {
                    Caption = 'Metrics to Calculate';
                    
                    field(CalculateAverages; CalculateAverages)
                    {
                        Caption = 'Calculate Average Times';
                        ToolTip = 'Calculate average response and resolution times.';
                        ApplicationArea = All;
                    }
                    
                    field(AnalyzeSatisfaction; AnalyzeSatisfaction)
                    {
                        Caption = 'Analyze Customer Satisfaction';
                        ToolTip = 'Include customer satisfaction score analysis.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            FromDate := CalcDate('<-1M>', Today);
            ToDate := Today;
            IncludeResponses := false;
            ShowSLAAnalysis := true;
            GroupByCategory := true;
            GroupByAgent := false;
            ShowOnlyOpen := false;
            CalculateAverages := true;
            AnalyzeSatisfaction := true;
        end;
    }

    labels
    {
        ReportTitle = 'Support Metrics Analysis Report';
        TicketNoCaption = 'Ticket No.';
        CustomerNoCaption = 'Customer No.';
        SubjectCaption = 'Subject';
        CategoryCaption = 'Category';
        PriorityCaption = 'Priority';
        StatusCaption = 'Status';
        AssignedToCaption = 'Assigned To';
        CreatedCaption = 'Created';
        SLADueCaption = 'SLA Due';
        ResolvedCaption = 'Resolved';
        ClosedCaption = 'Closed';
        ResolutionTimeCaption = 'Resolution Time (Hours)';
        ResponseTimeCaption = 'Response Time (Hours)';
        SLAMetCaption = 'SLA Met';
        EscalatedCaption = 'Escalated';
        SatisfactionCaption = 'Satisfaction Score';
        FirstContactCaption = 'First Contact Resolution';
        ResponseDetailsCaption = 'Response Details';
        SummaryMetricsCaption = 'Summary Metrics';
    }

    var
        FromDate: Date;
        ToDate: Date;
        IncludeResponses: Boolean;
        ShowSLAAnalysis: Boolean;
        GroupByCategory: Boolean;
        GroupByAgent: Boolean;
        ShowOnlyOpen: Boolean;
        CalculateAverages: Boolean;
        AnalyzeSatisfaction: Boolean;
        Escalated: Boolean;
        FirstContactResolution: Boolean;
        TotalTickets: Integer;
        ResolvedTickets: Integer;
        SLACompliantTickets: Integer;
        AverageResolutionTime: Decimal;
        AverageResponseTime: Decimal;
        AverageSatisfactionScore: Decimal;

    local procedure CalculateTicketMetrics()
    var
        TicketResp: Record "CRM Ticket Response";
        ResponseCount: Integer;
    begin
        // Resolution time and response time are now calculated in the table fields
        // We just need to calculate the derived metrics
        
        // Check if escalated
        Escalated := SupportTicket.Escalated;
        
        // Check first contact resolution
        TicketResp.SetRange("Ticket No.", SupportTicket."Ticket No.");
        ResponseCount := TicketResp.Count();
        FirstContactResolution := (ResponseCount <= 1) and (SupportTicket.Status = SupportTicket.Status::Resolved);
    end;

    local procedure UpdateGlobalMetrics()
    begin
        TotalTickets += 1;
        
        if SupportTicket.Status = SupportTicket.Status::Resolved then begin
            ResolvedTickets += 1;
            AverageResolutionTime := (AverageResolutionTime + SupportTicket."Resolution Time (Hours)") / 2;
        end;
        
        if not SupportTicket."SLA Breached" then
            SLACompliantTickets += 1;
            
        AverageResponseTime := (AverageResponseTime + SupportTicket."Response Time (Hours)") / 2;
        if SupportTicket."Customer Satisfaction" > 0 then
            AverageSatisfactionScore := (AverageSatisfactionScore + SupportTicket."Customer Satisfaction") / 2;
    end;
}