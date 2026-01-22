report 50762 "Audit Risk Details Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AuditRiskDetailsReport.rdl';

    dataset
    {
        dataitem(DataItem1; "AUDIT-Risk Analysis Header")
        {
            RequestFilterFields = No;
            column(No_AUDITRiskAnalysisHeader; No)
            {
            }
            column(Date_AUDITRiskAnalysisHeader; Date)
            {
            }
            column(DepartmantName_AUDITRiskAnalysisHeader; "Departmant Name")
            {
            }
            column(Likelihood_AUDITRiskAnalysisHeader; Likelihood)
            {
            }
            column(Impact_AUDITRiskAnalysisHeader; Impact)
            {
            }
            column(OverallRating_AUDITRiskAnalysisHeader; "Overall Rating")
            {
            }

            column(ResponsiblePersonsName_AUDITRiskAnalysisHeader; "Responsible Persons Name")
            {
            }
            column(Process_AUDITRiskAnalysisHeader; Process)
            {
            }
            column(status_AUDITRiskAnalysisHeader; status)
            {
            }
            column(BudgetPeriod_AUDITRiskAnalysisHeader; "Budget Period")
            {
            }
            column(Risks_AUDITRiskAnalysisHeader; Risks)
            {
            }
            column(departmentName; departmentName)
            {
            }
            dataitem(DataItem12; "Audit-Risk Causes")
            {
                DataItemLink = "Risk Code" = FIELD(No);
                //DataItemLinkReference = "AUDIT-Risk Analysis Header";
                column(RiskCode_AuditRiskCauses; "Risk Code")
                {
                }
                column(Title_AuditRiskCauses; Title)
                {
                }
                column(Description_AuditRiskCauses; Description)
                {
                }
                column(causesCount; causesCount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    causesCount := causesCount + 1;
                end;
            }
            dataitem(DataItem16; "Audit Risk Impacts")
            {
                DataItemLink = "Risk Code" = FIELD(No);
                column(Title_AuditRiskImpacts; Title)
                {
                }
                column(Description_AuditRiskImpacts; Description)
                {
                }
                column(impactsCount; impactsCount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    impactsCount := impactsCount + 1;
                end;
            }
            dataitem(DataItem19; "Audit Risk Actions")
            {
                DataItemLink = "Risk Code" = FIELD(NO);
                column(RiskTreatment_AuditRiskActions; "Risk Treatment")
                {
                }
                column(RiskAction_AuditRiskActions; "Risk Action")
                {
                }
                column(actionsCount; actionsCount)
                {
                }
                dataitem(DataItem22; "Audit-Risk Treatment Act. Step")
                {
                    DataItemLink = "Risk Code" = FIELD("Risk Code");
                    column(RiskTreatmentAction_AuditRiskTreatmentActStep; "Risk Treatment Action")
                    {
                    }
                    column(Verified_AuditRiskTreatmentActStep; Verified)
                    {
                    }
                    column(VerifiedDate_AuditRiskTreatmentActStep; "Verified Date")
                    {
                    }
                    column(VerifiedBy_AuditRiskTreatmentActStep; "Verified By")
                    {
                    }
                    column(Remarks_AuditRiskTreatmentActStep; Remarks)
                    {
                    }
                    column(TreatmentCode_AuditRiskTreatmentActStep; TreatmentCode)
                    {
                    }
                    column(BudgetedAmount_AuditRiskTreatmentActStep; "Budgeted Amount")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    actionsCount := actionsCount + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                DimensionValue.RESET;
                DimensionValue.SETFILTER(Code, "Departmant Name");
                IF DimensionValue.FINDFIRST THEN
                    departmentName := DimensionValue.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        causesCount := 0;
    end;

    var
        causesCount: Integer;
        impactsCount: Integer;
        actionsCount: Integer;
        stepsCount: Integer;
        DimensionValue: Record 349;
        departmentName: Text;
    // "AUDIT-Risk Analysis Header": Record "AUDIT-Risk Analysis Header";
}

