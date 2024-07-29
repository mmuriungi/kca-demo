report 54214 "POS Sales Per Item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './POS/Report/SSR/PosCashierPrintOUT.rdl';


    dataset
    {
        dataitem(posHeader; "POS Sales Header")
        {
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
            dataitem(posLines; "POS Sales Lines")
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