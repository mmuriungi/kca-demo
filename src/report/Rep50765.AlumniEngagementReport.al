// Report: Alumni Engagement Report
report 50765 "Alumni Engagement Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AlumniEngagementReport.rdl';

    dataset
    {
        dataitem(Alumni; Customer)
        {
            RequestFilterFields = "No.", "Graduating Academic Year";
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Graduation_Year; "Graduating Academic Year")
            {
            }
            column(Degree; Programme)
            {
            }
            column(Last_Engagement_Date; "Last Engagement Date")
            {
            }
            column(Total_Donations; "Total Donations")
            {
            }
            column(CompanyLogo; Company.Picture)
            {

            }
            column(CompanyName; Company.Name)
            {

            }
            column(CompanyAddress; Company.Address)
            {

            }
            column(Company_Add; Company."Address 2")
            {

            }
            column(CompanyPhone; Company."Phone No.")
            {
                
            }
            column(CompanyPostCode; Company."Post Code")
            {
                
            }
            column(CompanyCity; Company.City)
            {
                
            }
        }
    }

    trigger OnInitReport()
    begin
        Company.GET;
        Company.CALCFIELDS(Picture);
    end;

     var
        Company: Record "Company Information";
}
