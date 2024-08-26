report 50687 "POS PrintOut"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PosPrintOut.rdl';
    Caption = 'Sales Receipt';

    dataset
    {
        dataitem(POSHeader; "POS Sales Header")
        {

            column(No_POSHeader; "No.")
            {
            }
            column(PostingDescription_POSHeader; "Posting Description")
            {
            }
            column(TotalAmount_POSHeader; "Total Amount")
            {
            }
            column(PostingDate_POSHeader; "Posting Date")
            {
            }
            column(Cashier_POSHeader; Cashier)
            {
            }
            column(CurrentDateTime_POSHeader; "Current Date Time")
            {
            }
            column(AmountPaid_POSHeader; "Amount Paid")
            {
            }
            column(Balance_POSHeader; Balance)
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

            dataitem("POS Sales Lines"; "POS Sales Lines")
            {
                DataItemLink = "Document No." = field("No.");


                column(Description_POSSalesLines; Description)
                {
                }
                column(Quantity_POSSalesLines; Quantity)
                {
                }
                column(LineTotal_POSSalesLines; "Line Total")
                {
                }
                column(Price_POSSalesLines; Price)
                {
                }
                column(ttamount; ttamount)
                {

                }
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