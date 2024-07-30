report 54233 "POS cashier Sales Totals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PosCashierPrintTotal.rdl';

    dataset
    {
        dataitem(posHeader; "POS Sales Header")
        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = Cashier, "Posting Date";
            column(No_posHeader; "No.")
            {
            }
            column(PostingDescription_posHeader; "Posting Description")
            {
            }
            column(PostingDate_posHeader; format("Posting Date"))
            {
            }
            column(TotalAmount_posHeader; "Total Amount")
            {
            }
            column(Cashier_posHeader; Cashier)
            {
            }
            column(CustomerType_posHeader; "Customer Type")
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
            column(startDate; format(startDate))
            {

            }
            column(endDate; format(endDate))
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
        startDate: date;
        endDate: date;

    // sDate := posHeader.ge

    trigger OnPreReport()
    begin
        startDate := posHeader.GetRangeMin("Posting Date");
        if posHeader.GetRangeMax("Posting Date") = 0D then
            endDate := posHeader.GetRangeMin("Posting Date")
        else
            endDate := posHeader.GetRangeMax("Posting Date");

        posHeader.SetFilter(Cashier, '%1', UserId);
    end;
}