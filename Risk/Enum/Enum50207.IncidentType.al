enum 50407 "Incident Type"
{
    Extensible = true;
    
    value(0; " ") { Caption = ' '; }
    value(1; Risk_Event) { Caption = 'Risk Event'; }
    value(2; Near_Miss) { Caption = 'Near Miss'; }
    value(3; Breach) { Caption = 'Breach'; }
    value(4; Fraud) { Caption = 'Fraud'; }
    value(5; System_Failure) { Caption = 'System Failure'; }
    value(6; Process_Failure) { Caption = 'Process Failure'; }
    value(7; External_Event) { Caption = 'External Event'; }
    value(8; Regulatory_Issue) { Caption = 'Regulatory Issue'; }
}