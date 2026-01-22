report 50777 "Students with Supervisors"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StudentsWithSupervisors.rdl';

    dataset
    {
        dataitem("Postgraduate Student"; "Customer")
        {
            DataItemTableView = where("Supervisor No." = filter(<> ''));

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
            column(SupervisorName; SupervisorName)
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
        SupervisorName: Text[100];

    trigger OnPreReport()
    begin
    end;

}