page 50525 "HRM-Salary Grades Card"
{
    PageType = Card;
    SourceTable = "HRM-Salary Grade Listing";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

