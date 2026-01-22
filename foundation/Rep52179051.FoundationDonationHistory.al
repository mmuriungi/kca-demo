report 52179051 "Foundation Donation History"
{
    Caption = 'Foundation Donation History';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donation; "Foundation Donation")
        {
            RequestFilterFields = "Donor No.", "Donation Date", Status, Purpose;
            
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
            column(CurrencyCode; "Currency Code")
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(SpecificPurpose; "Specific Purpose")
            {
            }
            column(PaymentMethod; "Payment Method")
            {
            }
            column(Status; Status)
            {
            }
            column(CampaignCode; "Campaign Code")
            {
            }
            column(Anonymous; Anonymous)
            {
            }
            column(TaxDeductible; "Tax Deductible")
            {
            }
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    
                    field(GroupByDonor; GroupByDonor)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Donor';
                    }
                    field(ShowTotals; ShowTotals)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Totals';
                    }
                }
            }
        }
    }
    
    var
        GroupByDonor: Boolean;
        ShowTotals: Boolean;
}