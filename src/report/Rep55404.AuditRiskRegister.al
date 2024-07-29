report 55404 "Audit Risk Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Audit/Report/SSR/AuditRiskRegister.rdl';

    dataset
    {
        dataitem(DataItem1; "AUDIT-Risk Analysis Header")
        {
            column(No_AUDITRiskAnalysisHeader; No)
            {
            }
            column(Date_AUDITRiskAnalysisHeader; Date)
            {
            }
            column(DepartmantName_AUDITRiskAnalysisHeader; "Departmant Name")
            {
            }
            column(Session_AUDITRiskAnalysisHeader; Session)
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
            /* column(AcademicYear_AUDITRiskAnalysisHeader; "Academic Year")
            {
            } */
            column(CreatedBy_AUDITRiskAnalysisHeader; "Created By")
            {
            }
            column(CreatedOn_AUDITRiskAnalysisHeader; "Created On")
            {
            }
            column(Risks_AUDITRiskAnalysisHeader; Risks)
            {
            }
            column(Causes_AUDITRiskAnalysisHeader; Causes)
            {
            }
            column(Implications_AUDITRiskAnalysisHeader; Implications)
            {
            }
            column(RiskAction_AUDITRiskAnalysisHeader; "Risk Action")
            {
            }
            column(ResponsiblePersons_AUDITRiskAnalysisHeader; "Responsible Persons")
            {
            }
            column(Process_AUDITRiskAnalysisHeader; Process)
            {
            }
            /*  column(DepartmentName2_AUDITRiskAnalysisHeader; "Department Name2")
             {
             } */
            column(ResponsiblePersonsName_AUDITRiskAnalysisHeader; "Responsible Persons Name")
            {
            }
            column(PriorityLevel_AUDITRiskAnalysisHeader; "Priority Level")
            {
            }
            column(status_AUDITRiskAnalysisHeader; status)
            {
            }
            column(NoSeries_AUDITRiskAnalysisHeader; "No Series")
            {
            }
            column(BudgetPeriod_AUDITRiskAnalysisHeader; "Budget Period")
            {
            }
        }
        dataitem(DataItem12; "AUDIT-Risk Analysis Header")
        {
            //DataItemLink = "Risk Code" = FIELD(No);
            PrintOnlyIfDetail = true;
            column(Risk_caueses_Description; "Audit-Risk Causes".Description)
            {
            }
        }
        dataitem(DataItem26; "Audit Risk Actions")
        {
            PrintOnlyIfDetail = true;
            column(Risk_Treatment; "Risk Treatment")
            {
            }
            column(Rist_Action; "Risk Action")
            {
            }
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

    var
        "Audit-Risk Causes": Record "Audit-Risk Causes";
}

