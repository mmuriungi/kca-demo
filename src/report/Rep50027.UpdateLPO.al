report 50027 "Update LPO"
{
    ApplicationArea = All;
    Caption = 'Update LPO';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(No; "No.")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyFactor; "Currency Factor")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }

        }

        trigger OnAfterGetRecord()
        begin
            If PurchaseHeader."Currency Code" <> '' then
                repeat
                    PurchaseHeader."Currency Code" := '';
                until PurchaseHeader.Next = 0;
            PurchaseHeader.Modify()
        End;
    }
}

