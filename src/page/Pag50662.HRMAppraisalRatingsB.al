page 50662 "HRM-Appraisal Ratings (B)"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Ratings";
    SourceTableView = SORTING("Up To")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Up To"; Rec."Up To")
                {
                }
            }
        }
    }

    actions
    {
    }
}

