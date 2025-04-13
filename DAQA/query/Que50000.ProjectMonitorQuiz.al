query 50006 "Project Monitor Quiz"
{
    Caption = 'Project Monitor Quiz';
    QueryType = Normal;

    elements
    {
        dataitem(ProjectMonitorQuiz; "Project Monitor Quiz")
        {
            column(ProjectNo; "Project No.")
            {
            }
            column(QuizNo; "Quiz No.")
            {
            }
            column(Question; Question)
            {
            }
            column(PeriodFrom; "Period From")
            {
            }
            column(PeriodTo; "Period To")
            {
            }
            column(RequiresDrillDown; "Requires Drill-Down")
            {
            }
            column(QuestionCategory; "Question Category")
            {
            }
            column(QuestionType; "Question Type")
            {
            }
            column(SurveyCode; "Survey Code")
            {
            }
            column(Mandatory; Mandatory)
            {
            }
            column(ActivatesQuestion; "Activates Question")
            {
            }
            column(ActivatesBasedOnAnswer; "Activates Based On Answer")
            {
            }
            column(ActivatesBasedOnValue; "Activates Based On Value")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
