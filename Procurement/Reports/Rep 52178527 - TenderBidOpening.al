report 52178527 "Tender/Bid Opening"
{
    RDLCLayout = './Procurement/Reports/SSR/Tender.Bid.Opening.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(header; "PROC-Purchase Quote Header")
        {

            column(No_header; "No.")
            {
            }
            column(ExpectedOpeningDate_header; "Expected Opening Date")
            {
            }
            column(ExpectedClosingDate_header; "Expected Closing Date")
            {
            }
            column(Description_header; Description)
            {
            }
            column(Procurementmethods_header; "Procurement methods")
            {
            }
            column(RequisitionNo_header; "Requisition No.")
            {
            }
            column(CompName; info.Name)
            {

            }
            column(CompAddress; info.Address)
            {

            }
            column(CompMail; info."E-Mail")
            {

            }
            column(CompPhone; info."Phone No.")
            {

            }
            column(logo; info.Picture)
            {

            }


            dataitem(bids; "Purchase Header")
            {
                DataItemLink = "Request for Quote No." = field("No.");
                DataItemTableView = where("Document Type" = filter(quote));
                column(No_bids; "No.")
                {
                }
                column(BuyfromVendorNo_bids; "Buy-from Vendor No.")
                {
                }
                column(BuyfromVendorName_bids; "Buy-from Vendor Name")
                {
                }
                column(sno; sno)
                {

                }

                trigger OnPreDataItem()
                begin
                    sno := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    sno := sno + 1;
                end;

            }

            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);

            end;
        }
    }

    var
        info: Record "Company Information";
        sno: Integer;

}