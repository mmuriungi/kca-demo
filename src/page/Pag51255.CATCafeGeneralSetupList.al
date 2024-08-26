page 51255 "CAT-Cafe. General Setup List"
{
    CardPageID = "CAT-Cafe. General Setup Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "General Ledger Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
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

