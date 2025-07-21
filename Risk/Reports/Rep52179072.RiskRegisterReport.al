report 52179072 "Risk Register Report"
{
    Caption = 'Risk Register Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Risk/Reports/RiskRegister.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(RiskRegister; "Risk Register")
        {
            RequestFilterFields = "Risk Category", "Department Code", "Risk Type", Status;
            
            column(RiskID; "Risk ID") { }
            column(RiskTitle; "Risk Title") { }
            column(RiskDescription; "Risk Description") { }
            column(RiskCause; "Risk Cause") { }
            column(RiskEffects; "Risk Effects") { }
            column(RiskCategory; "Risk Category") { }
            column(RiskType; "Risk Type") { }
            column(DepartmentCode; "Department Code") { }
            column(FunctionCode; "Function Code") { }
            column(StrategicPillar; "Strategic Pillar") { }
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
            column(RiskAppetite; "Risk Appetite") { }
            column(RiskTolerance; "Risk Tolerance") { }
            column(LastReviewDate; "Last Review Date") { }
            column(NextReviewDate; "Next Review Date") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'Risk Register Report') { }
            column(ReportDate; Today) { }
            column(UserName; UserId) { }
            column(MitigationCount; MitigationCount) { }
            column(IncidentCount; IncidentCount) { }
            
            trigger OnAfterGetRecord()
            begin
                CalculateCounts();
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
                    field(IncludeMitigationCount; IncludeMitigationCount)
                    {
                        Caption = 'Include Mitigation Count';
                        ApplicationArea = All;
                    }
                    field(IncludeIncidentCount; IncludeIncidentCount)
                    {
                        Caption = 'Include Incident Count';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;
    
    var
        CompanyInfo: Record "Company Information";
        RiskMitigation: Record "Risk Mitigation";
        RiskIncident: Record "Risk Incident";
        IncludeMitigationCount: Boolean;
        IncludeIncidentCount: Boolean;
        MitigationCount: Integer;
        IncidentCount: Integer;
    
    local procedure CalculateCounts()
    begin
        MitigationCount := 0;
        IncidentCount := 0;
        
        if IncludeMitigationCount then begin
            RiskMitigation.SetRange("Risk ID", RiskRegister."Risk ID");
            MitigationCount := RiskMitigation.Count();
        end;
        
        if IncludeIncidentCount then begin
            RiskIncident.SetRange("Related Risk ID", RiskRegister."Risk ID");
            IncidentCount := RiskIncident.Count();
        end;
    end;
}