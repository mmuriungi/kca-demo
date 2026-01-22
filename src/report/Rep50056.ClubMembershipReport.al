report 50056 "Club Membership Report"
{
    Caption = 'Club Membership Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClubMembershipReport.rdl';

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
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyPhone; CompanyInformation."Phone No.")
            { }
            column(Logo; CompanyInformation.Picture)
            { }
            dataitem("Club Member"; "Club Member")
            {
                DataItemLink = "Club Code" = field(Code);
                column(StudentNo; "Student No.")
                {
                }
                column(Student_Name; "Student Name")
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
    trigger OnInitReport()
    var
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture)
    end;

    var
        CompanyInformation: Record "Company Information";
}
