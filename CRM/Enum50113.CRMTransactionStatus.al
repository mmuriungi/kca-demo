enum 50113 "CRM Transaction Status"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Pending)
    {
        Caption = 'Pending';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
    value(3; Failed)
    {
        Caption = 'Failed';
    }
    value(4; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(5; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(6; "Partially Paid")
    {
        Caption = 'Partially Paid';
    }
    value(7; Refunded)
    {
        Caption = 'Refunded';
    }
    value(8; "On Hold")
    {
        Caption = 'On Hold';
    }
    value(9; Disputed)
    {
        Caption = 'Disputed';
    }
    value(10; Approved)
    {
        Caption = 'Approved';
    }
    value(11; Rejected)
    {
        Caption = 'Rejected';
    }
}