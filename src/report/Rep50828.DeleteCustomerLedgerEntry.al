report 50828 "Delete Customer Ledger Entry"
{
    ApplicationArea = All;
    Caption = 'Delete Customer Ledger Entry';
    UsageCategory = Tasks;
    dataset
    {
        dataitem(CompanyInformation; "Company Information")
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
