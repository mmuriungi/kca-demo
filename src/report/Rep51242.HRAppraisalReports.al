report 51242 "HR Appraisal Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HR Appraisal Reports.rdl';

    dataset
    {
        dataitem("HRM-Appraisal Goal Setting H"; "HRM-Appraisal Goal Setting H")
        {
            column(AppraisalStage_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Appraisal Stage")
            {
            }
            column(JobTitle_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Job Title")
            {
            }
            column(EmployeeNo_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Employee No")
            {
            }
            column(EmployeeName_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Employee Name")
            {
            }
            column(AppraisalNo_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Appraisal No")
            {
            }
            column(Supervisor_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H".Supervisor)
            {
            }
            column(AppraisalType_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Appraisal Type")
            {
            }
            column(Sent_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H".Sent)
            {
            }
            column(AppraisalPeriod_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H"."Appraisal Period")
            {
            }
            column(Status_HRAppraisalGoalSettingH; "HRM-Appraisal Goal Setting H".Status)
            {
            }
            dataitem("HRM-Appraisal Goal Setting L"; "HRM-Appraisal Goal Setting L")
            {
                DataItemLink = "Appraisal No" = FIELD("Appraisal No");
                column(MsrmentCriteriaTargetDate_HRAppraisalGoalSettingL; "HRM-Appraisal Goal Setting L"."Criteria/Target Date")
                {
                }
                column(PlannedTargetsObjectives_HRAppraisalGoalSettingL; "HRM-Appraisal Goal Setting L"."Planned Targets/Objectives")
                {
                }
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
}

