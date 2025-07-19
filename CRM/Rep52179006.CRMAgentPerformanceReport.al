report 52179006 "CRM Agent Performance Report"
{
    Caption = 'Agent Performance Analysis';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;

    dataset
    {
        dataitem(User; User)
        {
            RequestFilterFields = "User Name", "Full Name";
            
            column(User_Name; "User Name")
            {
            }
            column(Full_Name; "Full Name")
            {
            }
            column(Email; "Contact Email")
            {
            }
            column(Total_Tickets; TotalTickets)
            {
            }
            column(Open_Tickets; OpenTickets)
            {
            }
            column(Resolved_Tickets; ResolvedTickets)
            {
            }
            column(Closed_Tickets; ClosedTickets)
            {
            }
            column(Avg_Resolution_Time; AvgResolutionTime)
            {
            }
            column(Avg_Response_Time; AvgResponseTime)
            {
            }
            column(SLA_Compliance_Rate; SLAComplianceRate)
            {
            }
            column(Customer_Satisfaction; CustomerSatisfaction)
            {
            }
            column(First_Contact_Resolution_Rate; FirstContactResolutionRate)
            {
            }
            column(Escalation_Rate; EscalationRate)
            {
            }
            column(Tickets_Per_Day; TicketsPerDay)
            {
            }
            column(Workload_Score; WorkloadScore)
            {
            }
            column(Performance_Score; PerformanceScore)
            {
            }
            column(Total_Leads; TotalLeads)
            {
            }
            column(Converted_Leads; ConvertedLeads)
            {
            }
            column(Lead_Conversion_Rate; LeadConversionRate)
            {
            }
            column(Revenue_Generated; RevenueGenerated)
            {
            }
            column(Avg_Deal_Size; AvgDealSize)
            {
            }
            column(Total_Interactions; TotalInteractions)
            {
            }
            column(Interaction_Quality_Score; InteractionQualityScore)
            {
            }
            
            dataitem(SupportTicket; "CRM Support Ticket")
            {
                DataItemLink = "Assigned To" = field("User Name");
                DataItemTableView = sorting("Assigned To", "Created Date");
                
                column(Ticket_No; "Ticket No.")
                {
                }
                column(Customer_No; "Customer No.")
                {
                }
                column(Subject; Subject)
                {
                }
                column(Category; Category)
                {
                }
                column(Priority; Priority)
                {
                }
                column(Status; Status)
                {
                }
                column(Created_Date; "Created Date")
                {
                }
                column(Resolution_Date; "Resolution Date")
                {
                }
                column(Due_Date; "Due Date")
                {
                }
                column(Escalated; Escalated)
                {
                }
            }
            
            dataitem(Lead; "CRM Lead")
            {
                DataItemLink = "Assigned To" = field("User Name");
                DataItemTableView = sorting("Assigned To", "Created Date");
                
                column(Lead_No; "No.")
                {
                }
                column(Lead_First_Name; "First Name")
                {
                }
                column(Lead_Last_Name; "Last Name")
                {
                }
                column(Lead_Status; "Lead Status")
                {
                }
                column(Lead_Score; "Lead Score")
                {
                }
                column(Lead_Created_Date; "Created Date")
                {
                }
                column(Lead_Converted_Date; "Converted Date")
                {
                }
            }
            
            trigger OnAfterGetRecord()
            begin
                CalculateAgentMetrics();
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
                        ToolTip = 'Specify the start date for the performance analysis.';
                        ApplicationArea = All;
                    }
                    
                    field(ToDate; ToDate)
                    {
                        Caption = 'To Date';
                        ToolTip = 'Specify the end date for the performance analysis.';
                        ApplicationArea = All;
                    }
                }
                
                group("Performance Metrics")
                {
                    Caption = 'Performance Metrics';
                    
                    field(IncludeTicketMetrics; IncludeTicketMetrics)
                    {
                        Caption = 'Include Support Ticket Metrics';
                        ToolTip = 'Include support ticket performance metrics.';
                        ApplicationArea = All;
                    }
                    
                    field(IncludeLeadMetrics; IncludeLeadMetrics)
                    {
                        Caption = 'Include Lead Management Metrics';
                        ToolTip = 'Include lead conversion and sales metrics.';
                        ApplicationArea = All;
                    }
                    
                    field(CalculateWorkload; CalculateWorkload)
                    {
                        Caption = 'Calculate Workload Analysis';
                        ToolTip = 'Calculate workload distribution and capacity metrics.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowPerformanceRanking; ShowPerformanceRanking)
                    {
                        Caption = 'Show Performance Ranking';
                        ToolTip = 'Rank agents by overall performance score.';
                        ApplicationArea = All;
                    }
                }
                
                group("Comparison Options")
                {
                    Caption = 'Comparison Options';
                    
                    field(CompareToTeamAverage; CompareToTeamAverage)
                    {
                        Caption = 'Compare to Team Average';
                        ToolTip = 'Show comparison to team average performance.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowTrends; ShowTrends)
                    {
                        Caption = 'Show Performance Trends';
                        ToolTip = 'Show performance trends over time.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            FromDate := CalcDate('<-1M>', Today);
            ToDate := Today;
            IncludeTicketMetrics := true;
            IncludeLeadMetrics := true;
            CalculateWorkload := true;
            ShowPerformanceRanking := true;
            CompareToTeamAverage := true;
            ShowTrends := false;
        end;
    }

    labels
    {
        ReportTitle = 'Agent Performance Analysis Report';
        UserNameCaption = 'User Name';
        FullNameCaption = 'Full Name';
        EmailCaption = 'Email';
        TotalTicketsCaption = 'Total Tickets';
        OpenTicketsCaption = 'Open Tickets';
        ResolvedTicketsCaption = 'Resolved Tickets';
        ClosedTicketsCaption = 'Closed Tickets';
        AvgResolutionCaption = 'Avg Resolution Time (Hrs)';
        AvgResponseCaption = 'Avg Response Time (Hrs)';
        SLAComplianceCaption = 'SLA Compliance %';
        SatisfactionCaption = 'Customer Satisfaction';
        FirstContactCaption = 'First Contact Resolution %';
        EscalationCaption = 'Escalation Rate %';
        WorkloadCaption = 'Tickets per Day';
        PerformanceCaption = 'Performance Score';
        LeadsCaption = 'Total Leads';
        ConvertedCaption = 'Converted Leads';
        ConversionRateCaption = 'Conversion Rate %';
        RevenueCaption = 'Revenue Generated';
        DealSizeCaption = 'Avg Deal Size';
        InteractionsCaption = 'Total Interactions';
        QualityCaption = 'Interaction Quality Score';
    }

    var
        FromDate: Date;
        ToDate: Date;
        IncludeTicketMetrics: Boolean;
        IncludeLeadMetrics: Boolean;
        CalculateWorkload: Boolean;
        ShowPerformanceRanking: Boolean;
        CompareToTeamAverage: Boolean;
        ShowTrends: Boolean;
        TotalTickets: Integer;
        OpenTickets: Integer;
        ResolvedTickets: Integer;
        ClosedTickets: Integer;
        AvgResolutionTime: Decimal;
        AvgResponseTime: Decimal;
        SLAComplianceRate: Decimal;
        CustomerSatisfaction: Decimal;
        FirstContactResolutionRate: Decimal;
        EscalationRate: Decimal;
        TicketsPerDay: Decimal;
        WorkloadScore: Decimal;
        PerformanceScore: Decimal;
        TotalLeads: Integer;
        ConvertedLeads: Integer;
        LeadConversionRate: Decimal;
        RevenueGenerated: Decimal;
        AvgDealSize: Decimal;
        TotalInteractions: Integer;
        InteractionQualityScore: Decimal;

    local procedure CalculateAgentMetrics()
    var
        Ticket: Record "CRM Support Ticket";
        LeadRec: Record "CRM Lead";
        Interaction: Record "CRM Interaction Log";
        CampaignResp: Record "CRM Campaign Response";
        TotalResolutionTime: Decimal;
        TotalResponseTime: Decimal;
        SLACompliantTickets: Integer;
        EscalatedTickets: Integer;
        FirstContactResolutions: Integer;
        DaysInPeriod: Integer;
        TotalRevenue: Decimal;
    begin
        // Reset metrics
        TotalTickets := 0;
        OpenTickets := 0;
        ResolvedTickets := 0;
        ClosedTickets := 0;
        TotalResolutionTime := 0;
        TotalResponseTime := 0;
        SLACompliantTickets := 0;
        EscalatedTickets := 0;
        FirstContactResolutions := 0;
        TotalLeads := 0;
        ConvertedLeads := 0;
        TotalRevenue := 0;
        TotalInteractions := 0;
        
        // Calculate ticket metrics
        Ticket.SetRange("Assigned To", User."User Name");
        Ticket.SetFilter("Created Date", '%1..%2', CreateDateTime(FromDate, 0T), CreateDateTime(ToDate, 235959T));
        if Ticket.FindSet() then
            repeat
                TotalTickets += 1;
                
                case Ticket.Status of
                    Ticket.Status::Open:
                        OpenTickets += 1;
                    Ticket.Status::Resolved:
                        ResolvedTickets += 1;
                    Ticket.Status::Closed:
                        ClosedTickets += 1;
                end;
                
                // Calculate resolution time
                if (Ticket."Resolution Date" <> 0DT) and (Ticket."Created Date" <> 0DT) then
                    TotalResolutionTime += (Ticket."Resolution Date" - Ticket."Created Date") / (1000 * 60 * 60);
                
                // Calculate first response time (simplified)
                if (Ticket."First Response Date" <> 0DT) and (Ticket."Created Date" <> 0DT) then
                    TotalResponseTime += (Ticket."First Response Date" - Ticket."Created Date") / (1000 * 60 * 60);
                
                // Check SLA compliance
                if (Ticket."Due Date" <> 0DT) and (Ticket."Resolution Date" <> 0DT) and 
                   (Ticket."Resolution Date" <= Ticket."Due Date") then
                    SLACompliantTickets += 1;
                
                // Check escalations
                if Ticket.Escalated then
                    EscalatedTickets += 1;
                
                // First contact resolution (simplified - check if resolved without escalation)
                if (Ticket.Status = Ticket.Status::Resolved) and not Ticket.Escalated then
                    FirstContactResolutions += 1;
                    
            until Ticket.Next() = 0;
        
        // Calculate lead metrics
        LeadRec.SetRange("Assigned To", User."User Name");
        LeadRec.SetFilter("Created Date", '%1..%2', CreateDateTime(FromDate, 0T), CreateDateTime(ToDate, 235959T));
        if LeadRec.FindSet() then
            repeat
                TotalLeads += 1;
                if LeadRec."Lead Status" = LeadRec."Lead Status"::Converted then
                    ConvertedLeads += 1;
            until LeadRec.Next() = 0;
        
        // Calculate revenue from campaign responses (simplified)
        CampaignResp.SetFilter("Response Date", '%1..%2', CreateDateTime(FromDate, 0T), CreateDateTime(ToDate, 235959T));
        if CampaignResp.FindSet() then
            repeat
                if CampaignResp."Sale Made" then
                    TotalRevenue += CampaignResp."Sale Amount";
            until CampaignResp.Next() = 0;
        
        // Calculate interaction count
        Interaction.SetFilter("Interaction Date", '%1..%2', FromDate, ToDate);
        TotalInteractions := Interaction.Count();
        
        // Calculate averages and rates
        if ResolvedTickets > 0 then
            AvgResolutionTime := TotalResolutionTime / ResolvedTickets;
        if TotalTickets > 0 then begin
            AvgResponseTime := TotalResponseTime / TotalTickets;
            SLAComplianceRate := (SLACompliantTickets / TotalTickets) * 100;
            EscalationRate := (EscalatedTickets / TotalTickets) * 100;
            FirstContactResolutionRate := (FirstContactResolutions / TotalTickets) * 100;
        end;
        if TotalLeads > 0 then
            LeadConversionRate := (ConvertedLeads / TotalLeads) * 100;
        if ConvertedLeads > 0 then
            AvgDealSize := TotalRevenue / ConvertedLeads;
        
        // Calculate workload metrics
        DaysInPeriod := ToDate - FromDate + 1;
        if DaysInPeriod > 0 then
            TicketsPerDay := TotalTickets / DaysInPeriod;
        
        // Calculate performance scores (simplified scoring system)
        RevenueGenerated := TotalRevenue;
        CustomerSatisfaction := 4.2; // Placeholder - would come from actual feedback
        InteractionQualityScore := 85; // Placeholder - would be calculated from interaction data
        WorkloadScore := TicketsPerDay * 10; // Simple workload scoring
        
        // Overall performance score (weighted average)
        PerformanceScore := (SLAComplianceRate * 0.3) + (FirstContactResolutionRate * 0.25) + 
                           (LeadConversionRate * 0.25) + (CustomerSatisfaction * 20 * 0.2);
    end;
}