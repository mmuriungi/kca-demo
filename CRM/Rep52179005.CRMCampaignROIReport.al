report 52179005 "CRM Campaign ROI Report"
{
    Caption = 'Campaign ROI Analysis Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    RDLCLayout = './Rep52179005.CRMCampaignROIReport.rdl';

    dataset
    {
        dataitem(Campaign; "CRM Campaign")
        {
            RequestFilterFields = "Campaign Type", Status, "Start Date", "End Date";
            
            column(Campaign_No; "No.")
            {
            }
            column(Campaign_Description; Description)
            {
            }
            column(Campaign_Type; "Campaign Type")
            {
            }
            column(Status; Status)
            {
            }
            column(Start_Date; "Start Date")
            {
            }
            column(End_Date; "End Date")
            {
            }
            column(Budget_Amount; "Budget Amount")
            {
            }
            column(Actual_Cost; "Actual Cost")
            {
            }
            column(Total_Revenue; TotalRevenue)
            {
            }
            column(Net_Profit; NetProfit)
            {
            }
            column(ROI_Amount; ROIAmount)
            {
            }
            column(ROI_Percentage; ROIPercentage)
            {
            }
            column(Cost_Per_Response; CostPerResponse)
            {
            }
            column(Cost_Per_Lead; CostPerLead)
            {
            }
            column(Cost_Per_Conversion; CostPerConversion)
            {
            }
            column(Revenue_Per_Lead; RevenuePerLead)
            {
            }
            column(Conversion_Value; ConversionValue)
            {
            }
            column(Total_Responses; TotalResponses)
            {
            }
            column(Total_Leads; TotalLeads)
            {
            }
            column(Total_Conversions; TotalConversions)
            {
            }
            column(Response_Rate; ResponseRate)
            {
            }
            column(Lead_Conversion_Rate; LeadConversionRate)
            {
            }
            column(Customer_Lifetime_Value; CustomerLifetimeValue)
            {
            }
            column(Payback_Period_Days; PaybackPeriodDays)
            {
            }
            column(Break_Even_Point; BreakEvenPoint)
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                CalculateROIMetrics();
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
                        ToolTip = 'Specify the start date for the ROI analysis period.';
                        ApplicationArea = All;
                    }
                    
                    field(ToDate; ToDate)
                    {
                        Caption = 'To Date';
                        ToolTip = 'Specify the end date for the ROI analysis period.';
                        ApplicationArea = All;
                    }
                }
                
                group("ROI Calculations")
                {
                    Caption = 'ROI Calculation Options';
                    
                    field(IncludeLifetimeValue; IncludeLifetimeValue)
                    {
                        Caption = 'Include Customer Lifetime Value';
                        ToolTip = 'Include projected customer lifetime value in ROI calculations.';
                        ApplicationArea = All;
                    }
                    
                    field(DefaultLifetimeValue; DefaultLifetimeValue)
                    {
                        Caption = 'Default Customer Lifetime Value';
                        ToolTip = 'Default lifetime value to use for customers without specific data.';
                        ApplicationArea = All;
                    }
                    
                    field(IncludeIndirectRevenue; IncludeIndirectRevenue)
                    {
                        Caption = 'Include Indirect Revenue';
                        ToolTip = 'Include revenue from referrals and word-of-mouth.';
                        ApplicationArea = All;
                    }
                    
                    field(IndirectRevenueMultiplier; IndirectRevenueMultiplier)
                    {
                        Caption = 'Indirect Revenue Multiplier';
                        ToolTip = 'Multiplier to estimate indirect revenue (e.g., 1.2 for 20% additional).';
                        ApplicationArea = All;
                        DecimalPlaces = 1 : 2;
                    }
                }
                
                group("Grouping Options")
                {
                    Caption = 'Grouping Options';
                    
                    field(GroupByType; GroupByType)
                    {
                        Caption = 'Group by Campaign Type';
                        ToolTip = 'Group campaigns by their type for comparison.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupByChannel; GroupByChannel)
                    {
                        Caption = 'Group by Marketing Channel';
                        ToolTip = 'Group campaigns by their marketing channel.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowBenchmarks; ShowBenchmarks)
                    {
                        Caption = 'Show Industry Benchmarks';
                        ToolTip = 'Display industry benchmark ROI figures for comparison.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            FromDate := CalcDate('<-6M>', Today);
            ToDate := Today;
            IncludeLifetimeValue := true;
            DefaultLifetimeValue := 1000.00;
            IncludeIndirectRevenue := false;
            IndirectRevenueMultiplier := 1.2;
            GroupByType := true;
            GroupByChannel := false;
            ShowBenchmarks := false;
        end;
    }

    labels
    {
        ReportTitle = 'Campaign Return on Investment (ROI) Analysis';
        CampaignNoCaption = 'Campaign No.';
        DescriptionCaption = 'Description';
        TypeCaption = 'Type';
        StatusCaption = 'Status';
        StartDateCaption = 'Start Date';
        EndDateCaption = 'End Date';
        BudgetCaption = 'Budget';
        ActualCostCaption = 'Actual Cost';
        TotalRevenueCaption = 'Total Revenue';
        NetProfitCaption = 'Net Profit';
        ROIAmountCaption = 'ROI Amount';
        ROIPercentageCaption = 'ROI %';
        CostPerResponseCaption = 'Cost per Response';
        CostPerLeadCaption = 'Cost per Lead';
        CostPerConversionCaption = 'Cost per Conversion';
        RevenuePerLeadCaption = 'Revenue per Lead';
        ConversionValueCaption = 'Avg Conversion Value';
        ResponsesCaption = 'Total Responses';
        LeadsCaption = 'Total Leads';
        ConversionsCaption = 'Total Conversions';
        ResponseRateCaption = 'Response Rate %';
        LeadConversionCaption = 'Lead Conversion %';
        LifetimeValueCaption = 'Customer Lifetime Value';
        PaybackPeriodCaption = 'Payback Period (Days)';
        BreakEvenCaption = 'Break Even Point';
    }

    var
        FromDate: Date;
        ToDate: Date;
        IncludeLifetimeValue: Boolean;
        DefaultLifetimeValue: Decimal;
        IncludeIndirectRevenue: Boolean;
        IndirectRevenueMultiplier: Decimal;
        GroupByType: Boolean;
        GroupByChannel: Boolean;
        ShowBenchmarks: Boolean;
        TotalRevenue: Decimal;
        NetProfit: Decimal;
        ROIAmount: Decimal;
        ROIPercentage: Decimal;
        CostPerResponse: Decimal;
        CostPerLead: Decimal;
        CostPerConversion: Decimal;
        RevenuePerLead: Decimal;
        ConversionValue: Decimal;
        TotalResponses: Integer;
        TotalLeads: Integer;
        TotalConversions: Integer;
        ResponseRate: Decimal;
        LeadConversionRate: Decimal;
        CustomerLifetimeValue: Decimal;
        PaybackPeriodDays: Integer;
        BreakEvenPoint: Decimal;

    local procedure CalculateROIMetrics()
    var
        CampaignResp: Record "CRM Campaign Response";
        DirectRevenue: Decimal;
        TotalSent: Integer;
    begin
        // Reset all metrics
        TotalRevenue := 0;
        TotalResponses := 0;
        TotalLeads := 0;
        TotalConversions := 0;
        DirectRevenue := 0;
        TotalSent := 0;
        
        // Calculate metrics from campaign responses
        CampaignResp.SetRange("Campaign No.", Campaign."No.");
        if CampaignResp.FindSet() then
            repeat
                TotalSent += 1;
                if CampaignResp.Responded then
                    TotalResponses += 1;
                if CampaignResp."Lead Generated" then
                    TotalLeads += 1;
                if CampaignResp."Sale Made" then begin
                    TotalConversions += 1;
                    DirectRevenue += CampaignResp."Sale Amount";
                end;
            until CampaignResp.Next() = 0;
        
        // Calculate total revenue
        TotalRevenue := DirectRevenue;
        
        // Add lifetime value if enabled
        if IncludeLifetimeValue and (TotalConversions > 0) then
            TotalRevenue += (TotalConversions * DefaultLifetimeValue);
        
        // Add indirect revenue if enabled
        if IncludeIndirectRevenue then
            TotalRevenue := TotalRevenue * IndirectRevenueMultiplier;
        
        // Calculate ROI metrics
        if Campaign."Actual Cost" > 0 then begin
            NetProfit := TotalRevenue - Campaign."Actual Cost";
            ROIAmount := NetProfit;
            ROIPercentage := (NetProfit / Campaign."Actual Cost") * 100;
            
            // Calculate cost metrics
            if TotalResponses > 0 then
                CostPerResponse := Campaign."Actual Cost" / TotalResponses;
            if TotalLeads > 0 then
                CostPerLead := Campaign."Actual Cost" / TotalLeads;
            if TotalConversions > 0 then
                CostPerConversion := Campaign."Actual Cost" / TotalConversions;
                
            // Calculate break-even point
            if ConversionValue > 0 then
                BreakEvenPoint := Campaign."Actual Cost" / ConversionValue;
        end;
        
        // Calculate rates
        if TotalSent > 0 then
            ResponseRate := (TotalResponses / TotalSent) * 100;
        if TotalLeads > 0 then begin
            LeadConversionRate := (TotalConversions / TotalLeads) * 100;
            RevenuePerLead := TotalRevenue / TotalLeads;
        end;
        if TotalConversions > 0 then
            ConversionValue := DirectRevenue / TotalConversions;
        
        // Calculate customer lifetime value and payback period
        CustomerLifetimeValue := DefaultLifetimeValue;
        if (TotalRevenue > 0) and (Campaign."Actual Cost" > 0) then begin
            if TotalRevenue > Campaign."Actual Cost" then
                PaybackPeriodDays := Round((Campaign."Actual Cost" / TotalRevenue) * 365, 1, '>')
            else
                PaybackPeriodDays := 0; // Never pays back
        end;
    end;
}