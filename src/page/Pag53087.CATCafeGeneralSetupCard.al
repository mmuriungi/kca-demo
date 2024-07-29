page 53087 "CAT-Cafe. General Setup Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "General Ledger Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Meals Booking No."; Rec."Meals Booking No.")
                {
                }
                field("Cafeteria Sales Account"; Rec."Cafeteria Sales Account")
                {
                }
                field("Cafeteria Credit Sales Account"; Rec."Cafeteria Credit Sales Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}

