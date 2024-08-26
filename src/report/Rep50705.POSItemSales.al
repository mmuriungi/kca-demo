report 50705 "POS Item Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PosItemSales.rdl';
    dataset
    {
        dataitem(posItem; "POS Items")
        {
            RequestFilterFields = "Date filter";
            column(No_posItem; "No.")
            {
            }
            column(Description_posItem; Description)
            {
            }
            column(Inventory_posItem; Inventory)
            {
            }
            column(ServingCategory_posItem; "Serving Category")
            {
            }
            column(SalesAmount_posItem; "Sales Amount")
            {
            }
            column(SoldUnits_posItem; "Sold Units")
            {
            }
            column(logo; info.Picture)
            {

            }
            column(Cname; Info.Name)
            {

            }
            column(address; info.Address)
            {

            }
            column(email; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(startdate; format(startdate))
            {

            }
            column(endDate; format(endDate))
            {

            }
            column(samount; samount)
            {

            }
            column(sunits; sunits)
            {

            }
            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin

                itm.Reset();
                itm.SetRange("No.", posItem."No.");
                itm.SetFilter("Date filter", '%1..%2', startdate, endDate);
                if itm.Find('-') then begin
                    itm.CalcFields("Sales Amount", "Sold Units");
                    sunits := itm."Sold Units";
                    samount := itm."Sales Amount";
                end;

            end;
        }
    }

    var
        itm: Record "POS Items";
        startdate: date;
        endDate: Date;
        info: Record "Company Information";
        sunits: Decimal;
        samount: Decimal;



    trigger OnPreReport()
    begin
        startdate := posItem.GetRangeMin("Date filter");
        if posItem.GetRangeMax("Date filter") = 0D then
            endDate := posItem.GetRangeMin("Date filter") else
            endDate := posItem.GetRangeMax("Date filter");

    end;
}