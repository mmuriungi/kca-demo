page 53103 "CAT-Cafe. Item Inventory List"
{
    Editable = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Item Inventory";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
    }
}

