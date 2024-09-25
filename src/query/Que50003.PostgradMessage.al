query 50003 "Postgrad Message"
{
    APIGroup = 'postgraduateApplication';
    APIPublisher = 'appKings';
    APIVersion = 'v1.0';
    EntityName = 'postgradMessage';
    EntitySetName = 'postgradMessage';
    QueryType = API;

    elements
    {
        dataitem(postgradMessages; "Postgrad Messages")
        {
            column(communicationDate; "Communication Date")
            {
            }
            column(entryNo; "Entry No.")
            {
            }
            column(message; Message)
            {
            }
            column(senderType; "Sender Type")
            {
            }
            column(studentName; "Student Name")
            {
            }
            column(studentNo; "Student No.")
            {
            }
            column(supervisorCode; "Supervisor Code")
            {
            }
            column(supervisorName; "Supervisor Name")
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
            column("time"; "Time")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
