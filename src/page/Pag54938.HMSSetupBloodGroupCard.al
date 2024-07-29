page 54938 "HMS-Setup Blood Group Card"
{
    PageType = Card;
    SourceTable = "HMS-Setup Blood Group";

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

