query 50011 "Survey Student Groups"
{
    Caption = 'Survey Student Groups';
    QueryType = Normal;
    
    elements
    {
        dataitem(SurveyStudentGroups; "Survey Student Groups")
        {
            column(SurveyCode; "Survey Code")
            {
            }
            column(YearofStudy; "Year of Study")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
