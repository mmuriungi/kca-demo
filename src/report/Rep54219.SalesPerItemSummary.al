report 54219 "Sales Per Item Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './POS/Report/SSR/SalesPerItemSummary.rdl';

    dataset
    {

        dataitem(PosLines; "POS Sales Lines")
        {
            RequestFilterFields = "Posting Date";
            column(DocumentNo_PosLines; "Document No.")
            {
            }
            column(No_PosLines; "No.")
            {
            }
            column(Quantity_PosLines; Quantity)
            {
            }
            column(Description_PosLines; Description)
            {
            }
            column(UnitofMeasure_PosLines; "Unit of Measure")
            {
            }
            column(Price_PosLines; Price)
            {
            }
            column(LineTotal_PosLines; "Line Total")
            {
            }
            column(Inventory_PosLines; Inventory)
            {
            }
            column(ServingCategory_PosLines; "Serving Category")
            {
            }
            column(PostingDate_PosLines; format("Posting Date"))
            {
            }
            column(Posted_PosLines; Posted)
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
            column(ttamount; ttamount)
            {
            }
            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                sheader.Reset();
                sheader.SetRange("No.", "No.");
                if sheader.Find('-') then begin
                    sheader.CalcFields("Total Amount");
                    ttamount := sheader."Total Amount";
                end;
            end;
        }

    }
    var
        info: Record "Company Information";
        sheader: Record "POS Sales Header";
        ttamount: Decimal;
}