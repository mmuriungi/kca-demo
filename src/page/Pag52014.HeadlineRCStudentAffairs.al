page 52014 "Headline RC Student Affairs"
{
    ApplicationArea = All;
    Caption = 'Headline RC Student Affairs';
    PageType = HeadlinePart;

    layout
    {
        area(Content)
        {
            field(Headline1; GetTotalStudentsOnLeave())
            {
                ApplicationArea = All;
            }
            field(Headline2; GtTotalClubActivitiesToday())
            {
                ApplicationArea = All;
            }
            field(Headline3; GetUpcomingClubActivities())
            {
                ApplicationArea = All;
            }
        }
    }

    local procedure GetTotalStudentsOnLeave(): Text
    var
        StudentLeave: Record "Student Leave";
        LeaveCount: Integer;
    begin
        StudentLeave.SetRange("Start Date", WorkDate(), CalcDate('<+30D>', WorkDate()));
        LeaveCount := StudentLeave.Count;
        if LeaveCount = 0 then
            exit('No students on leave in the next 30 days');
        if LeaveCount = 1 then
            exit('1 student on leave in the next 30 days');
        exit(Format(LeaveCount) + ' students on leave in the next 30 days');
    end;

    local procedure GtTotalClubActivitiesToday(): Text
    var
        ClubActivity: Record "Club/Society Activity";
        ActivityCount: Integer;
    begin
        ClubActivity.SetRange("Activity Date", WorkDate(), WorkDate());
        ActivityCount := ClubActivity.Count;
        if ActivityCount = 0 then
            exit('No club activities scheduled for today');
        if ActivityCount = 1 then
            exit('1 club activity scheduled for today');
        exit(Format(ActivityCount) + ' club activities scheduled for today');
    end;

    local procedure GetUpcomingClubActivities(): Text
    var
        ClubActivity: Record "Club/Society Activity";
        ActivityCount: Integer;
    begin
        ClubActivity.SetRange("Activity Date", WorkDate(), CalcDate('<+30D>', WorkDate()));
        ActivityCount := ClubActivity.Count;
        if ActivityCount = 0 then
            exit('No club activities scheduled in the next 30 days');
        if ActivityCount = 1 then
            exit('1 club activity scheduled in the next 30 days');
        exit(Format(ActivityCount) + ' club activities scheduled in the next 30 days');
    end;
}
