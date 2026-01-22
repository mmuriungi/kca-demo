report 52179050 "Foundation Donor Statement"
{
    Caption = 'Foundation Donor Statement';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donor; "Foundation Donor")
        {
            RequestFilterFields = "No.", "Donor Type", "Donor Category";
            
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
            column(TotalDonations; "Total Donations")
            {
            }
            column(LastDonationDate; "Last Donation Date")
            {
            }
            column(NoOfDonations; "No. of Donations")
            {
            }
            column(DonorSince; "Donor Since")
            {
            }
            column(DonorCategory; "Donor Category")
            {
            }
            
            dataitem(Donation; "Foundation Donation")
            {
                DataItemLink = "Donor No." = field("No.");
                
                column(DonationNo; "No.")
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
                column(Status; Status)
                {
                }
                column(PaymentMethod; "Payment Method")
                {
                }
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
                    
                    field(ShowDetails; ShowDonationDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Donation Details';
                    }
                }
            }
        }
    }
    
    var
        ShowDonationDetails: Boolean;
}