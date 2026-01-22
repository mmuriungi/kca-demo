page 51239 "CAT-Catering Sale Points"
{
    PageType = List;
    SourceTable = "CAT-Catering Sale Points";

    layout
    {
        area(content)
        {
            repeater(ewtw)
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

