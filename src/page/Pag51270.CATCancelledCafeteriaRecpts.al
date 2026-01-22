page 51270 "CAT-Cancelled Cafeteria Recpts"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts";
    SourceTableView = WHERE(Status = CONST(Canceled));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Recept Total"; Rec."Recept Total")
                {
                    Editable = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
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

