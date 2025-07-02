query 50010 "Questionnaire Instructions"
{
    Caption = 'Questionnaire Instructions';
    QueryType = Normal;

    elements
    {
        dataitem(QuestionnaireInstructions; "Questionnaire Instructions")
        {
            column(SurveyCode; "Survey Code")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(Instructions; Instructions)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
