page 51260 "CAT-Cafe. Meal Entries List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafe_Meal Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Meal Code"; Rec."Meal Code")
                {
                }
                field("Meal Description"; Rec."Meal Description")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

