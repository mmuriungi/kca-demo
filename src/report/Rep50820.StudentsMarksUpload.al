report 50820 "Students Marks Upload"
{
    Caption = 'Students Marks Upload';
    DefaultLayout = Rdlc;
    RDLCLayout = './Layouts/StudentsMarksUpload.rdlc';
    dataset
    {
        dataitem(ACAStudentUnits; "ACA-Student Units")
        {
            RequestFilterFields = Semester, Stage, Programme, Unit;
            column(StudentNo; "Student No.")
            {
            }
            column(StudName; "Student Name")
            {
            }


            column(CATs_Marks; VarCat)
            {

            }
            column(Exam_Marks; VarExam)
            {

            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Exam Marks", "CATs Marks");
                VarExam := '';
                VarCat := '';
                if "Exam Marks" <> 0 then
                    VarExam := Format("Exam Marks");
                if "CATs Marks" <> 0 then
                    VarCat := Format("CATs Marks");

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        VarExam: Text;
        VarCat: text;
}
