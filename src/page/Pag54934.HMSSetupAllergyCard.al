page 54934 "HMS-Setup Allergy Card"
{
    PageType = Card;
    SourceTable = "HMS-Setup Allergy";

    layout
    {
        area(content)
        {
            group(Group)
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

