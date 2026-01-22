report 52179084 "Litigation Overview Report"
{
    Caption = 'Litigation Overview Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/LitigationOverviewReport.rdlc';

    dataset
    {
        dataitem("Legal Case"; "Legal Case")
        {
            RequestFilterFields = "Case No.", "Case Type", "Case Status", Priority, "Filing Date";
            DataItemTableView = where("Case Type" = filter(Litigation | Civil | Criminal));
            
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
            column(CaseStatus; "Case Status")
            {
                IncludeCaption = true;
            }
            column(Priority; Priority)
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
            column(CourtName; "Court Name")
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
            column(ClaimAmount; "Claim Amount")
            {
                IncludeCaption = true;
            }
            column(SettlementAmount; "Settlement Amount")
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
            column(FilterString; FilterString)
            {
            }
            
            dataitem("Legal Court Hearing"; "Legal Court Hearing")
            {
                DataItemLink = "Case No." = field("Case No.");
                DataItemTableView = sorting("Hearing Date") where(Status = filter(Scheduled | Completed));
                
                column(HearingDate; "Hearing Date")
                {
                    IncludeCaption = true;
                }
                column(HearingType; "Hearing Type")
                {
                    IncludeCaption = true;
                }
                column(HearingStatus; Status)
                {
                    IncludeCaption = true;
                }
                column(HearingOutcome; "Hearing Outcome")
                {
                    IncludeCaption = true;
                }
            }
            
            trigger OnAfterGetRecord()
            begin
                CalcFields("Actual Costs");
                TotalCases += 1;
                TotalClaimedAmount += "Claim Amount";
                TotalSettlementAmount += "Settlement Amount";
                TotalLegalCosts += "Actual Costs";
                
                case "Case Status" of
                    "Case Status"::Open:
                        OpenCases += 1;
                    "Case Status"::"In Progress":
                        InProgressCases += 1;
                    "Case Status"::Closed:
                        ClosedCases += 1;
                    "Case Status"::Settled:
                        SettledCases += 1;
                end;
            end;
        }
        
        dataitem(Summary; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            
            column(TotalCases; TotalCases)
            {
            }
            column(OpenCases; OpenCases)
            {
            }
            column(InProgressCases; InProgressCases)
            {
            }
            column(ClosedCases; ClosedCases)
            {
            }
            column(SettledCases; SettledCases)
            {
            }
            column(TotalClaimedAmount; TotalClaimedAmount)
            {
            }
            column(TotalSettlementAmount; TotalSettlementAmount)
            {
            }
            column(TotalLegalCosts; TotalLegalCosts)
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
                    
                    field(IncludeClosedCases; IncludeClosedCases)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Closed Cases';
                        ToolTip = 'Specifies whether to include closed cases.';
                    }
                    field(ShowHearingDetails; ShowHearingDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Hearing Details';
                        ToolTip = 'Specifies whether to show court hearing details.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Litigation Overview Report';
        FilterString := "Legal Case".GetFilters();
        
        if not IncludeClosedCases then
            "Legal Case".SetFilter("Case Status", '<>%1', "Legal Case"."Case Status"::Closed);
            
        // Initialize counters
        Clear(TotalCases);
        Clear(OpenCases);
        Clear(InProgressCases);
        Clear(ClosedCases);
        Clear(SettledCases);
        Clear(TotalClaimedAmount);
        Clear(TotalSettlementAmount);
        Clear(TotalLegalCosts);
    end;
    
    var
        ReportTitle: Text[100];
        FilterString: Text;
        IncludeClosedCases: Boolean;
        ShowHearingDetails: Boolean;
        TotalCases: Integer;
        OpenCases: Integer;
        InProgressCases: Integer;
        ClosedCases: Integer;
        SettledCases: Integer;
        TotalClaimedAmount: Decimal;
        TotalSettlementAmount: Decimal;
        TotalLegalCosts: Decimal;
}