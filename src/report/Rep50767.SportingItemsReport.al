// Report: Sporting Items Report
report 50767 "Sporting Items Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SportingItemsReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where("Item Category" = const("Sporting Equipment"));

            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Game_Code; "Game Code")
            {
            }
            column(Inventory; Inventory)
            {
            }
        }
    }
}
