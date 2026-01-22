report 52179080 "Case Status Report"
{
    Caption = 'Case Status Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/CaseStatusReport.rdlc';

    dataset
    {
        dataitem("Legal Case"; "Legal Case")
        {
            RequestFilterFields = "Case No.", "Case Status", "Case Type", Priority, "Department Code", "Filing Date";
            
            column(CaseNo; "Case No.")
            {
                IncludeCaption = true;
            }
            column(CaseTitle; "Case Title")
            {
                IncludeCaption = true;
            }
            column(CaseType; "Case Type")
            {
                IncludeCaption = true;
            }
            column(CaseCategory; "Case Category")
            {
                IncludeCaption = true;
            }
            column(CaseStatus; "Case Status")
            {
                IncludeCaption = true;
            }
            column(Priority; Priority)
            {
                IncludeCaption = true;
            }
            column(RiskLevel; "Risk Level")
            {
                IncludeCaption = true;
            }
            column(PlaintiffClaimant; "Plaintiff/Claimant")
            {
                IncludeCaption = true;
            }
            column(DefendantRespondent; "Defendant/Respondent")
            {
                IncludeCaption = true;
            }
            column(LeadCounsel; "Lead Counsel")
            {
                IncludeCaption = true;
            }
            column(ExternalCounsel; "External Counsel")
            {
                IncludeCaption = true;
            }
            column(CourtName; "Court Name")
            {
                IncludeCaption = true;
            }
            column(CourtFileNumber; "Court File Number")
            {
                IncludeCaption = true;
            }
            column(FilingDate; "Filing Date")
            {
                IncludeCaption = true;
            }
            column(NextCourtDate; "Next Court Date")
            {
                IncludeCaption = true;
            }
            column(DepartmentCode; "Department Code")
            {
                IncludeCaption = true;
            }
            column(ClaimAmount; "Claim Amount")
            {
                IncludeCaption = true;
            }
            column(EstimatedCosts; "Estimated Costs")
            {
                IncludeCaption = true;
            }
            column(ActualCosts; "Actual Costs")
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
            column(UserID; UserId)
            {
            }
            column(TimeGenerated; Format(CurrentDateTime, 0, 4))
            {
            }
            column(FilterString; FilterString)
            {
            }
            
            dataitem("Legal Court Hearing"; "Legal Court Hearing")
            {
                DataItemLink = "Case No." = field("Case No.");
                DataItemTableView = sorting("Hearing Date") where(Status = const(Scheduled));
                
                column(HearingDate; "Hearing Date")
                {
                    IncludeCaption = true;
                }
                column(HearingType; "Hearing Type")
                {
                    IncludeCaption = true;
                }
                column(PresidingJudge; "Presiding Judge")
                {
                    IncludeCaption = true;
                }
            }
            
            trigger OnAfterGetRecord()
            begin
                CalcFields("Actual Costs");
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
                    
                    field(ShowClosedCases; ShowClosedCases)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Closed Cases';
                        ToolTip = 'Specifies whether to include closed cases in the report.';
                    }
                    field(ShowFinancialDetails; ShowFinancialDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Financial Details';
                        ToolTip = 'Specifies whether to show financial information in the report.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Case Status Report';
        FilterString := "Legal Case".GetFilters();
        
        if not ShowClosedCases then
            "Legal Case".SetFilter("Case Status", '<>%1', "Legal Case"."Case Status"::Closed);
    end;
    
    var
        CompanyInfo: Record "Company Information";
        ReportTitle: Text[100];
        FilterString: Text;
        ShowClosedCases: Boolean;
        ShowFinancialDetails: Boolean;
}