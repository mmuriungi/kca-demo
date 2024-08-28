page 51306 "Meal Process Batches"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Meal Proc. Prod. Batches";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch Date"; Rec."Batch Date")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Product Class"; Rec."Product Class")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Batch No"; Rec."Batch No")
                {
                }
                field("Manufacture Date"; Rec."Manufacture Date")
                {
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

