page 50168 "Procurement Methods Card"
{
    PageType = Card;
    SourceTable = "Procurement Methods";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
            part("Procurement Methods Sub Page"; "Procurement Methods Sub Page")
            {
                SubPageLink = "Procurement Method" = FIELD(Code);
            }
            systempart(Outlook; Outlook)
            {
            }
        }
    }

    actions
    {
    }
}

