page 53069 "CAT-Sales Point List"
{
    CardPageID = "CAT-Sales Point Card";
    Editable = true;
    PageType = List;
    SourceTable = "CAT-Catering Sale Points";

    layout
    {
        area(content)
        {
            repeater(qreqwr)
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

