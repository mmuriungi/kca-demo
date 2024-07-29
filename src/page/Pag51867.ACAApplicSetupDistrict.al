page 51867 "ACA-Applic. Setup District"
{
    PageType = CardPart;
    SourceTable = "ACA-Applic. Setup County";

    layout
    {
        area(content)
        {
            repeater(___)
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

