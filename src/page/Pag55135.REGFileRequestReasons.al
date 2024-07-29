page 55135 "REG-File Request Reasons"
{
    CardPageID = "REG-File Reasons Card";
    PageType = List;
    SourceTable = "REG-File Request Reasons";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

