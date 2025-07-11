enum 56262 "SMS Recipient Type"
{
    Extensible = true;
    
    value(0; Customer)
    {
        Caption = 'Customer';
    }
    value(1; Vendor)
    {
        Caption = 'Vendor';
    }
    value(2; KUCCPS)
    {
        Caption = 'KUCCPS Import';
    }
    value(3; Manual)
    {
        Caption = 'Manual Entry';
    }
}