page 50303 "Student Affairs Analytics"
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            cuegroup(OverallMetrics)
            {
                Caption = 'Overall Metrics';
                field(AverageEngagementScore; AverageEngagementScore)
                {
                    Caption = 'Average Engagement Score';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(HighEngagementPercentage; HighEngagementPercentage)
                {
                    Caption = '% Students with High Engagement';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            cuegroup(ClubMetrics)
            {
                Caption = 'Club Metrics';
                field(MostActiveClub; MostActiveClub)
                {
                    Caption = 'Most Active Club';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(AverageClubsPerStudent; AverageClubsPerStudent)
                {
                    Caption = 'Average Clubs per Student';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            cuegroup(LeaveMetrics)
            {
                Caption = 'Leave Metrics';
                field(AverageLeaveUsage; AverageLeaveUsage)
                {
                    Caption = 'Average Leave Usage (Days)';
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
            cuegroup(CounselingMetrics)
            {
                Caption = 'Counseling Metrics';
                field(AverageCounselingSessions; AverageCounselingSessions)
                {
                    Caption = 'Average Counseling Sessions';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(StudentsUsingCounseling; StudentsUsingCounseling)
                {
                    Caption = '% Students Using Counseling';
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
            action(ExportAnalytics)
            {
                ApplicationArea = All;
                Caption = 'Export Analytics';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ExportAnalyticsToExcel();
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
        HighEngagementCount: Integer;
    begin
        TotalStudents := Student.Count;

        if Student.FindSet() then
            repeat
                AverageEngagementScore += Student."Club Engagement Score";
                if Student."Club Engagement Score" >= 8 then
                    HighEngagementCount += 1;
            until Student.Next() = 0;

        if TotalStudents > 0 then begin
            AverageEngagementScore /= TotalStudents;
            HighEngagementPercentage := (HighEngagementCount / TotalStudents) * 100;
        end;

        MostActiveClub := GetMostActiveClub();
        AverageClubsPerStudent := ClubSocietyMember.Count / TotalStudents;

        if StudentLeave.FindSet() then
            repeat
                AverageLeaveUsage += (StudentLeave."End Date" - StudentLeave."Start Date" + 1);
            until StudentLeave.Next() = 0;
        AverageLeaveUsage /= TotalStudents;

        MostCommonLeaveReason := GetMostCommonLeaveReason();

        AverageCounselingSessions := CounselingSession.Count / TotalStudents;
        StudentsUsingCounseling := (GetStudentsUsingCounseling() / TotalStudents) * 100;
    end;

    local procedure GetMostActiveClub(): Text[100]
    var
        ClubSociety: Record Club;
        ClubSocietyActivity: Record "Club/Society Activity";
        MaxActivities: Integer;
        CurrentActivities: Integer;
    begin
        MaxActivities := 0;
        if ClubSociety.FindSet() then
            repeat
                ClubSocietyActivity.SetRange("Club/Society Code", ClubSociety.Code);
                CurrentActivities := ClubSocietyActivity.Count;
                if CurrentActivities > MaxActivities then begin
                    MaxActivities := CurrentActivities;
                    exit(ClubSociety.Name);
                end;
            until ClubSociety.Next() = 0;
        exit('');
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

    local procedure ExportAnalyticsToExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        AnalyticsExportLbl: Label 'Student Affairs Analytics Export';
        FileName: Text;
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Metric', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Value', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        AddExcelRow(TempExcelBuffer, 'Average Engagement Score', Format(AverageEngagementScore));
        AddExcelRow(TempExcelBuffer, '% Students with High Engagement', Format(HighEngagementPercentage));
        AddExcelRow(TempExcelBuffer, 'Most Active Club', MostActiveClub);
        AddExcelRow(TempExcelBuffer, 'Average Clubs per Student', Format(AverageClubsPerStudent));
        AddExcelRow(TempExcelBuffer, 'Average Leave Usage (Days)', Format(AverageLeaveUsage));
        AddExcelRow(TempExcelBuffer, 'Most Common Leave Reason', MostCommonLeaveReason);
        AddExcelRow(TempExcelBuffer, 'Average Counseling Sessions', Format(AverageCounselingSessions));
        AddExcelRow(TempExcelBuffer, '% Students Using Counseling', Format(StudentsUsingCounseling));

        FileName := AnalyticsExportLbl + '.xlsx';
        TempExcelBuffer.CreateNewBook(AnalyticsExportLbl);
        TempExcelBuffer.WriteSheet(AnalyticsExportLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(FileName);
        TempExcelBuffer.OpenExcel();
    end;

    local procedure AddExcelRow(var TempExcelBuffer: Record "Excel Buffer" temporary; MetricName: Text; MetricValue: Text)
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(MetricName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MetricValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    var
        AverageEngagementScore: Decimal;
        HighEngagementPercentage: Decimal;
        MostActiveClub: Text[100];
        AverageClubsPerStudent: Decimal;
        AverageLeaveUsage: Decimal;
        MostCommonLeaveReason: Text[250];
        AverageCounselingSessions: Decimal;
        StudentsUsingCounseling: Decimal;
}
