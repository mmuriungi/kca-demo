report 52179056 "Foundation Donation Summary"
{
    Caption = 'Foundation Donation Summary';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(Donation; "Foundation Donation")
        {
            RequestFilterFields = "Donation Date", Status, Purpose;
            DataItemTableView = where(Status = const(Received));
            
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(DonationCount; DonationCount)
            {
            }
            column(AverageAmount; AverageAmount)
            {
            }
            
            trigger OnPreDataItem()
            begin
                CurrPurpose := Purpose::" ";
                TotalAmount := 0;
                DonationCount := 0;
            end;
            
            trigger OnAfterGetRecord()
            begin
                if Purpose <> CurrPurpose then begin
                    if CurrPurpose <> Purpose::" " then begin
                        if DonationCount > 0 then
                            AverageAmount := TotalAmount / DonationCount;
                        // Output the group total here
                    end;
                    
                    CurrPurpose := Purpose;
                    TotalAmount := Amount;
                    DonationCount := 1;
                end else begin
                    TotalAmount += Amount;
                    DonationCount += 1;
                end;
            end;
            
            trigger OnPostDataItem()
            begin
                if DonationCount > 0 then
                    AverageAmount := TotalAmount / DonationCount;
            end;
        }
    }
    
    var
        CurrPurpose: Enum "Foundation Donation Purpose";
        TotalAmount: Decimal;
        DonationCount: Integer;
        AverageAmount: Decimal;
}