report 52178633 "Stock Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Procurement/Reports/SSR/Stock Report.rdl';
    dataset
    {
        dataitem(DataItemName; Item)
        {

            DataItemTableView = where("Gen. Prod. Posting Group" = filter('GOS'));
            column(Inventory_DataItemName; Inventory)
            {
            }

            column(No_DataItemName; "No.")
            {
            }
            column(UnitofMeasureId_DataItemName; "Unit of Measure Id")
            {
            }
            column(UnitPrice_DataItemName; "Unit Price")
            {
            }
            column(UnitCost_DataItemName; "Unit Cost")
            {
            }
            column(BaseUnitofMeasure_DataItemName; "Base Unit of Measure")
            {
            }
            column(Description_DataItemName; Description)
            {
            }
            column(Comment_DataItemName; Comment)
            {
            }
            column(FromDate; FromDate)
            { }
            column(Todate; Todate)
            { }
            column(Totalcost; item.Inventory * item."Unit Cost")
            { }
            column(seq; seq)
            { }
            column(compname; compinfo.Name)
            { }
            column(comppic; compinfo.Picture)
            { }
            column(compemail; compinfo."E-Mail")
            { }
            column(compphone; compinfo."Phone No.")
            { }
            column(compwebpage; compinfo."Home Page")
            { }
            column(compaddress; compinfo.Address)
            { }
            trigger OnAfterGetRecord()
            begin
                compinfo.get();
                compinfo.CalcFields(Picture);
                item.calcfields(Inventory);
                seq := seq + 1;
                SETRANGE("Date Filter", FromDate, ToDate);
            end;
        }

    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = all;
                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        Item.SetFilter("Date Filter", '%1..%2', FromDate, ToDate);
    end;





    var
        FromDate: date;
        Todate: date;
        seq: Integer;
        Item: Record item;
        compinfo: record "Company Information";
}