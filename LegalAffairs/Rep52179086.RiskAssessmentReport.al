report 52179086 "Risk Assessment Report"
{
    Caption = 'Risk Assessment Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/RiskAssessmentReport.rdlc';

    dataset
    {
        dataitem("Legal Risk Assessment"; "Legal Risk Assessment")
        {
            RequestFilterFields = "Assessment No.", "Risk Type", "Risk Level", Status, "Assessment Date";
            
            column(AssessmentNo; "Assessment No.")
            {
                IncludeCaption = true;
            }
            column(RiskType; "Risk Type")
            {
                IncludeCaption = true;
            }
            column(RiskDescription; "Risk Description")
            {
                IncludeCaption = true;
            }
            column(RiskLevel; "Risk Level")
            {
                IncludeCaption = true;
            }
            column(Probability; Probability)
            {
                IncludeCaption = true;
            }
            column(Impact; Impact)
            {
                IncludeCaption = true;
            }
            column(RiskScore; "Risk Score")
            {
                IncludeCaption = true;
            }
            column(Status; Status)
            {
                IncludeCaption = true;
            }
            column(FinancialImpact; "Financial Impact")
            {
                IncludeCaption = true;
            }
            column(ResponsiblePerson; "Responsible Person")
            {
                IncludeCaption = true;
            }
            column(AssessmentDate; "Assessment Date")
            {
                IncludeCaption = true;
            }
            column(ReviewDate; "Review Date")
            {
                IncludeCaption = true;
            }
            column(MitigationStrategy; "Mitigation Strategy")
            {
                IncludeCaption = true;
            }
            column(CaseNo; "Case No.")
            {
                IncludeCaption = true;
            }
            column(ContractNo; "Contract No.")
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
            column(FilterString; FilterString)
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                TotalRisks += 1;
                TotalFinancialImpact += "Financial Impact";
                
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
                
                case Status of
                    Status::Active:
                        ActiveRisks += 1;
                    Status::Mitigated:
                        MitigatedRisks += 1;
                    Status::Closed:
                        ClosedRisks += 1;
                end;
                
                if ("Review Date" <> 0D) and ("Review Date" <= Today) then
                    OverdueReviews += 1;
            end;
        }
        
        dataitem(RiskSummary; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            
            column(TotalRisks; TotalRisks)
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
            column(ActiveRisks; ActiveRisks)
            {
            }
            column(MitigatedRisks; MitigatedRisks)
            {
            }
            column(ClosedRisks; ClosedRisks)
            {
            }
            column(TotalFinancialImpact; TotalFinancialImpact)
            {
            }
            column(OverdueReviews; OverdueReviews)
            {
            }
            column(RiskMitigationRate; RiskMitigationRate)
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
                    
                    field(ShowOnlyActiveRisks; ShowOnlyActiveRisks)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Active Risks';
                        ToolTip = 'Specifies whether to show only active risks.';
                    }
                    field(ShowHighRiskOnly; ShowHighRiskOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Show High Risk Only';
                        ToolTip = 'Specifies whether to show only high and critical risks.';
                    }
                    field(IncludeMitigationDetails; IncludeMitigationDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Mitigation Details';
                        ToolTip = 'Specifies whether to include mitigation strategy details.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Risk Assessment Report';
        FilterString := "Legal Risk Assessment".GetFilters();
        
        if ShowOnlyActiveRisks then
            "Legal Risk Assessment".SetRange(Status, "Legal Risk Assessment".Status::Active);
            
        if ShowHighRiskOnly then
            "Legal Risk Assessment".SetFilter("Risk Level", '%1|%2', 
                "Legal Risk Assessment"."Risk Level"::High,
                "Legal Risk Assessment"."Risk Level"::Critical);
                
        // Initialize counters
        Clear(TotalRisks);
        Clear(LowRiskCount);
        Clear(MediumRiskCount);
        Clear(HighRiskCount);
        Clear(CriticalRiskCount);
        Clear(ActiveRisks);
        Clear(MitigatedRisks);
        Clear(ClosedRisks);
        Clear(TotalFinancialImpact);
        Clear(OverdueReviews);
    end;
    
    trigger OnPostReport()
    begin
        if TotalRisks > 0 then
            RiskMitigationRate := Round((MitigatedRisks + ClosedRisks) / TotalRisks * 100, 0.01);
    end;
    
    var
        ReportTitle: Text[100];
        FilterString: Text;
        ShowOnlyActiveRisks: Boolean;
        ShowHighRiskOnly: Boolean;
        IncludeMitigationDetails: Boolean;
        TotalRisks: Integer;
        LowRiskCount: Integer;
        MediumRiskCount: Integer;
        HighRiskCount: Integer;
        CriticalRiskCount: Integer;
        ActiveRisks: Integer;
        MitigatedRisks: Integer;
        ClosedRisks: Integer;
        TotalFinancialImpact: Decimal;
        OverdueReviews: Integer;
        RiskMitigationRate: Decimal;
}