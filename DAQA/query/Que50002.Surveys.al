query 50008 Surveys
{
    Caption = 'Surveys';
    QueryType = Normal;

    elements
    {
        dataitem(SurveyHeader; "Survey Header")
        {
            DataItemTableFilter = Status = FILTER(Published);
            column(SurveyCode; "Survey Code")
            {
            }
            column(Description; Description)
            {
            }
            column(SemesterCode; "Semester Code")
            {
            }
            column(SurveyType; "Survey Type")
            {
            }
            column(Status; Status)
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}

