report 50776 "Graduated Students"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GraduatedStudents.rdl';

    dataset
    {
        dataitem("Postgraduate Student"; "Customer")
        {
            // DataItemTableView = where("Study Stage" = const(Completed));

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
            column(Admission_Date; "Admission Date")
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

    trigger OnPreReport()
    begin
       
    end;
}