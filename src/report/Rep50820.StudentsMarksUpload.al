report 50820 "Students Marks Upload"
{
    Caption = 'Students Marks Upload';
    DefaultLayout = Word;
    WordLayout = './Layouts/StudentsMarksUpload.docx';
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


            column(CATs_Marks; "CATs Marks")
            {

            }
            column(Exam_Marks; "Exam Marks")
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
}
