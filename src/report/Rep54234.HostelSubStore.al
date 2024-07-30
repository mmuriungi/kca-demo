report 54234 "Hostel Sub-Store "
{
    Caption = 'Hostel Sub-Store ';
    RDLCLayout = './Layouts/stockreport.rdl';
    dataset
    {
        dataitem(HostelSubStore; "Hostel Sub-Store")
        {
            RequestFilterFields = "Item Category";
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Unitofmeasure; "Unit of measure")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(ItemCategory; "Item Category")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(logo; info.Picture)
            {

            }
            column(cname; info.Name)
            {

            }
            column(caddress; info.Address)
            {

            }
            column(cmail; info."E-Mail")
            {

            }
            column(curl; info."Home Page")
            {

            }
            column(cphone; info."Phone No.")
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        info.get;
        info.CalcFields(Picture);
    end;

    var
        info: Record "Company Information";
}
