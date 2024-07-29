page 52054 "ACA-Payment By"
{
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Payment By";

    layout
    {
        area(content)
        {
            repeater(general)
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

