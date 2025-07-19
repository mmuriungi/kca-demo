enum 50117 "CRM Approval Status"
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
    value(2; "Pending Review")
    {
        Caption = 'Pending Review';
    }
    value(3; "Under Review")
    {
        Caption = 'Under Review';
    }
    value(4; Approved)
    {
        Caption = 'Approved';
    }
    value(5; Rejected)
    {
        Caption = 'Rejected';
    }
    value(6; "Conditional Approval")
    {
        Caption = 'Conditional Approval';
    }
    value(7; "Requires Changes")
    {
        Caption = 'Requires Changes';
    }
    value(8; "Re-submitted")
    {
        Caption = 'Re-submitted';
    }
    value(9; Withdrawn)
    {
        Caption = 'Withdrawn';
    }
    value(10; Cancelled)
    {
        Caption = 'Cancelled';
    }
}