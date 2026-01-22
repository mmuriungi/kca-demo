page 51265 "CAT-Cafe. Rec. List (Filtered)"
{
    CardPageID = "CAT-Cafe. Recpts Card";
    Editable = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts";
    SourceTableView = WHERE(Status = FILTER(New));

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

    trigger OnAfterGetCurrRecord()
    begin
        Rec.SETFILTER("Receipt Date", '=%1', TODAY);
        Rec.SETFILTER(User, '=%1', USERID);
    end;
}

