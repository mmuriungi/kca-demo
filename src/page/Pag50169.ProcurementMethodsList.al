page 50169 "Procurement Methods List"
{
    CardPageID = "Procurement Methods Card";
    Editable = false;
    PageType = List;
    SourceTable = "Procurement Methods";

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
            }
        }
    }

    actions
    {
    }
}

