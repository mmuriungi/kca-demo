// Report: Donation Report
report 50766 "Donation Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DonationReport.rdl';

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