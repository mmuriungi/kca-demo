page 51257 "CAT-Cafe. Item Inventory List2"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Item Inventory";
    SourceTableView = WHERE("Quantity in Store" = FILTER(> 0));

    layout
    {
        area(content)
        {
            group(DateFilter)
            {
                Caption = 'Date Filter                            (The Meals Inventory is filtered per date.)';
                field(menudate; menudate)
                {
                    Caption = 'Menu Date';
                }
            }
            repeater(Group)
            {
                field("Menu Date"; Rec."Menu Date")
                {
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                }
                field("Item No"; Rec."Item No")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Price Per Item"; Rec."Price Per Item")
                {
                }
                field("Quantity in Store"; Rec."Quantity in Store")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Journal)
            {
                Caption = 'Cafe Item Journal';
                Description = 'Posting Meal Items for sale';
                Image = Transactions;
                action(Journal_Lines)
                {
                    Caption = 'View Journal Lines';
                    Image = AddAction;
                    Promoted = true;
                    RunObject = Page "CAT-Cafe. Meal Journal Line";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        menudate := TODAY;
        //Rec.RESET;
        Rec.SETFILTER("Menu Date", '=%1', TODAY);
        // IF Rec.FIND('-') THEN BEGIN
        // END;
    end;

    trigger OnOpenPage()
    begin
        menudate := TODAY;
        //Rec.RESET;
        Rec.SETFILTER("Menu Date", '=%1', TODAY);
        // IF Rec.FIND('-') THEN BEGIN
        // END;
    end;

    var
        menudate: Date;
}

