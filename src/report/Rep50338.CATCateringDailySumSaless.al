report 50338 "CAT-Catering Daily Sum. Saless"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CAT-Catering Daily Sum. Saless.rdl';

    dataset
    {
        dataitem("CAT-Cafeteria Receipts"; "CAT-Cafeteria Receipts")
        {
            DataItemTableView = WHERE(Status = FILTER(Posted));
            column(ReceiptNo_MenuSaleHeader; "CAT-Cafeteria Receipts"."Receipt No.")
            {
            }
            column(Date_MenuSaleHeader; "CAT-Cafeteria Receipts"."Receipt Date")
            {
            }
            column(CashierNo_MenuSaleHeader; "CAT-Cafeteria Receipts".User)
            {
            }
            column(CustomerType_MenuSaleHeader; "CAT-Cafeteria Receipts"."Customer No.")
            {
            }
            column(CustomerNo_MenuSaleHeader; "CAT-Cafeteria Receipts"."Cashier Bank")
            {
            }
            column(CustomerName_MenuSaleHeader; "CAT-Cafeteria Receipts".User)
            {
            }
            column(ReceivingBank_MenuSaleHeader; "CAT-Cafeteria Receipts"."Cashier Bank")
            {
            }
            column(Amount_MenuSaleHeader; "CAT-Cafeteria Receipts"."Recept Total")
            {
            }
            column(Department_MenuSaleHeader; "CAT-Cafeteria Receipts"."Department Name")
            {
            }
            column(ContactStaff_MenuSaleHeader; "CAT-Cafeteria Receipts"."Employee Name")
            {
            }
            column(SalesPoint_MenuSaleHeader; "CAT-Cafeteria Receipts".Sections)
            {
            }
            column(PaidAmount_MenuSaleHeader; "CAT-Cafeteria Receipts"."Recept Total")
            {
            }
            column(Balance_MenuSaleHeader; "CAT-Cafeteria Receipts"."Recept Total" - "CAT-Cafeteria Receipts".Amount)
            {
            }
            column(Posted_MenuSaleHeader; "CAT-Cafeteria Receipts".Status)
            {
            }
            column(CashierName_MenuSaleHeader; "CAT-Cafeteria Receipts".User)
            {
            }
            column(SalesType_MenuSaleHeader; "CAT-Cafeteria Receipts"."Transaction Type")
            {
            }
            column(PrepaymentBalance_MenuSaleHeader; 0)
            {
            }
            column(LastSc_MenuSaleHeader; '')
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

