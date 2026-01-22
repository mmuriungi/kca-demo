enum 50402 "Risk Treatment Strategy"
{
    Extensible = true;
    
    value(0; " ") { Caption = ' '; }
    value(1; Terminate) { Caption = 'Terminate'; }
    value(2; Treat) { Caption = 'Treat'; }
    value(3; Transfer) { Caption = 'Transfer'; }
    value(4; Tolerate) { Caption = 'Tolerate'; }
    value(5; Exploit) { Caption = 'Exploit'; }
}