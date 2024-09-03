// Page: Sports Equipment Manager Role Center
page 52017 "Sports Equip. Manager RC"
{
    PageType = RoleCenter;
    Caption = 'Sports Equipment Manager';

    layout
    {
        area(RoleCenter)
        {
            part(HeadlinePart; "Headline RC Sports Equipment")
            {
                ApplicationArea = All;
            }
            part(Activities; "Sports Equipment Activities")
            {
                ApplicationArea = All;
            }
            part(SportsCues; "Sports Equipment Cues")
            {
                ApplicationArea = All;
            }
            part(EquipmentChart; "Equipment Usage Chart")
            {
                ApplicationArea = All;
            }
            part(GameList; "Game List Part")
            {
                ApplicationArea = All;
            }
            part(RecentlyIssuedEquipment; "Recently Issued Equipment")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(SportsMgmt)
            {
                Caption = 'Sports Management';
                action(Games)
                {
                    ApplicationArea = All;
                    Caption = 'Games';
                    RunObject = page "Game List";
                }
                action(SportsEquipment)
                {
                    ApplicationArea = All;
                    Caption = 'Sports Equipment';
                    RunObject = page "Item List";
                    RunPageView = where("Item Category" = const("Sporting Equipment"));
                }
                action(EquipmentIssuance)
                {
                    ApplicationArea = All;
                    Caption = 'Equipment Issuance';
                    RunObject = page "Equipment Issuance List";
                }
            }
        }
        area(Embedding)
        {
            action(EmbedGames)
            {
                ApplicationArea = All;
                Caption = 'Games';
                RunObject = page "Game List";
            }
            action(EmbedEquipment)
            {
                ApplicationArea = All;
                Caption = 'Sports Equipment';
                RunObject = page "Item List";
                RunPageView = where("Item Category" = const("Sporting Equipment"));
            }
            action(EmbedIssuance)
            {
                ApplicationArea = All;
                Caption = 'Equipment Issuance';
                RunObject = page "Equipment Issuance";
            }
        }
        area(Processing)
        {
            action(IssueEquipment)
            {
                ApplicationArea = All;
                Caption = 'Issue Equipment';
                RunObject = page "Equipment Issuance";
                RunPageMode = Create;
            }
            action(ReturnEquipment)
            {
                ApplicationArea = All;
                Caption = 'Return Equipment';
                RunObject = codeunit "Sports Equipment Management";
                RunPageOnRec = true;
            }
        }
        area(Reporting)
        {
            action(SportingItemsReport)
            {
                ApplicationArea = All;
                Caption = 'Sporting Items Report';
                RunObject = report "Sporting Items Report";
            }
            action(LostEquipmentReport)
            {
                ApplicationArea = All;
                Caption = 'Lost Equipment Report';
                RunObject = report "Lost Equipment Report";
            }
            action(InventoryByGameReport)
            {
                ApplicationArea = All;
                Caption = 'Inventory by Game';
                RunObject = report "Inventory by Game";
            }
        }
    }
}