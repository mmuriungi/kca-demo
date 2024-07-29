page 53098 "CAT-Cafe. Recpts Line View"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt No."; Rec."Receipt No.")
                {
                }
                field("Meal Code"; Rec."Meal Code")
                {
                }
                field("Meal Descption"; Rec."Meal Descption")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

