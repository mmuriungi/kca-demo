// Report: Donation Report
report 50766 "Donation Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'DonationReport.rdl';

    dataset
    {
        dataitem(Donation; Donation)
        {
            RequestFilterFields = "Donation Date", "Campaign Code";
            column(No_; "No.")
            {
            }
            column(Donor_No_; "Donor No.")
            {
            }
            column(Donation_Date; "Donation Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Campaign_Code; "Campaign Code")
            {
            }
        }
    }
}