report 50820 "Students Marks Upload"
{
    Caption = 'Students Marks Upload';
    dataset
    {
        dataitem(ACAStudentUnits; "ACA-Student Units")
        {
            column(StudentNo; "Student No.")
            {
                Caption = 'Student No.';
                //TableView = sorting("Student No.");
            }
            column(StudName; "Student Name")
            {
                Caption = 'Student Name';
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
