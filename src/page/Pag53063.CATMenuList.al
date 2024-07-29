page 53063 "CAT-Menu List"
{
    Editable = true;
    PageType = List;
    SourceTable = "CAT-Food Menu";

    layout
    {
        area(content)
        {
            repeater(FoodMenu)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Items Cost"; Rec."Items Cost")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Units Of Measure"; Rec."Units Of Measure")
                {
                }
                field("Type"; Rec."Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

