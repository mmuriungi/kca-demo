report 52179055 "Foundation Donation Report"
{
    Caption = 'Foundation Donation Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donation; "Foundation Donation")
        {
            RequestFilterFields = "Donation Date", Status, Purpose, "Campaign Code";
            
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(DonationNo; "No.")
            {
            }
            column(DonorNo; "Donor No.")
            {
            }
            column(DonorName; "Donor Name")
            {
            }
            column(DonationDate; "Donation Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(SpecificPurpose; "Specific Purpose")
            {
            }
            column(CampaignCode; "Campaign Code")
            {
            }
            column(Status; Status)
            {
            }
            column(PaymentMethod; "Payment Method")
            {
            }
            column(TaxDeductible; "Tax Deductible")
            {
            }
            column(Anonymous; Anonymous)
            {
            }
        }
    }
}