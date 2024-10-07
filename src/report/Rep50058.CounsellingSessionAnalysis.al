report 50058 "Counselling Session Analysis"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CounselingSessionAnalysis.rdl';

    dataset
    {
        dataitem("Counseling Session"; "Counseling Session")
        {
            column(SessionNo; "Session No.")
            {
            }
            column(SessionDate; "Session Date")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(CounselorNo; "Counselor No.")
            {
            }
            column(IssueDescription; "Issue Description")
            {
            }
            column(FollowupRequired; "Follow-up Required")
            {
            }
             column(CompanyName;CompanyInformation.Name)
            {
            }
            column(CompanyPhone;CompanyInformation."Phone No.")
            {}
            column(Logo;CompanyInformation.Picture)
            {}
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if StartDate <> 0D then
            "Counseling Session".SetFilter("Session Date", '>=%1', StartDate);
        if EndDate <> 0D then
            "Counseling Session".SetFilter("Session Date", '<=%1', EndDate);
    end;
    trigger OnInitReport()
    var
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture)
    end;
    var
        StartDate: Date;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
}
