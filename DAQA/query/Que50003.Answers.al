query 50009 Answers
{
    Caption = 'Answers';
    QueryType = Normal;

    elements
    {
        dataitem(ProjectQuizAnswers; "Project Quiz Answers")
        {
            column(AnsweredBy; "Answered By")
            {
            }
            column(AnsweredByEmail; "Answered By Email")
            {
            }
            column(AnsweredDate; "Answered Date")
            {
            }
            column(BooleanAnswer; "Boolean Answer")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(NumberAnswer; "Number Answer")
            {
            }
            column(PeriodFrom; "Period From")
            {
            }
            column(PeriodTo; "Period To")
            {
            }
            column(ProjectNo; "Project No.")
            {
            }
            column(Question; Question)
            {
            }
            column(QuestionType; "Question Type")
            {
            }
            column(QuizNo; "Quiz No.")
            {
            }
            column(SurveyCode; "Survey Code")
            {
            }
            column(SurveyName; "Survey Name")
            {
            }
            column(TextAnswer; "Text Answer")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
