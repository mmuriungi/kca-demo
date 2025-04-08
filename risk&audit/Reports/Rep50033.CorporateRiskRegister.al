report 50033 "Corporate Risk Register Report"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Corporate Risk Register.rdl';
    dataset
    {
        dataitem(RiskHeader; "Risk Header")
        {
            RequestFilterFields = "No.", "Station Code", "Risk Category", "Risk Description2";
            DataItemTableView = where("Document Status" = const("Risk Manager"));
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
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
            column(Additionalmitigationcontrols; "Additional mitigation controls")
            {
            }
            column(AssessmentDate; "Assessment Date")
            {
            }
            column(AuditPeriod; "Audit Period")
            {
            }
            column(Auditor; Auditor)
            {
            }
            column(AuditorEmail; "Auditor Email")
            {
            }
            column(AuditorName; "Auditor Name")
            {
            }
            column(Comment; Comment)
            {
            }
            column(ConsolidatetoHQ; "Consolidate to HQ")
            {
            }
            column(ConsolidateionDate; "Consolidateion Date")
            {
            }
            column(ControlEvaluationImpact; "Control Evaluation Impact")
            {
            }
            column(ControlEvaluationLikelihood; "Control Evaluation Likelihood")
            {
            }
            column(ControlRAGStatus; "Control RAG Status")
            {
            }
            column(ControlRiskLI; "Control Risk (L * I)")
            {
            }
            column(ControlRiskImpact; "Control Risk Impact")
            {
            }
            column(ControlRiskLikelihood; "Control Risk Likelihood")
            {
            }
            column(ControlRiskProbability; "Control Risk Probability")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(CurrentDisposal; "Current Disposal")
            {
            }
            column(CurrentPlan; "Current Plan")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(DateIdentified; "Date Identified")
            {
            }
            column(DocumentStatus; "Document Status")
            {
            }
            column(EmployeeEmail; "Employee Email")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(ExistingRiskControls; "Existing Risk Controls")
            {
            }
            column(HODUserID; "HOD User ID")
            {
            }
            column(LinkedIncident; "Linked Incident")
            {
            }
            column(LinkedIncidentDescription; "Linked Incident Description")
            {
            }
            column(MarkOkay; "Mark Okay")
            {
            }
            column(MitigationOwner; "Mitigation Owner")
            {
            }
            column(MitigationSuggestions; "Mitigation Suggestions")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PlanType; "Plan Type")
            {
            }
            column(ProjectCode; "Project Code")
            {
            }
            column(RAGStatus; "RAG Status")
            {
            }
            column(Rejected; Rejected)
            {
            }
            column(RejectionReason; "Rejection Reason")
            {
            }
            column(ResidualLikelihoodImpact; "Residual Likelihood Impact")
            {
            }
            column(ResidualRAGStatus; "Residual RAG Status")
            {
            }
            column(ResidualRiskLI; "Residual Risk (L * I)")
            {
            }
            column(ResidualRiskImpact; "Residual Risk Impact")
            {
            }
            column(ResidualRiskLikelihood; "Residual Risk Likelihood")
            {
            }
            column(ResidualRiskLikelihoodCat; "Residual Risk Likelihood Cat")
            {
            }
            column(ResidualValue; "Residual Value")
            {
            }
            column(ReviewDate; "Review Date")
            {
            }
            column(RiskLI; "Risk (L * I)")
            {
            }
            column(RiskAcceptanceDecision; "Risk Acceptance Decision")
            {
            }
            column(RiskArea; "Risk Area")
            {
            }
            column(RiskCategory; "Risk Category")
            {
            }
            column(RiskCategoryDescription; "Risk Category Description")
            {
            }
            column(RiskDepartment; "Risk Department")
            {
            }
            column(RiskDepartmentDescription; "Risk Department Description")
            {
            }
            column(RiskDescription; "Risk Description")
            {
            }
            column(RiskDescription2; "Risk Description2")
            {
            }
            column(RiskImpact; "Risk Impact")
            {
            }
            column(RiskImpactValue; "Risk Impact Value")
            {
            }
            column(RiskLikelihood; "Risk Likelihood")
            {
            }
            column(RiskLikelihoodValue; "Risk Likelihood Value")
            {
            }
            column(RiskOpportunityAssessment; "Risk Opportunity Assessment")
            {
            }
            column(RiskProbability; "Risk Probability")
            {
            }
            column(RiskRegion; "Risk Region")
            {
            }
            column(RiskRegionName; "Risk Region Name")
            {
            }
            column(RiskResponse; "Risk Response")
            {
            }
            column(RiskResult; "Risk Result")
            {
            }
            column(RiskType; "Risk Type")
            {
            }
            column(RiskTypeDescription; "Risk Type Description")
            {
            }
            column(RootCauseAnalysis; "Root Cause Analysis")
            {
            }
            column(SenttoHQ; "Sent to HQ")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(StationCode; "Station Code")
            {
            }
            column(Status; Status)
            {
            }
            column(Submission; Submission)
            {
            }

            column(TotalCount; "Total Count")
            {
            }
            column(Type; "Type")
            {
            }
            column(ValueafterControl; "Value after Control")
            {
            }
            column(ValueatRisk; "Value at Risk")
            {
            }
            dataitem("Risk Details"; "Risk Details")
            {
                DataItemLink = "Risk No." = field("No.");
                column(Risk_Category; "Risk Category")
                { }
                column(Risk_Category_Description; "Risk Category Description")
                { }
                column("Risk_Type"; "Risk Type")
                {


                }
                column("Risk_Type_Description"; "Risk Type Description")
                {


                }
                column("Risk_Descriptions"; "Risk Descriptions")
                {


                }
                column("Risk_Likelihood"; "Risk Likelihood")
                {
                }
                column("Risk_Likelihood_Value"; "Risk Likelihood Value")
                {


                }
                column("Risk_Rating"; "Risk Rating")
                {


                }
                column("Risk_Impact"; "Risk Impact")
                {

                }
                column("Risk_Impact_Value"; "Risk Impact Value")
                {


                }

                column("Gross_Risk_Score"; "Risk (L * I)")
                {

                    //applicationmethod(SetCellColor);
                }

                column("To_Consolidate"; "To Consolidate")
                {
                }
                dataitem("Causes & Effects2"; "Causes & Effects2")
                {
                    DataItemLink = "Risk Details Line" = field("Risk Details Line");
                    column(Causes; Causes)
                    { }
                    column(Effects; Effects)
                    { }
                    column(Opportunity__identify_; "Opportunity (identify)")
                    { }
                    dataitem(Treatment; Treatment)
                    {
                        DataItemLink = "Entry No" = field("Entry No");
                        column(Treatment__risk_champion_suggestions_; "Treatment (risk champion suggestions)")
                        { }
                        column(Action_points__risk_owner_in_point_form__To_have_a_treatment_action_plan_on_the_side; "Action points (risk owner in point form) To have a treatment action plan on the side")
                        { }
                        column(Areas_to_review__risk_champion__evidences; "Areas to review (risk champion)-evidences")
                        { }
                        column(Entry_No_; "Entry No.")
                        { }
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    SetCellColor();
                end;
            }
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

    procedure SetCellColor()
    var

    begin
        if "Risk Details"."Risk (L * I)" <= 4.4 then
            StyleExprTxt := 'Favorable'
        else
            if ("Risk Details"."Risk (L * I)" = 4.5) or ("Risk Details"."Risk (L * I)" <= 14.4) then
                StyleExprTxt := 'Ambiguous'
            else
                if ("Risk Details"."Risk (L * I)" = 14.5) or ("Risk Details"."Risk (L * I)" <= 25) then
                    StyleExprTxt := 'unfavorable'
                else
                    StyleExprTxt := '';
    end;

    // procedure OnDataPre(report: Report "Corporate Risk Register Report")
    // var
    //     grossRiskScore: Decimal;
    // begin
    //     if report.Table.HasField('Gross_Risk_Score') then begin
    //         grossRiskScore := report.Table.GetValue('Gross_Risk_Score');
    //         if grossRiskScore <= 4.4 then
    //             report.Table.SetStyle('Color', Green)
    //         else
    //         if grossRiskScore <= 14.4 then
    //             report.Table.SetStyle('Color', Yellow)
    //         else
    //         report.Table.SetStyle('Color', Red);
    //     end;
    // end;


    var
        CompanyInfo: Record "Company Information";
        StyleExprTxt: Text;
        grossRiskScore: Decimal;

}
