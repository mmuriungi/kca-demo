page 50864 "FIN-Memo Expense Codes Setup"
{
    PageType = List;
    SourceTable = "FIN-Memo Expense Codes Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {

                }

            }
        }
    }

    actions
    {
    }
}

