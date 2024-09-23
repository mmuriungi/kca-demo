report 50779 "Students by Study Stage"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StudentsByStudyStage.rdl';

    dataset
    {
        dataitem("Postgraduate Student"; "Customer")
        {

            column(Student_No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Program_Code; Programme)
            {
            }
            column(Department_Code; "Global Dimension 2 Code")
            {
            }
            column(School_Code; "Global Dimension 1 Code")
            {
            }
            column(Supervisor_Code; "Supervisor No.")
            {
            }
            column(SupervisorName; "Supervisor Name")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {

                }
            }
        }
    }

    var
        ProgramFilter: Code[20];
        DepartmentFilter: Code[20];
        SchoolFilter: Code[20];
        StudyStageFilter: Option " ",Coursework,"Concept Paper",Thesis,Completed;
}
