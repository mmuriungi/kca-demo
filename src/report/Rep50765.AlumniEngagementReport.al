// Report: Alumni Engagement Report
report 50765 "Alumni Engagement Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'AlumniEngagementReport.rdl';

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
        }
    }
}
