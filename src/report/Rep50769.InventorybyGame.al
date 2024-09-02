// Report: Inventory by Game
report 50769 "Inventory by Game"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'InventoryByGame.rdl';

    dataset
    {
        dataitem(Game; Game)
        {
            column(Code; Code)
            {
            }
            column(Name; Name)
            {
            }

            dataitem(Item; Item)
            {
                DataItemLink = "Game Code" = field(Code);
                DataItemTableView = where("Item Category" = const("Sporting Equipment"));

                column(No_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Inventory; Inventory)
                {
                }
            }
        }
    }
}