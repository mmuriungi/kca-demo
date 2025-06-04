xmlport 50020 "Export Custom Cust Ledger"
{
    Caption = 'Export Custom Cust Ledger';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(; "")
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
