/// <summary>
/// Report Appraisal Report (ID 50014).
/// </summary>
report 50173 "Appraisal Report"
{
    RDLCLayout = './Layouts/Appraisal report.rdl';
    DefaultLayout = rdlc;
    dataset
    {
        dataitem(Appraisal; Appraisal)
        {

            column(AppraisalNo_Appraisal; "Appraisal No")
            {
            }
            column(EmployeeCode_Appraisal; "Employee Code")
            {
            }
            column(EmployeeName_Appraisal; "Employee Name")
            {
            }

            column(GlobalDimension2Code_Appraisal; "Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_Appraisal; "Shortcut Dimension 3 Code")
            {
            }

            column(Designation_Appraisal; Designation)
            {
            }
            column(JobGrade_Appraisal; "Job Grade")
            {
            }
            column(JobTitle_Appraisal; "Job Title")
            {
            }
            column(Period_Appraisal; Period)
            {
            }
            column(Rating_Appraisal; Rating)
            {
            }
            column(RequiredTraining_Appraisal; "Required Training")
            {
            }
            column(ResponseScale_Appraisal; "Response Scale")
            {
            }
            column(SelfAssement_Appraisal; "Self Assement")
            {
            }

            column(HeadofDirectorate_Appraisal; "Head of Department")
            {
            }
            column(PerfomanceGap_Appraisal; "Perfomance Gap")
            {
            }
            column(SupervisorDesignation_Appraisal; "Supervisor Designation")
            {
            }
            column(SupervisorName_Appraisal; "Supervisor Name")
            {
            }
            column(SupervisorNo_Appraisal; "Supervisor No")
            {
            }
            column(SupervisorsComment_Appraisal; "Supervisors Comment")
            {
            }
            column(TermsofService_Appraisal; "Terms of Service")
            {
            }
            column(Timeline_Appraisal; Timeline)
            {
            }
            column(compinfopic; compinfo.Picture)
            {

            }
            column(compinfoname; compinfo.Name)
            {

            }
            column(compinfophone; compinfo."Phone No.")
            {

            }
            column(compinfoaddress; compinfo.Address)
            {

            }
            column(compinfoemail; compinfo."E-Mail")
            {

            }
            column(compinfowebpage; compinfo."Home Page")
            {

            }

            dataitem("Targets kra kpi"; "Targets kra kpi")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No"), "Employee No" = field("Employee Code");
                column(TargetScore_Targetskrakpi; "Target Score")
                {
                }

                column(AchievedOutcome_Targetskrakpi; "Achieved Outcome")
                {
                }
                column(Activity_Targetskrakpi; Activity)
                {
                }
                column(KPIs_Targetskrakpi; KPIs)
                {
                }
                column(KRA_Targetskrakpi; KRA)
                {
                }
                column(Period_Targetskrakpi; Period)
                {
                }
                column(Rating_Targetskrakpi; Rating)
                {
                }
                column(SelfAccess_Targetskrakpi; "Self Access")
                {
                }
                column(StrategicObjectives_Targetskrakpi; "Strategic Objectives")
                {
                }
                column(SupervisorAccess_Targetskrakpi; "Supervisor Access")
                {
                }
                column(Timeline_Targetskrakpi; Timeline)
                {
                }
                column(Timelines_Targetskrakpi; Timelines)
                {
                }
            }
            dataitem("Perfomance Review"; "Perfomance Review")
            {
                DataItemLink = "Appraisal No" = field("Employee Code");
                column(AgreedTargets_PerfomanceReview; "Agreed Targets")
                {
                }
                column(ChangedTargets_PerfomanceReview; "Changed Targets")
                {
                }
                column(Code_PerfomanceReview; "Code")
                {
                }
                column(KPIs_PerfomanceReview; KPIs)
                {
                }
                column(Levelofachievement_PerfomanceReview; "Level of achievement")
                {
                }
                column(Period_PerfomanceReview; Period)
                {
                }
                column(ReviewPeriod_PerfomanceReview; "Review Period")
                {
                }
            }
            dataitem("Employee Core Values"; "Employee Core Values")
            {
                DataItemLink = "Employee No" = field("Employee Code"), "Appraisal No" = field("Appraisal No"), Period = field(Period);
                column(Code_EmployeeCoreValues; "Code")
                {
                }
                column(Description_EmployeeCoreValues; Description)
                {
                }
                column(SelfAssement_EmployeeCoreValues; "Self Assement")
                {
                }
                column(SupervisorsComment_EmployeeCoreValues; "Supervisors Comment")
                {
                }
                column(ResponseScale_EmployeeCoreValues; "Response Scale")
                {
                }
                column(Rating_EmployeeCoreValues; Rating)
                {
                }
            }

        }
    }
    trigger OnPreReport()
    begin
        compinfo.get;
        compinfo.CalcFields(picture)
    end;

    var
        compinfo: record "Company Information";

}
