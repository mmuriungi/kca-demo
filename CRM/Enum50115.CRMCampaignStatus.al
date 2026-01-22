enum 50115 "CRM Campaign Status"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Draft)
    {
        Caption = 'Draft';
    }
    value(2; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(3; Approved)
    {
        Caption = 'Approved';
    }
    value(4; Scheduled)
    {
        Caption = 'Scheduled';
    }
    value(5; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(6; Completed)
    {
        Caption = 'Completed';
    }
    value(7; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(8; Paused)
    {
        Caption = 'Paused';
    }
    value(9; "On Hold")
    {
        Caption = 'On Hold';
    }
    value(10; Failed)
    {
        Caption = 'Failed';
    }
    value(11; "Under Review")
    {
        Caption = 'Under Review';
    }
}