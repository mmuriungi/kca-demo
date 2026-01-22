report 50029 "Order Status Report"
{

    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OrderStatusReport.rdl';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = filter(Order));

            column(No_PurchaseHeader; "No.")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Pay-to Name")
            {
            }
            column(OrderDate_PurchaseHeader; "Order Date")
            {
            }
            column(PostingDescription_PurchaseHeader; "Posting Description")
            {
            }
            column(Amount_PurchaseHeader; Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Amount Including VAT")
            {
            }
            column(Status_PurchaseHeader; Status)
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(logo; CompInf.Picture)
            {
            }
            column(Adress; CompInf.Address)
            {
            }
            column(Email; CompInf."E-Mail")
            {
            }
            column(Phone; CompInf."Phone No.")
            {
            }
            column(City; CompInf.City)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CompInf.GET;
                CompInf.CALCFIELDS(CompInf.Picture);
            end;
        }
        dataitem(archived; "Purchase Header Archive")
        {
            DataItemTableView = where("Document Type" = filter(Order));

            column(No_archived; "No.")
            {
            }
            column(PaytoVendorNo_archived; "Pay-to Vendor No.")
            {
            }
            column(PaytoName_archived; "Pay-to Name")
            {
            }
            column(Status_archived; Status)
            {
            }
            column(Amount_archived; Amount)
            {
            }
            column(AmountIncludingVAT_archived; "Amount Including VAT")
            {
            }
        }
    }

    var
        CompInf: Record "Company Information";
}