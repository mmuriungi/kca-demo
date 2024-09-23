
// Report: Event Report
report 50069 "Event Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EventReport.rdl';

    dataset
    {
        dataitem("CRM Event"; "CRM Event")
        {
            RequestFilterFields = "No.", Date, Category;
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Date; Date)
            {
            }
            column(Time; Time)
            {
            }
            column(Location; Location)
            {
            }
            column(Category; Category)
            {
            }
            column(Registered_Attendees; "Registered Attendees")
            {
            }
            column(Checked_in_Attendees; "Checked-in Attendees")
            {
            }
            column(Feedback_Score; "Feedback Score")
            {
            }
        }
    }
}
