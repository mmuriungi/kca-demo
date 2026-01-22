report 52179071 "Risk Heat Map Report"
{
    Caption = 'Risk Heat Map Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Risk/Reports/RiskHeatMap.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(RiskRegister; "Risk Register")
        {
            RequestFilterFields = "Risk Category", "Department Code", "Risk Type";
            
            column(RiskID; "Risk ID") { }
            column(RiskTitle; "Risk Title") { }
            column(RiskCategory; "Risk Category") { }
            column(DepartmentCode; "Department Code") { }
            column(InherentLikelihood; "Inherent Likelihood") { }
            column(InherentImpact; "Inherent Impact") { }
            column(InherentRating; "Inherent Rating") { }
            column(InherentRiskLevel; "Inherent Risk Level") { }
            column(ResidualLikelihood; "Residual Likelihood") { }
            column(ResidualImpact; "Residual Impact") { }
            column(ResidualRating; "Residual Rating") { }
            column(ResidualRiskLevel; "Residual Risk Level") { }
            column(TreatmentStrategy; "Treatment Strategy") { }
            column(RiskOwner; "Risk Owner") { }
            column(Status; Status) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'Risk Heat Map Report') { }
            column(ReportDate; Today) { }
            column(UserName; UserId) { }
            
            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowInherentRisk; ShowInherentRisk)
                    {
                        Caption = 'Show Inherent Risk';
                        ApplicationArea = All;
                    }
                    field(ShowResidualRisk; ShowResidualRisk)
                    {
                        Caption = 'Show Residual Risk';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    
    var
        CompanyInfo: Record "Company Information";
        ShowInherentRisk: Boolean;
        ShowResidualRisk: Boolean;
}