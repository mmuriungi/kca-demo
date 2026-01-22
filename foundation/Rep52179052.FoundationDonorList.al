report 52179052 "Foundation Donor List"
{
    Caption = 'Foundation Donor List';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donor; "Foundation Donor")
        {
            RequestFilterFields = "Donor Type", "Donor Category", "Recognition Level";
            
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
            column(DonorCategory; "Donor Category")
            {
            }
            column(Email; Email)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(City; City)
            {
            }
            column(TotalDonations; "Total Donations")
            {
            }
            column(NoOfDonations; "No. of Donations")
            {
            }
            column(LastDonationDate; "Last Donation Date")
            {
            }
            column(DonorSince; "Donor Since")
            {
            }
            column(RecognitionLevel; "Recognition Level")
            {
            }
        }
    }
}