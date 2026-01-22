// Page: Event Metrics
page 50323 "Event Metrics"
{
    PageType = CardPart;
    Caption = 'Event Metrics';

    layout
    {
        area(content)
        {
            cuegroup(EventMetrics)
            {
                field(TotalEvents; GetTotalEvents())
                {
                    Caption = 'Total Events (This Year)';
                    ApplicationArea = All;
                }
                field(TotalAttendees; GetTotalAttendees())
                {
                    Caption = 'Total Attendees (This Year)';
                    ApplicationArea = All;
                }
                field(AverageAttendance; GetAverageAttendance())
                {
                    Caption = 'Average Attendance';
                    ApplicationArea = All;
                }
                field(AverageFeedbackScore; GetAverageFeedbackScore())
                {
                    Caption = 'Average Feedback Score';
                    ApplicationArea = All;
                }
            }
        }
    }

    local procedure GetTotalEvents(): Integer
    var
        CRMEvent: Record "CRM Event";
    begin
        CRMEvent.SetRange(Date, CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        exit(CRMEvent.Count);
    end;

    local procedure GetTotalAttendees(): Integer
    var
        EventAttendee: Record "Event Attendee";
        CRMEvent: Record "CRM Event";
    begin
        CRMEvent.SetRange(Date, CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        if CRMEvent.FindSet() then
            repeat
                EventAttendee.SetRange("Event No.", CRMEvent."No.");
                EventAttendee.SetRange("Checked In", true);
            until CRMEvent.Next() = 0;
        exit(EventAttendee.Count);
    end;

    local procedure GetAverageAttendance(): Decimal
    var
        TotalEvents: Integer;
        TotalAttendees: Integer;
    begin
        TotalEvents := GetTotalEvents();
        TotalAttendees := GetTotalAttendees();
        if TotalEvents = 0 then
            exit(0);
        exit(TotalAttendees / TotalEvents);
    end;

    local procedure GetAverageFeedbackScore(): Decimal
    var
        EventFeedback: Record "Event Feedback";
        TotalScore: Decimal;
        FeedbackCount: Integer;
    begin
        EventFeedback.SetRange("Feedback Date", CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        if EventFeedback.FindSet() then
            repeat
                TotalScore += EventFeedback.Rating;
                FeedbackCount += 1;
            until EventFeedback.Next() = 0;
        if FeedbackCount = 0 then
            exit(0);
        exit(TotalScore / FeedbackCount);
    end;
}
