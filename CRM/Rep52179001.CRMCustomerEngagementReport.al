report 52179001 "CRM Customer Engagement Report"
{
    Caption = 'Customer Engagement Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    RDLCLayout = './Rep52179001.CRMCustomerEngagementReport.rdl';

    dataset
    {
        dataitem(Customer; "CRM Customer")
        {
            RequestFilterFields = "Customer Type", "Segmentation Code", "Created Date";
            
            column(Customer_No; "No.")
            {
            }
            column(Customer_Name; "Full Name")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            column(Email; Email)
            {
            }
            column(Phone; "Phone No.")
            {
            }
            column(VIP; VIP)
            {
            }
            column(Engagement_Score; "Engagement Score")
            {
            }
            column(Last_Interaction_Date; "Last Interaction Date")
            {
            }
            column(Total_Interactions; "Total Interactions")
            {
            }
            column(Created_Date; "Created Date")
            {
            }
            column(Segmentation_Code; "Segmentation Code")
            {
            }
            
            dataitem(Interaction; "CRM Interaction Log")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.", "Interaction Date") order(descending);
                
                column(Interaction_Date; "Interaction Date")
                {
                }
                column(Interaction_Type; "Interaction Type")
                {
                }
                column(Interaction_Subject; Subject)
                {
                }
                column(Interaction_Outcome; Outcome)
                {
                }
                column(Duration_Minutes; "Duration (Minutes)")
                {
                }
            }
            
            dataitem(CampaignResponse; "CRM Campaign Response")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.", "Response Date") order(descending);
                
                column(Campaign_No; "Campaign No.")
                {
                }
                column(Response_Date; "Response Date")
                {
                }
                column(Responded; Responded)
                {
                }
                column(Response_Type; "Response Type")
                {
                }
                column(Engagement_Score_Response; "Engagement Score")
                {
                }
            }
            
            trigger OnAfterGetRecord()
            begin
                // Calculate dynamic engagement metrics
                Customer.CalcFields("Total Interactions");
                
                // Update engagement score based on recent activity
                CalculateEngagementMetrics();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Options")
                {
                    Caption = 'Report Options';
                    
                    field(IncludeInteractions; IncludeInteractions)
                    {
                        Caption = 'Include Interaction Details';
                        ToolTip = 'Include detailed interaction history for each customer.';
                        ApplicationArea = All;
                    }
                    
                    field(IncludeCampaignResponses; IncludeCampaignResponses)
                    {
                        Caption = 'Include Campaign Responses';
                        ToolTip = 'Include campaign response details for each customer.';
                        ApplicationArea = All;
                    }
                    
                    field(MinEngagementScore; MinEngagementScore)
                    {
                        Caption = 'Minimum Engagement Score';
                        ToolTip = 'Only include customers with engagement score above this threshold.';
                        ApplicationArea = All;
                    }
                    
                    field(DateRangeFilter; DateRangeFilter)
                    {
                        Caption = 'Date Range for Analysis';
                        ToolTip = 'Specify date range for interaction analysis (e.g., 30D, 3M, 1Y).';
                        ApplicationArea = All;
                    }
                }
                
                group("Grouping")
                {
                    Caption = 'Grouping Options';
                    
                    field(GroupByCustomerType; GroupByCustomerType)
                    {
                        Caption = 'Group by Customer Type';
                        ToolTip = 'Group customers by their type in the report.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupBySegmentation; GroupBySegmentation)
                    {
                        Caption = 'Group by Segmentation';
                        ToolTip = 'Group customers by their segmentation code.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            IncludeInteractions := true;
            IncludeCampaignResponses := true;
            MinEngagementScore := 0;
            DateRangeFilter := '3M';
            GroupByCustomerType := true;
            GroupBySegmentation := false;
        end;
    }

    labels
    {
        ReportTitle = 'Customer Engagement Analysis Report';
        CustomerNoCaption = 'Customer No.';
        CustomerNameCaption = 'Customer Name';
        CustomerTypeCaption = 'Customer Type';
        EmailCaption = 'Email';
        PhoneCaption = 'Phone';
        VIPCaption = 'VIP';
        EngagementScoreCaption = 'Engagement Score';
        LastInteractionCaption = 'Last Interaction';
        TotalInteractionsCaption = 'Total Interactions';
        CreatedDateCaption = 'Created Date';
        SegmentationCaption = 'Segmentation';
        InteractionDetailsCaption = 'Recent Interactions';
        CampaignResponsesCaption = 'Campaign Responses';
    }

    var
        IncludeInteractions: Boolean;
        IncludeCampaignResponses: Boolean;
        MinEngagementScore: Decimal;
        DateRangeFilter: Text[10];
        GroupByCustomerType: Boolean;
        GroupBySegmentation: Boolean;

    local procedure CalculateEngagementMetrics()
    var
        InteractionLog: Record "CRM Interaction Log";
        CampaignResp: Record "CRM Campaign Response";
        CalculatedScore: Decimal;
        InteractionCount: Integer;
        ResponseCount: Integer;
        DateFilter: Date;
    begin
        // Calculate engagement score based on recent activity
        DateFilter := CalcDate('<-' + DateRangeFilter + '>', Today);
        
        // Count recent interactions
        InteractionLog.SetRange("Customer No.", Customer."No.");
        InteractionLog.SetFilter("Interaction Date", '>=%1', DateFilter);
        InteractionCount := InteractionLog.Count();
        
        // Count recent campaign responses
        CampaignResp.SetRange("Customer No.", Customer."No.");
        CampaignResp.SetFilter("Response Date", '>=%1', CreateDateTime(DateFilter, 0T));
        CampaignResp.SetRange(Responded, true);
        ResponseCount := CampaignResp.Count();
        
        // Calculate engagement score (simplified formula)
        CalculatedScore := (InteractionCount * 10) + (ResponseCount * 15);
        if Customer.VIP then
            CalculatedScore := CalculatedScore * 1.2;
    end;
}