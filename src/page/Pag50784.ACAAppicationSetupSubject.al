page 50784 "ACA-Appication Setup Subject"
{
    PageType = CardPart;
    SourceTable = "ACA-Applic. Setup Subjects";

    layout
    {
        area(content)
        {
            repeater(__)
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

