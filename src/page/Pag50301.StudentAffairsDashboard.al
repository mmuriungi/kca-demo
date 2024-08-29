page 50301 "Student Affairs Dashboard"
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            cuegroup(ClubStatistics)
            {
                Caption = 'Club Statistics';
                field(TotalClubs; TotalClubs)
                {
                    Caption = 'Total Clubs';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalMembers; TotalMembers)
                {
                    Caption = 'Total Club Members';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UpcomingActivities; UpcomingActivities)
                {
                    Caption = 'Upcoming Activities';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            cuegroup(LeaveStatistics)
            {
                Caption = 'Leave Statistics';
                field(PendingLeaves; PendingLeaves)
                {
                    Caption = 'Pending Leave Requests';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ApprovedLeaves; ApprovedLeaves)
                {
                    Caption = 'Approved Leaves This Month';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            cuegroup(CounselingStatistics)
            {
                Caption = 'Counseling Statistics';
                field(TotalSessions; TotalSessions)
                {
                    Caption = 'Total Counseling Sessions';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UpcomingSessions; UpcomingSessions)
                {
                    Caption = 'Upcoming Counseling Sessions';
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
            action(RefreshDashboard)
            {
                ApplicationArea = All;
                Caption = 'Refresh Dashboard';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalculateStatistics();
    end;

    local procedure CalculateStatistics()
    var
        ClubSociety: Record "Club";
        ClubSocietyMember: Record "Club Member";
        ClubSocietyActivity: Record "Club/Society Activity";
        StudentLeave: Record "Student Leave";
        CounselingSession: Record "Counseling Session";
    begin
        TotalClubs := ClubSociety.Count;
        ClubSocietyMember.SetRange("Join Date", CalcDate('<-CY>', Today), Today);
        TotalMembers := ClubSocietyMember.Count;
        ClubSocietyActivity.SetFilter("Activity Date", '>=%1', Today);
        UpcomingActivities := ClubSocietyActivity.Count;

        StudentLeave.SetRange("Approval Status", StudentLeave."Approval Status"::"Pending Approval");
        PendingLeaves := StudentLeave.Count;
        StudentLeave.SetRange("Approval Status", StudentLeave."Approval Status"::Approved);
        StudentLeave.SetRange("Start Date", CalcDate('<-CM>', Today), CalcDate('<CM>', Today));
        ApprovedLeaves := StudentLeave.Count;

        TotalSessions := CounselingSession.Count;
        CounselingSession.SetFilter("Session Date", '>=%1', Today);
        UpcomingSessions := CounselingSession.Count;
    end;

    var
        TotalClubs: Integer;
        TotalMembers: Integer;
        UpcomingActivities: Integer;
        PendingLeaves: Integer;
        ApprovedLeaves: Integer;
        TotalSessions: Integer;
        UpcomingSessions: Integer;
}
