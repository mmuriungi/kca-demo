report 50656 "CAT-Daily Sales Summary (All)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CAT-Daily Sales Summary (All).rdl';

    dataset
    {
        dataitem("CAT-Cafeteria Receipts"; "CAT-Cafeteria Receipts")
        {
            DataItemTableView = WHERE(Status = FILTER(Posted));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Receipt No.", "Receipt Date";
            column(ReceiptNo; "CAT-Cafeteria Receipts"."Receipt No.")
            {
            }
            column(Date; "CAT-Cafeteria Receipts"."Receipt Date")
            {
            }
            column(Amount; "CAT-Cafeteria Receipts".Amount)
            {
            }
            column(CashierName; "CAT-Cafeteria Receipts".User)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //"Cafeteria Item Inventory".CALCFIELDS("Cafeteria Item Inventory"."Quantity Sold")
                // "Menu Sale Header".CALCFIELDS("Menu Sale Header".Amount);
            end;

            trigger OnPreDataItem()
            begin
                "CAT-Cafeteria Receipts".SetFilter("CAT-Cafeteria Receipts"."Receipt Date", '=%1', datefilter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(datefilter; datefilter)
                {
                    Caption = 'Sale Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //  datefilter:=TODAY;
    end;

    trigger OnPreReport()
    begin
        if datefilter = 0D then Error('Please specify the sale date.')
    end;

    var
        info: Record "Company Information";
        Address: Text[250];
        Tel: Code[100];
        Fax: Code[20];
        PIN: Code[20];
        Email: Text[50];
        VAT: Code[20];
        DetTotal: Decimal;
        totals: Decimal;
        change: Decimal;
        Amounts: Decimal;
        creditEmp: Code[150];
        datefilter: Date;
}

