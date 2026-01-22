page 50542 "HRM-Appraisal Periods Card"
{
    PageType = Card;
    SourceTable = "HRM-Appraisal Periods";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

