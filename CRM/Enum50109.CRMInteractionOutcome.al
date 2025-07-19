enum 50109 "CRM Interaction Outcome"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Successful)
    {
        Caption = 'Successful';
    }
    value(2; "Partially Successful")
    {
        Caption = 'Partially Successful';
    }
    value(3; Unsuccessful)
    {
        Caption = 'Unsuccessful';
    }
    value(4; "No Response")
    {
        Caption = 'No Response';
    }
    value(5; "Needs Follow-up")
    {
        Caption = 'Needs Follow-up';
    }
    value(6; Completed)
    {
        Caption = 'Completed';
    }
    value(7; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(8; Postponed)
    {
        Caption = 'Postponed';
    }
    value(9; "Not Interested")
    {
        Caption = 'Not Interested';
    }
    value(10; "Information Provided")
    {
        Caption = 'Information Provided';
    }
    value(11; "Issue Resolved")
    {
        Caption = 'Issue Resolved';
    }
    value(12; "Escalated")
    {
        Caption = 'Escalated';
    }
}