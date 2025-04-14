query 50007 "Drill Down Answers"
{
    Caption = 'Drill Down Answers';
    QueryType = Normal;
    
    elements
    {
        dataitem(DrillDownAnswers; "Drill Down Answers")
        {
            column(SemesterCode; "Semester Code")
            {
            }
            column(QuizNo; "Quiz No.")
            {
            }
            column(Choice; Choice)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
