enum 50401 "Risk Status"
{
    Extensible = true;
    
    value(0; Open) { Caption = 'Open'; }
    value(1; In_Progress) { Caption = 'In Progress'; }
    value(2; Under_Review) { Caption = 'Under Review'; }
    value(3; Closed) { Caption = 'Closed'; }
    value(4; Monitoring) { Caption = 'Monitoring'; }
    value(5; Escalated) { Caption = 'Escalated'; }
    value(6; Approved) { Caption = 'Approved'; }
    value(7; Rejected) { Caption = 'Rejected'; }
}