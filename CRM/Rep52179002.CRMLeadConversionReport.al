report 52179002 "CRM Lead Conversion Report"
{
    Caption = 'Lead Conversion Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;

    dataset
    {
        dataitem(Lead; "CRM Lead")
        {
            RequestFilterFields = "Lead Source", "Lead Status", "Created Date", "Assigned To";
            
            column(Lead_No; "No.")
            {
            }
            column(Lead_First_Name; "First Name")
            {
            }
            column(Lead_Last_Name; "Last Name")
            {
            }
            column(Company_Name; "Company Name")
            {
            }
            column(Lead_Source; "Lead Source")
            {
            }
            column(Lead_Status; "Lead Status")
            {
            }
            column(Lead_Score; "Lead Score")
            {
            }
            column(Interest_Level; "Interest Level")
            {
            }
            column(Created_Date; "Created Date")
            {
            }
            column(Converted_Date; "Converted Date")
            {
            }
            column(Days_to_Convert; DaysToConvert)
            {
            }
            column(Assigned_To; "Assigned To")
            {
            }
            column(Email; "Email")
            {
            }
            column(Phone; "Phone No.")
            {
            }
            column(Budget_Range; "Budget Range")
            {
            }
            column(Decision_Timeline; "Decision Timeline")
            {
            }
            column(Nurture_Stage; "Nurture Stage")
            {
            }
            column(Last_Contact_Date; "Last Contact Date")
            {
            }
            column(Next_Follow_up_Date; "Next Follow-up Date")
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                // Calculate days to convert
                if ("Lead Status" = "Lead Status"::Converted) and ("Converted Date" <> 0D) then
                    DaysToConvert := "Converted Date" - DT2Date("Created Date")
                else
                    DaysToConvert := 0;
                    
                // Update statistics
                UpdateConversionStatistics();
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
                    
                    field(ShowOnlyConverted; ShowOnlyConverted)
                    {
                        Caption = 'Show Only Converted Leads';
                        ToolTip = 'Include only leads that have been converted to customers.';
                        ApplicationArea = All;
                    }
                    
                    field(ShowStatistics; ShowStatistics)
                    {
                        Caption = 'Include Summary Statistics';
                        ToolTip = 'Include conversion rate statistics in the report.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupBySource; GroupBySource)
                    {
                        Caption = 'Group by Lead Source';
                        ToolTip = 'Group leads by their source in the report.';
                        ApplicationArea = All;
                    }
                    
                    field(GroupByAssignee; GroupByAssignee)
                    {
                        Caption = 'Group by Assigned To';
                        ToolTip = 'Group leads by who they are assigned to.';
                        ApplicationArea = All;
                    }
                }
                
                group("Conversion Analysis")
                {
                    Caption = 'Conversion Analysis';
                    
                    field(AnalyzeConversionFunnel; AnalyzeConversionFunnel)
                    {
                        Caption = 'Analyze Conversion Funnel';
                        ToolTip = 'Include conversion funnel analysis showing lead progression.';
                        ApplicationArea = All;
                    }
                    
                    field(CalculateROI; CalculateROI)
                    {
                        Caption = 'Calculate ROI';
                        ToolTip = 'Calculate return on investment for lead generation activities.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            FromDate := CalcDate('<-3M>', Today);
            ToDate := Today;
            ShowOnlyConverted := false;
            ShowStatistics := true;
            GroupBySource := true;
            GroupByAssignee := false;
            AnalyzeConversionFunnel := true;
            CalculateROI := false;
        end;
    }

    labels
    {
        ReportTitle = 'Lead Conversion Analysis Report';
        LeadNoCaption = 'Lead No.';
        LeadNameCaption = 'Lead Name';
        CompanyCaption = 'Company';
        SourceCaption = 'Source';
        StatusCaption = 'Status';
        ScoreCaption = 'Score';
        InterestCaption = 'Interest Level';
        CreatedCaption = 'Created';
        ConvertedCaption = 'Converted';
        DaysToConvertCaption = 'Days to Convert';
        AssignedToCaption = 'Assigned To';
        EmailCaption = 'Email';
        PhoneCaption = 'Phone';
        ExpectedRevenueCaption = 'Expected Revenue';
        BudgetCaption = 'Budget Range';
        TimelineCaption = 'Decision Timeline';
        StageCaption = 'Nurture Stage';
        LastContactCaption = 'Last Contact';
        NextFollowupCaption = 'Next Follow-up';
        StatisticsCaption = 'Conversion Statistics';
    }

    var
        FromDate: Date;
        ToDate: Date;
        ShowOnlyConverted: Boolean;
        ShowStatistics: Boolean;
        GroupBySource: Boolean;
        GroupByAssignee: Boolean;
        AnalyzeConversionFunnel: Boolean;
        CalculateROI: Boolean;
        DaysToConvert: Integer;
        TotalLeads: Integer;
        ConvertedLeads: Integer;
        ConversionRate: Decimal;
        AverageConversionTime: Decimal;

    local procedure UpdateConversionStatistics()
    begin
        TotalLeads += 1;
        
        if Lead."Lead Status" = Lead."Lead Status"::Converted then begin
            ConvertedLeads += 1;
            if DaysToConvert > 0 then
                AverageConversionTime := (AverageConversionTime + DaysToConvert) / 2;
        end;
        
        if TotalLeads > 0 then
            ConversionRate := (ConvertedLeads / TotalLeads) * 100;
    end;
}