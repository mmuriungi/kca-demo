report 50812 "Audit Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Audit Report.rdl';
    dataset
    {
        dataitem(AuditReport; "Audit Report")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            //
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(EXECUTIVESUMMARY; "1.0 EXECUTIVE SUMMARY")
            {
            }
            column(Introductions; "1.1 Introduction")
            {
            }
            column(AuditFindingsinDetailandRecommendations; "1.10 Audit Findings in Detail and Recommendations")
            {
            }
            column(Favorable; "1.11 Favorable")
            {
            }
            column(UnfavorabletohaveListandtheirnarrationRecommendationandManagementResponse; "1.12 Unfavorable – to have List, and their narration Recommendation and Management Response")
            {
            }
            column(Conclusions; "1.13 Conclusion")
            {
            }
            column(Riskscorelistriskindicatelikelihoodimpactandgetoverallrisk; "1.14 Risk score – list risk, indicate likelihood, impact and get overall risk")
            {
            }
            column(SummaryofFindings; "1.2 Summary of Findings")
            {
            }
            column(Conclusion; "1.3 Conclusion")
            {
            }
            column(Introduction; "1.4 Introduction")
            {
            }
            column(Participants; "1.5 Participants")
            {
            }
            column(Thescopeoftheassignment; "1.6 The scope of the assignment")
            {
            }
            column(Objectives; "1.7 Objectives")
            {
            }
            column(GeneralObjective; "1.8 General Objective")
            {
            }
            column(SpecificObjectives; "1.9 Specific Objectives")
            {
            }
            column(AuditReportNo; "Audit Report No")
            {
            }
            column(NoSeries; "No.Series")
            {
            }
            trigger OnAfterGetRecord()
            begin
             
            end;


        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        InstrD2: InStream;
        DNotesD2: BigText;
        DNotesTextD2: Text;
        OutStrD2: OutStream;

  

}
