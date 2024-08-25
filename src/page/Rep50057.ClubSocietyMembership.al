report 50057 "Club/Society Membership"
{
    Caption = 'Club/Society Membership';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ClubSocietyMembership.rdl';

    dataset
    {
        dataitem("Club/Society"; "Club")
        {
            column(Code; Code)
            {
            }
            column(Name; Name)
            {
            }
            dataitem("Club/Society Member"; "Club Member")
            {
                DataItemLink = "Club Code" = field(Code);
                column(StudentNo; "Student No.")
                {
                }
                column(JoinDate; "Join Date")
                {
                }
                column(Role; Role)
                {
                }
            }
        }
    }
}
