// Page: Alumni Metrics
page 50324 "Alumni Metrics"
{
    PageType = CardPart;
    Caption = 'Alumni Metrics';

    layout
    {
        area(content)
        {
            cuegroup(AlumniMetrics)
            {
                field(TotalAlumni; GetTotalAlumni())
                {
                    Caption = 'Total Alumni';
                    ApplicationArea = All;
                }
                field(EngagedAlumni; GetEngagedAlumni())
                {
                    Caption = 'Engaged Alumni (This Year)';
                    ApplicationArea = All;
                }
                field(TotalDonations; GetTotalDonations())
                {
                    Caption = 'Total Donations (This Year)';
                    ApplicationArea = All;
                }
                field(AverageDonation; GetAverageDonation())
                {
                    Caption = 'Average Donation (This Year)';
                    ApplicationArea = All;
                }
            }
        }
    }

    local procedure GetTotalAlumni(): Integer
    var
        Alumni: Record customer;
    begin
        exit(Alumni.Count);
    end;

    local procedure GetEngagedAlumni(): Integer
    var
        Alumni: Record customer;
    begin
        Alumni.SetRange("Last Engagement Date", CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        exit(Alumni.Count);
    end;

    local procedure GetTotalDonations(): Decimal
    var
        Donation: Record Donation;
        TotalAmount: Decimal;
    begin
        Donation.SetRange("Donation Date", CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        if Donation.FindSet() then
            repeat
                TotalAmount += Donation.Amount;
            until Donation.Next() = 0;
        exit(TotalAmount);
    end;

    local procedure GetAverageDonation(): Decimal
    var
        Donation: Record Donation;
        TotalAmount: Decimal;
        DonationCount: Integer;
    begin
        Donation.SetRange("Donation Date", CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        if Donation.FindSet() then
            repeat
                TotalAmount += Donation.Amount;
                DonationCount += 1;
            until Donation.Next() = 0;
        if DonationCount = 0 then
            exit(0);
        exit(TotalAmount / DonationCount);
    end;
}
