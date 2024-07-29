page 53097 "CAT-Cafe. Rec. List (All)"
{
    CardPageID = "CAT-Cafe. Recpts Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Doc. No."; Rec."Doc. No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Recept Total"; Rec."Recept Total")
                {
                }
                field(User; Rec.User)
                {
                }
            }
        }
    }

    actions
    {
    }
}

