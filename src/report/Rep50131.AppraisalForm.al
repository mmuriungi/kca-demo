report 50131 "Appraisal Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Appraisal Form.rdl';

    dataset
    {
        dataitem("HRM-Employee Appraisals"; "HRM-Employee Appraisals")
        {
            DataItemTableView = SORTING("Employee No", "Appraisal Type", "Appraisal Period");
            RequestFilterFields = "Employee No", "Appraisal Type", "Appraisal Period";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }

            column(USERID; UserId)
            {
            }
            column(Employee_Appraisals__Employee_No_; "Employee No")
            {
            }
            column(Employee_Appraisals__Appraisal_Type_; "Appraisal Type")
            {
            }
            column(Employee_Appraisals__Appraisal_Period_; "Appraisal Period")
            {
            }
            column(Employee_Appraisals__No__Supervised__Directly__; "No. Supervised (Directly)")
            {
            }
            column(Employee_Appraisals__No__Supervised__In_Directly__; "No. Supervised (In-Directly)")
            {
            }
            column(Employee__First_Name__________Employee__Middle_Name__________Employee__Last_Name_; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
            {
            }
            column(Employee__Department_Code_; Employee."Department Code")
            {
            }
            column(Jobs_Grade; Jobs.Grade)
            {
            }
            column(Employee__Job_Title_; Employee."Job Title")
            {
            }
            column(Jobs_Objective; Jobs.Objective)
            {
            }
            column(Jobs__Job_Description_; Jobs."Job Description")
            {
            }
            column(Employee__Date_Of_Join_; Employee."Date Of Join")
            {
            }
            column(Employee_Appraisals__Agreement_With_Rating_; "Agreement With Rating")
            {
            }
            column(Employee_Appraisals__General_Comments_; "General Comments")
            {
            }
            column(Employee_Appraisals_Date; Date)
            {
            }
            column(Employee_AppraisalsCaption; Employee_AppraisalsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Appraisals__Employee_No_Caption; FieldCaption("Employee No"))
            {
            }
            column(Employee_Appraisals__Appraisal_Type_Caption; FieldCaption("Appraisal Type"))
            {
            }
            column(Employee_Appraisals__Appraisal_Period_Caption; FieldCaption("Appraisal Period"))
            {
            }
            column(Employee_Appraisals__No__Supervised__Directly__Caption; FieldCaption("No. Supervised (Directly)"))
            {
            }
            column(Employee_Appraisals__No__Supervised__In_Directly__Caption; FieldCaption("No. Supervised (In-Directly)"))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(Job_TitleCaption; Job_TitleCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Position_FunctionCaption; Position_FunctionCaptionLbl)
            {
            }
            column(Date_EmployedCaption; Date_EmployedCaptionLbl)
            {
            }
            column(Job_PositionCaption; Job_PositionCaptionLbl)
            {
            }
            column(Key_ResponsibilitiesCaption; Key_ResponsibilitiesCaptionLbl)
            {
            }
            column(Staff_Member_Review__Part_3___Review_of_Ratings_Assesment_By_Supervisor_Caption; Staff_Member_Review__Part_3___Review_of_Ratings_Assesment_By_Supervisor_CaptionLbl)
            {
            }
            column(Agreement_With_Rating_Caption; Agreement_With_Rating_CaptionLbl)
            {
            }
            column(General_Comments_Caption; General_Comments_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Employee_Appraisals_Job_ID; "Job ID")
            {
            }
            dataitem("HRM-Job Responsiblities"; "HRM-Job Responsiblities")
            {
                DataItemLink = "Job ID" = FIELD("Job ID");
                column(Job_Responsiblities_Responsibility; Responsibility)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(Job_Responsiblities_Job_ID; "Job ID")
                {
                }
            }
            dataitem("HRM-Performance Plan"; "HRM-Performance Plan")
            {
                DataItemLink = "Employee No" = FIELD("Employee No"), "Appraisal Type" = FIELD("Appraisal Type"), "Appraisal Period" = FIELD("Appraisal Period");
                column(Performance_Plan__Key_Responsibility_; "Key Responsibility")
                {
                }
                column(Performance_Plan__No__; "No.")
                {
                }
                column(Performance_Plan__Key_Indicators_; "Key Indicators")
                {
                }
                column(Performance_Plan__Agreed_Target_Date_; "Agreed Target Date")
                {
                }
                column(Performance_Plan_Weighting; Weighting)
                {
                }
                column(Performance_Plan__Results_Achieved_Comments_; "Results Achieved Comments")
                {
                }
                column(Performance_Plan__Score_Points_; "Score/Points")
                {
                }
                column(Perofrmance_Plan__Part_1___Agreed_Key_indicators_Caption; Perofrmance_Plan__Part_1___Agreed_Key_indicators_CaptionLbl)
                {
                }
                column(Performance_Plan__Key_Responsibility_Caption; FieldCaption("Key Responsibility"))
                {
                }
                column(Performance_Plan__No__Caption; FieldCaption("No."))
                {
                }
                column(Performance_Plan__Key_Indicators_Caption; FieldCaption("Key Indicators"))
                {
                }
                column(Performance_Plan__Agreed_Target_Date_Caption; FieldCaption("Agreed Target Date"))
                {
                }
                column(Performance_Plan_WeightingCaption; FieldCaption(Weighting))
                {
                }
                column(Performance_Plan__Results_Achieved_Comments_Caption; FieldCaption("Results Achieved Comments"))
                {
                }
                column(Score__PointsCaption; Score__PointsCaptionLbl)
                {
                }
                column(Performance_Plan_Employee_No; "Employee No")
                {
                }
                column(Performance_Plan_Appraisal_Type; "Appraisal Type")
                {
                }
                column(Performance_Plan_Appraisal_Period; "Appraisal Period")
                {
                }
                column(Performance_Plan_Job_ID; "Job ID")
                {
                }
            }
            dataitem("HRM-Career Developement Plan"; "HRM-Career Developement Plan")
            {
                DataItemLink = "Employee No" = FIELD("Employee No"), "Appraisal Type" = FIELD("Appraisal Type"), "Appraisal Period" = FIELD("Appraisal Period"), "Job ID" = FIELD("Job ID");
                column(Career_Developement_Plan_Type; Type)
                {
                }
                column(Career_Developement_Plan_Description; Description)
                {
                }
                column(Career_Developement_Plan_Remarks; Remarks)
                {
                }
                column(Career_Development_Plan__Part_2___To_be_extablished_by_both_officer_and_supervisor_Caption; Career_Development_Plan__Part_2___To_be_extablished_by_both_officer_and_supervisor_CaptionLbl)
                {
                }
                column(Career_Developement_Plan_TypeCaption; FieldCaption(Type))
                {
                }
                column(Career_Developement_Plan_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Career_Developement_Plan_RemarksCaption; FieldCaption(Remarks))
                {
                }
                column(Career_Developement_Plan_Employee_No; "Employee No")
                {
                }
                column(Career_Developement_Plan_Appraisal_Type; "Appraisal Type")
                {
                }
                column(Career_Developement_Plan_Appraisal_Period; "Appraisal Period")
                {
                }
                column(Career_Developement_Plan_Job_ID; "Job ID")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if Employee.Get("HRM-Employee Appraisals"."Employee No") then
                    Jobs.Get(Employee.Position)
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

    var
        Employee: Record "HRM-Employee C";
        Jobs: Record "HRM-Company Jobs";
        Employee_AppraisalsCaptionLbl: Label 'Employee Appraisals';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NamesCaptionLbl: Label 'Names';
        DepartmentCaptionLbl: Label 'Department';
        Job_TitleCaptionLbl: Label 'Job Title';
        GradeCaptionLbl: Label 'Grade';
        Position_FunctionCaptionLbl: Label 'Position Function';
        Date_EmployedCaptionLbl: Label 'Date Employed';
        Job_PositionCaptionLbl: Label 'Job Position';
        Key_ResponsibilitiesCaptionLbl: Label 'Key Responsibilities';
        Staff_Member_Review__Part_3___Review_of_Ratings_Assesment_By_Supervisor_CaptionLbl: Label 'Staff Member Review (Part 3 - Review of Ratings/Assesment By Supervisor)';
        Agreement_With_Rating_CaptionLbl: Label 'Agreement With Rating:';
        General_Comments_CaptionLbl: Label 'General Comments:';
        Date_CaptionLbl: Label 'Date:';
        EmptyStringCaptionLbl: Label '-';
        Perofrmance_Plan__Part_1___Agreed_Key_indicators_CaptionLbl: Label 'Perofrmance Plan (Part 1 - Agreed Key indicators)';
        Score__PointsCaptionLbl: Label 'Score/ Points';
        Career_Development_Plan__Part_2___To_be_extablished_by_both_officer_and_supervisor_CaptionLbl: Label 'Career Development Plan (Part 2 - To be extablished by both officer and supervisor)';
}

