report 52179003 "CRM Campaign Performance"
{
    Caption = 'Campaign Performance Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;

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
            column(Target_Audience; "Target Audience")
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
            column(Expected_Response_Rate; "Expected Response Rate")
            {
            }
            column(Total_Sent; TotalSent)
            {
            }
            column(Total_Delivered; TotalDelivered)
            {
            }
            column(Total_Opens; TotalOpens)
            {
            }
            column(Total_Clicks; TotalClicks)
            {
            }
            column(Total_Responses; TotalResponses)
            {
            }
            column(Leads_Generated; LeadsGenerated)
            {
            }
            column(Conversions; Conversions)
            {
            }
            column(Revenue_Generated; RevenueGenerated)
            {
            }
            column(Delivery_Rate; DeliveryRate)
            {
            }
            column(Open_Rate; OpenRate)
            {
            }
            column(Click_Rate; ClickRate)
            {
            }
            column(Response_Rate; ResponseRate)
            {
            }
            column(Conversion_Rate; ConversionRate)
            {
            }
            column(ROI_Percentage; ROIPercentage)
            {
            }
            column(Cost_Per_Lead; CostPerLead)
            {
            }
            column(Cost_Per_Conversion; CostPerConversion)
            {
            }
            
            dataitem(CampaignResponse; "CRM Campaign Response")
            {
                DataItemLink = "Campaign No." = field("No.");
                DataItemTableView = sorting("Campaign No.", "Response Date");
                
                column(Response_Entry_No; "Entry No.")
                {
                }
                column(Customer_No; "Customer No.")
                {
                }
                column(Response_Date; "Response Date")
                {
                }
                column(Responded; Responded)
                {
                }
                column(Email_Delivered; "Email Delivered")
                {
                }
                column(Email_Opens; "Email Opens")
                {
                }
                column(Email_Clicks; "Email Clicks")
                {
                }
                column(Lead_Generated; "Lead Generated")
                {
                }
                column(Sale_Made; "Sale Made")
                {
                }
                column(Sale_Amount; "Sale Amount")
                {
                }
            }
            
            trigger OnAfterGetRecord()
            begin
                CalculateCampaignMetrics();
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
                    
                    field(IncludeDetailedResponses; IncludeDetailedResponses)
                    {
                        Caption = 'Include Detailed Responses';
                        ToolTip = 'Include individual response details for each campaign.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowPerformanceMetrics; ShowPerformanceMetrics)
                    {
                        Caption = 'Show Performance Metrics';
                        ToolTip = 'Calculate and display performance metrics like ROI and conversion rates.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupByChannel; GroupByChannel)
                    {
                        Caption = 'Group by Marketing Channel';
                        ToolTip = 'Group campaigns by their marketing channel.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupByType; GroupByType)
                    {
                        Caption = 'Group by Campaign Type';
                        ToolTip = 'Group campaigns by their type.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            FromDate := CalcDate('<-3M>', Today);
            ToDate := Today;
            IncludeDetailedResponses := false;
            ShowPerformanceMetrics := true;
            GroupByChannel := true;
            GroupByType := false;
        end;
    }

    labels
    {
        ReportTitle = 'Campaign Performance Analysis Report';
        CampaignNoCaption = 'Campaign No.';
        CampaignNameCaption = 'Campaign Name';
        TypeCaption = 'Type';
        ChannelCaption = 'Channel';
        StatusCaption = 'Status';
        StartDateCaption = 'Start Date';
        EndDateCaption = 'End Date';
        BudgetCaption = 'Budget';
        ActualCostCaption = 'Actual Cost';
        TargetAudienceCaption = 'Target Audience';
        TotalSentCaption = 'Total Sent';
        DeliveredCaption = 'Delivered';
        OpensCaption = 'Opens';
        ClicksCaption = 'Clicks';
        ResponsesCaption = 'Responses';
        LeadsCaption = 'Leads Generated';
        ConversionsCaption = 'Conversions';
        RevenueCaption = 'Revenue Generated';
        DeliveryRateCaption = 'Delivery Rate %';
        OpenRateCaption = 'Open Rate %';
        ClickRateCaption = 'Click Rate %';
        ResponseRateCaption = 'Response Rate %';
        ConversionRateCaption = 'Conversion Rate %';
        ROICaption = 'ROI %';
        CostPerLeadCaption = 'Cost per Lead';
        CostPerConversionCaption = 'Cost per Conversion';
    }

    var
        FromDate: Date;
        ToDate: Date;
        IncludeDetailedResponses: Boolean;
        ShowPerformanceMetrics: Boolean;
        GroupByChannel: Boolean;
        GroupByType: Boolean;
        TotalSent: Integer;
        TotalDelivered: Integer;
        TotalOpens: Integer;
        TotalClicks: Integer;
        TotalResponses: Integer;
        LeadsGenerated: Integer;
        Conversions: Integer;
        RevenueGenerated: Decimal;
        DeliveryRate: Decimal;
        OpenRate: Decimal;
        ClickRate: Decimal;
        ResponseRate: Decimal;
        ConversionRate: Decimal;
        ROIPercentage: Decimal;
        CostPerLead: Decimal;
        CostPerConversion: Decimal;

    local procedure CalculateCampaignMetrics()
    var
        CampaignResp: Record "CRM Campaign Response";
    begin
        // Reset counters
        TotalSent := 0;
        TotalDelivered := 0;
        TotalOpens := 0;
        TotalClicks := 0;
        TotalResponses := 0;
        LeadsGenerated := 0;
        Conversions := 0;
        RevenueGenerated := 0;
        
        // Calculate metrics from campaign responses
        CampaignResp.SetRange("Campaign No.", Campaign."No.");
        if CampaignResp.FindSet() then
            repeat
                TotalSent += 1;
                if CampaignResp."Email Delivered" then
                    TotalDelivered += 1;
                TotalOpens += CampaignResp."Email Opens";
                TotalClicks += CampaignResp."Email Clicks";
                if CampaignResp.Responded then
                    TotalResponses += 1;
                if CampaignResp."Lead Generated" then
                    LeadsGenerated += 1;
                if CampaignResp."Sale Made" then begin
                    Conversions += 1;
                    RevenueGenerated += CampaignResp."Sale Amount";
                end;
            until CampaignResp.Next() = 0;
        
        // Calculate rates
        if TotalSent > 0 then begin
            DeliveryRate := (TotalDelivered / TotalSent) * 100;
            ResponseRate := (TotalResponses / TotalSent) * 100;
        end;
        
        if TotalDelivered > 0 then
            OpenRate := (TotalOpens / TotalDelivered) * 100;
            
        if TotalOpens > 0 then
            ClickRate := (TotalClicks / TotalOpens) * 100;
            
        if TotalResponses > 0 then
            ConversionRate := (Conversions / TotalResponses) * 100;
        
        // Calculate ROI and costs
        if Campaign."Actual Cost" > 0 then begin
            ROIPercentage := ((RevenueGenerated - Campaign."Actual Cost") / Campaign."Actual Cost") * 100;
            if LeadsGenerated > 0 then
                CostPerLead := Campaign."Actual Cost" / LeadsGenerated;
            if Conversions > 0 then
                CostPerConversion := Campaign."Actual Cost" / Conversions;
        end;
    end;
}