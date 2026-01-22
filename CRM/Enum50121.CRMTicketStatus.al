enum 50121 "CRM Ticket Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Open)
    {
        Caption = 'Open';
    }
    value(2; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(3; "Pending Customer")
    {
        Caption = 'Pending Customer';
    }
    value(4; "Pending Internal")
    {
        Caption = 'Pending Internal';
    }
    value(5; "Waiting for Approval")
    {
        Caption = 'Waiting for Approval';
    }
    value(6; Escalated)
    {
        Caption = 'Escalated';
    }
    value(7; "On Hold")
    {
        Caption = 'On Hold';
    }
    value(8; Resolved)
    {
        Caption = 'Resolved';
    }
    value(9; Closed)
    {
        Caption = 'Closed';
    }
    value(10; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(11; Reopened)
    {
        Caption = 'Reopened';
    }
    value(12; "Duplicate")
    {
        Caption = 'Duplicate';
    }
    value(13; "Cannot Reproduce")
    {
        Caption = 'Cannot Reproduce';
    }
    value(14; "Will Not Fix")
    {
        Caption = 'Will Not Fix';
    }
}