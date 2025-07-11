enum 56263 "SMS Line Status"
{
    Extensible = true;
    
    value(0; Pending)
    {
        Caption = 'Pending';
    }
    value(1; Sent)
    {
        Caption = 'Sent';
    }
    value(2; Failed)
    {
        Caption = 'Failed';
    }
    value(3; Skipped)
    {
        Caption = 'Skipped';
    }
}