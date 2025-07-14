report 50834 "Bank Recon. - Posted"
{
    ApplicationArea = All;
    Caption = 'Bank Recon. - Posted';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(BankAccountStatement; "Bank Account Statement")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
