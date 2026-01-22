report 50778 "Students Qualified to Graduate"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StudentsQualifiedToGraduate.rdl';

    dataset
    {
        dataitem("Postgraduate Student"; "Customer")
        {
            // DataItemTableView = where("Study Stage" = const(Thesis));


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
            column(ThesisApproved; ThesisApproved)
            {
            }
        }
    }

    var
        ThesisApproved: Boolean;
}
