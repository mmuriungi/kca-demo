query 50001 "Supervisor Application"
{
    QueryType = API;
    APIPublisher = 'appKings';
    APIVersion = 'v1.0';
    EntityName = 'postgraduateApplication';
    EntitySetName = 'postgraduateApplications';
    APIGroup = 'postgraduateApplication';

    elements
    {
        dataitem(postgradSupervisorApplic; "Postgrad Supervisor Applic.")
        {
            column(applicationDate; "Application Date")
            {
            }
            column(assignedSupervisorCode; "Assigned Supervisor Code")
            {
            }
            column(assignedSupervisorName; "Assigned Supervisor Name")
            {
            }
            column(dateApproved; "Date Approved")
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
