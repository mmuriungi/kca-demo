page 54949 "HMS-Setup Lab Package Card"
{
    PageType = Card;
    SourceTable = "HMS-Setup Lab Package";

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
            part(Part; "HMS-Setup Lab Pack Test SF")
            {
                SubPageLink = "Lab Package" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

