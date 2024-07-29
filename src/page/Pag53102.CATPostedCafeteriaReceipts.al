page 53102 "CAT-Posted Cafeteria Receipts"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts";
    SourceTableView = WHERE(Status = CONST(Posted));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    Editable = false;
                }
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
        area(creation)
        {
            action(Print)
            {
                Caption = 'Print Copy';
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin

                    Receipt.RESET;
                    Receipt.SETRANGE(Receipt.Status, Receipt.Status::Posted);
                    Receipt.SETRANGE(Receipt."Receipt No.", Rec."Receipt No.");
                    IF Receipt.FIND('-') THEN BEGIN
                    END;
                    IF CONFIRM('This Prints Copies of the Selected Receipts, Continue?', TRUE) = TRUE THEN
                        REPORT.RUN(51831, TRUE, TRUE, Receipt);
                end;
            }
        }
    }

    var
        Receipt: Record "CAT-Cafeteria Receipts";
}

