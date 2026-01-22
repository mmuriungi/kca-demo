report 52179053 "Foundation Donor Analysis"
{
    Caption = 'Foundation Donor Analysis';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donor; "Foundation Donor")
        {
            RequestFilterFields = "Donor Type", "Donor Category";
            
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
            column(TotalDonations; "Total Donations")
            {
            }
            column(NoOfDonations; "No. of Donations")
            {
            }
            column(AverageDonation; AverageDonation)
            {
            }
            column(LastDonationDate; "Last Donation Date")
            {
            }
            column(DaysSinceLastDonation; DaysSinceLastDonation)
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                CalcFields("Total Donations", "No. of Donations", "Last Donation Date");
                
                if "No. of Donations" > 0 then
                    AverageDonation := "Total Donations" / "No. of Donations"
                else
                    AverageDonation := 0;
                    
                if "Last Donation Date" <> 0D then
                    DaysSinceLastDonation := Today - "Last Donation Date"
                else
                    DaysSinceLastDonation := 0;
            end;
        }
    }
    
    var
        AverageDonation: Decimal;
        DaysSinceLastDonation: Integer;
}