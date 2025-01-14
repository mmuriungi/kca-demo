report 50059 "Club Performance Analysis"
{
    Caption = 'Club Performance Analysis';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClubPerformanceAnalysis.rdl';

    dataset
    {
        dataitem(Club; Club)
        {
            column(Code; Code)
            {
            }
            column(Name; Name)
            {
            }
            column(MemberCount; "Member Count")
            {
            }
            column(ActivityCount; "Activity Count")
            {
            }
            column(AverageAttendance; AverageAttendance)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyPhone; CompanyInformation."Phone No.")
            { }
            column(Logo; CompanyInformation.Picture)
            { }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Member Count", "Activity Count");
                CalculateAverageAttendance();
            end;
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
        SetDateFilters();
    end;

    local procedure SetDateFilters()
    begin
        if StartDate <> 0D then
            Club.SetFilter("Date Filter", '>=%1', StartDate);
        if EndDate <> 0D then
            Club.SetFilter("Date Filter", '<=%1', EndDate);
    end;

    local procedure CalculateAverageAttendance()
    var
        ClubActivity: Record "Club/Society Activity";
        TotalAttendance: Integer;
    begin
        ClubActivity.SetRange("Club/Society Code", Club.Code);
        ClubActivity.SetFilter("Activity Date", Club.GetFilter("Date Filter"));
        if ClubActivity.FindSet() then begin
            repeat
                TotalAttendance += ClubActivity.Attendance;
            until ClubActivity.Next() = 0;
            if ClubActivity.Count <> 0 then
                AverageAttendance := TotalAttendance / ClubActivity.Count
            else
                AverageAttendance := 0;
        end
        else
            AverageAttendance := 0;
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
        AverageAttendance: Decimal;
        CompanyInformation: Record "Company Information";
}