report 50056 "Club Membership Report"
{
    Caption = 'Club Membership Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ClubMembershipReport.rdl';

    dataset
    {
        dataitem(Club; Club)
        {
            column(Code; "Code")
            {
            }
            column(Name; Name)
            {
            }
            column(MemberCount; "Member Count")
            {
            }
            dataitem("Club Member"; "Club Member")
            {
                DataItemLink = "Club Code" = field(Code);
                column(StudentNo; "Student No.")
                {
                }
                column(JoinDate; "Join Date")
                {
                }
                column(MembershipStatus; "Membership Status")
                {
                }
                column(Position; Position)
                {
                }
            }
        }
    }
}
