page 50302 "Student Engagement Analytics"
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(ClubEngagement)
            {
                Caption = 'Club Engagement';
                field(AverageClubsPerStudent; AverageClubsPerStudent)
                {
                    Caption = 'Average Clubs per Student';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(MostPopularClub; MostPopularClub)
                {
                    Caption = 'Most Popular Club';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(LeaveAnalysis)
            {
                Caption = 'Leave Analysis';
                field(AverageLeavePerStudent; AverageLeavePerStudent)
                {
                    Caption = 'Average Leave Days per Student';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(MostCommonLeaveReason; MostCommonLeaveReason)
                {
                    Caption = 'Most Common Leave Reason';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(CounselingAnalysis)
            {
                Caption = 'Counseling Analysis';
                field(StudentsUsingCounseling; StudentsUsingCounseling)
                {
                    Caption = '% Students Using Counseling';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AverageSessionsPerStudent; AverageSessionsPerStudent)
                {
                    Caption = 'Average Sessions per Student';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshAnalytics)
            {
                ApplicationArea = All;
                Caption = 'Refresh Analytics';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CalculateAnalytics();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CalculateAnalytics();
    end;

    local procedure CalculateAnalytics()
    var
        Student: Record Customer;
        ClubSocietyMember: Record "Club Member";
        StudentLeave: Record "Student Leave";
        CounselingSession: Record "Counseling Session";
        TotalStudents: Integer;
    begin
        TotalStudents := Student.Count;

        // Club Engagement
        if TotalStudents > 0 then
            AverageClubsPerStudent := ClubSocietyMember.Count / TotalStudents
        else
            AverageClubsPerStudent := 0;

        MostPopularClub := GetMostPopularClub();

        // Leave Analysis
        if TotalStudents > 0 then
            AverageLeavePerStudent := GetTotalLeaveDays() / TotalStudents
        else
            AverageLeavePerStudent := 0;

        MostCommonLeaveReason := GetMostCommonLeaveReason();

        // Counseling Analysis
        if TotalStudents > 0 then
            StudentsUsingCounseling := (GetStudentsUsingCounseling() / TotalStudents) * 100
        else
            StudentsUsingCounseling := 0;

        if GetStudentsUsingCounseling() > 0 then
            AverageSessionsPerStudent := CounselingSession.Count / GetStudentsUsingCounseling()
        else
            AverageSessionsPerStudent := 0;
    end;

    local procedure GetMostPopularClub(): Text[100]
    var
        ClubSociety: Record Club;
        ClubSocietyMember: Record "Club Member";
        MaxMembers: Integer;
        CurrentMembers: Integer;
    begin
        MaxMembers := 0;
        if ClubSociety.FindSet() then
            repeat
                ClubSocietyMember.SetRange("Club Code", ClubSociety.Code);
                CurrentMembers := ClubSocietyMember.Count;
                if CurrentMembers > MaxMembers then begin
                    MaxMembers := CurrentMembers;
                    exit(ClubSociety.Name);
                end;
            until ClubSociety.Next() = 0;
        exit('');
    end;

    local procedure GetTotalLeaveDays(): Integer
    var
        StudentLeave: Record "Student Leave";
        TotalDays: Integer;
    begin
        if StudentLeave.FindSet() then
            repeat
                TotalDays += StudentLeave."End Date" - StudentLeave."Start Date" + 1;
            until StudentLeave.Next() = 0;
        exit(TotalDays);
    end;

    local procedure GetMostCommonLeaveReason(): Text[250]
    var
        StudentLeave: Record "Student Leave";
        ReasonCount: Dictionary of [Text, Integer];
        MaxCount: Integer;
        MaxReason: Text;
        Reason: Text;
    begin
        if StudentLeave.FindSet() then
            repeat
                if ReasonCount.ContainsKey(StudentLeave.Reason) then
                    ReasonCount.Set(StudentLeave.Reason, ReasonCount.Get(StudentLeave.Reason) + 1)
                else
                    ReasonCount.Add(StudentLeave.Reason, 1);
            until StudentLeave.Next() = 0;

        MaxCount := 0;
        foreach Reason in ReasonCount.Keys do begin
            if ReasonCount.Get(Reason) > MaxCount then begin
                MaxCount := ReasonCount.Get(Reason);
                MaxReason := Reason;
            end;
        end;
        exit(MaxReason);
    end;

    local procedure GetStudentsUsingCounseling(): Integer
    var
        CounselingSession: Record "Counseling Session";
    begin
        CounselingSession.SetRange("Session Date", CalcDate('<-CY>', Today), Today);
        exit(CounselingSession.Count);
    end;

    var
        AverageClubsPerStudent: Decimal;
        MostPopularClub: Text[100];
        AverageLeavePerStudent: Decimal;
        MostCommonLeaveReason: Text[250];
        StudentsUsingCounseling: Decimal;
        AverageSessionsPerStudent: Decimal;
}
