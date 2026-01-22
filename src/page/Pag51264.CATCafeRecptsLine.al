page 51264 "CAT-Cafe. Recpts Line"
{
    PageType = ListPart;
    SourceTable = "CAT-Cafeteria Receipts Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meal Code"; Rec."Meal Code")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        Rec.VALIDATE(Quantity);
                        Rec."Total Amount" := Rec."Unit Price" * Rec.Quantity;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Meal Descption"; Rec."Meal Descption")
                {
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                    Editable = false;
                }
                field(Price; Rec.Price)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

