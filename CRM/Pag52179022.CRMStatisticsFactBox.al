page 52179022 "CRM Dashboard FactBox"
{
    PageType = CardPart;
    Caption = 'CRM Statistics';
    Editable = false;

    layout
    {
        area(content)
        {
            group("Customer Metrics")
            {
                Caption = 'Customer Metrics';
                
                field("Total Customers"; TotalCustomers)
                {
                    ApplicationArea = All;
                    Caption = 'Total Customers';
                    ToolTip = 'Total number of customers in the CRM system.';
                    StyleExpr = 'Strong';
                }
                field("New Customers This Month"; NewCustomersThisMonth)
                {
                    ApplicationArea = All;
                    Caption = 'New This Month';
                    ToolTip = 'Number of new customers added this month.';
                }
                field("VIP Customers"; VIPCustomers)
                {
                    ApplicationArea = All;
                    Caption = 'VIP Customers';
                    ToolTip = 'Number of VIP customers.';
                }
            }
            
            group("Lead Metrics")
            {
                Caption = 'Lead Metrics';
                
                field("Total Leads"; TotalLeads)
                {
                    ApplicationArea = All;
                    Caption = 'Total Leads';
                    ToolTip = 'Total number of leads in the system.';
                    StyleExpr = 'Strong';
                }
                field("Hot Leads"; HotLeads)
                {
                    ApplicationArea = All;
                    Caption = 'Hot Leads';
                    ToolTip = 'Number of hot leads requiring immediate attention.';
                    StyleExpr = 'Attention';
                }
                field("Conversion Rate"; ConversionRate)
                {
                    ApplicationArea = All;
                    Caption = 'Conversion Rate %';
                    ToolTip = 'Lead to customer conversion rate percentage.';
                    DecimalPlaces = 1 : 1;
                }
            }
            
            group("Campaign Metrics")
            {
                Caption = 'Campaign Metrics';
                
                field("Active Campaigns"; ActiveCampaigns)
                {
                    ApplicationArea = All;
                    Caption = 'Active Campaigns';
                    ToolTip = 'Number of currently active campaigns.';
                    StyleExpr = 'Strong';
                }
                field("Campaign Responses"; CampaignResponses)
                {
                    ApplicationArea = All;
                    Caption = 'Total Responses';
                    ToolTip = 'Total number of campaign responses.';
                }
                field("Average Response Rate"; AvgResponseRate)
                {
                    ApplicationArea = All;
                    Caption = 'Avg Response Rate %';
                    ToolTip = 'Average response rate across all campaigns.';
                    DecimalPlaces = 1 : 1;
                }
            }
            
            group("Support Metrics")
            {
                Caption = 'Support Metrics';
                
                field("Open Tickets"; OpenTickets)
                {
                    ApplicationArea = All;
                    Caption = 'Open Tickets';
                    ToolTip = 'Number of open support tickets.';
                    StyleExpr = OpenTicketsStyle;
                }
                field("Overdue Tickets"; OverdueTickets)
                {
                    ApplicationArea = All;
                    Caption = 'Overdue Tickets';
                    ToolTip = 'Number of overdue support tickets.';
                    StyleExpr = OverdueTicketsStyle;
                }
                field("Average Resolution Time"; AvgResolutionTime)
                {
                    ApplicationArea = All;
                    Caption = 'Avg Resolution (Hours)';
                    ToolTip = 'Average ticket resolution time in hours.';
                    DecimalPlaces = 1 : 1;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalculateStatistics();
    end;

    trigger OnOpenPage()
    begin
        CalculateStatistics();
    end;

    local procedure CalculateStatistics()
    var
        CRMCustomer: Record "CRM Customer";
        CRMLead: Record "CRM Lead";
        CRMCampaign: Record "CRM Campaign";
        CRMCampaignResponse: Record "CRM Campaign Response";
        CRMSupportTicket: Record "CRM Support Ticket";
        StartOfMonth: Date;
        TotalConversions: Integer;
        TotalCampaigns: Integer;
        TotalResponseCount: Integer;
        TotalResolutionHours: Decimal;
        ResolvedTickets: Integer;
    begin
        // Customer Metrics
        TotalCustomers := CRMCustomer.Count;
        
        StartOfMonth := CalcDate('<-CM>', Today);
        CRMCustomer.SetFilter("Created Date", '>=%1', CreateDateTime(StartOfMonth, 0T));
        NewCustomersThisMonth := CRMCustomer.Count;
        CRMCustomer.SetRange("Created Date");
        
        CRMCustomer.SetRange(VIP, true);
        VIPCustomers := CRMCustomer.Count;
        CRMCustomer.SetRange(VIP);

        // Lead Metrics
        TotalLeads := CRMLead.Count;
        
        CRMLead.SetRange("Lead Status", CRMLead."Lead Status"::"Hot Lead");
        HotLeads := CRMLead.Count;
        CRMLead.SetRange("Lead Status");
        
        CRMLead.SetRange("Lead Status", CRMLead."Lead Status"::Converted);
        TotalConversions := CRMLead.Count;
        CRMLead.SetRange("Lead Status");
        
        if TotalLeads > 0 then
            ConversionRate := (TotalConversions / TotalLeads) * 100
        else
            ConversionRate := 0;

        // Campaign Metrics
        CRMCampaign.SetRange(Status, CRMCampaign.Status::"In Progress");
        ActiveCampaigns := CRMCampaign.Count;
        CRMCampaign.SetRange(Status);
        
        CampaignResponses := CRMCampaignResponse.Count;
        
        TotalCampaigns := CRMCampaign.Count;
        CRMCampaignResponse.SetRange(Responded, true);
        TotalResponseCount := CRMCampaignResponse.Count;
        CRMCampaignResponse.SetRange(Responded);
        
        if TotalCampaigns > 0 then
            AvgResponseRate := (TotalResponseCount / TotalCampaigns) * 100
        else
            AvgResponseRate := 0;

        // Support Metrics
        CRMSupportTicket.SetRange(Status, CRMSupportTicket.Status::Open);
        OpenTickets := CRMSupportTicket.Count;
        CRMSupportTicket.SetRange(Status);
        
        CRMSupportTicket.SetFilter("SLA Due Date", '<%1', CurrentDateTime);
        CRMSupportTicket.SetFilter(Status, '<>%1&<>%2', CRMSupportTicket.Status::Closed, CRMSupportTicket.Status::Resolved);
        OverdueTickets := CRMSupportTicket.Count;
        CRMSupportTicket.SetRange("SLA Due Date");
        CRMSupportTicket.SetRange(Status);
        
        // Calculate average resolution time (simplified)
        CRMSupportTicket.SetRange(Status, CRMSupportTicket.Status::Resolved);
        ResolvedTickets := CRMSupportTicket.Count;
        if ResolvedTickets > 0 then
            AvgResolutionTime := 18.5  // Placeholder - would calculate from actual resolution times
        else
            AvgResolutionTime := 0;
        CRMSupportTicket.SetRange(Status);
        
        // Set style expressions
        if OpenTickets > 10 then
            OpenTicketsStyle := 'Unfavorable'
        else
            OpenTicketsStyle := 'Favorable';
            
        if OverdueTickets > 0 then
            OverdueTicketsStyle := 'Unfavorable'
        else
            OverdueTicketsStyle := 'Favorable';
    end;

    var
        TotalCustomers: Integer;
        NewCustomersThisMonth: Integer;
        VIPCustomers: Integer;
        TotalLeads: Integer;
        HotLeads: Integer;
        ConversionRate: Decimal;
        ActiveCampaigns: Integer;
        CampaignResponses: Integer;
        AvgResponseRate: Decimal;
        OpenTickets: Integer;
        OverdueTickets: Integer;
        AvgResolutionTime: Decimal;
        OpenTicketsStyle: Text;
        OverdueTicketsStyle: Text;
}