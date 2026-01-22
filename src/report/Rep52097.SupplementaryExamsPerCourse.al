report 52097 "Supplementary Exams Per Course"
{
    Caption = 'Supplementary Exams Per Course';
    DefaultLayout = Word;
    WordLayout = './Layouts/SupplementaryExamsPerCourse.docx';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Aca-Special Exams Details"; "Aca-Special Exams Details")
        {
            RequestFilterFields = Programme, "Unit Code", "Current Semester";
            DataItemTableView = sorting(Programme, "Unit Code") where(Category = const(Supplementary), Status = const(Approved));
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(UnitDescription; "Unit Description")
            {
            }
            column(Stage; Stage)
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(StudentName; StudentName)
            {
            }
            column(Status; Status)
            {
            }
            column(Programme; Programme)
            {
            }
            column(StatusText; Format(Status))
            {
            }
            column(ChargePosted; "Charge Posted")
            {
            }
            column(CostPerExam; "Cost Per Exam")
            {
            }
            column(ExamMarks; "Exam Marks")
            {
            }
            column(TotalMarks; "Total Marks")
            {
            }
            column(Grade; Grade)
            {
            }
            column(CurrentAcademicYear; "Current Academic Year")
            {
            }
            column(CurrentSemester; "Current Semester")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Customer.Get("Student No.") then
                    StudentName := Customer.Name
                else
                    StudentName := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {

            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        StudentName: Text[100];
        SecondStudentName: Text[100];
        SchoolName: Text[100];
        DepartmentName: Text[100];
        ReportTitle: Text[100];
}
