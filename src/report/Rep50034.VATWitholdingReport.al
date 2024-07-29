report 50034 "VAT Witholding Report"
{
    ApplicationArea = All;
    Caption = 'VAT Witholding Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Finance/Reports/SSR/VAT Witholding Report.rdl';
    dataset
    {
        dataitem(FinWitholdingTaxLedges; "Fin-Witholding Tax Ledges")
        {
            RequestFilterFields = "Vendor No", "Posting Date";

            column(VendorPvNo; "Vendor Pv No")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Description; Description)
            {
            }
            column(EntryNo; "Entry No")
            {
            }
            column(FullyPaid; "Fully Paid")
            {
            }
            column(GlNo; "Gl No")
            {
            }
            column(InvoiceDate; FORMAT("Invoice Date"))
            {
            }
            column(InvoiceNo; "Invoice No")
            {
            }
            column(NetAmount; "Net  Amount")
            {
            }
            column(PaidAmount; "Paid Amount")
            {
            }
            column(PinNo; "Pin No")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TaxGl; "Tax G/l ")
            {
            }
            column(TaxPvNo; "Tax Pv No")
            {
            }
            column(TaxType; "Tax Type")
            {
            }
            column(VatAmount; "Vat Amount")
            {
            }
            column(VatWithold; "Vat Withold")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(VendorNo; "Vendor No")
            {
            }
            column(paymentDate; FORMAT("payment Date"))
            {
            }
            column(startdate; startdate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            column(Sn; Sn)
            {

            }
            trigger OnPreDataItem()
            begin
                FinWitholdingTaxLedges.SetFilter("Posting Date", '%1..%2', startdate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                Sn := Sn + 1;
                CalcFields("Tax Pv No", "Paid Amount", "payment Date");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Start Date"; startdate)
                    {

                    }
                    field("End Date"; EndDate)
                    {

                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        startdate: Date;
        EndDate: Date;
        Sn: Integer;
}
