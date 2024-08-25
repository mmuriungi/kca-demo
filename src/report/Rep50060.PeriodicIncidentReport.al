// Report: Periodic Incident Report
report 50060 "Periodic Incident Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'IncidentReport.rdl';

    dataset
    {
        dataitem("Incident Report"; "Incident Report")
        {
            column(Case_No_; "Case No.")
            {
            }
            column(Accused_Name; "Accused Name")
            {
            }
            column(Victim_Reporting_Party; "Victim/Reporting Party")
            {
            }
            column(Nature_of_Case; "Nature of Case")
            {
            }
            column(Category; Category)
            {
            }
            column(Status; Status)
            {
            }
        }
    }
}
