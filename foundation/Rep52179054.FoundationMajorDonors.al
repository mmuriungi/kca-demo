report 52179054 "Foundation Major Donors"
{
    Caption = 'Foundation Major Donors';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donor; "Foundation Donor")
        {
            RequestFilterFields = "Donor Type", "Recognition Level";
            DataItemTableView = where("Donor Category" = const(Major));
            
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(DonorNo; "No.")
            {
            }
            column(DonorName; Name)
            {
            }
            column(DonorType; "Donor Type")
            {
            }
            column(ContactPerson; "Contact Person")
            {
            }
            column(Email; Email)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(TotalDonations; "Total Donations")
            {
            }
            column(LastDonationDate; "Last Donation Date")
            {
            }
            column(RecognitionLevel; "Recognition Level")
            {
            }
            column(ActivePledges; "Active Pledges")
            {
            }
        }
    }
}