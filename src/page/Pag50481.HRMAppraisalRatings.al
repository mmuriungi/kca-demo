page 50481 "HRM-Appraisal Ratings"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Ratings (B)";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Score; Rec.Score)
                {
                }
                field(Recommendations; Rec.Recommendations)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
            }
        }
    }

    actions
    {
    }
}

