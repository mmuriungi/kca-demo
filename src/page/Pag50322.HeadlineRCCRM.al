// Page: Headline RC CRM
page 50322 "Headline RC CRM"
{
    PageType = HeadlinePart; 
    Caption = 'CRM Headline';

    layout
    {
        area(content)
        {
            field(Headline1; GetUpcomingEventsHeadline())
            {
                ApplicationArea = All;
            }
            field(Headline2; GetRecentDonationsHeadline())
            {
                ApplicationArea = All;
            }
        }
    }

    local procedure GetUpcomingEventsHeadline(): Text
    var
        CRMEvent: Record "CRM Event";
        EventCount: Integer;
    begin
        CRMEvent.SetRange(Date, WorkDate(), CalcDate('<+30D>', WorkDate()));
        EventCount := CRMEvent.Count;
        if EventCount = 0 then
            exit('No upcoming events in the next 30 days');
        if EventCount = 1 then
            exit('1 event scheduled in the next 30 days');
        exit(Format(EventCount) + ' events scheduled in the next 30 days');
    end;

    local procedure GetRecentDonationsHeadline(): Text
    var
        Donation: Record Donation;
        TotalAmount: Decimal;
    begin
        Donation.SetRange("Donation Date", CalcDate('<-30D>', WorkDate()), WorkDate());
        if Donation.FindSet() then
            repeat
                TotalAmount += Donation.Amount;
            until Donation.Next() = 0;
        exit('Recent donations: ' + Format(TotalAmount, 0, '<Precision,2:2><Standard Format,0>'));
    end;
}
