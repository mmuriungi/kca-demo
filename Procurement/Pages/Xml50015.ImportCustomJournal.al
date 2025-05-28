xmlport 50015 "Import Custom Journal"
{
    Caption = 'Import Custom Journal';
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
