query 50002 "Student Submission"
{
    APIGroup = 'postgraduateApplication';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'studentSubmission';
    EntitySetName = 'studentSubmissions';
    QueryType = API;

    elements
    {
        dataitem(studentSubmission; "Student Submission")
        {
            column(documentLink; "Document Link")
            {
            }
            column(no; "No.")
            {
            }
            column(noSeries; "No. Series")
            {
            }
            column(status; Status)
            {
            }
            column(studentName; "Student Name")
            {
            }
            column(studentNo; "Student No.")
            {
            }
            column(submissionDate; "Submission Date")
            {
            }
            column(submissionType; "Submission Type")
            {
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
            }
            column(systemCreatedBy; SystemCreatedBy)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
            }
            column(systemModifiedBy; SystemModifiedBy)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
