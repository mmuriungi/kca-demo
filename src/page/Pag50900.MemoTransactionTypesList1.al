page 50900 "Memo Transaction Types List1"
{
    PageType = List;
    SourceTable = "Memo-Transaction Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field("Transaction Type Desc."; Rec."Transaction Type Desc.")
                {
                }
                field("Is Taxable"; Rec."Is Taxable")
                {
                }
            }
        }
    }

    actions
    {
    }
}

