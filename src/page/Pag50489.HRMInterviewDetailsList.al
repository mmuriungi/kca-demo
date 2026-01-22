page 50489 "HRM-Interview Details List"
{
    CardPageID = "HRM-Interview Details Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Interview Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

