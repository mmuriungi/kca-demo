enum 50203 "Foundation Pledge Status"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; PartiallyFulfilled)
    {
        Caption = 'Partially Fulfilled';
    }
    value(3; Fulfilled)
    {
        Caption = 'Fulfilled';
    }
    value(4; Overdue)
    {
        Caption = 'Overdue';
    }
    value(5; Cancelled)
    {
        Caption = 'Cancelled';
    }
    value(6; WrittenOff)
    {
        Caption = 'Written Off';
    }
}